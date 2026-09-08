Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C6C1917CD
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848310; cv=none; b=TxYG+zeYrQyOvRPPcWdc0k857M5dFB7DNIfd9huCju3BaYF31veOdtqddNbash8Vuzx2CA8F+v9rtel6+kpL+QK1YoYBTh9eGTiG9k+q/OrZx1+DhKAST5BqMSIwxsIOLWHeof32H3PJ4wNbQjhifL9WLsP9c5Z8Kn4iUgHGY1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848310; c=relaxed/simple;
	bh=0vkb45uA+f1IecX8p6Fn//JP/tyBGpSwpx6m5DP9MwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X1v5O0B8zDyMYPJaapXNRguEim33726wiL5EGcObp+JpEdCjPl7LYAlNx+outHeq8+bF5xYeY58ghmDN/oDdlsQwd58q8fHO8KdIicAsR3+C1oDFfKhZSVwzYMHWUNaMzffoI6xFnhg2j75ufiSMoNP0ZkF+3p0155ccLBtX9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PYoWSoj2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q2+tzKGj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PYoWSoj2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q2+tzKGj"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Nlvv21331466
	for <linux-pci@vger.kernel.org>; Tue, 8 Sep 2026 06:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nqBXrvv1RYaPwCQj7BRN37
	7mYup6Ff7fzyJcboTfiN8=; b=PYoWSoj2pXhhQm6ApjggiKMv7gYTMiux4Ckc1l
	lW2pmLCXE0VqJMPEdTyjN7G8T1q9h0lvxaIWDIPLezfAJ/4bFSvYCK/iIsCAZX0R
	GR2v0CnL1n3xTbXo+yVurutZT/NnFx3ckKkDstlHtjCJpH1I1FzJYHsQId1rFrQy
	M1yWwGy0a126L6RKJeS+Fa9FwcjQrrq16gvUXeSq+OoSXZednIP5/vfXcaxP/BJR
	21AQHoVHAk42dGLR1Cx50pFZvsH6BZKwyZxdJROb7yV8EK+3SZ9WJlmKWwINkCVK
	ZLQOye4YnPHC59MKE2e6zYFxCxoXw/xEtZ6VX+AXMr+y3gsw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rrhxxc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 06:18:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398d0010cfaso8202127a91.3
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 23:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788848308; x=1789453108; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nqBXrvv1RYaPwCQj7BRN377mYup6Ff7fzyJcboTfiN8=;
        b=Q2+tzKGjD2lNvhcxCzZoW1TIKNiz+6TcmGxONmfNyGnS0riT2vr/E78VfvmqIrJj9K
         iUO/+V9nKv5xEIL23Aj42NaEoBWSrBNjFRgQzfkcvarz8BgK3rpknPik1A3O4UysWsAI
         LnlnsdXME/KlUp8WOVOXDN1I/6+PwC0k5Vlzek86r2xzoSfn/HrOjHOFFwWG/4vudkLK
         hYOc9tR2z46tYCd2T5eyfTkiuGXifwqi9GMz+wkvkhYT04H/6pEM+jSdQoMwNCY/jMNn
         kjeSr4UbdI6E8vQTNHF5OW3UKpGuq4mGxOH/FtbVQtNzh4uXozc8cuKRMBUqcho5OPDy
         oePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848308; x=1789453108;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nqBXrvv1RYaPwCQj7BRN377mYup6Ff7fzyJcboTfiN8=;
        b=T4FEr/2Yi3AMMhK8ToSrCaeLTJP+s5bVeNjIE2LEtQFm3VVkzABg+qpb+yUHcegwL4
         KsLUjl2krvUgHTxdq3Buf01r86QOs4s4v7VKOohD4WLB5fpXiwx0nTD2isrn3LWhurKd
         86lR+NgM6ImQg1fz+kFxzcar1S7tTzUdW8KZsUvClxceRMDunICLY6l/FVfYAHhDLpvo
         ltf1C8H6JKmnf2Q5fILa3YbNqe4miDXvltaEmOvmX2C43S7wP9lcMD8gE+VPkl8v+BvP
         WsGp5V3HzjxuDke65SFMu+fq2FN/PCFV9a/J4AbtlfsKC4L5RMVwPeyH62qXudMLqxRq
         oWrA==
