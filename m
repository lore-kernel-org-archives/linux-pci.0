Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FDE47A89E
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258527; cv=none; b=NDqadNsM4LDLc/B6RZ8emfXRfhiFR497TLKCWV2NQMAxpYCyLs1iDIi6sowrmunuX/GNpc3zZbDomO+Vly+0S4OW7SN5uQvAcs7HPxHnEnTo0a3/OTer+MdEWe2qKslU0UNjUn2i0jCXi7zsr9KEsG/54wPc/pFUBT1ArGZWsss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258527; c=relaxed/simple;
	bh=Lpf/ZwlDI+w5kSfuIzRiRRQ5wKeVd07lzqLdLM481UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivdy5koy8tEL73C5UsIEelo1WFNIDx8arUrFQdz4tWsRAEJDCF59shDntXrDsLAa4EtloLgYg5S4yy4Bxe7dTfqBsY++Lv2bgH2eRdduKN7JTMh1mYmSKiP7Wg+RBhuCY6I19Qb6ClDkaHioiSBzwTfwGk9zYHaerMRW4cy+5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YxNodZtW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gSrVfduh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YxNodZtW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gSrVfduh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJlSh1713281
	for <linux-pci@vger.kernel.org>; Tue, 1 Sep 2026 10:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9cTjmjn9lQpAlWcg2tEI3HZAf9kgXfovcrDlHVMdULM=; b=YxNodZtWZ5gPCRGa
	zia0bsdxU+6rzZCXzo+oOKwFvC3d1SX9PsM8nKkXvr4x3rbNDpF738OJ/cLDkIZZ
	fxIeCfbPZGqKiXrRNDb7v/cCrJYuUIEUlF9j/dXyfB2PV9A4huymwrspxb0gSGaV
	jSq5RlxUazIMCseFukme1qGGc4jb3Kjcg6bj1ethGwvoE8tGkEmPIRZUF0icqEVv
	lv7ft741qHqNoh7ddQGnnTYMI+Q83hs2HyiVCPFV3HLAOUMgjZ6b73AAQ/CltEnb
	jTpmQryux1Nmnaevana9t+/HWmaaJcAU3/hT6KolNBqUk66GbtZ/Ahi+bqZclbgC
	TTfD+w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdndxa156-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 10:28:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e4f946461so785769485a.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 03:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788258524; x=1788863324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9cTjmjn9lQpAlWcg2tEI3HZAf9kgXfovcrDlHVMdULM=;
        b=gSrVfduhkCQtty7HlXi/6vtZRM3T21geX4/DUMHui/mvk+c1POO0PCUWFQAQ7nd3On
         mSK6A2BgmibhgTor1tN1RNjklkNeE3qms7AwCl67MFYNPIzkXcjGnbeCl6mZOI+apZFD
         rYkWOD4PvbC6rN51/qm4NPTpaCDHmcPvvu2X8bhUxrsxEaKWgls85OV2aM3oan2Ri1SI
         0TSbohQuL5cXb+/HntmpGPIIeFIOEN8tswGeUA7tqtFQclu5wCMsBn7tEFFZ359WKKkS
         Q0eU/9WFw9iU5ZQ2v198UvLLfnDfnQcOgJbBvvWoA2CsiONq5e9ijeIF5fThBelbn5W7
         G25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258524; x=1788863324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cTjmjn9lQpAlWcg2tEI3HZAf9kgXfovcrDlHVMdULM=;
        b=Y5I9pnIqMoWw4uAyNS1j62DmkcYInpeClNK1tAg2nk3M5eT2NV1c1fWBoXKsAkDZTr
         aIjMxLVNHhhWltIgZjMg/QwUyJcAGRqvD7p/15xwV5c9gHhuzB0ONDR0lVM5AY1HfmzW
         IKPWehK7WbwFTI4eMP+F/o+NRcTNeWGhXwJs1UgHEtRBiXKUCV9hPEq2aCcpXEURDViO
         NbViIXTM4s0CJsvQrg42IbogcVvCMmSF6IdJ+i5e7yKCgyIQgZWqyglt/plt1pL6UWDn
         LTkVdQm+VU9FPhDz3XvwH6q0Ok7lEco+QIKwenQ8ClOm8VrFxfo0XnW0CIvVmkgCO6R/
         URlw==
