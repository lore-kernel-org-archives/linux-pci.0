Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA928E0
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923930; cv=none; b=X/fUs3pw7VoBwiiQ1BjEKEoD0xiU3BkJLtxTxHeD3oaaWcxrdTw5e1Gkbn3kONFgDiXEfWoXrEh9ssmB8eHB2OVYnuAsjUteOXJEVd2KvbHNW3kx9fJUlqiZSqOUoJvFGpRLn49tzuAq05R1GjWd90CiC0pj7uQPxLop2Psrxy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923930; c=relaxed/simple;
	bh=CPhuwiKk207t+1jnVVIbKCSc7SYTACWeojSCMGpFJQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nq+iPkrBaVOwceP4UfOPeSN77DWtqkN9o+p65CdYDwcsEZLm1ySrby/w+Czkqrzo8/HMRBxFXeJZMMfauN0FXzkHFpSPJfICZNGAqrcqupxGBM7nBDdX3VllDO2lNh9n+E6W2O9pFtXK4bgW1sfiIN9DKQ8XfF9I+lqSV+h/EJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=wEs8uEwW; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="wEs8uEwW"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61CHFmvw1995783;
	Thu, 12 Feb 2026 11:18:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cswab+TVCRhY8hUaODrd2b4Mvnm+yEHqtCJfechSy34=; b=wEs8uEwWqQrM
	bKNGdbQe/l2hijgYgtqpNzKm9VQvaOoziugj20eIX0O1FMiRBmuwARIa1M2A1iH8
	DyLyeVYSpp8FQ26m8vu4VdogusWa8FnO9b9M/L/cn4VmNiDqlknQgrYSGm2jKfz/
	1sWuKpSC6e2rG/GbGKjuG4370FVx165JkvJhpRcEMP9zoj62Fqa9UCF6EiFKD2rm
	0Y5go2mweZH4dcp+eS3CYhmjFwRhgQrvLSDoJG7Oba8RAO/51T1t4fDpf1ZNwzr7
	sIQ3QjiyYG02ut057LpbzWFTb2YN83lsdXE6Efjd1JblbGpByOgAspcAi3nRHOgH
	qSxxmWC/RQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4c9dty5a0b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Feb 2026 11:18:41 -0800 (PST)
Received: from devvm16459.vll0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 19:18:39 +0000
From: Danielle Costantino <dcostantino@meta.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran
	<oohall@gmail.com>, <linux-pci@vger.kernel.org>,
        Danielle Costantino
	<dcostantino@meta.com>
Subject: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
Date: Thu, 12 Feb 2026 11:18:17 -0800
Message-ID: <20260212191818.3625264-2-dcostantino@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212191818.3625264-1-dcostantino@meta.com>
References: <20260212191818.3625264-1-dcostantino@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wTvAF_MHhQr8BDRarAI9UD3AihSB45yc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE0OSBTYWx0ZWRfX8sFI5AEwjH2Y
 MJxwyZbotbFyXH/QIvMAQ7+xx8GE7LSC9cW2sJJktnIfZRUZJ6pSI5PO7+7K24lTEzWz94TN25t
 ozIKG5sjOVlY8PZoUJVNuSmYEnw2w5rYDQe8/BYTzqJC4cmvvcp46p6mBC0hkoc0BTS5/Qcz3o7
 iOTtmkxz1/mRQISu5IEq0mwK/mc+QkxtlwMIGB/ypuGbxQocubGHSlY4imjSE23yfiyZZVQ60kN
 hDmMjmOn+PaWTFS+ViORB6W6abGs0ci13ZBFFtvafzUZqTd5PsNZuCkpCuhyyxdm1LONFwznn9V
 dXW3aAVwWW9pmLeytfTEZ6Nio2/thq1sYOvCxbf0NX071bRVJnwmB2TxSN9v69rmADqvCVQhs8a
 MOgpNstu8YvVaoMQcfIvY98aqfQ/h0sA8lSQhEtYiKV+ASGr3OIx94gRsZQ4RP7lf/6irUAKsUe
 vmyOJ7XPgHwBgUCapSA==
X-Proofpoint-ORIG-GUID: wTvAF_MHhQr8BDRarAI9UD3AihSB45yc
X-Authority-Analysis: v=2.4 cv=brNBxUai c=1 sm=1 tr=0 ts=698e2791 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=aYVGL-vDrxpcnfgFjpMA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01

In the native DPC interrupt path, dpc_irq() clears
PCI_EXP_DPC_STATUS_INTERRUPT before scheduling the threaded handler
that eventually calls dpc_reset_link().  However, in the firmware-first
EDR path, dpc_irq() is never invoked -- firmware owns the DPC interrupt
and notifies the OS via an ACPI EDR notification.  dpc_reset_link() is
then called directly from edr_handle_event() via pcie_do_recovery().

Because dpc_reset_link() only clears PCI_EXP_DPC_STATUS_TRIGGER, the
Interrupt Status bit (bit 3) is left set permanently after every EDR
event.

Clear PCI_EXP_DPC_STATUS_INTERRUPT alongside PCI_EXP_DPC_STATUS_TRIGGER
in dpc_reset_link().  Both bits are RW1C in the DPC Status register per
PCIe r6.1, sec 7.9.14.5, so writing them together is safe.  The native
path is unaffected because dpc_irq() has already cleared the Interrupt
Status bit before dpc_reset_link() runs.

Fixes: aea47413e7ce ("PCI/DPC: Expose dpc_process_error(), dpc_reset_link() for use by EDR")
Signed-off-by: Danielle Costantino <dcostantino@meta.com>
---
 drivers/pci/pcie/dpc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fc18349614d7..9baa2345e33e 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -171,8 +171,16 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 		goto out;
 	}
 
+	/*
+	 * Clear both DPC Trigger Status and DPC Interrupt Status.  In the
+	 * native DPC path, dpc_irq() already clears Interrupt Status before
+	 * the threaded handler runs.  But in the EDR (firmware-first) path,
+	 * dpc_irq() is never called, so Interrupt Status must be cleared
+	 * here to prevent it from remaining stale indefinitely.
+	 */
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
-			      PCI_EXP_DPC_STATUS_TRIGGER);
+			      PCI_EXP_DPC_STATUS_TRIGGER |
+			      PCI_EXP_DPC_STATUS_INTERRUPT);
 
 	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC")) {
 		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
-- 
2.47.3

