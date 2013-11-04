# RailroadMap security requirements file

# Type of Access Control. rbac
$ac_type = 'rbac'

$roles = {
  'admin' => {
    description: 'system admin',
    color:       '#A757A8',  # Purple
    level:       10,
  },
  'user' => {
    description: 'user can edit his/her railsapps entry',
    color:       '#97A750',   #   Kimidori
    level:       3,
  },
}

$assets_base_policies = {
  'user' => {         # for Devise and User
    model_alias: { # for controllers defined by Devise
      'devise:registration' => 'user',
      'devise:session' => 'user',
      'devise:password' => 'user',
      'devise:confirmation' => 'user',
      'devise:unlock' => 'user',
      'devise:omniauth_callback' => 'user' },
    is_authenticated: true,
    is_authorized:    true,
    level:            10,  # High
    roles: [
      { role: 'admin', action: 'CRUD' },
      { role: 'user',  action: 'CRU', is_owner: true }
    ],
    color: 'orange'
  },

  'role' => {         # CanCan
    is_authenticated: true,
    is_authorized:    true,       # Admin only
    level: 15,  # Highest
    roles:  [
      { role: 'admin',  action: 'CRUD' },
      { role: 'user',   action: 'R' },
    ],
    color: 'red'
  },

  # M_users_role
  'users_role' => {
    is_authenticated: true,
    is_authorized:    true,
    level:            5,  # Mid
    roles:  [
      { role: 'user', action: 'CRUD' }
    ]
  },
  # M_ability
  'ability' => {
    is_authenticated: true,
    is_authorized:    true,
    level:            5,  # Mid
    roles:  [
      { role: 'user', action: 'CRUD' }
    ]
  },
}

$assets_mask_policies = {
  # Devise
  # public
  'C_devise:session#new'         => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:session#create'      => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:session#destroy'     => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:registration#new'    => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:registration#create' => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:registration#cancel' => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:unlock#new'          => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:unlock#show'         => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:unlock#create'       => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:confirmation#new'    => { is_authenticated: false, level: 0, color: 'green' }, 
  'C_devise:confirmation#show'   => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:confirmation#create' => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:password#new'        => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:password#edit'       => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:password#create'     => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:password#update'     => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:omniauth_callback#passthru'  => { is_authenticated: false, level: 0, color: 'green' },
  'C_devise:omniauth_callback#failure'   => { is_authenticated: false, level: 0, color: 'green' },
  # any role
  'C_devise:registration#edit'    => { is_authenticated: true, is_authorized: false, level: 15, color: 'red' },
  'C_devise:registration#update'  => { is_authenticated: true, is_authorized: false, level: 15, color: 'red' },
  'C_devise:registration#destroy' => { is_authenticated: true, is_authorized: false, level: 15, color: 'red' },
   # ignore
  'V_devise#_links'                             => { ignore: true },
  'V_devise:mailer#reset_password_instructions' => { ignore: true },
  'V_devise:mailer#unlock_instructions'         => { ignore: true },
  'V_devise:mailer#confirmation_instructions'   => { ignore: true },

  # Application
  'C_home#index' => {
    is_authenticated: false,
    level: 0,  # Public
    color: 'green'
  },
  'C_user#show' => {
    is_authenticated: true,
    is_authorized:    false,  # any role
    level:            10,  # High
    color: 'orange'
  },

  # V of layout use
  'V_layout#application' => {
    is_authenticated: false,
    ignore: true,
    view_type: 'layout',
    level: 0,  # Public and else
  },
}
# EOF
