Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2564133FE15
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149543; cv=none; b=k4HDCGSQ6j5gRjmXW70/p4o4BxaPGLMpD68SnQPubz6DmesoeGhWwoABpO/4zn4070BwWu3xANlNWXqPtCYmIbCFIJGGPkWApnnqo+wZ9QcGbQE0+fA4z8M/QMZd303O1LfN9zTFUrUoApKiRPesgbQyr4MsAgmXkYynMEpAxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149543; c=relaxed/simple;
	bh=vMVlmN+3MPUtn8iSuHRsgvSPszAsXgfwV4er7Ps1Iqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DsZW0x9mWtZZJH4k5u3XYklYGHxFmHoG1vngKEmuzAUYKvMWqRvnbuqrBF9ZBf/Btb4xLiI/wkD24y5J9OA3Yaqh6FIfRAZAcIRVd+Q6fk/cIy6xBwINp0oUH+5gEXfRAUrIwYpbIvmyyNKijUWHOP55XFZL2jonGxYLC8cJ6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A0pCNWU8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jyZCbn1v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A0pCNWU8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jyZCbn1v"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6V9lj1479046
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 06:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/973+ADhp7ja1pNXUALB1jgQRlOkwMbLVxA
	BVyNMYms=; b=A0pCNWU8PsEsJKGtzBXulmNPL2WjYWXOyLntyBOjrqNmO2z8Xe+
	GmS0Z4nvXh4JK810Lsf0Eqv1VkiOTVkGLjcc0ABFf7qEtwtyFyrkGM5MqWR67zKo
	ICXk4xHzKVRIKMA9hoRH+T7mot5kjwBh5xIgPU3JFyojttCN1ob9HDk1ade44E6u
	S8G0p7y8JtfWr+38Qh1JxUc5ZdNW5Wn3OBE5lEKUzMtL+c4FMj0Ng4/f05v/eCc/
	e7tXk2Mt7IG1WXu+gUPNZWeTicGg3ZigivosOczy02XjexgWNFO9XRI6EHhxv2tr
	Dbnw+/uPPxyMfYSa5Pm2m50/ov1n57SLuig==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87j1e9n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 06:52:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c769b25315eso6364284a12.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2026 23:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776149540; x=1776754340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/973+ADhp7ja1pNXUALB1jgQRlOkwMbLVxABVyNMYms=;
        b=jyZCbn1vcvIFJXJqL1DT9skAA3aG7cyIcmT/6e38+lLuJ8liGGUg2CjlRUK/9R0SML
         porxNn2cpwhgFyA66IHqG6EaU19pqnHyH/JDuCgbqHeQKLEDUCVAtaCLzC+DxtYtwGRd
         Wqd0xOvxamDQme8HTfCJTxP2sIULRkh+Z9PQsUKnJPU5vJPcGg401bnw3ZcAnTjETQkr
         Diav8p9rqdZFtAsKM0XDqefYEK/OaAcu6fC48hlkBI3ckI6gZMmL5lVXY8kdf6SnCxMf
         4RbgiqIeIS7r1bvSmygN7viYDEnWQOUvNml5D2SHnCZn++sA5DDimPRgONSAZtIZ/bwE
         c/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776149540; x=1776754340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/973+ADhp7ja1pNXUALB1jgQRlOkwMbLVxABVyNMYms=;
        b=DKsr4dG2xCXxmwhFQceKzpQKguBAryfnws1c/xIdp/7LBleVxpSo79eCX9bwl4jAMp
         dAH3GpTjcFAjofAzurWrHjuvYQZdvMq/ioNLt6GSQPOHub8kCGmHXoPnsqvFSPJDIG6W
         ZKPqK3Mqye1d67PyhgNh9BnjA3UilReZs99snkdhxtfrKor1Mr2jSvJb8COi1/0bh6C1
         DyQvhaliBNG2CDXYFEafJ2RTC6oPzMqU2Xnh7SEyZiEko7dcCEQ+wey63PCxbr7oBBGo
         cX5fBuVeLUqpLDke4iHSEOnLsuBUqawkSYR1M/tWd0nJhQlpI1n4dCoW58LAaXraK5Fz
         McdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bDgQgBTolEVHAbyaoo3XEiPVyHrHiein928IrXnYIwbN5l7fPeO9OVF1+vZr3tZGqkiv6sFL8fcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkyusB1eGnXBZyEHut5S2bsSkOX3XiAHRNFt5L7jd5trIx9qv6
	3Iefo45pCgU1LCBOhkTe8bryEmVxUPpwH0JCQ98cb1iI7x8yEq69FfWurUK8dpkMcvIIQkPQUUI
	y2hceE6bUV62Vifkbn2nvKFoasQgYgX6flnxvGmuWR+g11pycd7tgfOA3ZTFWW9E=
