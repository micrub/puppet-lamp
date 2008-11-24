class wordpress {
  include build,
          git,
          apache,
          mysql,
          php,
          users,
          sudo
}