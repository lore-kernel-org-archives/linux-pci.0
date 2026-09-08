Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48698558216
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881367; cv=none; b=akE7uozZPyKNTjeT/094+gc/IG22Rgio76/yAeOZphns8t36XaZdDTJ/ED9TKq9cJ+LSftPgrn6LlrLc2s/jugYTzfx1wITHaSLdWwQ/rCJ4FPlXu4oHT7bgyS4GjG5MI8egqsroFR+AHa2NohhrupIhFe71RhnSC05LMaFCtb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881367; c=relaxed/simple;
	bh=yr7zxykqaTEaqzdPRUQ5MNYO5+hsegnlEgHIOVDefkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sgyiwEXtclS9Dr8NnW1pmM+z5tDFVh4kD+1adGB8LjzokQMdcDYpm3VkbzrarVeVvdkaIFxP6Orkss7ZRUlTxcVeG+wdyQRaC2B8EY7qmdv7x8TyiJPbSNznTfDNM1wDhPrdnoFecBFPkIDa3hEacV/oTxp9nIwbtn7AhBPFSDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TaBj/npQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xoa6eIIG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TaBj/npQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xoa6eIIG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FOiTO2736059
	for <linux-pci@vger.kernel.org>; Tue, 8 Sep 2026 15:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lRt8wHoXcNopaXjD+865R32+7CTYvwmYmsu8jeufAWE=; b=TaBj/npQq79CGR2t
	tmlokXHfSNPQDQM4VHilbhWH5DL+BJ3Wovl157JWOtF95T4k4249IIYZtIFG1UyX
	TQrSYSrayAFYNqGll6Kug5pzq/xiNIec5h7yJEqNEuWIe1acBpKyfMnOo2LfAOn4
	HmVoYympceVmwrBZvb1FEk9WOk69rCX28yLKbcu846qk4VSyOTkX91RIaNzI+ewe
	4haQ5/CoIcIY3+mTfahGq3wRfm2gbwI8LzyCg/LSgSqr7npKRznq34UHGlfqStgq
	lbvT9YObMM+YZhu/IUS+v/2yYnJdXPXPWH85UhSk2NBvcLpQ/80qSPgTmO+WMuGj
	0RG6eQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjjvugqmq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 15:29:13 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-97cc09260a3so4251305241.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 08:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788881353; x=1789486153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRt8wHoXcNopaXjD+865R32+7CTYvwmYmsu8jeufAWE=;
        b=Xoa6eIIGg4l9r924fJwLj1igq/tHS6JRBaaD8EpYziSfrKy97hsTxtFP/ZuxTbDmYe
         JnrEm3b4KEQ+PLUmlv0k7OngeviHyMeXlEPn61rz6D2pxQNnKUrTCNhDr2tvXq5DuQIt
         pb6JFYW+ZlPZcUFFpvRTVNNx+PvSpCb+TX5ee1OvM4Ha5cVq7Napb4/P0cOl41raqP78
         xG+AyE8S3q57wFqAsQW4o42Oco3VNlP4N3PwMnVG5hj9CfCf/PQW8MulRaHEhfIGkkyp
         1AFFCBENXCEHHX5EExPlQKFQ+OTqVcFngmcuh0UvU1iz1/0bLHWRNkW5dfpQDnJ4JjBt
         2iQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881353; x=1789486153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lRt8wHoXcNopaXjD+865R32+7CTYvwmYmsu8jeufAWE=;
        b=Yz+jm3K6yQGQR60u0EoYTQ5D1kqNMCVwxQ1xeIxYq/VmLd4tqg8TjuIPaNHqM2Dxlq
         jN5WiJqKhP6Wh7AAY+CwJA+lYREhJGXAKr1Bi5dkc86m7TOZF/DoGiuShb97tTWrlnNx
         lO0alPGAunyJbx4DZoF4p7anGWkPjtKk76C6pOQuXJxUq642owbkwGNjr5lyDvm1BYbW
         xCg+hgHraFsBy1kw0Eee2rAWcNm3TYOjQb0oRAWiCUlSx5o32FwOSWhKpmbt+6Xk1dbt
         375hXljvsbtJomcaxqoTl+F40H4qMjL5hqRRV49kZbC+rLgDCVTgrrB5x4knthge/Dqt
         5Ttw==
