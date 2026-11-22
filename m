Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316228;
	b=iMppkFIFsXR1WTm1/lo/mA/TQNG4pnQg0N7SjFPRHyQcjMwukQ2V/AR2WkhS7VeEG24v
	 cG0BQLc1FJR+qa/TToVNO0kZQdgyA0KLgaF7+eN/TInZzsVk0ha0i2w5LxxjaPT3e1tfm
	 XrJNdOIR20Os8yDFwazFK+JOdwb9JgY+IN3Xd2DaHyr7zlyrL99VBN5V7UL8zmM9Vq8RM
	 ietrnNVsa2pa4j8DgQkUjgjyT+GqLfvH7ZVYZYccrDG5DoRLy/yTtxFB+Y+T17QA28AdL
	 tAGWsnruEA0HhThwO4lahFs5DFQMalZ0AVP0tlC2UmBDytHoOs+Lzvcc+FnY4dENnrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316228;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vcCSKiEVp1onOIUz37SBkeUiaPNCLwE5jiEgCzuAmSA=;
	b=z0X/FKCIhtdgNHOCLEIHOom23TmqwJWomQB1UUMP+xOo1Lt1KJkgl+OgCkg0Fplu6MQV
	 PE9kGbUeL1jLh/ym3ZPO5IyMMyplozyZkWvdcZN+X4Sjp61bS32ZuqskvNcExSusXU9Qc
	 ZRgVq3Iu41I2BqtZUIjzu/5uyPWAn4XqKz4tS4p/S2uEAHfWrsFzddt4PNapOVTyTbG62
	 vqN53rHuFiRy1cvgxqRI2I9ACy0HA5koIgZiWdIEwaEUxBWLmhzGqd3rsLoGQmHxu1rD3
	 pzug93E8JHnlRvjhuGsW/R54AELYdZAAsXICDR4shsxR5TDFR/n4uF/n/v1pRgbHt8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NYdFd5bs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q15uVlcL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6BA606A330
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C6BA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NYdFd5bs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q15uVlcL
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM08Cac2906681
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vcCSKiEVp1onOIUz37SBkeUiaPNCLwE5jiEgCzuAmSA=; b=NYdFd5bseRzfCXzt
	d8aJg5vz4MYycLsLY6gJcUjcBbyln2NaS/SgvQPXbQialcB55FHjww2sBKAq8qia
	h6aDB9U+2/CtlVUTvFN/JRYgumvbLqkT90+rz/fxgMTgJDQQtk/twHMy7/ZEnMCI
	evtaU8xv69mJDERv0vsAW0ARveftu4lfJ45+IK9sOOQbWJv+Hqd2ez8FmLg0txCX
	R1kytBO2gZVh8iUOLTb2/2fliVmwqjRz5me772JxUQpkq257V4nwjrO31erueNVA
	IgTJy5ZM7g+5F5GOl9qso8DQyNxq5qOCoMgcH0+zgbs+ysVYmdQoVCnR5s4Kr+YH
	kviskQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j310fau1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:57:07 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3854627c1c8so3451132eec.1
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 18:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795316226; x=1795921026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vcCSKiEVp1onOIUz37SBkeUiaPNCLwE5jiEgCzuAmSA=;
        b=Q15uVlcLm5cpCufmEW3sKFe5N1CIRhPSwjIDmiacC/gDKBerPEvJyiJgWS98Slui18
         3hOrcCgLLYF2m3JV+jbEo9lvQ5x234avKvt3MRg3ubhyEL53lPtIvcElqJcYqwBm6FqZ
         9L6EgTr0sH7Wr1ShpzeqDm4FfThCnUBARn/8rS0HLFTmDzDywoIEjyhEhdgVcrbGyXK6
         3sn2jO9llAFgfooab7YKsdgx5hcl0HeQfBLi1eNV3uYnGzOxCxeU/AQxizGK885BMcyC
         Lh221FdWLk21ux+VHKrgojXqnoDY27cnt+DzMx1yuOiuHx6ml7BRXRmuJ9uVlyUUuXeZ
         8aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316226; x=1795921026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcCSKiEVp1onOIUz37SBkeUiaPNCLwE5jiEgCzuAmSA=;
        b=CvoXAVywl6X0o3Lzu+wDg0JikU3IE0ipGCSq8ewrEY/SkcCAfOBKRwItk3vX30ik4W
         KYZ0iAdLs8KX8Yil73YUlPz3A94O/nfKk+bntYi9oLKloIQiYKf2QO0uEakpP03JNv8K
         ZO8AQXXnb8ScC06ux12TagnalLMS6Ep9PlEFF8K95r4HSVbvFN9oOF7QkCxnoTaylYjq
         3dHATYKHnUNNtCJi+V5tHB+CiImkRJvDkK/iD+nOSMZqO80qaUSHv0gi9bg+Mmq5+JC3
         kvehrX5H68y99mgl+u7Pn/SDS1awE5TUodEYGQH03n0VUjEMSLi7NKFBRhhWg2btIONN
         riHg==