X-Gm-Message-State: AFuF++liu6K7RePT4WFTRB2iYjF3E3EUjYJM+36CaKKyoFqG+BHjMatb
	0VoMt3lEBny0zl+O5w4xUQ3lIeorZvtHJtosWp8x2/BBjajQO4tl/BzJMO1PGK4grofhPxzDu+J
	gKZG19jjTMUurO+PsbZp6RPoUcB3HzTVWXKJmK/eQ087cxX9dtUMpX3rgz3Rl9pgwm1ISJIw=
X-Gm-Gg: AR+sD10lQQp+1P7nf4AgdEy/wacbA7VCSqcHJUXJoRRuQq82zNAei4iWVtXdCqoe2j/
	bCJYOCdbkowZ2/3qiVqp4uwz89WeBXSztbGTE9GxetBNCSlUGK+2wh7oKGvxrBx9DFBvx3CLSQ/
	OYx5MA3UvCYTgFfYwoNBlTUduo5ZHuZstU60mHeak1XoCQQgO1oJYxM7B/jcGa8bAqK9h7pkxuK
	40nfA5VcQynGeamdK8LaT/ihYN3nflYoqnevonj9eo2sAQl733el/r+ZXnYDgtjHyAfmgZierhr
	P+t+EdPzOnIMEDEWt3z6RQ7B8RnQoFr+IuMbeHUpH/tOJlBKvIXK/DEX5C5xzmRn4k6EnBG/73k
	L+DN3D1yVP1a2HA==
X-Received: by 2002:a05:620a:6f06:b0:92e:fc42:2c19 with SMTP id af79cd13be357-93947ff98a6mr936891585a.11.1788258524106;
        Tue, 01 Sep 2026 03:28:44 -0700 (PDT)
X-Received: by 2002:a05:620a:6f06:b0:92e:fc42:2c19 with SMTP id af79cd13be357-93947ff98a6mr936887785a.11.1788258523641;
        Tue, 01 Sep 2026 03:28:43 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce0b425sm56300155e9.1.2026.09.01.03.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:28:42 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 01 Sep 2026 12:27:56 +0200
Subject: [PATCH 4/5] PCI/pwrctrl: tc9563: switch per-port reset to GPIO
 descriptor API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pci-tc9563-aux-v1-4-dd9b80738e70@oss.qualcomm.com>
References: <20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com>
In-Reply-To: <20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: zJXZBEFbcxYUXWVsBz3y6687ifEdTHu0
X-Proofpoint-ORIG-GUID: zJXZBEFbcxYUXWVsBz3y6687ifEdTHu0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5MSBTYWx0ZWRfXy3rmYTpDQ64Y
 Y75YPV98v5hH+vEpAm4FNQK2FziDDGpUCZ0nIw2j1LDZq/WgMOp+9dPqe2Fvch0PcGbxQ5/Z4QA
 lH75YBfJtXQvaN+ekr1y64CSe3xQIrA=
X-Authority-Analysis: v=2.4 cv=U8eiy+ru c=1 sm=1 tr=0 ts=6a96a8dc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=viGhCAv9QodxNsH3n2EA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5MSBTYWx0ZWRfXxBN3fhIGhimF
 ktdePX+JPmrwViyJdM8toBUQkjjFPfwXQdkNT2PtRkxMbPCyzchT8p24SlP5mYygNiCo2XB6eQ3
 hmaYgg174Q8YTncN+bkHgp0rPwV8LJm1rzbP+lcLm+kw4cqKZyUydSPuY/yakwcvNsHsiQxV23n
 sBIcadWL+rsJ4XKaInKJxYIUfzzBfVIAr3CyJN7a5A0H3sZwVIFmbweO8K2trSArBIXEXaCDyzb
 /t5oozvLHFe+v/b93fTaPodT9hvXuxWzswOso2ezvBZ4AMR/7WXYHc6t0DGx/y3K5TFswG4d42f
 z/4g8XQAb6ZF0Xn7Mkxx08xMLt9kqgLwRGQTht1FKrqVrwJrFgCeMgBhqkI8iwwTlFOcYLMFiZA
 J1McXFPtZIfZY/aBffgWhSxXk2HC1tqgTbcczm+Iq+54zNEvKW4bUc94UvH/fXhUEAq6kIfMpVp
 py1NbnjFF+HAcTqv9MA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010091

Remove the local TC9563_GPIO_MASK and TC9563_GPIO_DEASSERT_BITS
definitions, which are no longer used after switching to the GPIO
descriptor API.