X-Forwarded-Encrypted: i=1; AKwUvBy1yhOen7Yx6TI1JZnBCLpzqcSAugNY8dE8mSZK9kJRiQVAustlvjb1j2V8H10H8sd8XThGXZqYKMo=@vger.kernel.org
X-Gm-Message-State: AFuF++mMO3QbJtKDS08yOwg7c0jT0Ntv/95DrlQXjYMKo1pj8fMF4l45
	mfMgdAgCC9cMnK3KdVon3n2VjwuqEcQHW75oxsvN8hjvDLjny+7klGFpt8mVfAa6X5LuG5LiIUa
	Cfoe+RlSYb6mooQu38nSVLpHBQl92AVT2WP2QE45asIC/dgdJ8c8jlUGkGF+6blU=
X-Gm-Gg: AYBFou3hmgcJlg2LBWvH7stojPqBPk3Qzg2b4YkW8jm+wptarGnctUmBdI3KBF22QZA
	UHZNq/jN+kpTxSUv8RqCQBnTIjLfbNLYZdPacgb7C+5/RAqz88DAB+1itJcHm7NJtkuTSdb82mr
	yn3u6izPSuTybwJjRyV1YJYSfu9yOVqmgMRpnhX9E6x/1fUkLmFai202rF1vnzCsU8UK3g8JzQk
	B81llP99PFAtsh16BfP7ytf1P3zcDVn5FlpQvrwVNUHwy2NFtr+m1o7MsfzSSkCQPE9jQjrOMqk
	f/aQZxSCe16fEq2WY90ecc3Y4BADYoOSiUmPC0mNwefYNh6J8l/WvlFtW3XVbwxV1Tce5UPe+LM
	pT3w0x+A1V8RgzQ==
X-Received: by 2002:a67:f2d6:0:b0:78a:6488:b1e1 with SMTP id ada2fe7eead31-78a6488b3a8mr4358778137.12.1788881353099;
        Tue, 08 Sep 2026 08:29:13 -0700 (PDT)
X-Received: by 2002:a67:f2d6:0:b0:78a:6488:b1e1 with SMTP id ada2fe7eead31-78a6488b3a8mr4358758137.12.1788881352550;
        Tue, 08 Sep 2026 08:29:12 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm525231635e9.14.2026.09.08.08.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:29:11 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 17:28:37 +0200
Subject: [PATCH v4 4/5] PCI/pwrctrl: tc9563: Switch per-port reset to GPIO
 descriptor API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-pci-tc9563-aux-v4-4-c7fc7778292b@oss.qualcomm.com>
References: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
In-Reply-To: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
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
Cc: Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: Rvd7slCiszogbfcggaGLx0SrL40d_2iL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfX5LVtXaynCzzt
 M+Svz/tOBYwYhIuRfPipgPG4cMB92DCTwr+jx8BK+Dq9gRYQ9b5paJoN3eczocr27bju54k7iHo
 hdH6YwDdqoZcMlL2SVEUq10zBX7ymNBikxVutDuKeJrGCZ9+WekpjIHDrcgFVmTdxC1p03kixek
 PynoiLRDQ8rdJUsh434jSezFUa14cu57e6KiBUHtbHf5FE2X6LQSx8qURjnw7NNkIOb7+1H5pTV
 uw7ErF2oAjWIy1M1hKozridZS5Nbps903hbzSwqDKUvDA+9r2GUQ+yTobnXQ0GVzcwM4WtTQ4xh
 CnxCyHEIX1J24spvnGo/odvPqyRR1Qkjx7eoUpdosDXjE7DdZ5sEE1LOw4JVB9HTmSLMFWf+rG0
 QRqLnjAxnAHRD7DsSiuarwwrmwyBhIWhfMzp5GI2eky9V7cyPEFHFmDRPiyfp4GHLNKXfA+zo/b
 Y9AQfwtS1GxTv3ec6Zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfX77Ouwxbzo2z+
 Ie4r4BOtvnGt6/sIXmQGux2pdGB9PR3iS46018kSR9ynMkzKPi8cRKrOFOKgYuqPtJjHoXvB2eO
 8gCJsyoZDwEAsXkJOPe2BBcvWXaDC3M=