X-Gm-Gg: AeBDietNTgshdFxFC8hR4XwkxUbO3HXxBDM4m8f0gFw0L6V5jX/gYruB3wZoMLj2Fq6
	TzxbgpB1I/PICVl8aE+lS0Dv7Ksc7VRATkgpHA9nr64svMfooCjaVr98qPjXVCJw9fQ+IzRVEF4
	QV8T8tCYfVWNnXKR69wuOMlKp7PRX/HzuAd5Qw5V4qYtdZkdJj6RHxaj8FMLC+J/RhWvotciBMc
	guRbe20RoKNdHyGHfus8mNlxI4IuUH1p9isKbsI6j4AxQaDGeq3WIChPsv2+5g68mLY6wWJ5ewt
	BxQHAGf9qNUK3OBSdr9Jfmwo4grUIFNbbGXNp4653476LQ+mVzNAmhviN+x2VHHsE0XcfdtQc3z
	2paoGrwi2DpVwTx0/Cf1nlr39vVNYTzbopshcKWZ/YCHj0X0oSJIyROuhQ/TyoapPhcmkhEeuiW
	ojTuTrRppFikuC561ohV0CPpDAFrNWtHyYJaigekQ=
X-Received: by 2002:a05:6a21:3286:b0:398:4a1f:8a54 with SMTP id adf61e73a8af0-39fe3c91219mr18171353637.2.1776149539712;
        Mon, 13 Apr 2026 23:52:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:3286:b0:398:4a1f:8a54 with SMTP id adf61e73a8af0-39fe3c91219mr18171323637.2.1776149539210;
        Mon, 13 Apr 2026 23:52:19 -0700 (PDT)
Received: from hu-ymg-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79219fe2d5sm12226004a12.24.2026.04.13.23.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 23:52:18 -0700 (PDT)
From: Yadu M G <yadu.mg@oss.qualcomm.com>
To: jingoohan1@gmail.com, mani@kernel.org
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        robh@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: Initialize pp->lock before MSI domain registration
Date: Tue, 14 Apr 2026 12:22:14 +0530
Message-Id: <20260414065214.3085209-1-yadu.mg@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WCksoza26k4MH4aHRL3A8xRMKbaJR0oj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA2MiBTYWx0ZWRfX0BG8y9FS6KIE
 K2XrQep7c98dEoKLgg62eyhf/m09wo92A44Q5RW6Nq7OTujg5FBYRg6TLRr7kuNwFZGyt+GveT9
 6e7NEYQCH0aAKXeitQ/Dw+B7yXCgtnh+RqrPmIdFKiOPEwhQdPy4Y3B1V8YVoPwHYfU/JPG7lmZ
 D6izP+cp8rohyoK8j7uKgsTWI9u5B4MaWCVPaRuktKdqx4YhsoBeYWT64hfT6K4pqqsx3tWRoDn
 0Dsmw5H4sjsHoP0Cf0d+sN5l1/qDPNEPCju3qAJKTJLUYTJIZ1U4r2E4flN8fJFeXpaV//Nr+Ap
 G1zU+M1O4Q67hdcPl73LTzEWqi8u1TF3WVfYpQFdZEiRlz3mSkdZ3HJqHi/LrybqvvHFx6aT8FA
 Ys74eRkhD+YggspzUjhfysaRftEggSdN9amzCIqOdyFfMBbPceaY4e/FKJvxg1KvbmnRkfJcmNP
 E1RL2ePdA9JCBlTSrMA==
X-Proofpoint-ORIG-GUID: WCksoza26k4MH4aHRL3A8xRMKbaJR0oj
X-Authority-Analysis: v=2.4 cv=DrpmPm/+ c=1 sm=1 tr=0 ts=69dde424 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=4YNVNgpfuJSr3wIkXjAA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140062

A lockdep warning is observed during boot on a Qcom firmware managed
platform:

  INFO: trying to register non-static key.
  The code is fine but needs lockdep annotation, or maybe
  you didn't initialize this object before use?
  turning off the locking correctness validator.
  ...
  Call trace:
   register_lock_class+0x128/0x4d8
   __lock_acquire+0x110/0x1db0
   lock_acquire+0x278/0x3d8
   _raw_spin_lock_irq+0x6c/0xc0
   dw_pcie_irq_domain_alloc+0x48/0x190
   irq_domain_alloc_irqs_parent+0x2c/0x48
   msi_domain_alloc+0x90/0x160
  ...

dw_pcie_irq_domain_alloc() takes pp->lock while allocating MSI
interrupts. pp->lock was initialized in dw_pcie_host_init(). However,
some DWC glue drivers like those on Qcom firmware managed platforms
allocate MSI domains from their .msi_init callback by calling
dw_pcie_allocate_domains() directly, bypassing dw_pcie_host_init(). This
leaves pp->lock without a lockdep key and triggers the warning when MSI
vectors are later allocated.

Initialize pp->lock in dw_pcie_allocate_domains() immediately before
registering the MSI IRQ domain so the lock is always initialized for
every caller path.

Signed-off-by: Yadu M G <yadu.mg@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c9517a348836..8acd671bbc8c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -215,6 +215,14 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 		.host_data	= pp,
 	};
 
+	/*
+	 * Initialize the lock here rather than in dw_pcie_host_init() so that
+	 * drivers using a custom msi_init() callback that call
+	 * dw_pcie_allocate_domains() directly also have the lock properly
+	 * initialized before dw_pcie_irq_domain_alloc() can be invoked.
+	 */
+	raw_spin_lock_init(&pp->lock);
+
 	pp->irq_domain = msi_create_parent_irq_domain(&info, &dw_pcie_msi_parent_ops);
 	if (!pp->irq_domain) {
 		dev_err(pci->dev, "Failed to create IRQ domain\n");
@@ -573,8 +581,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct pci_host_bridge *bridge;
 	int ret;
 
-	raw_spin_lock_init(&pp->lock);
-
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
-- 
2.25.1

