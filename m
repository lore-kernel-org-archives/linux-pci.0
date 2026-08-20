Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82E389452
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207827; cv=none; b=j7+PPPuZhLlBUKZQUVgeJpKTamKIq9qrvIX+W0b46Yv84US1jwnKi8cADT7a+QmndaBCaeFlLWowzuiz5V5qY3ekx6fYUxBq6M65xLPE9l/2/NWOUEaVYwqli3rpZ5NUK1wyED+1dVZq+Gge9qvIswOKpRnw0BFD5o/x0mwu63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207827; c=relaxed/simple;
	bh=d6WM+v+FBJuA8YyT5RgQvj/s+9uuGVMaZAXpn5rKdzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ei2ROS+O5jz/fbLIwAAGopRH1gw7LgY98FmjGDnJKSrJXKZSY3TQA7g6R6FbDRf2ZjvWvP505hK3miq9HxoEsVXg43OYMEL+0uany+76A3UNXFcxeUBxFi77dgwww1TdlRMLdZYSJuol76lHu3nJY9b1dqA1jfipTt+lkkGkP3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jgk1HIdD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fc+xcmKT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jgk1HIdD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fc+xcmKT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6Nmjp231825
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 06:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9EUmjbABQac+dR9Fd35BSO
	wp1Th/Mqddk7UhcNMDwn8=; b=Jgk1HIdDprzcMi685Z1of9Jd3tqF2H7BT4kPLh
	R3+aT/oKJjOTNgX51Wim39M7hiWvf4O06DI0Z/iMdn8Eu6kNG7qLCWGRDpWdIQ0n
	9kvElgKL78de1pojUi46ZXZ3oi/Q21tgywAaIlFMjqulz+gd6FaJC1y4gTcaOYzx
	AAIuLZF3oD6kDxh3NyFji5gRaxgSh1+2ulu7yaJU1Q2Hqm/zDiPyMLnj7jHN8SFb
	a22C0ABuOPO+ZjIHPmPFy08lcAJIw/0MZVcS1l5iGD+p6uxH57DbV9Ab8FE4gsN3
	56uBHrkcrv/nLgbWASGTFyezHEFYHxjuEENJQfrq/hupm/4w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esaugm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 06:37:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848662cd2a1so2317182b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 23:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787207823; x=1787812623; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9EUmjbABQac+dR9Fd35BSOwp1Th/Mqddk7UhcNMDwn8=;
        b=fc+xcmKTWdrw1BtjDFLVedbB4SMc4UXS0z6fFg12PtHOxOo8auqh4D/X/KRRKZcFH+
         MnQ9X/bowZ6s6fIbwNblcvJPnnnf6FWvTIbDDJyjNX7CjPrdAeKi0GywKwshEEau+65t
         IXwBaTGz88w6lYjLS7B/IY8J7npDOJxJA8ek5/vSC6+Yol12QSird7kkG04wZrk9F0Ny
         0X2hwMQmf6kWyZe1VOpMQQ7oieTqHylHqU0MoA9sDNHuMB/Em/3J3CMfy2FzrBIZJQJ0
         g/7TLzk7qpY2cutdQmV337+dtLZEZgmFVNkFRHYxYr3s8yrhF33M5B2vqwu5quXTIK0k
         UN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787207823; x=1787812623;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9EUmjbABQac+dR9Fd35BSOwp1Th/Mqddk7UhcNMDwn8=;
        b=eng48poQJFHdMpgzhFRn1uihQZbzUDunzUh8mWTHmYuVgUJMc+iCJNd9BK+ObVJF32
         0Og129EblNR5QxQx5jfSak4NJNUUofO7CslFfdDoafC87wigI01MQgUxCt7umfdMrMCl
         rpTVbVcBwe5xck7eCoe6CvAQNI3EYS7Rf/RadvronAkS6mJvE/FePlQ5z4F8eevrrKPc
         WJt/I9wqjOE8AxRkfPqntjGh43S0mHtBuLoIEXhzHphBxH29jXrhKfykx2dYT/b1x9xc
         aAB+eQ86pK0A9cD105QlN44BMi5Uyh9CHFMGCOjXSFPvgwAy57i5ZIkIlcyKrLCEpAJc
         a4zA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5WTFWd9EJ/nd/QwiDLSkZPFh3CDAraucKl+BXiJOgylTTXHP4Dngq7zhAI07S6FJjo/tq2Vw17n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBjKmqgxIiApdZlYTTKDMHGBfAw6HNSbdMIF0iEnHMLg9pEaL
	uEV3duOoWjbiiYC30Nt4PQ0C5FgI5UL3RRiRcH6EAg3hT5JY8hi6kEutwANGY8gTDGU+OxzP99J
	PFBwFz5edG9ROa8Z6sFSxEXr2//TJGfDdkJFOyJIIthUKxSUMu7g6b5X795V8BOU=