Replace the direct regmap-based per-port reset logic in
assert_deassert_reset() with gpiod_direction_output() calls, falling
back to the legacy regmap approach only when no reset-gpios DT
property is present for a given port.

Add the reset GPIO pointer to struct tc9563_pwrctrl_cfg and introduce
tc9563_pwrctrl_parse_reset_line() to look up reset-gpios from each
PCI downstream port child node. The lookup is done lazily at the
beginning of power_on(), returning -EPROBE_DEFER until the GPIO chip
is registered.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 85 +++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index ee9c26b8f5cb..ff84f4ef7878 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -57,9 +57,6 @@
 #define TC9563_POWER_CONTROL		0x82b09c
 #define TC9563_POWER_CONTROL_OVREN	0x82b2c8
 
-#define TC9563_GPIO_MASK		0xfffffff3
-#define TC9563_GPIO_DEASSERT_BITS	0xc  /* Clear to deassert GPIO */
-
 #define TC9563_TX_MARGIN_MIN_UA		400000
 
 /*
@@ -85,6 +82,7 @@ struct tc9563_pwrctrl_cfg {
 	u8 nfts[2]; /* GEN1 & GEN2 */
 	bool disable_dfe;
 	bool disable_port;
+	struct gpio_desc *reset;
 };
 
 #define TC9563_PWRCTL_MAX_SUPPLY	6
@@ -349,16 +347,40 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
 static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl *tc9563,
 						bool deassert)
 {
-	int ret, val;
-
-	ret = regmap_write(tc9563->regmap, TC9563_GPIO_CONFIG,
-			   TC9563_GPIO_MASK);
-	if (ret)
-		return ret;
-
-	val = deassert ? TC9563_GPIO_DEASSERT_BITS : 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tc9563->cfg); i++) {
+		int err;
+
+		if (tc9563->cfg[i].reset) {
+			err = gpiod_direction_output(tc9563->cfg[i].reset,
+						     !deassert);
+			if (err)
+				return err;
+		} else {
+			/* Fallback: legacy DTS without reset-gpios */
+			switch (i) {
+			case TC9563_DSP1:
+			case TC9563_DSP2:
+				err = regmap_clear_bits(tc9563->regmap,
+							TC9563_GPIO_CONFIG,
+							BIT(i + 1));
+				if (err)
+					return err;
+
+				err = regmap_assign_bits(tc9563->regmap,
+							 TC9563_RESET_GPIO,
+							 BIT(i + 1), deassert);
+				if (err)
+					return err;
+				break;
+			default:
+				break;
+			}
+		}
+	}
 
-	return regmap_write(tc9563->regmap, TC9563_RESET_GPIO, val);
+	return 0;
 }
 
 static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
@@ -393,6 +415,41 @@ static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
 	return 0;
 }
 
+static int tc9563_pwrctrl_parse_reset_line(struct tc9563_pwrctrl *tc9563)
+{
+	enum tc9563_pwrctrl_ports port = TC9563_USP;
+	struct device *dev = tc9563->pwrctrl.dev;
+	struct device_node *node = dev->of_node;
+
+	for_each_child_of_node_scoped(node, child) {
+		struct tc9563_pwrctrl_cfg *cfg;
+
+		if (!of_node_is_type(child, "pci"))
+			continue;
+
+		if (++port >= TC9563_MAX)
+			break;
+
+		cfg = &tc9563->cfg[port];
+		if (cfg->reset) /* Already discovered */
+			continue;
+
+		cfg->reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(child),
+						   "reset", GPIOD_ASIS,
+						   NULL);
+		if (IS_ERR(cfg->reset)) {
+			int err = PTR_ERR(cfg->reset);
+
+			cfg->reset = NULL;
+			if (err != -ENOENT)
+				return dev_err_probe(dev, err,
+						     "failed to get reset\n");
+		}
+	}
+
+	return 0;
+}
+
 static void tc9563_pwrctrl_adev_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
@@ -478,6 +535,10 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 	struct tc9563_pwrctrl_cfg *cfg;
 	int ret, i;
 
+	ret = tc9563_pwrctrl_parse_reset_line(tc9563);
+	if (ret)
+		return ret;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(tc9563->supplies),
 				    tc9563->supplies);
 	if (ret < 0)

-- 
2.55.0

