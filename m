Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BA4317D
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296164; cv=none; b=nvDs9MlysrOqz7CmzsuDN8QFTOlEbhniBb5IOP9BI61NJe9bQUJLfBMuWATUSAutFIt7toDbvCzYQnv9OogJh1lVgnSPN/yvl/6FNBdB1MhH2IwBzLfMIKkdLxgawy6uJZHOxj9thFshyoyA0J/a2UHZkC8YLAjJ3DKT5WaDdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296164; c=relaxed/simple;
	bh=L1HljvU2xvbzF/aLGQarPA4ktyCZjGfjunv/5XdAHOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AyJ5EgY2qXfOXBnXJf3bHDIPdnB5MJVpD7R46n0fSac4z+8lZZWTggoqOFlHRZvXXdHfVo25V6MSmIGruf7cu0u5Q5U0c5nMAf5jznYbI6SJ/dlEOc8un9h/zFfqsSMli7+PjPR55afM6qlIupxtIwXYaBn/5WiEPbFLtJvgu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NoibjIRk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sb6hgENx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NoibjIRk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sb6hgENx"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5togl533305
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 10:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NcoHzJszeYpqsM2A4EUkIi
	iMUIpNqZhSmYTarqLAzy4=; b=NoibjIRkOWFQ6dVHE0iRVoPy/hAWwieQxLadls
	/1u9GSMgEDczXR5mXWgA3hZrbxM6vPNsN7mtgGIMDJXN9ylcA/D0vIHOqebC9Lyz
	SeAm0re2XUA99L0fWq53TXLIK1HbVJS3ZCX+bnLCqlX6dOCsBpvW0nOch72wMO+N
	9w5bwWn+DB6WdlZWk85i5pQEKG0FuYZQA300YSsloFPkptwR8Rnz2hadvzVNOQPN
	w6y3PwLCVn3HnDtoxhNhN9d2GSYUh4Tcu+h3hMGdfYLwY7/L2XoQvHGP6ftZlEn4
	vHTF3phzhqZlYd2Re5Kvoc8I5cl8if+WKn+FYlwnoxYpN6Kw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f06r31jc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 10:16:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c76be5dd09so6329025ad.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 03:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782296161; x=1782900961; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NcoHzJszeYpqsM2A4EUkIiiMUIpNqZhSmYTarqLAzy4=;
        b=Sb6hgENxRiL7irtjFaFPlqcr4iO2H4anLxGQTR0Ks1STqQY43rKb3cwU0WDPif/9b7
         CsFMVQDvWG0Tpp3BPg6bTD+PecleZI8ox0z0Txo+5W428I6gpdniSwEAZp+oX0Au7c5Y
         hAnItEtowmj4vqXK8gFqRQkwc9xn+b6P+S9Y0pTy38rHid0f+hBNuiVVuVerXKOYkcSq
         Qtc49PBMVUUFH0lVZYwgVBxDx3YHcmwMzou7I2xXUEfrKdX7mP3pi/jqXcNR81VjKaqg
         bTWgJn0L3HJbtsl4KhccBqx2VDwAWLZTxh5NFlnLUPUa1bABDyeSOY7dKp+yNHP2V/TB
         cbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782296161; x=1782900961;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcoHzJszeYpqsM2A4EUkIiiMUIpNqZhSmYTarqLAzy4=;
        b=gqWRfavzaOicW3KFgIaXW4rVNuC2qxiy8xo0xkRHO0SG2YKV3jWcdzkuaAN96KXKYL
         WXZ9S5Wihj/CJxVdhu5BxayIFPsA9De+6yPaWSRAqEGRnSByUGiWLIwdZQzy2Iv7kief
         WSbnlD6uKb5qPgjmUmi8cl3tzqfJPnOrXh5l6oAi00BXJcpLlv040aKpCoRl3NNTyn/x
         vLgoR40lpYaJM+P2+uvxv7Ows4XtqSQck8KGcUhR7RbFj2/D+31goRfDaWejMmW+zv/U
         GCu3ANy/2MUGM7A8U+jZSbkYvn4xo20dn/qr+uZzO6R34ZjUqmym6tFJtriJu2KVHM5B
         8wmg==
