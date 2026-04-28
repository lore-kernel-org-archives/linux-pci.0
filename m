Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074703DC4A1
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365462; cv=none; b=IBIXrY5eCjmvzRsewF2IdbCkG1pSZY6HKW/nRM4rLCvxDgkg0R3XjDHVqZ0yK8PLWb7YognXNFe+FCwnXt83h/dY0cO5DKH9rw2Ksx3csWUHugD4QIULw+xuUUEiub29jOX0sLFPBnKToB0a1PUyF3IGNi8PBxMhX0uIbGpRTwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365462; c=relaxed/simple;
	bh=vt5YE7wXt9WaDQtNgVd28OtMNl95FIkNup1m283AaoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGuYsa6ajBVh+TZCwnMOfqh/VsXpt89u30v5Kp1Yynq/nmdVK/bXGZycGFUF8hnDKo+SLK5N2lQimojzHyI2E+NDOQhN0yslAQJEV5S8c0CVoHfp9RSzVGrF4gGNDX7tJ9mhF1+hy5gOKYfJssUuk9cs57jdtgpJtMMHvl1g8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UyjygCdQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FVB9o5YK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UyjygCdQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FVB9o5YK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S21irZ3123758
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 08:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Tj44f4tU9rPyjpStS2CB8zxmonpsjSFqeb8FHEyg4c=; b=UyjygCdQFVfTGaGk
	o25zaijW7QQfU15HqhrTP3j6oTx3xGqDpS/ehgfpM+oIPStUcRQsKfeEWaoJohMd
	tFXdaqu3RVEIvvb9wbwW/4uXF/Tt8uTZlCMouW7KVbXnogJhTatwrjgWGu9ZInoy
	/NgPtRdXGPO65IYbT/JvcOwnwTpfS2NlQQNmrVJVYVuTGthcubAJaUV9v9dDya2w
	B6QXE/gdIk+OeSMR+25XcNG3sPYUVFb72Igne2lTK0dEClgtsYWLh3KMbQs1qM/A
	hB4JtYyiSbL8TU750SRDneJehjhIF23mCrjYy6IDJE2z9nLMxiiRmKujb+z4h2EA
	G+1z3Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5qgmm6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 08:37:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b465bf993cso114179365ad.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777365460; x=1777970260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Tj44f4tU9rPyjpStS2CB8zxmonpsjSFqeb8FHEyg4c=;
        b=FVB9o5YK8OKv2Swd6JJn0e8BoP+GfldsAqKYWIf4dbN/Ez8gjoVMA/ZBLP8s2zkO84
         rOn0Q7mjLcZbctWH85ODwCEXzOvYlINL2ADhh/XXjdR/scK6icdGTiHHjPqtDvxk84O0
         mf72AIdFMdCPP3KJQ65Oxazjax8uAAqFIdmHGRuSYMX1u2RZrpMjzZQLqwrV3w0+tU5n
         P7FrN59aM5JUf/G1w5YDTI+no4wa7FPh0MTu/fziiPWoiPHrVMDOg8Qp3beF9//RuX9z
         bDpjXj4VXOWAWHVQH3/GI4ujPRXzrgm2X3HXSTUMYQvdPa5TSF77HPjNy+odlnqJXIpS
         1WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365460; x=1777970260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Tj44f4tU9rPyjpStS2CB8zxmonpsjSFqeb8FHEyg4c=;
        b=beVuRDWAqBW+hXflERzT3V0SpJWhVB/qd5tqPQvY/L+wDKB3mq9iDLzOhupVL7ZIom
         XScNNXuWnRIGAYRI9ju3GuMQt+bPl2NV7NR6bJTIn5k70zmAG/E2weNsL+xrfKdsnjCN
         XCEp69cJkD/3JwpgEfDxXLIowhg4mukBHwDF1YtoBaoAaPnXCSPwRRV7GyL29RvLYuMK
         iTyZ0AsCxBQcTIy4IPyiuUnFLRURJ1W0ZEIlTAS2gLdwSbbjZH4h/dqvfw1JMzEstzcG
         gLg1Pj/YDS4iHSSAg4CrpPRF76xZ5nK8JKhXtclj3aVymFO35xyuCWd3Md/4YBQkZVzO
         PXBQ==
X-Gm-Message-State: AOJu0YwnOCexvRn7rmvWkdUXzprw/J4kNxAhjQGW6fSH9CduOx0zdKlK
	CX0BcxNhsCW4/YpkhiKUib7FGLL/HW8/stkmmZMv6xEmMKUVWBx5L9inQ4hE0v0cSsG/bgpJWfm
	XTK6dyze5CRLlqqL3MRhjIVFKIhRdaMFFYHdrLJzhuyNMMF5GHIbigds1qhYNxFQ=
X-Gm-Gg: AeBDiev4cfldJ8y74jGeb8nfhDzbciXZxEIR8NyA2Y2y8d3eVIOFN+dk5g63Rkju/pR
	Gv0p6kuq85e4/bvcXkogWEazbahcv7aYf6IwydGs2Gg7QtnX6VaZ2r37tlRXQ3TNRcD5l7XB/XT
	Fx6YdOQtS9pz1DMvbeqYvdDE5HRha3BRE1GLWoCJqVhSVwyG1vJhSl9vjwkATqfarQIMLHZSgNz
	l9PgvSplVs2Wy6m8zSDxuMyZbadumiAjlLnpUMdEnH80jQ4kSg3LXIt1LT8+tC9GLJv2XCpP5Me
	DzR2Esterce/PEse68LAhT26mtWUGmbcNAdmRIChGO4+4/aIihvkgzKoCdmMuQNfFE8+L6OvJcc
	RC8UxEZTx7D+NmV3nqlwHo6HfBHlDyr/+TTlm6ubiy0GNx45cwfhoi+LFGIq0N4H4JMk=
