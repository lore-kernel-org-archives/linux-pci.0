Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A8319848;
	Tue, 14 Apr 2026 03:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776136585; cv=none; b=JKhClj3z8yz1CE29dMZji/peOBHflhycBBarCnCJMd6SPdl/G93itkaa9emX9vTugomaLkB6FhYd7oqa54Yci8aZ9Ceqs3qSLrYSqxJ+6dNetfPUFc34giMvsKQElN+NCCU7CxXvYQSQ/1gHBwIrp9u3Tj8r5a0Tg7P0DPfB7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776136585; c=relaxed/simple;
	bh=oKTYqYhLv/KKCwdvRpI6OjNnIIZ57VjTfvU9UFl192A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EG5i9wNH543678o22KXcUlUI7znGtISLDQqomArXEaPehk/BSUZ329oIfhpfLY5K0M9/PDm5ZHHMIJi9PwQ9MgUaAZYchD9/WYt5z7uAtoel9QimLkyWDPv5HMyLwRh6l2JyWGA0nmUUCCP3CCcjzMGb4S2ZiJRLi9dvykKtBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMRDStIh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMRDStIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776136584; x=1807672584;
  h=from:to:cc:subject:date:message-id;
  bh=oKTYqYhLv/KKCwdvRpI6OjNnIIZ57VjTfvU9UFl192A=;
  b=RMRDStIhDgOtgYIkswWqDwOki1heAkDi54xUx5HMTtkXrePjlleFa4sn
   m/DQUVyWqPdMqMkPzpmhwTa/0OATKmVx6XucczglCFhc1XJZUVtloNYfk
   A459AZCJOZQntl1yRFmCzfhRm6sX1advtkrka1APIOxUhPcGXKWe93MVN
   zH/nIDOKGi6aqlpGV5nNc4k/oHqmYpM1fcb79SPHjVaV0C0c0UNTB/n4f
   +hbH8UnaBww81pYVKSgPLvObc37hnzYZxF9r16OLU0GiL4vU+PoZtRPz5
   he6izqIL3MJdHZ/MBWQJDgO3dG6IU4Rj44motCbI7w5gnvTziLZ0ORY8b
   Q==;
X-CSE-ConnectionGUID: 9aCLuYOaT66vm96dHEWaqg==
X-CSE-MsgGUID: KzJ9GZ23SNmF/52MqwJijg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="87706558"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="87706558"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 20:16:24 -0700
X-CSE-ConnectionGUID: p1/4XYGlSN6pBnEUjOedkg==
X-CSE-MsgGUID: MJYetiEoTGqwlYG4dp6yxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="226795510"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa007.fm.intel.com with ESMTP; 13 Apr 2026 20:16:23 -0700
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
Subject: [PATCH iwl-next v2 0/2] Introduce IDPF PCI callbacks
Date: Mon, 13 Apr 2026 20:16:29 -0700
Message-Id: <20260414031631.2107-1-emil.s.tantilov@intel.com>
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
v1->v2:
- Removed the call to pci_save_state() from idpf_pci_err_slot_reset(),
  as it is no longer needed after pci_restore_state(). Suggested by
  Lukas Wunner.

v1:
https://lore.kernel.org/netdev/20260411003959.30959-1-emil.s.tantilov@intel.com/

Emil Tantilov (2):
  idpf: remove conditonal MBX deinit from idpf_vc_core_deinit()
  idpf: implement pci error handlers

 drivers/net/ethernet/intel/idpf/idpf.h        |   3 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 112 ++++++++++++++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  11 +-
 4 files changed, 127 insertions(+), 12 deletions(-)

-- 
2.37.3

