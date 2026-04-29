Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33E38E13F
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777444970; cv=none; b=tx+KrsGcRtrF8kot3KSmnRolPgq9nvWlm8VbFpxedsc/ziIZbv4MMYtv1tOkfliHxBvGtSZA8lpGwtcs7nQvPEKTs/+SIrbqDX/NvT0L6ALOn7Nn+YpvFeBXAJW+Ig3oJQK5ReJ2unhVZ6pepu2cl00qCJ4Rj9uFEysKiVicop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777444970; c=relaxed/simple;
	bh=kJOcLpJ2/X+O6jVsxBIhyhEdHIhlOc1Lfh/fcN/6y0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l9MqhRdmLeNP+AV5Fm8Z8+1E5Svc7Mm1jlZT6h3Tzyljkq4k83mTQTJRdN4jXzuPIwvgfCSlXtgzeA4JTG5E+pfOc5Onv4JnQBAHAeGusYeqPL9moJLkyBDouswZ3l0e8tPmS4e4r6b98tqFyXYTa4wAk5WVU6eP2B+OB76i/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8IQRfIN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZmWRYlJQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8IQRfIN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmWRYlJQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T5luCH3347507
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SEfRbstRjVHeuT0nzZzxKbaNveaGv52bqCxDptLPZ5w=; b=B8IQRfINvxXIN5tH
	/bVnZzf5djPZX2GOqJN6eUTg+n5KQzzuUYuhxrQYaH6NAAqKT1xX0Jwu0o0jX3EY
	OdsNe+0GGI8nEVR0PAFOK6td2G/icAZ+y4VWnOPgxNubu52Mcxfb7a1S38vDyD0B
	jQBTdmjqSoa0tRRTbZ8GE29rCMtce/AOGsiOrjQWc/fKJgPKHf80QXfTv/hEtO/c
	bTQGOeoGMXkRpHCjclnTsF94HY/0Ebv1tY6MA7UYubv4HxbgeFwAdcXaHNfXhYwW
	7E5e+XQIW0VG8eCl1GSjF96++Z5VPsdWeQ0hHwc1mryqYbrVswGSMCe6HTyjkPxP
	b6uIgw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4t07y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da86144daso11793977a91.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 23:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777444967; x=1778049767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEfRbstRjVHeuT0nzZzxKbaNveaGv52bqCxDptLPZ5w=;
        b=ZmWRYlJQNeSM9h0NHxk1QuQ7y60CF94bTeKdVHbylOko/Bj7GM4rs+IxdPcq+O0OEV
         rIzdQc1k7VH4Oh8PMEBw2cvza5cgJvMt/rn5HM+EeBmtQeEKR+XMy6fPbE6hCnJQj5PB
         Zvx5BRDyG93N6WFNVnj6sglHxMHSYotRsQC1NtuJgBQs8y/h3kI5XWDdJxhri53oLHH/
         jkMp/T/IXtyRV7i+78UC1LAGzA0lySmbqY53XCg8MR46N9B21QN195Iir4HyxPLrkWMk
         IeGbhS+Ns0BM/bFZHSZF62d2MhopLlpUtzcJ6S2QikcrkUU2EhEzbmB2h2K/e/3fApxs
         AELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777444967; x=1778049767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SEfRbstRjVHeuT0nzZzxKbaNveaGv52bqCxDptLPZ5w=;
        b=jBYM0+6rzGuujna0SoEr5Ks3updkUgW0UdflkJF1f2AApNE4o5cx9V0ajayjDHN7+W
         r23W5oaif9G+E4Gf+p/OOhNcCL8UD5xVt74s/+yYlozvGBw6Tv5GroA0+3Blgn+u+onK
         O+byWlDQNMp8BR+M08+0X4yRTEniCY3hobuMWA5iIWPKw0zXRD8baHPpNCbIGHHI2w1F
         EDEGHUKFfjdza51Z8UYc18AtHyDGP/CJjYtujDLYWicFY2UOqU8JlKWSc3zjbGpGF6oM
         t3MJD9WxED+WllRCZaalV4qgbACIfToG5bkrdUUO9A5QWxKkvtfFmn874aw4hIEF3MQf
         oXUA==
