Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F77431A57;
	Wed,  5 Aug 2026 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934323; cv=none; b=aSKStgI0BIa1xa03r6XASUKoNZ/PgzD0BWKVSZzb0m6J3qvDKypoi6Ap6/EwrxIqePsqUNI+uJfiqhJjpjQMzPaldHWQSmA9spaLZg5DEABNh1xCLQ80BxdkNdPxtCtYEDq2kTDdW1O6daeoz+19ET1ONgqQjRpbnzUpbpz4zxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934323; c=relaxed/simple;
	bh=Y8Oj/2MO/PIGGlx75m1tYYWVxVvHMxX7moB5rou0no8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uAdIPed+OtdqtL0sr2D/JqS5kBRxXqU6uJhwoTGlVzMcKPlfDMJdqrQxnHoM3+Uu6CTHqc3nW/TRBrQnRaV+y6gc4wo6OwF91MsUgtngcoVjtLEjW57szmjQbMLUpId9n0BrcuCcn/oyBprAkIkBeft2nSW2hDWU/9abgGJ7jTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NmfHAEIV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NmfHAEIV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHcTC3725260;
	Wed, 5 Aug 2026 12:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dp6lqC/IaqHGcUthe9B0UG1lf67zbhuwq4levDRmh
	hA=; b=NmfHAEIVuB/JJLN64CmfnNqDXKputohxCeLzKHxn1fmzGDa7OZCFi+BGS
	/c1eXPEgD7OUs4tZS9ZNsMLTAldyMxirnzCmtinhC4qqOEFqJqrIagESPHeeIUwa
	8srKa6rRZbNNh/6YOvapIU3E3qpVjUzAtkqYId3D49cj+sRZrNTQqgZdq8PSIFx/
	tNh1f0EagkiaYJfB3ZCTeeVEJb/V8YjwR0sVeY5+u50e9KNAe8iWCsZLF9VRFKKO
	6ZSbLuX+LT45F3UGiFULbLcNcdYqLNgFzSlTgl381iIEdEavBtf2fWARVV/xe2SA
	y/p+LmswrjqG9lH1aGG6YKCdoZdPg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67htu6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:51:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675CfIJ3017500;
	Wed, 5 Aug 2026 12:51:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k6jeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:51:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675Cp1TB60948978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 12:51:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 708FC58045;
	Wed,  5 Aug 2026 12:51:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE20258050;
	Wed,  5 Aug 2026 12:51:34 +0000 (GMT)
Received: from li-75d4d1cc-257f-11b2-a85c-f97fadd0f3fb.ibm.com.com (unknown [9.61.130.57])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 12:51:34 +0000 (GMT)
From: Avinash Roy <avinash@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, bhelgaas@google.com
Cc: npiggin@gmail.com, chleroy@kernel.org, sbhat@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Avinash Roy <avinash.roy1@linux.ibm.com>
Subject: [PATCH] PCI: quirks: Add warm reset quirk for IBM Spyre accelerator
Date: Wed,  5 Aug 2026 18:21:32 +0530
Message-ID: <20260805125132.941270-1-avinash@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwMyBTYWx0ZWRfX7u4PNvW2fnsV
 PC3jmQRu7nQg86lZLMqZU5VvBqAYMdbS9HxTEeQYFzqSl39ETGddJqENIy2x9jhbjR017qbUkxx
 eJ7YHsL77SSlcTPexeHnXjDNBwpikDE=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a7331dd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=mUP9U6Z0ULmw1JRC5QIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwMyBTYWx0ZWRfX5hh0+GgiASfI
 yHd6UdCsvA9gQiJKJLNdxzr06gLh7qVee8vAD5sia7pv2ZoDyqOK/C2/Q0GiW7VMvsVu2ZChbwc
 9kGfX8v03JKuGKLhynKfYXLLUw2D+GPDmpVnAlOY8xEEj4kzbTIiwXWrzUsSFOiZRNhKQogvkCo
 hdB8NoPzcfWKtD4PgqDf+8SZSL6P331BZOZC9s+oNi9xLN/KimGhAto6hBIUZljkuHImUNpXXMF
 O9LnVwdeCVNIday9l9OTjSOxz1sN1hfespc0C7QUmXVYbDX8RnDq7qfH6ervCm45EtPhTaxT9WW
 xvYZOtahkJzLUNbEUrfI7qfsuVdGIJNESLrIoafbTGr4nYtf/Xr5AuZptf3M2bFcj7fU6QjRcHh
 7WZ5GvxhfmSEWmhbsp64qIwo0vuCcFXk0aziTUYLS2QvSmybgg+3AvJor06OIwBcEWafyIZ6exv
 OgAybOiLZfrbBXsdt0Q==
