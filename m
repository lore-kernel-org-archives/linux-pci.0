Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1537647B
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775290658; cv=none; b=cVzSG6V5IoqFt5mbR73lSFUag6IaFh+y5Ghf8Ew+pc3FY5bbYlabsGqwkxQDS2suORvhlQu2fhGZ5V6Rj/uRf5SNB2AlJOFbocwfZ60HUzQ7/Fah+GFNkBkau4XuEjvW6bXtCJEMr9BKIGgkDinR7OSruCTAcQ4T0d/Xskm3r+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775290658; c=relaxed/simple;
	bh=WxyWJaM1nRlxUT9s9i7G0JqWO3oDpGfwYpYNm18PeQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYitFAXnHsMqflxMoRItu2eDtb9MA+jqphCOXqquqkEy3BvnTG02+DUSUurckuT8GHzd2R26lli6LtYas/SSrn3+6gqLbNORZNEk54hnnsKf7f3BOWo1/feZ8oT/1ge+98v7B386wyUAe+xKJ7JH4K7BxSy2JjPyy911/7S1KkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TxAyVwWp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WTWWCWGw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TxAyVwWp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WTWWCWGw"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6342Bfpm4113344
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 08:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q5wgiGfuhLOG5aXzit2OLL975WIbQOoDmxtVx7USbCY=; b=TxAyVwWpGZC6atFF
	7mNBXXNI9dNq6tLgkqx0mhJdBmpsA/WT0pHJj6Ebe5BGjlfljqrtSJDJ8Gmil/HB
	Oml+ha8Rj3hErZ2O85+1XBfXpoUbsw0QZXWIoAx9gPIZiBSGw5we6XyApLIZjGvB
	lePqkl2T9/qUlMVQKR0BW8zfJGhiajl7DSScJBpsAIdSJ8eHRezVrd5wMuQTfrDS
	TgplnGlKUu9dzKMmHQUhdyLSe9hZiF4DPzzgHasXYTTA7+ohXtPDzWYV8WG2XZMU
	yC7dkpxP4IimngsWwcSQu98grCT9fU0Gcgr2P9ELk3V+wzXq7IjjqpyCOh9O0tWD
	EGMoqA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dasn5rk5m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 08:17:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3595485abbbso2930079a91.2
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 01:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775290655; x=1775895455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5wgiGfuhLOG5aXzit2OLL975WIbQOoDmxtVx7USbCY=;
        b=WTWWCWGwe5KXXvyNcEEEPScGt1ctpojAsiDT8r04t9MKQMhwHVioEItjNFkS00CjfB
         cX/2mJl+bNCKyLltstXoWWV+b4Cne3a93BUlj8U3V5ymoDpSS7QB38Lf3jAFLYc7UZp5
         te9jRX5diF4sl23HNZDLz1ZSh50/sah8CQDWeuDENwPrekYJcbP5xxVHbUkxjc3/7Dis
         YuXzb5XuE+GcntYyD30kjQQ0W9zOJ+RcfA6DVdnTYh01Dm9BD3AksXbXKU20BUH4MX8C
         cv2txca3mVQ8uM3tMGtCSBmUXRQMSXVpnnaDrIe+HUHjZbPpfMhvKSFLJj3yAtpcRJhy
         opeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775290655; x=1775895455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q5wgiGfuhLOG5aXzit2OLL975WIbQOoDmxtVx7USbCY=;
        b=Oqu7Yc5rBGHOnwmTKzGQNBU6JesJeEpdHsA+ADkavG3qfeFIs0PqRMmzs54AY05WXc
         +ymAprfwrKtNKhkw8L57ZlhPPKvBdeqLxlPApex8bmDAs0u/DjViuFCEBlsrxHmuVCmS
         ruG1gGKoX61HHNItHld05XguOQpPV4SQa72eFRBZe0UBJ3i7eYwPU75xiAwEVhF71x3X
         nKMxDGMQ3WJdBd8Swikxi+VGBGHWxcpNKo5bdVJVIsLNgbNOaFQZNO2N7WIwCH/Y7nBc
         Xzkw+0FiLMZJWs5xnd9rZcicRmfoRsb1X2nZk8s0BN774tqdD+ODG8FXZ9LVddxgoh1k
         VvHg==
X-Gm-Message-State: AOJu0Ywx+p+RgbVZGIh8A2X5mGvxDttwqPKATUrBEdn64WO6WSMDaWAS
	gIRq/K6pBnfzhdgazaZpxC2DH0yr+gT5bSs7qzN6WDFDZ7AC94rkHSzeSwtyQRVqg19aC47nTr7
	E2NUNh/NVHDQd+HmD2O63ZyAozBEEFwJF5RkHapjgdBDqrFPKHrJ4HsWqMTVam5I=
X-Gm-Gg: AeBDiev5wHh8O1RmbTXe3WyxcCE5LCwxYTpDkgL3dVlc1DFzk3ccJWRpsvdhGtwrXj0
	ntexa5RFqFG3reNk69DrmCJlnWVFVTfggfh409uWb7Iqj2i1AkZoNDeIt10ZBvkeDWhBES7xgHh
	dX+AdSNRhtogKUDBI2e3glKnHqbWTxctKEk6jO9kvbwKP7XXuoILFKDiU6MttPG6HD0tfu178pI
	jwW8DZeop3aXeQPnckXNI6lKZaVcAfN819/kcHpifl1E6rPf5T6E3h+FxuDc2E5h2odRg9rdsIn
	MED8VxzWfaf0BLb71b91TpcPcQnEWZUcFz77SdZ4xntSfiBkOGDcIr9I7G0GnfRtbJJaiy4Zf26
	zXZSphIYaJL73N2wTKbabqlfqPePtcn/mRfhkWV/s0rnx6lyjAD89QAhw
