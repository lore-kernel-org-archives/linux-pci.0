Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88562318B9B;
	Tue, 14 Apr 2026 03:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776136587; cv=none; b=NNE2NnGioua8bdw3zsysH9HcXvHpF1nN2l7eUB5Q8ywSzi0J4iXdgaVBdT3GVCkSxeI8Rks96heMbw8JLnoqWAZVAEeFPjJzfbq4IciTCsoPQTAf9SsyPd+DjK03qOObm/ai3PLFEyoPSiAhva1UjGA28peSgBOF8KgfI0nbZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776136587; c=relaxed/simple;
	bh=fJ+x0FuS4kfTxKVTAiQAsAjahv+Ub5YWK+sKz1QUweY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PUdoseRzkT+LsfLK6g7PH+xF3weYIDkY3JJuKJy8zVmI8K8P7r+pySO2wfIS2g8dbYu/5Qy4mjf5w8pl9t0ECUxAXI3vjPF9bcJ+pMNTkiq34l+bao9/mJc+6PW8ahxh9VzTse7SNfWSDc/dJBxKEhXmSgLOa/Py3M7W0/7e36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDON4N/y; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDON4N/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776136585; x=1807672585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fJ+x0FuS4kfTxKVTAiQAsAjahv+Ub5YWK+sKz1QUweY=;
  b=SDON4N/ykp5WS+ZGtBpCE8A2OBcQCRWAokV+idw7Ohcct0mfznxHsNNl
   HBUVY8r0hgoTG6MuXdCwZalkaekaGp8f9DBduZf5RFGo3kLbYb6Xw6SVF
   YEUtbGIlz7KwgX4jEwBWh/cWVwVOieT12DKDgSGEheK7ddh/uGTvLyJDG
   SHJKRWc+EVF9NG4uxYXh2paqMX8PT8UJ7wPsDGusixz0XgEtBSdS6IQ9Z
   9q53QKJTtRAnl/F4WYSuCbvP4gmAsO9+ve9cE1Yltm/5xOQ1GjzVFu5ei
   Yz80hJIXDm6+f2OaOyZKMipbyxAfrWNvntZh9DL0adMMqzxxj/JyDbvW2
   Q==;
X-CSE-ConnectionGUID: 8Y/6YnQFTmaKbd8IQOLasg==
X-CSE-MsgGUID: wAYjH+xSR5qDC9vXliObuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="87706571"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="87706571"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 20:16:25 -0700
X-CSE-ConnectionGUID: r4bOFk0+TgeGkwx+5EPfTw==
X-CSE-MsgGUID: n54daRj9ROmi8Fhrks/EqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="226795514"
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
Subject: [PATCH iwl-next v2 1/2] idpf: remove conditonal MBX deinit from idpf_vc_core_deinit()
Date: Mon, 13 Apr 2026 20:16:30 -0700
Message-Id: <20260414031631.2107-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260414031631.2107-1-emil.s.tantilov@intel.com>
References: <20260414031631.2107-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Previously it was assumed that idpf_vc_core_deinit() is always being
called during reset handling, with remove being an exception. Ideally
the driver needs to communicate the changes to FW in all instances where
the MBX is not already disabled. Remove the remove_in_prog check from
idpf_vc_core_deinit() as the MBX was already disabled while handling the
reset via libie_ctlq_xn_shutdown() by the service task. This is also
needed by the following patch, introducing PCI callbacks support.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Jay Bhat <jay.bhat@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 129c8f6b0faa..fceaf3ec1cd4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3229,24 +3229,15 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
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
-		idpf_deinit_dflt_mbx(adapter);
-
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
 	idpf_idc_deinit_core_aux_device(adapter);
 	idpf_rel_rx_pt_lkup(adapter);
 	idpf_intr_rel(adapter);
-
-	if (remove_in_prog)
-		idpf_deinit_dflt_mbx(adapter);
+	idpf_deinit_dflt_mbx(adapter);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 
-- 
2.37.3

