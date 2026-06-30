Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EED323417;
	Tue, 30 Jun 2026 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861532; cv=none; b=ajpF8Anotp+g7t46fsLBpYaqxirT/ar0E8mJsoz20Z0Shzncuz6USUXoWefO0Vmxxh7SD0SKk6zLpyakK9jxJ35QP67XqxrRRGCgfjBT3isZHlRrdbxEjkcKAqFX8wdGgoapmx2/I6fBZ1oEn7TjzGMaHnAkYDrxFDIQgdIHaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861532; c=relaxed/simple;
	bh=H++89qxpLaHmACQBNFHOWU+EDWqINXpJ1HRaaNeroTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=h3bhnPKMY5ptYqok2IPduWbFyexiu7AwKTbMJtrg+fwZsnyPt+qPo0umSEGmfbNh3tlKXw9KH4fTPyrSBEZzEWx0HobENdLyXockMV9dnT6sk2kNF5tKsCtsH7TrKIXicexnI0OALnXY3XoYD4OiYEouu9dm/Pu9AJb8ZnKDyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCnZUMm3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCnZUMm3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782861531; x=1814397531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=H++89qxpLaHmACQBNFHOWU+EDWqINXpJ1HRaaNeroTY=;
  b=gCnZUMm3V0TCiGfomrpOJSKjPY26tsVXZV9ukVqU1w3rduhRso43q2HL
   AiBXxfgK4dxKXavFlMsC8v0bzZIMCu5fUn0z2dZrZfsI3QNfPZaYS8iR5
   X//jYeQ1D6ysPbXtCY4H5mVX40Wo/GpB3VD99Zt0Jf6a/C+OBkTYxfLbE
   gPzV4PVzURha2A37BoC+EewNCfhUSFnVCYQHoVGZGLHhdTtSaIx9c23ZN
   bVLZ5XSI57MRWK62/w6bf/fpgmaUWlLbRvu7d6uWd12kyQ5BoEKbYicLt
   eH8bm4xIdxvXGY9R9Orjwv0ademUXOFhW6mChm6FnXKjycF9r5ySbXgV9
   w==;
X-CSE-ConnectionGUID: NVcB6EHmRreFnfHLM75Yaw==
X-CSE-MsgGUID: tDAcdpr3QGu2bCNAdBi3vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="86135268"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="86135268"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 16:18:47 -0700
X-CSE-ConnectionGUID: yyQUHXcDRtC0JuuZzxCzRA==
X-CSE-MsgGUID: FaFF0FSRQvaiSIvRKwd3zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="251972107"
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
Subject: [PATCH iwl-next v3 1/2] idpf: remove conditional MBX deinit from idpf_vc_core_deinit()
Date: Tue, 30 Jun 2026 16:18:53 -0700
Message-Id: <20260630231854.11536-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260630231854.11536-1-emil.s.tantilov@intel.com>
References: <20260630231854.11536-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Previously it was assumed that idpf_vc_core_deinit() is always being
called during reset handling, where the MBX is disabled by the reset,
with remove being the exception. Ideally the driver needs to communicate
the changes to FW in all instances where the MBX is not already disabled.
Remove the remove_in_prog check from idpf_vc_core_deinit() as the MBX was
already disabled while handling the reset via libie_ctlq_xn_shutdown()
in the service task. This is also needed by the following patch,
introducing PCI callbacks support, specifically in the case where FLR is
being triggered by a user, in which case, the driver still has the ability
to notify FW before the reset happens.

Add call to libie_ctlq_xn_shutdown() in idpf_shutdown() to avoid a possible
regression where long timeouts can happen on shutdown when FW is down.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Jay Bhat <jay.bhat@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c     |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 10 +---------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 5a191644b28e..064bf3583824 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -191,6 +191,8 @@ static void idpf_shutdown(struct pci_dev *pdev)
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+	if (adapter->xnm)
+		libie_ctlq_xn_shutdown(adapter->xnm);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index e0e510b1f1e1..cc5aeec3d00b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3195,24 +3195,16 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
-	bool remove_in_prog;
-
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
-	/* Avoid transaction timeouts when called during reset */
-	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
-	if (!remove_in_prog)
-		libie_ctlq_xn_shutdown(adapter->xnm);
-
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
 	idpf_idc_deinit_core_aux_device(adapter);
 	idpf_rel_rx_pt_lkup(adapter);
 	idpf_intr_rel(adapter);
 
-	if (remove_in_prog)
-		libie_ctlq_xn_shutdown(adapter->xnm);
+	libie_ctlq_xn_shutdown(adapter->xnm);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
-- 
2.37.3