X-Forwarded-Encrypted: i=1; AL+hErHb14oPrKDAhuZBnfhbepg4UdBd2S9lamuQZO2Rk+68DcW7U5U6CBsR0UOW6axqE5BNxgBgUjmFqyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/G35XY1pzFLl9wukLTCCykndZWQGTdPdwSXjnOYn5HyPTg9e54
	RHGhxQgJNoiPgJJXJ4uEDwpMem2nn//ZfaJw7KEdli8CqQDMGyPCH8UvlqLRto8GEoRM0F1qfaP
	4QbhF6Pk4C0Ef8kWp8xCnVlD/gbvNp1FezY0y5f5re0B7XMv/tVdl1sxOyPOBOA8=
X-Gm-Gg: AZFdTZdPopTz32JtikDEye+FhWS3zkJfkAoZJ0mFureeT9zb3Tb8YBt6cctYNRID0VR
	2AypGjKbVncsMBK+67yvNiTGhXJdv6+JLbqwMOjAfipsskfIXxroQ+rAhtZH023Kk7/u9UMtWwM
	jhIi+4zna9/xVs6wv57U54yDk8/CokRl59YregYea0q9DIDOT+ZLHWCLQ/jvC0V2yun68moWGuB
	r1L9Wc3KoveCB6Gs2SCJT799L+hyw4Vm4603JdfoG+43p52m0PQ8ExC9YCf3e4ryxtuma5mGVa4
	uGPEZbbmzYLzyiIx+yg1jyoYvxpYEgrWbY5FXxZm9hf0fvLrQ5+tksKz2EwEMr0agzeDrqlBjHH
	1R04PcIBV3MHu/28PcijS0RG6fu647a8BzU+WTTQ4NcP7mwW4RiEVRQvSKHdnuL/jSe1rBYwFnE
	k3M8nGPpz6
X-Received: by 2002:a05:693c:68d3:b0:386:912f:c8dc with SMTP id 5a478bee46e88-386912fe5efmr5271992eec.6.1795316226433;
        Sat, 21 Nov 2026 18:57:06 -0800 (PST)
X-Received: by 2002:a05:693c:68d3:b0:386:912f:c8dc with SMTP id 5a478bee46e88-386912fe5efmr5271971eec.6.1795316225925;
        Sat, 21 Nov 2026 18:57:05 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm312044eec.18.2026.11.21.18.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 18:57:05 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 08:26:18 +0530
Subject: [PATCH 05/11] phy: qcom: qmp-pcie: Add PCIe endpoint mode support
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-nord_ep-v1-5-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
In-Reply-To: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <cassel@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795316184; l=3245;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=9UVXub4tyfQyqAJ5iLairdqM1PlMxztFvo8mRpY4zlY=;
 b=/xrnyvXAlwvkroxvh1fh6Ne6gyQ24oDqJjVsXBGs8mljggskqwHJ8AW9eNpwHn3irT19BeiYT
 lqikiJvdKZZCrCsuPpUawQ1VpjJCazPuc8cDV0m8ITn42MGHDQw3421
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfX6gZ4VxkxolOv
 vZstLp3KmpTd/r6eIk8ADo4TLU144JU9+LKVrI5Jd7TQ40ooBMmqVbaUvflxCGI8XIKVwwGshNa
 9qnE3ugkyaxbkRD5+KzxmR0uSGvTotjFzb0L1rmTN46P9+ZetLqtsCtFcgukE8oumpdrkof+5zJ
 cpg5vtvBAnUmWpsi+3LFVdBt4/Qaq/Yi7l339dxv7m7oiM6M4sOxoMwZvBmhddlVl0sgWgr66HT
 ftOdpWIT0H34qt1u9XeY9D2wC5pIWvJsRMiEm2tVPrEq7y2SgONMSW/42QyLvV1MaXfU3xUYcOQ
 0C/l8eYT1D6nbByBLz5RYGvJ2rH18LyKNq/icQWQYdoRcpJDJW/OZPFPGBYpg519QZxNC5sClkM
 awT/rF2V7nx48POTVew66fTyq1/ZBO3zuhDJhcbkghVZ++EJWB+nffUKf2BtqVqGLyjnflDdsuB
 zzr+SBKDmIEK7PGk2xQ==