X-Received: by 2002:a17:902:f785:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2b97c3a2264mr22624975ad.1.1777365459625;
        Tue, 28 Apr 2026 01:37:39 -0700 (PDT)
X-Received: by 2002:a17:902:f785:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2b97c3a2264mr22624595ad.1.1777365459144;
        Tue, 28 Apr 2026 01:37:39 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97acaaa2asm21645315ad.84.2026.04.28.01.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:37:38 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 14:07:17 +0530
Subject: [PATCH v5 3/3] PCI: qcom: Program T_POWER_ON
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-t_power_on_fux-v5-3-f1ef926a91ff@oss.qualcomm.com>
References: <20260428-t_power_on_fux-v5-0-f1ef926a91ff@oss.qualcomm.com>
In-Reply-To: <20260428-t_power_on_fux-v5-0-f1ef926a91ff@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777365442; l=2457;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=vt5YE7wXt9WaDQtNgVd28OtMNl95FIkNup1m283AaoU=;
 b=FidNjQAujwlIm+A0h9RRZoa+4kbabjKGMaKc/8qzpAWtr5be0ilcW7O8gNKHjqgkVJdYTVUp8
 m4yODhxBGK5BiIwXU1YNdyAkA7CQCn0yW94tbTr3DKKNJkMmI1OVlvO
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3OSBTYWx0ZWRfX3lKT2yQyAyCl
 S9KjCY9jxylLf60PmOEtIn2vDBIJhjH5Ir/j8Y4MPdKEKqxq1pmkpEFDryb4eNqOeV3qPHU81Hs
 DpMAzb+1qnTMS/Y+5ZDHrcJ4zH4YrS7YJw8M3WHGEQIjiHXHuleFhjWhyTYzzt0O1QSUdpicV9K
 QX978utEID4ZE3sqzlDjrnqrfp6lKcS2DcgRuZlHqkezWmdHKxnGtzpIz5WKagb0i8e3gRRXyHU
 WSQU2W3cdUe4Hapael6K3Bp5ovkPS+7nsYOgsswXbuK41ekRakRUhedrA8fZkTp88O3aShj9vAy
 wHQxzY+nfV0ROfX2FqwflhNpj3f1BJqTzOdvJ8+HDI5X4jhcu1VbHG3TLnXHNZ7tQPcWgCc+cSu
 d76ULZMIZe2/3Y03rg+BejQA+9P3O15UCj66hCiKkaofDu4mk2xaS1n3jnOuLhs+3ZqaanSra7U
 379DmakLQFXhWpmsP2A==
X-Authority-Analysis: v=2.4 cv=V69NF+ni c=1 sm=1 tr=0 ts=69f071d4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wXczfBY3881IDOTkNB0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Nepu06I3sx-hguotE_MgAC6xabPPlVWI
X-Proofpoint-ORIG-GUID: Nepu06I3sx-hguotE_MgAC6xabPPlVWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280079

Some platforms have incorrect T_POWER_ON value programmed in hardware.
Generally these will be corrected by bootloaders, but not all targets
support bootloaders to program correct values due to that
LTR_L1.2_THRESHOLD value calculated by aspm driver can be wrong, which
can result in improper L1.2 exit behavior and if AER happens to be
supported and enabled, the error may be *reported* via AER.

Parse "t-power-on-us" property from each root port node and program them
as part of host initialization using dw_pcie_program_t_power_on() before
link training.

This property in added to the dtschema here[1].

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Link[1]: https://lore.kernel.org/all/20260205093346.667898-1-krishna.chundru@oss.qualcomm.com/
---
 drivers/pci/controller/dwc/pcie-qcom.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index af6bf5cce65b..4864e152625a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -269,6 +269,7 @@ struct qcom_pcie_perst {
 struct qcom_pcie_port {
 	struct list_head list;
 	struct phy *phy;
+	u32 l1ss_t_power_on;
 	struct list_head perst;
 };
 
@@ -1288,6 +1289,14 @@ static int qcom_pcie_phy_power_on(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static void qcom_pcie_configure_ports(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port;
+
+	list_for_each_entry(port, &pcie->ports, list)
+		dw_pcie_program_t_power_on(pcie->pci, port->l1ss_t_power_on);
+}
+
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1322,6 +1331,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
 	dw_pcie_remove_ext_capability(pcie->pci, PCI_EXT_CAP_ID_DPC);
 
+	qcom_pcie_configure_ports(pcie);
+
 	qcom_pcie_perst_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {
@@ -1764,6 +1775,9 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 	if (ret)
 		return ret;
 
+	/* TODO: Need to move to DWC core once multi Root Port support is added.  */
+	of_property_read_u32(node, "t-power-on-us", &port->l1ss_t_power_on);
+
 	port->phy = phy;
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);

-- 
2.34.1