X-Gm-Gg: AR+sD10ZMhtvCec1rBZO7aFoW+zZDimNTHzkN7/JJuaH1Pm7WqBotjgF80rdmLy79gV
	dzNSmIynK2MQlrbOh2MfU5Q+xZPdW+Yq23VZpC9r4wQwtMtGonUlj6bt8dbozWIeqpki+pVbIl8
	GkxAuYjHQEHEnUrmeLFqwU5H9mILZ7+hhJXXKnSfKlLrTLNW9on6XyEPHQYsFHKG0EUXaSgZi0X
	Te+jq9lmxKb+st+zKm6tMUfzjR4s1EmKvzaKt1EX+ZPRyVcgNGc8iJ854z/fcz41CFR9kk3mgms
	e1yo4c/uhMTZjdVBoO7xt+jgXPHEsdHQ4gZgi+dNbcey1eYIBgYb8GKpVUVd/SyQ19+J/c4bXgn
	oYeNxA5KFTY4RQOHR2V8FLNUtOjKVieP1CrW+xTUmyQx4OL0=
X-Received: by 2002:a05:6a20:3d06:b0:3cb:d156:d362 with SMTP id adf61e73a8af0-3cd00dc8c61mr20226754637.3.1787207823067;
        Wed, 19 Aug 2026 23:37:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d06:b0:3cb:d156:d362 with SMTP id adf61e73a8af0-3cd00dc8c61mr20226666637.3.1787207822562;
        Wed, 19 Aug 2026 23:37:02 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416aea2429sm12654455c88.15.2026.08.19.23.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 23:37:01 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 23:36:54 -0700
Subject: [PATCH v2] PCI: qcom: Block accesses to downstream devices on link
 down
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIWghmoC/3WNQQ6CMBREr0L+2pK2KjauuIchpi0fqVKq/UA0h
 LtbcO1mkpfMvJmBMDokOGczRJwcudAnkLsMbKv7GzJXJwbJZcGV4Ayt9lfTBfvAyBrFhdlrLo2
 tIU2eERv33nSX6sc0mjvaYXWsjdbREOJn+5vE2vujngQTDI9KIT81haoPZSDKX6PubPA+TwHVs
 ixf1YW+I8EAAAA=
X-Change-ID: 20260810-ecam_blocker-f801b3a02bcd
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787207821; l=9097;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=d6WM+v+FBJuA8YyT5RgQvj/s+9uuGVMaZAXpn5rKdzM=;
 b=R04a3qn+C2evrKVBBY157mQKcGm00aJ3yZCoIS2JXTZU8irmUBKFxwExBjFpygMwzEgnodxWG
 MNJXZ5CGip+A/3gZzLlhed6X5GD7IrIgYzZ/XOH39g8vuHvaM5HOefC
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0NiBTYWx0ZWRfXz3dEold4LBWi
 rBcr6JFhjH9jSwUXPb0zKEgNOeu/8/Yf0KC1pFjXl71xr5AwDNGM5QMLmpirHx+i5SFdTxrspLh
 98yNnTN1krF0MJqse82Yo7xkRW7bAAE=