X-Proofpoint-ORIG-GUID: 3FxYyMfEM-Pj_FjodNkQvxnr15cPA58E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfX3RQ3dyb77d7t
 5sdainLtaeLWhNLnfIH6NJELdKDhDARBXL8imdW3pM8woCdimPL9GDsuTsi/MqT5dI8FFWuD8Q0
 NWnZGymOhXSouDsIDKW0lzpMl15T5ik=
X-Proofpoint-GUID: 3FxYyMfEM-Pj_FjodNkQvxnr15cPA58E
X-Authority-Analysis: v=2.4 cv=UN1Ijyfy c=1 sm=1 tr=0 ts=6b025a03 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=n6AvfDos_TaM4Tq8RocA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_06,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220011

The register initialization sequence differs slightly between root
complex and endpoint mode. Add a .set_mode() op that records the
requested PCIe submode, and an optional per-config tbls_ep delta that is
applied as a second qmp_configure() pass over the pll_common/txrxz/pcs
blocks when the PHY was put into endpoint mode before power-on.

Configs that do not provide tbls_ep are unaffected and continue to
program only the root-complex tables.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
index ccdb7748a9e1..21cf6adf7d60 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
@@ -13,6 +13,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/phy/pcie.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -89,6 +90,7 @@ struct qmp_phy_cfg_tbls {
 struct qmp_phy_cfg {
 	const struct qmp_pcie_offsets *offsets;
 	const struct qmp_phy_cfg_tbls tbls;
+	const struct qmp_phy_cfg_tbls *tbls_ep;
 	const struct qmp_phy_init_tbl * const *pll_tbls;
 	const int *pll_nums;
 	bool port_split;
@@ -121,6 +123,7 @@ struct qmp_pcie {
 	struct reset_control_bulk_data *nocsr_resets;
 	struct regulator_bulk_data *vregs;
 	struct device **pd_devs;
+	bool is_ep;
 };
 
 struct qmp_pcie_multiphy {
@@ -930,6 +933,7 @@ static void qmp_pcie_init_port_registers(struct qmp_pcie *qmp)
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	const struct qmp_pcie_offsets *offs = cfg->offsets;
 	const struct qmp_phy_cfg_tbls *tbls = &cfg->tbls;
+	const struct qmp_phy_cfg_tbls *ep_tbls = qmp->is_ep ? cfg->tbls_ep : NULL;
 	int i;
 
 	for (i = 0; i < cfg->num_regs; i++) {
@@ -957,6 +961,15 @@ static void qmp_pcie_init_port_registers(struct qmp_pcie *qmp)
 		qmp_configure(qmp->dev, port + offs->pcs_lanez,
 			      tbls->pcs_lanez, tbls->pcs_lanez_num);
 
+		if (ep_tbls) {
+			qmp_configure(qmp->dev, port + offs->pll,
+				      ep_tbls->pll_common, ep_tbls->pll_common_num);
+			qmp_configure(qmp->dev, port + offs->txrxz,
+				      ep_tbls->txrxz, ep_tbls->txrxz_num);
+			qmp_configure(qmp->dev, port + offs->pcs,
+				      ep_tbls->pcs, ep_tbls->pcs_num);
+		}
+
 		if (cfg->port_split)
 			qmp_configure(qmp->dev, port + offs->txrxz,
 				      tbls->port_split_post_cfg, tbls->port_split_post_cfg_num);
@@ -1179,9 +1192,22 @@ static int qmp_pcie_disable(struct phy *phy)
 	return qmp_pcie_exit(phy);
 }
 
+static int qmp_pcie_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct qmp_pcie *qmp = phy_get_drvdata(phy);
+
+	if (mode != PHY_MODE_PCIE)
+		return -EINVAL;
+
+	qmp->is_ep = (submode == PHY_MODE_PCIE_EP);
+
+	return 0;
+}
+
 static const struct phy_ops qmp_pcie_phy_ops = {
 	.power_on	= qmp_pcie_enable,
 	.power_off	= qmp_pcie_disable,
+	.set_mode	= qmp_pcie_set_mode,
 	.owner		= THIS_MODULE,
 };
 

-- 
2.34.1