X-Proofpoint-ORIG-GUID: Rvd7slCiszogbfcggaGLx0SrL40d_2iL
X-Authority-Analysis: v=2.4 cv=X8hi7mTe c=1 sm=1 tr=0 ts=6aa029c9 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ee_2aqc6AAAA:8 a=Vto0WN7G90g_gJJAuHcA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080167

Remove the local TC9563_GPIO_MASK and TC9563_GPIO_DEASSERT_BITS
definitions, which are no longer used after switching to the GPIO
descriptor API. Move TC9563_GPIO_CONFIG and TC9563_RESET_GPIO
definitions in tc9563.h header file.

Replace the direct regmap-based per-port reset logic in
assert_deassert_reset() with gpiod_direction_output() calls, falling
back to the legacy regmap approach only when no reset-gpios DT
property is present for a given port.

Add the reset GPIO pointer to struct tc9563_pwrctrl_cfg and introduce
tc9563_pwrctrl_parse_reset_line() to look up reset-gpios from each
PCI downstream port child node. The lookup is done lazily at the
beginning of power_on(), returning -EPROBE_DEFER until the GPIO chip
is registered.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 85 ++++++++++++++++++++++++++------
 include/linux/soc/qcom/tc9563.h          |  3 ++
 2 files changed, 73 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 3fb862105fa5..59bc0d77d3c4 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -26,9 +26,6 @@
 
 #include "../pci.h"
 
-#define TC9563_GPIO_CONFIG		0x801208
-#define TC9563_RESET_GPIO		0x801210
-
 #define TC9563_PORT_L0S_DELAY		0x82496c
 #define TC9563_PORT_L1_DELAY		0x824970
 
@@ -60,9 +57,6 @@
 #define TC9563_POWER_CONTROL		0x82b09c
 #define TC9563_POWER_CONTROL_OVREN	0x82b2c8
 
-#define TC9563_GPIO_MASK		0xfffffff3
-#define TC9563_GPIO_DEASSERT_BITS	0xc  /* Clear to deassert GPIO */
-
 #define TC9563_TX_MARGIN_MIN_UA		400000
 
 /*
@@ -88,6 +82,7 @@ struct tc9563_pwrctrl_cfg {
 	u8 nfts[2]; /* GEN1 & GEN2 */
 	bool disable_dfe;
 	bool disable_port;
+	struct gpio_desc *reset;
 };
 
 #define TC9563_PWRCTL_MAX_SUPPLY	6
@@ -354,16 +349,40 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
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
@@ -398,6 +417,38 @@ static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
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
@@ -489,6 +540,10 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 	struct tc9563_pwrctrl_cfg *cfg;
 	int ret, i;
 
+	ret = tc9563_pwrctrl_parse_reset_line(tc9563);
+	if (ret)
+		return ret;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(tc9563->supplies),
 				    tc9563->supplies);
 	if (ret < 0)
diff --git a/include/linux/soc/qcom/tc9563.h b/include/linux/soc/qcom/tc9563.h
index 0dfd25747b9a..086f37a40d80 100644
--- a/include/linux/soc/qcom/tc9563.h
+++ b/include/linux/soc/qcom/tc9563.h
@@ -13,4 +13,7 @@
 #define TC9563_GPIO_EN0_OFFSET		0x801208
 #define TC9563_GPIO_OUT0_OFFSET		0x801210
 
+#define TC9563_GPIO_CONFIG		TC9563_GPIO_EN0_OFFSET
+#define TC9563_RESET_GPIO		TC9563_GPIO_OUT0_OFFSET
+
 #endif /* __QCOM_TC9563_H */

-- 
2.55.0