X-Gm-Message-State: AOJu0Ywz4OkGJW7LumsULg1mbFw6QUSIRWjyKly3X8J9A8a3J7AG+Zm4
	YuBwuZQRYZEztPeQnT9gk6in91j5bUM7DxJKia0/1ZiUQN2uN5xXiJ0A0NkuJPb+3OF1JPR1Rpb
	IsSfY0Q9DMZy/Cce6iCXBw904bXazWDXBKisefFkowDx8nJMrkZ6pfz9kuuvqr+I=
X-Gm-Gg: AeBDiev9c9nQFz3RdlsVY8rOdUG8wup8o7QgSWarIz7hE3+2xJuMrNh6aW/54PmgSSU
	NmZ18DbnghUcXD8mQ+P3vSqRCmRWixRuZ/5B5w3NG2Uc1l5qmgVvMLD/Mpp7gdCtTwiXjlXxqU+
	HpSDO2GlldhQgRblblh/qDzrxpBr3ZGlCGIiXOD+gy7e75+fAlmSd60I74Ot/+Y8PmmjGZBycLG
	+u7G5EofZ+E0SeETRPxAwzLM0rvUAfsxq4z6WfrpBFgxp5dQCpAi4znRGN5xTBDF9eBR6qwmfNx
	8SJpvsMsN6hKNHrbNTDZnWTBwnlNx/XsAOUfXxuQMFQGTjvZJiBs4YCxyFnh1swEGuscMTOL/ia
	Yt4tmRNKpba3F+LJtMXH5/HiEWPjipJiV2xPxC5OU50zQyIH6gywsD957NXcJ5jMvQ6c=
X-Received: by 2002:a17:90b:554d:b0:35d:a380:6d1a with SMTP id 98e67ed59e1d1-36491f89850mr6689828a91.2.1777444966979;
        Tue, 28 Apr 2026 23:42:46 -0700 (PDT)
X-Received: by 2002:a17:90b:554d:b0:35d:a380:6d1a with SMTP id 98e67ed59e1d1-36491f89850mr6689632a91.2.1777444963231;
        Tue, 28 Apr 2026 23:42:43 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0303d59sm2021414a91.15.2026.04.28.23.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:42:42 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:12:24 +0530
Subject: [PATCH v5 2/5] PCI: qcom: Add .get_ltssm() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-d3cold-v5-2-89e9735b9df6@oss.qualcomm.com>
References: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
In-Reply-To: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777444949; l=4016;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kJOcLpJ2/X+O6jVsxBIhyhEdHIhlOc1Lfh/fcN/6y0g=;
 b=XJXnUN7dlDghLSLQOMsNyk25AY1nkORIexsqqq+avIno/Mb0yfR49fPhveofsZcDVoM3HEBRC
 QbzePAgnlAbAtE0iREwuOauc0FMh5cJy2CWrHfPnjffh5SR3E15uxZo
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NCBTYWx0ZWRfX/+9NG0eiHXjE
 B/LHqYBSick0DAR+VfiOkfgz2ledzP7zGeGcDxapEpF11mK46+aQPFfYOkYC8Gx3UKox239Ixl8
 H9jLXn2Hb0NodcimmQAjJoMA2fomvTpRaHdU6HUMHEJCgaRRKKmTun7iM4tf/JibIG7adbkUvU3
 xgQsrpgJUWNyShgSwbNqOJ3Ij7LvylbZfZNkQFHEUAprvtRyU4GrI07zXItj0mLuTaflkvHRPYA
 DRxZMf01VIcUasEsUpPPIWw6Fw3a71FZ8vabg7SHrj65WPd82v3F28K64PMKOrS5PzRQ/ibWDeH
 Y6UJ7X6RWWm9Zq63II4BQuCG+AIbRHsURVQ4sJHK6wEo352NXlVIqoX1FOEw2p7rWe75arv31oV
 0ENc6xf2E5nc0c+33d8SKJ03lF7YoZP3XQtrvn1QUyrRLRHET8guRyFK7c0AE+bAH0fuZT+CBIG
 EAwCmPIpmy/61GWHqsA==