X-Proofpoint-ORIG-GUID: oWmMSvXGHFqldx1nCxPStb-X2Ko6V9_S
X-Proofpoint-GUID: gUsY_FeI19815_0Ubm3UefDIC5Kx_zIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050103

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
reset method for reliable EEH recovery on pSeries/ppc64 platforms.

FLR alone is insufficient because it does not re-initialize the Spyre
firmware state machine. On ppc64 with EEH enabled,
pcibios_set_pcie_reset_state() is overridden in
arch/powerpc/kernel/eeh.c to drive the platform-level PERST# signal via
EEH PE operations, which is the correct mechanism for full device
recovery after an EEH event.

The reset function is placed in arch/powerpc/platforms/pseries/pci.c
where the EEH infrastructure is already present, declared in
pseries.h, and registered in the generic pci_dev_reset_methods[] table
in drivers/pci/quirks.c under a CONFIG_PPC_PSERIES guard.

This reset method is only registered when CONFIG_PPC_PSERIES is enabled, 
so it is not available on other platforms.

Reset sequence:
  - Assert PERST# via pcie_warm_reset, hold 250 ms
  - Deassert PERST# via pcie_deassert_reset
  - Wait 250 ms for PCIe link retrain and device recovery

Signed-off-by: Avinash Roy <avinash.roy1@linux.ibm.com>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 84e4ffe957a8..7aa58d57208f 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/string.h>
+#include <linux/delay.h>
 
 #include <asm/eeh.h>
 #include <asm/pci-bridge.h>
@@ -236,6 +237,41 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
 			 fixup_winbond_82c105);
 
+/*
+ * Reset Spyre adapter using pci_set_pcie_reset_state()
+ * This is specifically for PPC platforms where EEH (Enhanced Error Handling)
+ * requires this reset method for proper device recovery.
+ */
+int reset_spyre(struct pci_dev *dev, bool probe)
+{
+	int ret;
+
+	if (probe)
+		return 0;
+
+	/* Assert warm reset */
+	ret = pci_set_pcie_reset_state(dev, pcie_warm_reset);
+	if (ret) {
+		pci_err(dev, "Failed to assert reset: %d\n", ret);
+		return ret;
+	}
+
+	/* Wait for reset to take effect */
+	msleep(250);
+
+	/* Deassert reset */
+	ret = pci_set_pcie_reset_state(dev, pcie_deassert_reset);
+	if (ret) {
+		pci_err(dev, "Failed to deassert reset: %d\n", ret);
+		return ret;
+	}
+
+	/* Wait for device to recover */
+	msleep(250);
+
+	return 0;
+}
+
 static enum pci_bus_speed prop_to_pci_speed(u32 prop)
 {
 	switch (prop) {
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 3968a6970fa8..79c194aeb3c6 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -92,6 +92,10 @@ extern struct pci_controller_ops pseries_pci_controller_ops;
 int pseries_msi_allocate_domains(struct pci_controller *phb);
 void pseries_msi_free_domains(struct pci_controller *phb);
 
+/* PCI device reset method for Spyre adapter */
+struct pci_dev;
+int reset_spyre(struct pci_dev *dev, bool probe);
+
 extern int CMO_PrPSP;
 extern int CMO_SecPSP;
 extern unsigned long CMO_PageSize;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..1b8ab5d9764b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4237,6 +4237,11 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	return 0;
 }
 
+#ifdef CONFIG_PPC_PSERIES
+/* Defined in arch/powerpc/platforms/pseries/pci.c */
+int reset_spyre(struct pci_dev *dev, bool probe);
+#endif
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -4252,6 +4257,10 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
 		reset_hinic_vf_dev },
+#ifdef CONFIG_PPC_PSERIES
+	{ PCI_VENDOR_ID_IBM, 0x06a7,
+		reset_spyre},
+#endif
 	{ 0 }
 };