X-Authority-Analysis: v=2.4 cv=fKcJG5ae c=1 sm=1 tr=0 ts=6a86a090 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=OOm15LuoyrK0kjIZ0nIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: nPNQ-xASA-4VdEYe1M0rKrvAslyrFzHg
X-Proofpoint-GUID: nPNQ-xASA-4VdEYe1M0rKrvAslyrFzHg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0NiBTYWx0ZWRfX/eY8V8TV4+jT
 1uv7Q10WNbH8q2mGvVy80HbJb9rb6Qw+XL6k6s6kpp5cVnfw68qoaojRc/nmkv84O+x7N8A3ako
 /pnz0DS88v4ZW47AcQxF30ChhEApHyfQRornhd3ysjc3swiYTrnQs1Fh3NEQAc7Rm+N78pzPaO9
 hFVRsfBdIzFmTMqTpfpMKUBmv9f+6XJamaQAsJrGk7c6MPANh9uhzLRPO0btddA6CeE1gpnfL4B
 BpimbOtL+4xYDZVB00a9VWLnQapUlxFqBSBjVDskDbBZhCjqVTFALflr+Sfn2zJQVPMKLBAnWFY
 8M932npC9r+gHnuKVfV2DNfSjCsFcBzIfZdCBzEcQ7ObDoS+uyQahGjAoX7LCLsii32wYjf4HRD
 vVQefYXXZ7YjoOn8VpB8BZJ56YMF4HXPNgG4c+TUnOk+x8bGBu0/r4lXqWQniWHA97AV6G31FWs
 wGvrqfvBiUnCTZKt4lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200046

After a PCIe link goes down, software may still access the BAR (MMIO)
space or configuration space of devices behind that link before recovery
has run. As the link is down, these accesses never complete, resulting in
a storm of Completion Timeout AERs.

Use the controller's ECAM blocker to drop these accesses to the PCIe
address space as soon as the link-down interrupt fires, so that Completion
Timeout AERs are reduced. The blocked range covers the entire address
space (base 0x0, all-ones limit), since the Root Port's own DBI/iATU
register space remains accessible regardless.

The range is programmed once in the host init path, since the range
registers are wiped by BCR reset. This leaves only the ECAM_BLOCKER_EN
bit to be flipped from the link-down IRQ handler, so the blocker can be
armed with a single fast register write for immediate effect.

The subsequent Root Port reset re-initialises the controller, which clears
the enable bit and re-programs the range for the fresh link.

Some IP revisions implement the ECAM blocker registers but do not wire
up the "global" interrupt used to deliver the link-down event that arms
the blocker, so there is no way to enable the blocker on those platforms.
Restrict blocker initialization to the post_init hooks of the IP
revisions that do have a global IRQ wired up
(qcom_pcie_post_init_2_3_3(), qcom_pcie_post_init_2_7_0() and
qcom_pcie_post_init_2_9_0()), instead of unconditionally programming it
from the common host_init path.

The link-down IRQ thread's blocker-enable write to PARF_SYS_CTRL can race
with a Root Port reset triggered independently through AER, which
reprograms PARF_SYS_CTRL as part of reinitializing the controller.
Serialize these with a per-controller mutex.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
Changes in v2:
- Only initialize the ECAM blocker on IP revisions that have the "global" IRQ wired up.
- Add a per-controller mutex to serialize the link-down IRQ thread's PARF_SYS_CTRL write against a concurrent Root Port reset from AER recovery.
- Link to v1: https://patch.msgid.link/20260810-ecam_blocker-v1-1-e588e07f68d4@oss.qualcomm.com

To: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-qcom.c | 83 +++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b58a607b713f..e8cf349579a8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
@@ -73,6 +74,23 @@
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
 #define PARF_BDF_TO_SID_CFG			0x2c00
 
+/*
+ * ECAM blocker range registers. The blocked range has a write pair
+ * (WR_BASE/WR_LIMIT) and a read pair (RD_BASE/RD_LIMIT); each address is
+ * split into a low (32-bit) and a HI (upper 32-bit) register.
+ */
+#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
+#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
+#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
+#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
+#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
+#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
+#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
+#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
+
+#define PARF_ECAM_BASE				0x380
+#define PARF_ECAM_BASE_HI			0x384
+
 /* ELBI registers */
 #define ELBI_SYS_CTRL				0x04
 #define ELBI_SYS_STTS				0x08
@@ -90,6 +108,7 @@
 
 /* PARF_SYS_CTRL register fields */
 #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
+#define ECAM_BLOCKER_EN				BIT(26)
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -308,6 +327,7 @@ struct qcom_pcie {
 	struct gpio_desc *reset;
 	int global_irq;
 	bool use_pm_opp;
+	struct mutex hw_lock;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -445,6 +465,25 @@ static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
 	}
 }
 
