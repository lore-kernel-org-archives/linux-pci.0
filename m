Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472582820AC
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036665; cv=none; b=uCGt6XEM1o4NAYZglcVZ7QOffyX/flo/lUuyW7GyG9lU8TuuOdUSvmpTqnNo1zQs8qdFdmVxDR2qiZ+cYg5VhOCd5AC5uDs9NvgVSytxNlpGrah8pvgvRGQYFdnulseL7qf39QP3bpFTDrcQ35iKMPJ1bd09pfR4rVrf7b0HVIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036665; c=relaxed/simple;
	bh=nRhrwagqj1Y/m53ZdIFTGGDjhi1SXcSMtIvkOyVmah0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTLfnuyOLspNNSENDmZkb8CO/9wrqjrhHpzN1CpBEmFU6D9GbCKY0/GOSCxQgF/Q/yWGbKFNjxoMJVgBA/nGsNDyS9iGBJglLJ+IMULYwJjMDO/89vjKXxbWuk+mkgs2MxZNSe+UP74kVjH7V1TBeYwAYCJ71lNWeqLOViGRXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IYX/dHdb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bMEIXH1O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IYX/dHdb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bMEIXH1O"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9SIhi1363573
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=16JiYRkM8Us
	t5Oul3yCggEtZkUZxoeNARYD5+VymD0k=; b=IYX/dHdbSZ31Q/CuAc+S78BRZYk
	gb0RgWIk5Re1S6XMQYDqPGVlk9IUycyaqaP3Z+MDNHImWlNcd7iPlJA4ozNe4upG
	OVDudcG7VMbesHxgtLQXe4As+3WhWgFC7qauoDeIuuD1Vr0d1aNkrBx1NNJRGKwr
	gJZTHXGBtHM81e3cXtIAkCoasuVnu/lGnvb5rCscmFqmgBOZQyL9I6SwUNRmzEIb
	E4XzFHAhH0fvv7FA9H2xop5C7tqhQX990M8m4qgMphk895nDzHpT7FxoSjV7K3Yk
	7iH0BPE6oEA1zOvdxdWeoPRfZEAO0C5cHtHHDIrjmylFAkkBI9vlxjhdslQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chp15apk0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:24:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c70eb09daefso429755a12.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 08:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772036662; x=1772641462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16JiYRkM8Ust5Oul3yCggEtZkUZxoeNARYD5+VymD0k=;
        b=bMEIXH1OES/ga4AXfUiKvBCK+gMQ/Dg+LDVbiRcUpjAZ4hWU2VSI3zeQ05ToJvph7C
         zufnSWZta3i8vHXHXIbVVpKKv/r0lF5GR6iiOVmYqokmW7gwRf6nyCcewLQ/3n2uf4Li
         z83DsOcdFb2xmJ/H9iWQKECdObfxP44CfBbC/hPDU4vSFUCf5kXU/xT7wKWdJH5XMoCg
         TgjXzy6uvOozoze+6YWK47o8IYI8VhjMTJ7c+cuiW5SPzFwGA7aoeK+fxOclg4Nh9QHV
         DgqeRSwoo4UpKe+uws3dU8bte50ld2I+ZfX0KieLRdS1VN7XA8qXJyq2uy4Op8MVSfEC
         6v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772036662; x=1772641462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=16JiYRkM8Ust5Oul3yCggEtZkUZxoeNARYD5+VymD0k=;
        b=auOi8uS/mR+ij1tnDuMKrqNRlWlqQKT+dBgd6DYkdpTs5gS+FjVmV3vYrBcLD+4XGH
         ++NK9rmu6IcuE74ofSdygZTy0O743JK04ukm3d9xJoz7etgNxEs7PXBxe+RmgZl+mZO/
         aIR9MsPongkgG6UM/YWRNyAzEVSdsWIpL0x2yfnkoxpH7ElmCdzemfnoziyz04PYD/sh
         TlKkyuEHbqbVBMHQCAmPOvxy7r0bp45jTvmcI0mckU4VRr3Yfow1bosDuAI0fJlH+Evy
         U3dqDN7/Deuf99w/mnuyCJPqrJoXK8FIaKLEIRro3agPPdp1qyFo9ZTgsO/j1xcEYw3A
         SpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhXSVs5mN358H90/URkg/Bmz+dqyizNBNQQcA0F1e7F/ey49uFAW9rxawkKEsCr+6FneL884yN5mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF1kq+jTUSaux1mWwgQim1UQVBLX2JKOUk0DrHCnNQoHJDadjv
	NOb8FdTQ2XLIcZOmKGwhKGB3xRjUvv7EObVR6c1ebXLnbG+tX7nIlSpKCgQrmIXMYskwSxr8RYY
	A2O0vP35yvcYs25KhBMR+2lTjsTaz7XXeAFQag9DY5CIz5ssh0rrseV4JyigzoR8=
X-Gm-Gg: ATEYQzy/s1Fn/yFEYdjcd7meMwPeD3k65kdpYtsIkyVcWqduETvo6O3WbWsUJUlAy0q
	dhfMa8mYDcW4D9+ZOgjBB0VK+SCjQ53iiiAOInLq8rg+dSILpFFs7Lv8p4V2xCnfsDkxk50XGB4
	mZ+byTPcxysiYk9KYI4cImENY9V7CVzltx3hrYs/CPe6dJxEswK9V7eJJuQc05dkGFwePlcLRlf
	ZiwKPXtg569NgU7ku7qamxCWc/QQ2D0w4a6t6ve6q3bBWCy3XUgWwg9RvIensj0ZwM7wt4gPruT
	1od/5SbXhZyCSFQBM4vg1qFhYo5HZ+UvNp9rXBzFLKo+mTZkEJVLkuhLqjL1BgN6YZulZWp0WVp
	LU9rKKmylJHhbK6mIGyjbzDe1bXbw5ccjOzC2rp8stQ==
