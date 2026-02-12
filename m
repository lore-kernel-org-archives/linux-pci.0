Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5D81AA8
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923930; cv=none; b=NsTmyt8RICTnD6cWVOkpD5RWVPTIT856+a1Cfa0OwMnUyncCRifGNofZsLZsVN/aGgDXN9HNIFUjj09TE05RBLBumjkFVaHD7L+DVp+4l+YB/lwSLsiYHkEqPmeq9xjKLBt1umhCP7Qb9KYxlJogIN0Oz6cpZPj5WVymDJJw/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923930; c=relaxed/simple;
	bh=kUR6StiDe2WeVmqIkvE6C1qvVpVUa+eyJHM+m+aKmHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/FOCe/OnEfqYdR+643G5Ec1WHh4eHKJJ5j+wlo6x+ugSopSM3NEZ1eMRLtikySFxq7HJwIvvXf3QUyCOIolVEtfByTvQCueRzLXEugDcEX0UU3XDrX+uJFFOg1OZwUwCjlsTZNvgB2UAeajezK3xAazOu/W5LtlKCtXQD5Efic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Z39RToor; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Z39RToor"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61CHFmvx1995783;
	Thu, 12 Feb 2026 11:18:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=oEg/nOuHSJEugT3L2lIPkGpNuTunBHt89TgbejE0VjA=; b=Z39RToorDyWT
	WL+aiv91Y4A/+8jqum4WnpQNZOTz2m4OQxt/GFiwY1xYod8E0DVyIbzLAgnPoVzE
	V1gEtzgSuI4lN91tf+/lfyscFEFu15b+loM5XfNX3VPOB2YAuxjdQR5feWt4EO5N
	fwHQ1DC9ZtZ9oJzwvXNudk1tPaPveApikMUwQgJ6LL7aS/bdqh3KBpHqUWOzwThP
	vSQzZbwvWoSL+0yU7aSv1FoQckIPk22E/JgQBRmUzVgIFrgueknjvbl6YU4MOM0u
	UUzvejpZMgn5RyD+LLQasMjKHeMi4Uu+hFAwTk5vJ4XsxajxUCMmTlE85WIBoN8/
	O4RAKC7p6Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4c9dty5a0b-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Feb 2026 11:18:42 -0800 (PST)
Received: from devvm16459.vll0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 19:18:40 +0000
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
Subject: [PATCH 2/2] PCI/EDR: Defer AER status clearing until after recovery
Date: Thu, 12 Feb 2026 11:18:18 -0800
Message-ID: <20260212191818.3625264-3-dcostantino@meta.com>
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
X-Proofpoint-GUID: JmcW_7QRoum2pyf32Tx95zYwZ1EI80nI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE0OSBTYWx0ZWRfX7KRRP8YQ4ULJ
 37FTaAm43KlkDkifFFP7U9bZWrJbWhgVjuhpXlCm3MTs3EjcGLjfsT6bkfHNKaBKdtakWRc3jGf
 +ov9LLIv93FRRZzk4tzmV5hgcuMXpa5XGFs8HsYaPyOvs//c8rH99QQ3hFAGvTlFVjdlSnbpVTS
 HHXidCFgtSK+bBk8mNqH8RbUC64R7TI0+zXW0n8op1c2QB+F5tzL3FD7Pbdq/juV5VpaSKyzNwL
 UcGvqKZwvx5yeqpp3f6TvrYXNRCGt/eBKGAzxipAg9Cq+NV6R5fS5My4U6zbTBzZUUalFi0M5k3
 bdESfeYYg9SX0GKg8rowpIaAH/8LcZGi/SPHyZ5cT0Qcc/EAbe7BsK/N8h1Upna3/s4XjBzVwnt
 xWczO62GBfSTBm6VsPUWZZ1/g0kMt7nyfXbQSjAfU3edi4xO6P+F1/Alynv72jMilq87HpnN0xf
 kdLdSSn0ZfkUp3wz1qA==
X-Proofpoint-ORIG-GUID: JmcW_7QRoum2pyf32Tx95zYwZ1EI80nI
X-Authority-Analysis: v=2.4 cv=brNBxUai c=1 sm=1 tr=0 ts=698e2792 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=dkVm-Xf8ABp1oUq4d-oA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01

edr_handle_event() calls pci_aer_raw_clear_status() immediately after
dpc_process_error() but before pcie_do_recovery().  While
dpc_process_error() has already read and logged the AER uncorrectable
status by this point, clearing the registers before recovery means
that driver error_detected/slot_reset/resume callbacks invoked by
pcie_do_recovery() can no longer inspect the AER status to make their
own decisions.

Additionally, in the firmware-first EDR path, the normal AER clearing
inside pcie_do_recovery() is a no-op because pcie_aer_is_native()
returns false, so pci_aer_raw_clear_status() in edr_handle_event() is
the only place these registers get cleared.  Moving it after recovery
completes keeps the diagnostic data available throughout the entire
recovery sequence.

Move pci_aer_raw_clear_status() to after pcie_do_recovery() returns so
AER registers remain readable during the full recovery sequence.

Fixes: ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR) support")
Signed-off-by: Danielle Costantino <dcostantino@meta.com>
---
 drivers/pci/pcie/edr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index e86298dbbcff..94a0e5e58fea 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -191,7 +191,6 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	}
 
 	dpc_process_error(edev);
-	pci_aer_raw_clear_status(edev);
 
 	/*
 	 * Irrespective of whether the DPC event is triggered by ERR_FATAL
@@ -200,6 +199,16 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	 */
 	estate = pcie_do_recovery(edev, pci_channel_io_frozen, dpc_reset_link);
 
+	/*
+	 * Clear AER status only after pcie_do_recovery() completes.
+	 * dpc_process_error() has already read and logged the AER
+	 * status above.  Deferring the clear keeps diagnostic data
+	 * available to driver callbacks invoked during recovery and
+	 * avoids interfering with any AER status reads they may
+	 * perform.
+	 */
+	pci_aer_raw_clear_status(edev);
+
 send_ost:
 
 	/*
-- 
2.47.3

