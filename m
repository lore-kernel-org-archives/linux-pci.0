Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC656E075
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965824; cv=none; b=qci9iG6ebrRBPri08TD4NItAAYwf8KSThHAzz9+OfkOQaYey/4x6qapDZo2XB5vDTBYTyldg5qx655N+sfpgBhIebBiL9QBjo7kkzEDmmmhUb5lm+RWpB/S2rcBcErM0frq6NAsiksq/KvRhAXSvPar65/CqaaraFUo5km2jLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965824; c=relaxed/simple;
	bh=yr7zxykqaTEaqzdPRUQ5MNYO5+hsegnlEgHIOVDefkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3pmEIf++LJDYO5AcolyWhZK5I1m2sMCQmimZca3/8fbbKqf73gVtwK+++wy4qD1RzJ2rG8b19HPqLyBu/JdT8E6vSG41wool3Y798wmU++ogOsgGleXdEha2nrOe/kuw+4BXrqQ0AFPaiN/X2eJNMFPL3wS6yxslaM4KoOXCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IqBPnfhn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hZgf63cG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IqBPnfhn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hZgf63cG"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BoXaB2698594
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 14:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lRt8wHoXcNopaXjD+865R32+7CTYvwmYmsu8jeufAWE=; b=IqBPnfhnHE7adOfO
	kBt04nuTYV7puM3zUBtUurw3QH6K0IR4eiCUu942/pcIg+3cu0yQpwW2zkarIXWt
	cjl6pXlM+fKmDg2cZ94PYVHCQlFHuz2tWEDBehkIQ97KAHSW0eO2ukqLGRnSJR25
	9z+ygs2psBxUkZLcudSOUeWkBCkV+c7tfRaqkpRDEw9U/jfp9bhcSTlsi0xKOZpa
	jBeZbiabRCdZwQmoYD/iNcEL6nY52iHxQ7zoUToV01aybK9wgA0zmsZ/7CP7c9h+
	Myo0NbI191Vcy8e5nGlYgXXKi6aAZqOnCdg6PUqeZiVvgHwl7ZazNywRqBmcRGnK
	F79h2w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk6xh0tne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 14:57:01 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98066bba118so630489241.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965820; x=1789570620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRt8wHoXcNopaXjD+865R32+7CTYvwmYmsu8jeufAWE=;
        b=hZgf63cGspSN5hXM6vRhqxEkoQX59ANh94BFrkjdKVwtPBjZPHsd89eHcri/NkJkrf
         nu/uUxXVigsqA0D5E5J75Omb1feOneOgcxRkAgy0TQDdirNKiD9pRoCb7SIdJw1Nzn4l
         on6RnL9/ipqLIOdo8C/500xY5EC6fcUJHssFnhJ1ZzGLlo9AYV0YWd8LKtpRDU0TA1T/
         Wk+FkNt06OVH8QydTNEXjzowglQuATbxiehWgrhy90A3wQeIoW5MWyD+qpxDRY3YNByu
         dtYgAbYWUsc8A7xla4MAeKcKReO0QS/zvFpQMmjzj3X2c0/PqL3sboHxYggRry9tutSm
         yc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965820; x=1789570620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lRt8wHoXcNopaXjD+865R32+7CTYvwmYmsu8jeufAWE=;
        b=nEgrngGjIDPy88HbzySiXE1ZHcPchE0ApDvgwhnDKi4VtLZa7pAWghsSCqEP5Ks81f
         XrSwi/PR/kzd8r6av/yHg3CZe5FDaNJ9dgpXTqWvb05i8UagTkZbsBYrrNuO9GlxnQkp
         dRt1JYj4vfy9fd13bBMQ7BI7TsJFLWbqkUsSXtaRKzjfPXDb22CI6sQbAYsjdw4Zm2R6
         if+uDqXHfizcG88JokhHs5HYuSSAENsoD4aHnS+X0yFbqSLxOBXUcEqcWd3RxgrOIvMi
         rZLA8xrj6K56ywG4BWdzo9HBsRzw1DmV/WnAdPvMXXkKMIRU97uC5uiTsIncyYIc57Cu
         Mv5g==