X-Gm-Message-State: AOJu0YyemONSZRYhoNvjaT7ammxfOdjPNqnt1ApHOLMkvwBt7chJWJjt
	22RlT3vm5PwxeavZQERrqj4xmpCXzBJ3ifZFIENwvtIgFDevHXs05MEBIVDDu18C3jOYjvDEHmI
	ahi8zZk24d6kf7+B6mzrkpQ4ZLvFpFd2ZW05BCk8onKNWsqs32z6/iboYOi/tTlU=
X-Gm-Gg: AfdE7ckBwJe/kPywvRisaOIZGLAHZzHPhBnKqwefo/SvGPLPMXikysujt+/5/zIK0UT
	SbC4dYnusjukTzilLWu5SK7vg31AOqW1aHKnBhLcTHl5jos6ynI6Z/FLCflCU3Xf3z20IeQ4zqv
	RlP+T6/RblzqfY/MvnPVn5tkuXpaK6lFqt+bvTUVTxqgZdwZXPpQmBUOY9Uo/pi/iPrwRilOjWT
	QDu8YqIp3qfLCpZQTJysHo01wsXVMHVHg0EpLVvpCIST5kmO47JRKpy+a1tkEfY+au+OH2NoWE/
	fmt5HaiNbuKSq4pEhQq4rwDrXnpQyBfkmZ1op17JMusCBHq/gQ5ObqEr/aj76ilnahNrTolHk8H
	m2z2KXMHgmbB7pemapa3TBoRwmHLEqB6VC2H7GcTzxoPsXA==
X-Received: by 2002:a17:902:cf10:b0:2c6:95d1:3bbc with SMTP id d9443c01a7336-2c7e157bf30mr29715235ad.24.1782296161166;
        Wed, 24 Jun 2026 03:16:01 -0700 (PDT)
X-Received: by 2002:a17:902:cf10:b0:2c6:95d1:3bbc with SMTP id d9443c01a7336-2c7e157bf30mr29714845ad.24.1782296160595;
        Wed, 24 Jun 2026 03:16:00 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aad99sm155645355ad.80.2026.06.24.03.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:15:59 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 15:45:53 +0530
Subject: [PATCH v2] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-aspm-v2-1-800a4151ba3a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFiuO2oC/yWNQQ6DIBBFr2JmXYwQaENXvUfjAnGoNFWUUdPGe
 PeCbiZ5yftvNiCMHgnuxQYRV08+DAnEpQDbmeGFzLeJQVTiWkmhmaGxZ61RyigpbholJHWM6Pz
 3yDzrk2lp3mjnvM1G52kO8Xf8WXn2zqTi/EyunHHWSKMdaqWs049AVE6L+djQ92U6UO/7/gdsh
 M2xsQAAAA==
X-Change-ID: 20260429-aspm-da55a54279e4
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782296158; l=3550;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=L1HljvU2xvbzF/aLGQarPA4ktyCZjGfjunv/5XdAHOU=;
 b=krMzulRV5cuXh6TFG3E+M06fddjE2+mD0mEQRAJ6ivoXB5MK69YKBweciOOPYx9CV9gZt+kn3
 TwVWJmKZaZkBGVwNJS8A6hZWSp+dmwjVZvvrAaODVs5uFDplTtTgZJO
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4NSBTYWx0ZWRfX9o+oCVQo9+Zq
 EiF1W9o8sdkXvXeeWQKPcn/6yZlAlj72ZPQ4nfaP0wAmYcvco0RdiuMlGtcipwPQJZMbW0r4EuZ
 tyxifPeHfBffD8eRa21Li26BHQXIqQk4ovvarLv4PXo0qhaQpzX3zO69lkqko34r9TXuzM1PN8P
 7RW9QG3fMGBupBBh+3LAYbGAfGVm4R8gaSKq1EC5rL+qbIUfiltlH8FlywnObCq7Oe1/MIJJpUP
 ZkTT/rAsCkK09mjTKiJ9nw3f2HY3oZbCPc+AGrMMtjhISe6QjRYJ4Ct+EEW5nrx6pnDUb7zR486
 EC8wg0sjpQQX9E8XXCZz+u+TgIanY28e4XFSpy8Q0/jqUHs6VJ3hSr7SDnEq/MOqFFo7xhSPv/u
 YINlsAcrC7PTxrfkDXnGQjxuygEype/26hlt9Xsw6z5Wqf7jVQ3i9mADkl22Ko/bos3rnugcQ+A
 v1i7GlxhEByFOfUxxdA==