X-Gm-Message-State: AFuF++krVhTbt4leEgCtcJ0zY2t0HTPLQ5sM067kGb9R47KK6Mrrot0t
	APZ91fvu75bFa9gDKncGrNpur/pEXMq3HQcjny0B9roYrSGN0kkNNad+XS5VXBVlp8QOcQYqDpK
	b0cGyfgNhnHNUM02GeehtyqCKTdX7O8MzmtsCIF3mK9YRD8kK6MyA3vf6SP8gyC3KkhkCs6M=
X-Gm-Gg: AYBFou0/cSOoFoorw7dYmVX21WwI7Mh/Hs8s79jguAXH80CLkcPzkBUpj50obhmEF8O
	5kSDdEDidwQ78Lrc0WhpRgJScBoEY9Mr+JY4sGe/Y5X2SUNII34ROfXpHZhwX8VR8cAl6bBfHjO
	T7Cy0PaQXEja+K/suxX3nHj0eh/if3B5kyozxcwA0wWhVcdWqv/o/CR45+pBuyHR2rgZtFKs2Kx
	3UbdbAlqRNbWuZM9FdBpWpcZOvv67seVEN+BFpMgl428Gz/uAgPR7UHdTf/6RPCEGfNDwyiGB8e
	OTvnLYXzn1TbuL+Gp5jQS2XkTggHKDOJc4YKcU6c5Pcishx+cHTVdrvtn7+OkZCnhFHbzU8VNFZ
	fpKjlVNCio9sW+Zw5YIpFeDdcWQ==
X-Received: by 2002:a17:90b:55cf:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39b261b1a52mr45423781a91.12.1788848307808;
        Mon, 07 Sep 2026 23:18:27 -0700 (PDT)
X-Received: by 2002:a17:90b:55cf:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39b261b1a52mr45423727a91.12.1788848307279;
        Mon, 07 Sep 2026 23:18:27 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm38764157c88.5.2026.09.07.23.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 23:18:26 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 11:48:22 +0530
Subject: [PATCH v2] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK2on2oC/22MQQ6CMBBFr0JmbUkpCpWV9zDETEuRSYRiR4mE9
 O5W1m5+8n7y3gbsAjmGJtsguIWY/JRAHTKwA053J6hLDEqqSmpViW7Em1lnZBbGmF6jtGfsa0j
 CHFxPnz12bRMPxC8f1r29FL/3b2YpRCFKPJWdrY/aOnXxzPnzjQ/rxzFPA22M8Qsimff3qwAAA
 A==
X-Change-ID: 20260826-dma_bypass-bbbf8a0c9af7
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848303; l=3163;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=0vkb45uA+f1IecX8p6Fn//JP/tyBGpSwpx6m5DP9MwQ=;
 b=4nGNOTQPE33vcPSpAvAcgyZUyyraOpcxnsHpPSw2ZMCEXniZH1i9O+XKVh4/wgzdQZSr3oc4E
 +PqKejPn/ZcBOgO3TCwwX0yk15D9n17RDVfl/wjI7XCOK9pDG9SEyjd
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA2NyBTYWx0ZWRfX3xJcT0WJfU3y
 ZEb5o/z0pOTxhksidl2Keb8lW+2O2KOdt0nz1reGTzcnhbH8fAgW8kR6Jeh5ofz/w9tWA4Egwdh
 3JlvuFojncyDcng5l1eqLfbIqPO7d24=