+static void qcom_pcie_init_ecam_blocker(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+
+	/* ECAM base must match the DBI base address */
+	writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
+	writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
+
+	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
+	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
+	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
+	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
+
+	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
+	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
+	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
+	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
+}
+
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
@@ -990,6 +1029,8 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 
+	qcom_pcie_init_ecam_blocker(pcie);
+
 	return 0;
 }
 
@@ -1104,6 +1145,8 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 
 	qcom_pcie_set_slot_cap(pcie->pci);
 
+	qcom_pcie_init_ecam_blocker(pcie);
+
 	return 0;
 }
 
@@ -1322,6 +1365,8 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	for (i = 0; i < 256; i++)
 		writel(0, pcie->parf + PARF_BDF_TO_SID_TABLE_N + (4 * i));
 
+	qcom_pcie_init_ecam_blocker(pcie);
+
 	return 0;
 }
 
@@ -1382,6 +1427,18 @@ static void qcom_pcie_configure_ports(struct qcom_pcie *pcie)
 		dw_pcie_program_t_power_on(pcie->pci, port->l1ss_t_power_on);
 }
 
+static void qcom_pcie_enable_ecam_blocker(struct qcom_pcie *pcie)
+{
+	u32 sys_ctrl;
+
+	sys_ctrl = readl(pcie->parf + PARF_SYS_CTRL);
+	sys_ctrl |= ECAM_BLOCKER_EN;
+	writel(sys_ctrl, pcie->parf + PARF_SYS_CTRL);
+
+	/* Flush the write so the blocker is enabled before this function returns */
+	readl(pcie->parf + PARF_SYS_CTRL);
+}
+
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1775,13 +1832,15 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
 	u32 val;
 	int ret;
 
+	mutex_lock(&pcie->hw_lock);
+
 	/* Wait for the pending transactions to be completed */
 	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_STATUS, val,
 					 val & FLUSH_COMPLETED, 10,
 					 FLUSH_TIMEOUT_US);
 	if (ret) {
 		dev_err(dev, "Flush completion failed: %d\n", ret);
-		return ret;
+		goto out_unlock;
 	}
 
 	/* Clear the FLUSH_MODE to allow the core to be reset */
@@ -1795,7 +1854,7 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
 					 FLUSH_TIMEOUT_US);
 	if (ret) {
 		dev_err(dev, "Flush mode clear failed: %d\n", ret);
-		return ret;
+		goto out_unlock;
 	}
 
 	qcom_pcie_host_deinit(pp);
@@ -1803,12 +1862,12 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
 	ret = qcom_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "Host init failed\n");
-		return ret;
+		goto out_unlock;
 	}
 
 	ret = dw_pcie_setup_rc(pp);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	/*
 	 * Re-enable global IRQ events as the PARF_INT_ALL_MASK register is
@@ -1822,11 +1881,14 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
 
 	ret = dw_pcie_wait_for_link(pci);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	dev_dbg(dev, "Root Port reset completed\n");
 
-	return 0;
+out_unlock:
+	mutex_unlock(&pcie->hw_lock);
+
+	return ret;
 }
 
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
@@ -1878,6 +1940,11 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 
 	if (test_and_clear_bit(INT_ALL_LINK_DOWN, &status)) {
 		dev_dbg(dev, "Received Link down event\n");
+
+		mutex_lock(&pcie->hw_lock);
+		qcom_pcie_enable_ecam_blocker(pcie);
+		mutex_unlock(&pcie->hw_lock);
+
 		for_each_pci_bridge(port, pp->bridge->bus) {
 			if (pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
 				pci_host_handle_link_down(port);
@@ -2204,6 +2271,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&pcie->ports);
 
+	ret = devm_mutex_init(dev, &pcie->hw_lock);
+	if (ret)
+		goto err_pm_runtime_put;
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;

---
base-commit: 3de6add8d15430cde96c615fd156216676762bf9
change-id: 20260810-ecam_blocker-f801b3a02bcd

Best regards,
--  
Qiang Yu <qiang.yu@oss.qualcomm.com>

