Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBCA226D05;
	Tue, 30 Jun 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861531; cv=none; b=G99yeJoD34Aj1XSZ2AkQRX0Ry9GNSsWZcYYi7hYuP8oGd1fz9HGoVm+79ak8NsWySD0YsIF+g3N+6pvKBUTBUzX/Dx25bdhlM6f+KewPvyfHxHiLOBCi7tbVshDXhQBDZyTJ0vheCxBZgt51gYS4x75Qkv+KWyjDzmCbwKJlgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861531; c=relaxed/simple;
	bh=+eQ6M0K+eMeEG4XsANC9glVnlOlhJrlgi8sTZLZhzh4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bRwIOSPuDolGhCAGF3orJyWgko5EbEGgveG1/rRB9w3ljmWlwdgKfapQ3c6PX2zLw/YE8WgQIWNBpiLIsuNYtjbvwxAuJKlOLpTiJb73CKN6ogx/bwNdzmoSQ3nWCZ3Hn0/K1W0K1pMrsf4CLUDzRBzwTqBC38/pi2kyPTBgTJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQCAWZ+J; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQCAWZ+J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782861529; x=1814397529;
  h=from:to:cc:subject:date:message-id;
  bh=+eQ6M0K+eMeEG4XsANC9glVnlOlhJrlgi8sTZLZhzh4=;
  b=ZQCAWZ+JFqHY7XuXfliRQJ3soYuvLPpgWNSE0aVzV0wS8WGZvLH4TWuO
   vyeYGwJ5DWMDoNI4Vip49Ji+KbNwLMI1f+4wFUv2TcWx7f3lr/C5Me/fx
   tznzUPzHm5M7VxWvLkX05CpgXDiToEiuEqBPSdROTvPbKh82+HldX+DBj
   jYdyGBeCXpm5n4bOQFJ3Vsp9NKDiW7Ch/zPYeZ0tFsTNKQwyN1OaI631J
   kKTMajZZIVGt+0g3QKqvCY355HPJrq/HPWoDrDZifYYWkTBfoir/0m50e
   Lz/VmcMnm+fU5bkkO0ZrqjkB0RYJMh4tn0aU1UVGwY0Dn6NS2CUhX185f
   Q==;
X-CSE-ConnectionGUID: UxBO63F3R6q2QFmJsWYsmA==
X-CSE-MsgGUID: qGfINolsTROb8KDGsaDwkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="86135256"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="86135256"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 16:18:47 -0700
X-CSE-ConnectionGUID: 64BaQv3RRWCocNHekXedBw==
X-CSE-MsgGUID: 8wDUs1oHQ5+ASvCYfZXpJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="251972105"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa008.jf.intel.com with ESMTP; 30 Jun 2026 16:18:48 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	jay.bhat@intel.com,
	ivan.d.barrera@intel.com,
	aleksandr.loktionov@intel.com,
	larysa.zaremba@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	linux-pci@vger.kernel.org,
	madhu.chittim@intel.com,
	decot@google.com,
	willemb@google.com,
	sheenamo@google.com,
	lukas@wunner.de
Subject: [PATCH iwl-next v3 0/2] Introduce IDPF PCI callbacks
Date: Tue, 30 Jun 2026 16:18:52 -0700
Message-Id: <20260630231854.11536-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This series implements PCI callbacks for the purpose of handling FLR and
PCI errors in the IDPF driver.

The first patch removes the conditional deinitialization of the mailbox in
the idpf_vc_core_deinit() function. Aside from being redundant, due to the
shutdown of the mailbox after a reset is detected, the check was also
preventing the driver from sending messages to stop and disable the vports
and queues on FW side, which is needed for the prepare phase of the FLR
handling.

The second patch implements the PCI callbacks. The logic here follows
the reset handling done in idpf_init_hard_reset(), but is split in
prepare and resume phases, where idpf_reset_prepare() stops all driver
operations and the resume callback attempt to recover following the
reset or the PCI error event.

NOTE: These changes depend on, and apply on top of the IXD series:
https://lore.kernel.org/netdev/20260608144127.2751230-1-larysa.zaremba@intel.com/

Testing hints:
1. FLR via sysfs:
echo 1 > /sys/class/net/<ifname>/device/reset

Previously this would have been handled by idpf_init_hard_reset() as the
driver detects the reset. Now it will be done by the PCI err callbacks,
so this is the easiest way to test the reset_prepare/resume path.

2. PCI errors can be tested with aer-inject:
./aer-inject -s 83:00.0 examples/<error_type>

3. Stress testing can be done by combining various callbacks with the
reset from step 1:
echo 1 > /sys/class/net/<if>/device/reset& ethtool -L <if> combined 8
ethtool -L <if> combined 16& echo 1 > /sys/class/net/<if>/device/reset

Changelog:
v2->v3:
1/2:
- Added call to libie_ctlq_xn_shutdown() in idpf_shutdown() to avoid
possible regression when shutting down while FW is not responsive,
causing long delays.
- Fixed typo in the title s/conditonal/conditional/

2/2:
- Improved the logic in idpf_reset_prepare() to make sure the
  RESET_IN_PROG bit is set after the init task.
- Renamed the err parameter in idpf_pci_err_detected() with state
  and updated the description to match.
- Added check for adapter->xnm before calling libie_ctlq_xn_shutdown()
  in idpf_pci_err_detected().
- Corrected a comment to add some context on the reasoning behind
  the reset triggered on resume, following a PCI error.
- Corrected the description for slot_reset callback by removing
  the mention of AER as it is not the only trigger for the reset.
- Use PCI_POSSIBLE_ERROR() macro when checking RSTAT value.
- Add vport_ctrl_lock when calling idpf_vc_core_deinit() in 
  idpf_reset_prepare().

v1->v2:
- Removed the call to pci_save_state() from idpf_pci_err_slot_reset(),
  as it is no longer needed after pci_restore_state(). Suggested by
  Lukas Wunner.

v1:
https://lore.kernel.org/netdev/20260411003959.30959-1-emil.s.tantilov@intel.com/

Emil Tantilov (2):
  idpf: remove conditional MBX deinit from idpf_vc_core_deinit()
  idpf: implement pci error handlers

 drivers/net/ethernet/intel/idpf/idpf.h        |   3 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 124 ++++++++++++++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  10 +-
 4 files changed, 139 insertions(+), 11 deletions(-)

-- 
2.37.3

