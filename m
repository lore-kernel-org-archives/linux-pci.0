Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC253368AA
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962374; cv=none; b=gvWXmVX84IPd3aSxlE0CSujq5C9OjsQ2UxL6MmN9vyxTt7LlPkG9dQ+noGZuyy6HKE1sZvCbdIGbs2Vwn8lqNkYFA4R9UjTtVsqg45evKE8MBsmtihOjcyXJCAd87XOzwUEr8MvY6OTVXyFRkhuFdwtTNVKQ0wMXXzB8xMGTD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962374; c=relaxed/simple;
	bh=GViVcwn+usWZpdsGAlpdSgcYeNdI3UPMett5ODt2vkU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XP/HmK6s/8m1ntRFT9NGwyQ3znwtHeJZN5+Y/v4KSTg4Ve0U2WwEkwFlDE9O17iSpTY3OU2qmfE/39V2a3tftVlG7PLwNEkd1C/AG+Z8XozIJvG8nO00JVHMlqHtZMIhxaXSD0hQYiDobz8ccZUDroHW71As9ATQ8rMRbPGd3jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=qb5LMIbJ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="qb5LMIbJ"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NFl4Vu3925924;
	Thu, 23 Apr 2026 09:39:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=EFqeliISL3HH7UUyFY
	ct0gI6YTPTrqub6g2c5nJ7u2M=; b=qb5LMIbJMyAfvp4PH57NRhDzVqPm/YKxfn
	quNdrXi1iaGEKLW3ntYnMN6Of5TCFjzVW78Ip6x/ASNICIitPWEzn6yolxh6o6IF
	AlKOG/HW3/SEpich50nuun9kV4e1oqfkKCsHrhSUgSJTfgPkZ6sIqfq1T6OlL5CT
	ElN+Hw+8ZFSHGRd/DeIh6AIkZBx5ZX8jiJMS6xMBp0i493utLjeVR9yFp2HXl+/t
	3DMOOzzr3YcPiFiHrTYVvJkxxl5xmD0MhNEhVWYjdNwMlRn1qx454Ulqvhmq9kZ4
	PluGgJk2feHdZ73WJCthntFcLbMSB4U9prjgeUVATXHiEKA1mHGQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepbwy52-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 Apr 2026 09:39:29 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 23 Apr
 2026 16:39:28 +0000
From: Mattias Nissler <mnissler@meta.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Mattias Nissler <mnissler@meta.com>,
        Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH] PCI/EDR: Support EDR_PORT_DPC_ENABLE_DSM Revision ID 5
Date: Thu, 23 Apr 2026 09:38:24 -0700
Message-ID: <20260423163824.2719927-1-mnissler@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3XhLyAMaNaVPh3yqxsEjE0JUK3srUL3G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE2NSBTYWx0ZWRfX9C15ryby4Pwy
 H121KjXAHJeczuqeHPvRDFhExNPdFcm/K0CoMCEXagNa7arWU+z2uoVNoBvahAgnqN0f82kVcIH
 Z5mUuF0UpI7OUTefJy8hdj4Wim4hZWst5q+CKeYqQerFK/Z531OcEY4IBVcD9BRPqpLmUkDJ76i
 ESLnp9TZi3aUiZCRnAzT+qoFv9NuDs5hp3CSg4Z4ZxqvT2V0iUM3biyV9cVmYYlhaYxvcftp2G/
 3wAkFsnuSqH7cjKgVs3zv6iqS9pVKEwOIhb2pGJwMx0+1WupbTb5NO+wbH/CkDoq0V0zOmz6jHc
 pOzyWP8Dj4em/a8P/soW/KL1kb4rGX16lKv/YCSaDAhaAxdlcCLVWMg3pQHrHwjDL9bGF9cH8gZ
 UctBtLbjRFoXgfZ50LZljdXWLWnpyfpZpVH1dkhyOeuBAzOO8pnH5hRPG7DSGW6/ixkRBDZPvYT
 i9PNV9XJ5NwvwZ6HCfw==
X-Proofpoint-ORIG-GUID: 3XhLyAMaNaVPh3yqxsEjE0JUK3srUL3G
X-Authority-Analysis: v=2.4 cv=ap6CzyZV c=1 sm=1 tr=0 ts=69ea4b41 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=QyXUC8HyAAAA:8
 a=BBbe4nR--wp83Su4mewA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

Commit f24ba846133d ("PCI/EDR: Align EDR_PORT_DPC_ENABLE_DSM with PCI
Firmware r3.3") updated the code to adhere to the
EDR_PORT_DPC_ENABLE_DSM interface as defined in v3.3 of the PCI Firmware
Specification. This DSM was originally proposed in EDN 12888 under a
different Revision ID and with differing parameter type for Arg3. It
turns out that there are BIOSes in production that only implement
Revision ID 5, so we're re-adding support for that.

Signed-off-by: Mattias Nissler <mnissler@meta.com>
cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
This patch deserves a bit of commentary, as I'm not really sure whether
it should get applied or not. In fact I can see arguments either way.

On the one hand, BIOSes are supposed to implement what is standardized
in the PCI firmware specification, and supporting random
pre-standardization variants adds unnecessary baggage to the kernel code
and reduces incentive to implement support for the standardized version.

On the other hand, the text in the standard explicitly calls out the ECN
that defines revision 5. Furthermore, there's a chance that there are
machines out there which only support revision 5. At Meta, we recently
came across such a platform. Fortunately, we do have the ability to
upgrade the BIOS with revision 6 support, but I would expect that this
is more the exception than the rule for users in general.

Bottom line: I'm posting this in case it is helpful to others, and to
prompt consideration/discussion as to whether to apply or not.
---
 drivers/pci/pcie/edr.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index e86298dbbcff..e5cedd41be04 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -28,26 +28,38 @@
 static int acpi_enable_dpc(struct pci_dev *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
-	union acpi_object *obj, argv4, req;
+	union acpi_object *obj, *arg3, pkg, req;
 	int status = 0;
-
-	/*
-	 * Per PCI Firmware r3.3, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
-	 * optional. Return success if it's not implemented.
-	 */
-	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
-			    1ULL << EDR_PORT_DPC_ENABLE_DSM))
-		return 0;
+	u64 rev = 0;
 
 	req.type = ACPI_TYPE_INTEGER;
 	req.integer.value = 1;
 
-	argv4.type = ACPI_TYPE_PACKAGE;
-	argv4.package.count = 1;
-	argv4.package.elements = &req;
+	pkg.type = ACPI_TYPE_PACKAGE;
+	pkg.package.count = 1;
+	pkg.package.elements = &req;
+
+	/*
+	 * EDR_PORT_DPC_ENABLE_DSM is defined in PCI Firmware r3.3, sec 4.6.12.
+	 * Revision ID 6 is the variant that appears in the spec, Revision ID 5
+	 * corresponds to the variant defined in ECN #12888, known to be
+	 * implemented in some platforms.
+	 */
+	if (acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
+			   1ULL << EDR_PORT_DPC_ENABLE_DSM)) {
+		rev = 6;
+		arg3 = &pkg;
+	} else if (acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+				  1ULL << EDR_PORT_DPC_ENABLE_DSM)) {
+		rev = 5;
+		arg3 = &req;
+	} else {
+		/* Return success if not implemented. */
+		return 0;
+	}
 
-	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
-				EDR_PORT_DPC_ENABLE_DSM, &argv4);
+	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, rev,
+				EDR_PORT_DPC_ENABLE_DSM, arg3);
 	if (!obj)
 		return 0;
 
-- 
2.52.0