X-Received: by 2002:a05:6a21:117:b0:38b:ecae:670c with SMTP id adf61e73a8af0-395ad0a2556mr724370637.25.1772036662044;
        Wed, 25 Feb 2026 08:24:22 -0800 (PST)
X-Received: by 2002:a05:6a21:117:b0:38b:ecae:670c with SMTP id adf61e73a8af0-395ad0a2556mr724343637.25.1772036661465;
        Wed, 25 Feb 2026 08:24:21 -0800 (PST)
Received: from work ([2401:4900:8fe5:3076:4038:f293:b188:d52d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71a735csm12822380a12.12.2026.02.25.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 08:24:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        cassel@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 1/2] PCI: dwc: ep: Add MSI Enable checks before raising MSI to the host
Date: Wed, 25 Feb 2026 21:53:58 +0530
Message-ID: <20260225162359.116000-2-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225162359.116000-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260225162359.116000-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE1NyBTYWx0ZWRfX7TouwpFcipk9
 Y/XJnvAGrp8z2MU95pgQDA0dkRgX7AYYgcmot17aDBeGHKqK6bhpmMjxcZSWlG0ree4BS5eMnaD
 fyRozgdkeKhzFkrZrHC92e3sdKYE/3qsx2NSXLFia19jUrqWrgK895nuVsnLTs0jW5sV/3eCNRA
 gmW+ILcY1a/oxOYPtbjQejlDkRWqI+ZJJbJYTS+8CeaUMY0SSCPtyQJQloTCv4yXmR9Q9MljrzM
 eZZpIghkbB3rySzwhOfbNZUAfPzoPkxWuD9B+MH1s/aLMyR8xsJcAKvhIoazWbh+O84ZC/sS1A6
 rbhHwcLfsoFoMoqu9TV7y2d85GmoYlJfF/r2PMCAhgej4ZIpKXIE4E8aEL5BcMxgbLWRMnv+vW0
 7hzjBYW0bkoEVenWvaxg6QJl782sJVMOJyubp4vOEd+wxi+mBEpqI5ohqq7hQ9iULoMFoKsNp00
 E8MhO8lyxiDqED8U94w==
X-Proofpoint-GUID: jHA1aCDBOk1zrx9is_gGSMjaFXAOvwQA
X-Proofpoint-ORIG-GUID: jHA1aCDBOk1zrx9is_gGSMjaFXAOvwQA
X-Authority-Analysis: v=2.4 cv=etXSD4pX c=1 sm=1 tr=0 ts=699f2237 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=h3NFc43X9HEVXFFuZAYA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250157

PCIe spec r7, sec 7.7.1.2 mandates that a Function should raise MSI only if
the MSI Enable bit is set and MSI-X enable bit is clear.

Hence, add those checks to be spec compliant with relevant helpers to avoid
code duplication.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 43 ++++++++++++++++---
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 295076cf70de..fcbd648e049e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -672,6 +672,17 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
+static bool dw_pcie_ep_msi_enabled(struct dw_pcie_ep *ep,
+				   struct dw_pcie_ep_func *ep_func, u8 func_no)
+{
+	u32 val, reg;
+
+	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
+	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
+
+	return FIELD_GET(PCI_MSI_FLAGS_ENABLE, val);
+}
+
 static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -682,11 +693,11 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	if (!ep_func || !ep_func->msi_cap)
 		return -EINVAL;
 
-	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
-	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
-	if (!(val & PCI_MSI_FLAGS_ENABLE))
+	if (!dw_pcie_ep_msi_enabled(ep, ep_func, func_no))
 		return -EINVAL;
 
+	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
+	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	val = FIELD_GET(PCI_MSI_FLAGS_QSIZE, val);
 
 	return 1 << val;
@@ -716,6 +727,17 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
+static bool dw_pcie_ep_msix_enabled(struct dw_pcie_ep *ep,
+				    struct dw_pcie_ep_func *ep_func, u8 func_no)
+{
+	u32 val, reg;
+
+	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
+	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
+
+	return FIELD_GET(PCI_MSIX_FLAGS_ENABLE, val);
+}
+
 static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -726,11 +748,11 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	if (!ep_func || !ep_func->msix_cap)
 		return -EINVAL;
 
-	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
-	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
-	if (!(val & PCI_MSIX_FLAGS_ENABLE))
+	if (!dw_pcie_ep_msix_enabled(ep, ep_func, func_no))
 		return -EINVAL;
 
+	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
+	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	val &= PCI_MSIX_FLAGS_QSIZE;
 
 	return val + 1;
@@ -877,6 +899,15 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	if (!ep_func || !ep_func->msi_cap)
 		return -EINVAL;
 
+	/*
+	 * PCIe spec r7, sec 7.7.1.2 mandates that a Function should raise MSI
+	 * only if the MSI Enable bit is set and MSI-X Enable bit is clear.
+	 */
+	if (!dw_pcie_ep_msi_enabled(ep, ep_func, func_no) ||
+	    (dw_pcie_ep_msi_enabled(ep, ep_func, func_no) &&
+	     dw_pcie_ep_msix_enabled(ep, ep_func, func_no)))
+		return -EOPNOTSUPP;
+
 	/* Raise MSI per the PCI Local Bus Specification Revision 3.0, 6.8.1. */
 	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
 	msg_ctrl = dw_pcie_ep_readw_dbi(ep, func_no, reg);
-- 
2.51.0