X-Proofpoint-ORIG-GUID: bhbF7IlDo_DaWBZis8lxHh0_UrJiDpsQ
X-Authority-Analysis: v=2.4 cv=ZM7nX37b c=1 sm=1 tr=0 ts=6a3bae61 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=XdZErTz-F4VmnR4h2NkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: bhbF7IlDo_DaWBZis8lxHh0_UrJiDpsQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4NSBTYWx0ZWRfX5uEF04Q3G+XX
 lUC24qFnvqjJKCUvszg4C8xixVW1Pa1N9q2kk6UHlns9df3ftsNTbiJRs2Q7Y4J0SWSLnI5P9xI
 UNds3gnIfUtKh34Sb2y6XaM7Eq8ZjSM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240085

Some platforms require selectively disabling specific ASPM states on a
given PCIe link to avoid link instability or functional failures caused
by board-level connectivity constraints such as PCB routing, connectors,
slots, or external cabling.

Devicetree initially supported disabling ASPM L0s via the 'aspm-no-l0s'
property, and has since been extended to also allow disabling ASPM L1 and
L1 PM Substates using the 'aspm-no-l1' [1] and 'aspm-no-l1ss' [2]
properties. However, the ASPM driver does not currently account for these
properties when determining the default ASPM link state.

Update ASPM link initialization to check for these Devicetree properties
on either end of the link and mask the corresponding ASPM states from
link->aspm_support before applying the default ASPM policy.

Link [1]: https://github.com/devicetree-org/dt-schema/pull/188
Link [2]: https://github.com/devicetree-org/dt-schema/pull/190

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Disable L1ss when L1 is disabled as pointed by sashiko.
- Disable L1ss if bootloader enables them but we are disabling via
  devicetree pointed by sashiko.
- Link to v1: https://patch.msgid.link/20260511-aspm-v1-1-b4a9fe955cf9@oss.qualcomm.com
---
 drivers/pci/pcie/aspm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 925373b98dff..a79426b5bff0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -27,6 +27,8 @@
 
 #include "../pci.h"
 
+static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state);
+
 void pci_save_ltr_state(struct pci_dev *dev)
 {
 	int ltr;
@@ -799,6 +801,13 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 
 #define FLAG(x, y, d)	(((x) & (PCIE_LINK_STATE_##y)) ? d : "")
 
+static bool pcie_link_has_aspm_override(const struct pcie_link_state *link,
+					const char *aspm)
+{
+	return (device_property_present(&link->pdev->dev, aspm) ||
+		device_property_present(&link->downstream->dev, aspm));
+}
+
 static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 {
 	struct pci_dev *pdev = link->downstream;
@@ -806,6 +815,24 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 
 	/* For devicetree platforms, enable L0s and L1 by default */
 	if (of_have_populated_dt()) {
+		if (pcie_link_has_aspm_override(link, "aspm-no-l0s"))
+			link->aspm_support &= ~PCIE_LINK_STATE_L0S;
+
+		if (pcie_link_has_aspm_override(link, "aspm-no-l1"))
+			link->aspm_support &= ~(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS);
+
+		if (pcie_link_has_aspm_override(link, "aspm-no-l1ss")) {
+			/*
+			 * Clear L1SS in hardware before updating aspm_support. Once
+			 * aspm_capable is derived from aspm_support, pcie_config_aspm_link()
+			 * skips pcie_config_aspm_l1ss() entirely via the aspm_capable guard,
+			 * leaving firmware-enabled L1SS substates active in hardware.
+			 */
+			if (link->aspm_enabled & PCIE_LINK_STATE_L1SS)
+				pcie_config_aspm_l1ss(link, 0);
+			link->aspm_support &= ~PCIE_LINK_STATE_L1SS;
+		}
+
 		if (link->aspm_support & PCIE_LINK_STATE_L0S)
 			link->aspm_default |= PCIE_LINK_STATE_L0S;
 		if (link->aspm_support & PCIE_LINK_STATE_L1)

---
base-commit: 840ef6c78e6a2f694b578ecb9063241c992aaa9e
change-id: 20260429-aspm-da55a54279e4

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

