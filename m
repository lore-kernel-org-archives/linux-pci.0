Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230702DA75B;
	Sat, 11 Apr 2026 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775867994; cv=none; b=ocsNK3D8OWHHi9PC42OXRZwJpw2cR/iaGF8JmqpBRKwPoXbujr/skuglP8kZcZXkCbQjb7ZUjPXyh/6zW+ZeM7VM+5hyP9GY51eVPhqxhxhOuCSQZJRfjZ772T2oJoMe9zjEIldmH7gM3KoDccNnmHqx5823g2ofR+ovDjNuWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775867994; c=relaxed/simple;
	bh=fJ+x0FuS4kfTxKVTAiQAsAjahv+Ub5YWK+sKz1QUweY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DZe3Yi4UdoNN9JZ0A6XY7Ln/w5O6Tjqj6Y48TRWglxl5jtZn1ji2VI+eZb4igAUljIg0jjvdHGWzxqbn9Vp1XO7CiVWUUPgRBD9stA8HhgDjax7n0njmoyFL585WhzGS6Z5u7LAYlOESKzExlbN/wNgvnsjFjCAKKc4OBWVb7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yo1V0Lzv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yo1V0Lzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775867993; x=1807403993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fJ+x0FuS4kfTxKVTAiQAsAjahv+Ub5YWK+sKz1QUweY=;
  b=Yo1V0LzvhbMYy+ljkwvCNwAZLypksuK751wRqZRagm7WwBXIvJcCvQOS
   AXapI8gzXeZQfrOn8Dkdz6vpVnQGpK1SkKyeLR8ZUIl+gUNl8ijxjjfpe
   mjW5H6tGbN9Qr7FqKVVm3LXYHSsmZ9pL94D/RYU+M1UdxcZAn1Pwy0Qxf
   hBzL76n4ku9S7CygqPvioLF82UKq72V9K1xIQZ6H3WtdGqub5xG/z6lSV
   zsn/ydDoy/3/rDnMxf1aH8bme3Xp42cmthykW9gAet9P7lnrWQ7JRk9ZD
   QnNhCNbSNu+YvBWLz79GJQrclw1GnYDw18oZihx5L/JA2GIKPP/u6NleL
   Q==;
X-CSE-ConnectionGUID: 2v3o0Hy1QV+MBLqt6uY6LQ==
X-CSE-MsgGUID: qKGN5ajgTp6dbhODyu6Nxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="64423728"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="64423728"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:39:51 -0700
X-CSE-ConnectionGUID: PiUauI7oSXq01LAz3hPfzA==
X-CSE-MsgGUID: Iot3WUGkQ42RCe3vJhrIdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="228392490"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa010.jf.intel.com with ESMTP; 10 Apr 2026 17:39:51 -0700
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
	sheenamo@google.com
Subject: [PATCH iwl-next 1/2] idpf: remove conditonal MBX deinit from idpf_vc_core_deinit()
Date: Fri, 10 Apr 2026 17:39:58 -0700
Message-Id: <20260411003959.30959-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260411003959.30959-1-emil.s.tantilov@intel.com>
References: <20260411003959.30959-1-emil.s.tantilov@intel.com>
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