X-Proofpoint-GUID: HmzhIimKeYb179HAcXQBqeSbC-peA81k
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f1a867 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: HmzhIimKeYb179HAcXQBqeSbC-peA81k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290064

For older targets like sc7280, we see reading DBI after sending PME
turn off message is causing NOC error.

To avoid unsafe DBI accesses, introduce qcom_pcie_get_ltssm() to retrieve
the LTSSM state. For newer platforms, the LTSSM state is read from the
PARF_LTSSM register, while older platforms continue to retrieve it from
ELBI_SYS_STTS.

This helper is used in place of direct DBI-based link state checks in
the D3cold path after sending PME turn-off message, ensuring the LTSSM
state can be queried safely even after DBI access is no longer valid.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index af6bf5cce65b..085300c1d1ec 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -71,6 +71,7 @@
 
 /* ELBI registers */
 #define ELBI_SYS_CTRL				0x04
+#define ELBI_SYS_STTS				0x08
 
 /* DBI registers */
 #define AXI_MSTR_RESP_COMP_CTRL0		0x818
@@ -131,6 +132,7 @@
 
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
+#define PARF_LTSSM_STATE_MASK			GENMASK(5, 0)
 
 /* PARF_NO_SNOOP_OVERRIDE register fields */
 #define WR_NO_SNOOP_OVERRIDE_EN			BIT(1)
@@ -145,6 +147,9 @@
 /* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
 
+/* ELBI_SYS_STTS register fields */
+#define ELBI_SYS_STTS_LTSSM_STATE_MASK		GENMASK(17, 12)
+
 /* AXI_MSTR_RESP_COMP_CTRL0 register fields */
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_4K	0x5
@@ -245,6 +250,7 @@ struct qcom_pcie_ops {
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
+	enum dw_pcie_ltssm (*get_ltssm)(struct qcom_pcie *pcie);
 };
 
  /**
@@ -428,6 +434,15 @@ static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 	writel(val, pci->elbi_base + ELBI_SYS_CTRL);
 }
 
+static enum dw_pcie_ltssm qcom_pcie_2_1_0_get_ltssm(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u32 val;
+
+	val = readl(pci->elbi_base + ELBI_SYS_STTS);
+	return (enum dw_pcie_ltssm)FIELD_GET(ELBI_SYS_STTS_LTSSM_STATE_MASK, val);
+}
+
 static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
@@ -1260,6 +1275,19 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
 	return val & PCI_EXP_LNKSTA_DLLLA;
 }
 
+static enum dw_pcie_ltssm qcom_pcie_get_ltssm(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u32 val;
+
+	if (pcie->cfg->ops->ltssm_enable)
+		return pcie->cfg->ops->get_ltssm(pcie);
+
+	val = readl(pcie->parf + PARF_LTSSM);
+
+	return (enum dw_pcie_ltssm)FIELD_GET(PARF_LTSSM_STATE_MASK, val);
+}
+
 static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_port *port;
@@ -1385,6 +1413,7 @@ static const struct qcom_pcie_ops ops_2_1_0 = {
 	.post_init = qcom_pcie_post_init_2_1_0,
 	.deinit = qcom_pcie_deinit_2_1_0,
 	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
+	.get_ltssm = qcom_pcie_2_1_0_get_ltssm,
 };
 
 /* Qcom IP rev.: 1.0.0	Synopsys IP rev.: 4.11a */
@@ -1394,6 +1423,7 @@ static const struct qcom_pcie_ops ops_1_0_0 = {
 	.post_init = qcom_pcie_post_init_1_0_0,
 	.deinit = qcom_pcie_deinit_1_0_0,
 	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
+	.get_ltssm = qcom_pcie_2_1_0_get_ltssm,
 };
 
 /* Qcom IP rev.: 2.3.2	Synopsys IP rev.: 4.21a */
@@ -1512,6 +1542,7 @@ static const struct qcom_pcie_cfg cfg_fw_managed = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.get_ltssm = qcom_pcie_get_ltssm,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)

-- 
2.34.1