X-Proofpoint-GUID: p8Odbp3dgpWpOKJc2nf8-QcGSAQxJ4-x
X-Authority-Analysis: v=2.4 cv=NsjhtcdJ c=1 sm=1 tr=0 ts=6a9fa8b4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=12MQry4_jSufYgdODo0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA2NyBTYWx0ZWRfX9yMFR3KA6FBM
 TLZc8Igrb+iTSAaFsExWpwG5wh0FG5C8E0Hl0r8A/oM04D2qB7T3FeLDzrn/ZHMkrlEQt7WVzlj
 0P6iKblBnaccjPfA90KhKs3qpnlSvaosRBsZU6h+BxSuRGiscGs036fFiptrvT4csc1jsV1GVRz
 1RU4wys+bU4zkNiKQQARH2bmvl2xzj7RRhMJhY93/aVHBHuCdZ6pICFdAUmY/tgWwS9fTHE+k3m
 3o9vNq70vEfynKe5Sj+WhrWmY3Vbm4e0WO0qMvMyeVlWXAC6gv2i9XGyBzU5wrRtl/K2RK1cIai
 WqUQ6xAHPNfs2TdyO/cUdkvqZac4VmOKgmI/TVSFz/5Q24x3gymSACFqOd+v6FAZ1ZDsamqLl+5
 BafsHSZVxg/py5eiG7gUSGwRYdGhGzx/7s+493n5BjdNe3ps1OE6/8n3vgQMLSR+TgDqKsZNzCl
 QroYI2UCYcVR3qCQcVw==
X-Proofpoint-ORIG-GUID: p8Odbp3dgpWpOKJc2nf8-QcGSAQxJ4-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080067

An outbound iATU region matches any local (AXI/application-side)
address that falls within its Base/Limit window and rewrites it to
the PCIe-side address programmed in that region's Target Address
Registers before the transaction goes out on the link. This matching
does not distinguish CPU-initiated transactions from ones issued by
the internal DMA engine (eDMA/HDMA).

Example: outbound region 0 is programmed with Base/Limit covering
local addresses 0x8000_0000-0x8000_0FFF and Target 0x1_0000_0000, for
CPU-initiated accesses. The DMA engine is later given a descriptor
whose destination is the host address 0x8000_0080, which happens to
fall inside region 0's Base/Limit range. The iATU matches the DMA
transaction against region 0 too and rewrites it to 0x1_0000_0080
instead of passing 0x8000_0080 through unchanged. The transaction
then lands on the wrong host address, causing data corruption or an
IOMMU fault when the rewritten address has no valid mapping.

Set the DMA_BYPASS bit (bit 27) in PCIE_ATU_REGION_CTRL2 when
programming outbound iATU regions so only CPU/AXI-initiated
transactions are matched against the region; DMA engine transactions
bypass the translation and go out on the PCIe link with their
original address.

Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
pci: designware: Set DMA_BYPASS in outbound IATU to prevent HDMA
interception
---
Changes in v2:
- Rewrote the commit message according to suggestion(Mani).
- Link to v1: https://lore.kernel.org/r/20260826-dma_bypass-v1-1-3a53dc748ce2@oss.qualcomm.com
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 ++
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 593388f29bdd48381cb04710f445042aaf2be29f..9297d0e607e3a1caaeb585b23742f9a29607b7f2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -577,6 +577,8 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		/* The data-less messages only for now */
 		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
 	}
+	if (dw_pcie_ver_is_ge(pci, 460A))
+		val |= PCIE_ATU_DMA_BYPASS;
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0735ae94092404bc2976af67a58f6842cc5e5c50..668a5ba1c6f59aef1aaf15566b77a649bd282ce0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -201,6 +201,7 @@
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
 #define PCIE_ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
+#define PCIE_ATU_DMA_BYPASS		BIT(27)
 #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008

---
base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
change-id: 20260826-dma_bypass-bbbf8a0c9af7

Best regards,
-- 
Sumit Kumar <sumit.kumar@oss.qualcomm.com>