X-Received: by 2002:a05:6300:6d8b:20b0:39f:57b1:ede2 with SMTP id adf61e73a8af0-39f57b26e77mr421900637.37.1775290655021;
        Sat, 04 Apr 2026 01:17:35 -0700 (PDT)
X-Received: by 2002:a05:6300:6d8b:20b0:39f:57b1:ede2 with SMTP id adf61e73a8af0-39f57b26e77mr421879637.37.1775290654535;
        Sat, 04 Apr 2026 01:17:34 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm6786408a12.24.2026.04.04.01.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:17:34 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 04 Apr 2026 13:47:19 +0530
Subject: [PATCH v4 2/3] PCI: dwc: Add helper to Program T_POWER_ON
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260404-t_power_on_fux-v4-2-2891391177f4@oss.qualcomm.com>
References: <20260404-t_power_on_fux-v4-0-2891391177f4@oss.qualcomm.com>
In-Reply-To: <20260404-t_power_on_fux-v4-0-2891391177f4@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775290642; l=3029;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=WxyWJaM1nRlxUT9s9i7G0JqWO3oDpGfwYpYNm18PeQs=;
 b=NZPGIsL8x+PRfP7EAG/l0EzDeAARbiXQ3V/gQXfIIL33gW1mnESBNlL3uw3M8FpAVsO24W8Pk
 T5xV5lrUbFXDwQg/VXK9GyrUP3wLjqhT4w5LHBHuUSW5BYJGO0SWOtt
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA3MiBTYWx0ZWRfXz0CGp04hW3jn
 48CkKOLF5yht4nK2q7EGRoxTT3UZANuCLHm1N9dhhC0nKZuY0v0+Edgf1yy7LuvVRe+B0HiTEnm
 WP/GQepJLVlutHoThQQrTZiYE2BdFld0P8RRwkngZSjAri2hZKzC+5xyuxXN3PsiGlMggwgL601
 ACjyOocvikaU3OW8OspzjUqLf0EWk2tJXEeC/Hz4+lXOXVMuGzFV0oQtWsPktFXvTVSqRG7Yixr
 pWaB9gX64XOu8FCDUJuPJGAuBgMVCKRpkv/wp6duVaXYVq2tNitpVS8jju2T3AK1mZOlAN1j7QK
 0Xlar8H/WvRfXnObcdiMclkrPnzS4ktvFuI2UOSPl91POnxY4GX/co6EdDvSxSEV4T2U5cioGCy
 iq2A+7/oQ6ykFq/G5r2ZXlKIb2gV9ohr5f9t/UaEuM7Miwlsvp+G7JqKvd2OS183yoAX/TkzNhS
 Dm0ChfM3uWLrgNYC+Pw==
X-Proofpoint-ORIG-GUID: RMgpkSD7ntWMi-it7r75blt6gCoQO2Ih
X-Authority-Analysis: v=2.4 cv=K9wv3iWI c=1 sm=1 tr=0 ts=69d0c920 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: RMgpkSD7ntWMi-it7r75blt6gCoQO2Ih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040072

The T_POWER_ON indicates the time (in μs) that a Port requires the port
on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
asserted before actively driving the interface. This value is used by
the ASPM driver to compute the LTR_L1.2_THRESHOLD.

Currently, some controllers exposes T_POWER_ON value of zero in the L1SS
capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations,
which can result in improper L1.2 exit behavior and if AER happens to be
supported and enabled, the error may be *reported* via AER.

Add a helper to override T_POWER_ON value by the DWC controller drivers.

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 28 ++++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5741c09dde7f40487c6da6dfd66f7c8d96a74259..6289329ef2b2a4ac9264d1c6cb5ea4e88c261634 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1249,6 +1249,34 @@ void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, l1ss_cap);
 }
 
+/* TODO: Need to handle multi root ports */
+void dw_pcie_program_t_power_on(struct dw_pcie *pci, u16 t_power_on)
+{
+	u8 scale, value;
+	u16 offset;
+	u32 val;
+
+	if (!t_power_on)
+		return;
+
+	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
+	if (!offset)
+		return;
+
+	pcie_encode_t_power_on(t_power_on, &scale, &value);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = readl(pci->dbi_base + offset + PCI_L1SS_CAP);
+	val &= ~(PCI_L1SS_CAP_P_PWR_ON_SCALE | PCI_L1SS_CAP_P_PWR_ON_VALUE);
+	FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_SCALE, &val, scale);
+	FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_VALUE, &val, value);
+
+	writel(val, pci->dbi_base + offset + PCI_L1SS_CAP);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 void dw_pcie_setup(struct dw_pcie *pci)
 {
 	u32 val;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ae6389dd9caa5c27690f998d58729130ea863984..da67beece3f11e33d9a1937fa23d443feea3bbc7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -602,6 +602,7 @@ int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				u8 bar, size_t size);
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci);
+void dw_pcie_program_t_power_on(struct dw_pcie *pci, u16 t_power_on);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);

-- 
2.34.1