X-Forwarded-Encrypted: i=1; AKwUvBw98FU1+rkCasabSXvHXaCGnC3mzsBdsiiPJLwgwv+UOpMIJuoAK/ArGb4Ga/QPntO+qIoRPv+tr2Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mp/SpqRNpiMfWOqy4D4OnrukwP55DZFTrLmDV64XImRHPO28Ck
	F8nqH4ngd0lLFFG5t+dyciIxxVrk7SqSTX0x0BTFWNF8lnfzbmaF99Rn/u1gTJ1FcTr5er+9PD7
	p71aU0GcI1ddFK6wYKH6BeYmYN6+DVLm15b6W2kPCCqWe28v7HN4u2PJ2QsLXNM0=
X-Gm-Gg: AYBFou2WtRqdwYJ30a8dinGH/BjUx6YP2TkYr1s3oFd227IcZWItwdBzYhAeCYEwK+3
	1HHtP+FuUHWj6fntJYskHlGLfGplujXDXEupWBSwoFqmDMrscKOt1aLvCLT/GsF7PzL35j+Tlrp
	yCeoe5dHsWIXkF6TvvEyQL9mS3xF+dsOVfacM0iB4Eld4MVGfQAYJsFsFTNnP87EWwX0PawV8r3
	2U962W1dJZxHGxzJhXo1wYtkobQjZUYT8wnbMz6NpvWk/W+R7kxqj7AJ51l1+ftTO6xv7sfOG/k
	Tw4CtYMQLCTq+om8Z7kyrfznUST/YjYm2ajhrUvOtRTQnENP2n0G0Yz/GjB9spVkdliz+DKBFX+
	zV4iGKW9+H/CrKA==
X-Received: by 2002:a05:6102:2925:b0:785:ac20:bdc4 with SMTP id ada2fe7eead31-78a4aa0796amr14035561137.10.1788965820434;
        Wed, 09 Sep 2026 07:57:00 -0700 (PDT)
X-Received: by 2002:a05:6102:2925:b0:785:ac20:bdc4 with SMTP id ada2fe7eead31-78a4aa0796amr14035531137.10.1788965819950;
        Wed, 09 Sep 2026 07:56:59 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm560702895e9.15.2026.09.09.07.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:56:59 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 16:55:56 +0200
Subject: [PATCH v5 4/5] PCI/pwrctrl: tc9563: Switch per-port reset to GPIO
 descriptor API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pci-tc9563-aux-v5-4-c9b33f56c8d3@oss.qualcomm.com>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
In-Reply-To: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX5U9vrWDH4mUO
 HW3dTbTqlzUsDWQBIfBsePU00udFWG/Py4CbpF2NzbpFo8NcrSauS8LCu5Ylw+jrf0z4w6uXSS5
 9qZdRi0pLR/lhPa1Yk3S8sMkLdQriqfh0BBA5j00znxNGGWkZdVDYqchznHx6Ad4X57zKwQsslG
 FGfNydE3C0Uo6c9lST30HAhCKzj/3I/44jjJIdu0JSJHBd4sOfZhA5sX+qdY9owvE0QapJd27YZ
 rYxXoF88CETrk9AT3I7y68ikgXTLrMYlfEwbz3KKwsWTt0bwtM28VHjNjKlx6rGC+Z5TRddNTnu
 2f3D5NnXUR+W89Pz63lgHX+F5+B3771Q78+CAaDizvcwh+EyJzN/bCH3Ff2UF4anToW9Rb+aPLV
 i4XDH0kONn3Q0tl6Mtg4y3t4URmQGrX+9raqS00052WmoXD6KeRIakwiyrY9zIPoDDOK4kriL1u
 kSlr6JYTjjkS1y52LPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX4z3xZ8pbr90T
 y/p1AgFWJDYfMqAwy7xetdEpBV2Lt8Uo+SdH74l8r5Zh0AsbiHsIIUAF2PAsi6UNKDC4ArEGnHT
 PYqCs68diR3iSkAt1AoMamUp7N9FoiY=
X-Proofpoint-GUID: 99F3z-VLQbStCFQqbe6C_D_EfFVOxghv
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6aa173bd cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ee_2aqc6AAAA:8 a=Vto0WN7G90g_gJJAuHcA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-ORIG-GUID: 99F3z-VLQbStCFQqbe6C_D_EfFVOxghv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090167

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

