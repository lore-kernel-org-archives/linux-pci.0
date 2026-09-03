Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8D1DDC1B
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422036; cv=none; b=mCwAWisIc4b1+kDYCZq8KXcKOgYkqfGUFbLDzkRnlBD0Eb8csXqeYPJ/X8JODtgmjTE46c8LsJWxxeSly/veQgoHSCPVMSAHuuJ1jl4F+VOqU0ZfZ6+tqM01SjjLcNnPmPQPtV7VK47g3RtFb1PgcSI9sQYnPDgs4LmbZ8sNP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422036; c=relaxed/simple;
	bh=CHcwrnk7BqNNtDAcRCTciVoNcRDgyYk3W4FG/5/vVF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kRoq/I33WjEydC+/xR6Hp67eXUa/ydDyWSaedScx2mK3h2gmhKu8jBb9bytV6+SgQNEpM9otZQzN+DzfK+OHrQmTgjeifvdptgL+iA6LRVFLZe6VErdUk6O7a5ToLPgSnMFrCrIGacsCTw7HP/gqhux7iVr71p1X/S8JdpU9YsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ed9KUjRJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gUnbqgmF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ed9KUjRJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gUnbqgmF"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835lZA73749594
	for <linux-pci@vger.kernel.org>; Thu, 3 Sep 2026 07:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yI6GCRP4sRLJedMdgEEQEAys0x4qhVAXlCoFVWRK8fk=; b=ed9KUjRJmn0LJIOb
	ycJoU6XH+g3MlLkvgflGzxIg8yq1B29psQNPHhoOlvqCLfAjMFE1TNaFc+GwnJFB
	4fYHJUSn+6n4H1VZWSDStJW2/SeseG4BTK2sWnX2mXHsusBPUHYOZYl7G1ax2kEB
	wJUf9HDJZawe3F3KqLz8U5hdoaFTmP9Dv19H72hdY0+QZFNK7kgPui78fdi+2Q31
	LpslEAL2PFL4XnFA7ErTWpxm1rcUAGP7g6sJjmrjTqNSw3pDFojzuw+iX0p1H+1w
	rjcBqcMK1IBauUVUp/jhmblrv2Me019BsJeFjMVKaJpTfyDColm+yqQUZs5HjSua
	B7Ei6w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gepv5uhkb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 07:53:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93975d63ffcso33507685a.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 00:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788422033; x=1789026833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yI6GCRP4sRLJedMdgEEQEAys0x4qhVAXlCoFVWRK8fk=;
        b=gUnbqgmFoj0CjwtmWO8PTZCTr5bjz/6J6moORr+pOfCYAfMMpVsyS2ed2H46q7QFGh
         KypGAHYCaeMVSSwaFirJHf/TKaEUJBT1O8ObEy2USpHKfEb0E4K1l1bDncVJ3t0MEdcS
         CQHCF7x3FD0bVPgTN+m8zTqZD1T97dHUVEWZI25ZhDpO+vcOVsALed2d+TrsXPKvg4xa
         8v3d6nkNpgcDSdsW6tcEIEz6p9MEYs+4xENEP4Dv0ywXoWQ6+yzAWhE4c2OdbYVUryeq
         /9gU/TK/NR+E/JgI5lJ3cj1JJjPdwuNQYi+38727O0KLUfZF+XIqjq1r11oVJe3xnGg+
         e/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422033; x=1789026833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yI6GCRP4sRLJedMdgEEQEAys0x4qhVAXlCoFVWRK8fk=;
        b=n9HRRQI/cEXF2WOC+l0UO00826wdMoJXekakD7gSAhbbDNzP4eH9QL9PBXeVb/FbxR
         p0167i4sLPdd2mg32fFmRe3ekcpnYItQ7H8h1BlfINeyUyn5655aHz/p92Z4wRM3SRnF
         pjfrwjia1PEESC6TU6faT+U293WSB78e9ZOAd3wVZph40j+/ThS9zidc78M6WwUP2v8u
         DPBnHUJ0Qcj30lBwthWQesvQFGDQ4qKn9LO4N0KGuWYpHF+L1IMCMdZt0nwnORC2B893
         OSp8DaoI7xbbDchGUW5H0lINyzzI3LOmfLQly3otKrWAgms2VLj4U01y4mKYlkU/jJgF
         2JQQ==
X-Forwarded-Encrypted: i=1; AKwUvBws7ujFhIKbNBSCsYQRxcmX2inG9sc0HgpVntOAJLnwuEmXyfc5S5LIze3BjOftG6W+4xYyZ2fK8SY=@vger.kernel.org
X-Gm-Message-State: AFuF++n7B7UFkk5Eik2efgXy5LbROEdVlq4OfERJ88WWVr2mJPpbMJph
	ABTiJAIjq1VzN6xNtYciZuGaL01wd5fG6JoHjK+OWd8UgF/dFf9JeXv4QL14gzZavxKi5Xci/Ig
	oSBRbUXhQWYmGmnLyjOPPGgwbgeuFwU5DIfifsD895nPHj4lS2Soe9xVV4IxlRR0=
X-Gm-Gg: AYBFou3YwP8sPTGWHnzAJSF2LaLX/wSnqtjDG19n4EBO031XAIIV2omEQE1S9Eb/Nzg
	KdWRfAd0H5LtWW9mVut8pZhVclOao/NgUS338XUBosC40b4ySq8qDTlbYeD2VUer/vI/i0siqvN
	SEn4pXCDATWmFY6DgvHfjLPcs+FssOcWaft4yYTvWKq5yq4W5KIi0VttRGUjF3tOlQIRzjFNWsl
	MkLwl928hoWa+pYck8j642qXrRI0ftMFH04Ptvf3sHBDv/Q6xB+UCLM6kGt1MtFEFG1B3dB06rg
	d8+th85Q5Kw8nxr2XnfbSKePu8zwPeq8LpNB/AdwlVB9qQ0Qf6Kih3cmwHPzQ1JsH8DLERlRK08
	/pKNrmt13kg6KGg==
X-Received: by 2002:a05:620a:2590:b0:939:6df9:6546 with SMTP id af79cd13be357-9396df96ee3mr521401185a.50.1788422028102;
        Thu, 03 Sep 2026 00:53:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2590:b0:939:6df9:6546 with SMTP id af79cd13be357-9396df96ee3mr521373685a.50.1788422022926;
        Thu, 03 Sep 2026 00:53:42 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72df2sm12697054f8f.1.2026.09.03.00.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:53:42 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 09:53:00 +0200
Subject: [PATCH v2 4/5] PCI/pwrctrl: tc9563: switch per-port reset to GPIO
 descriptor API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-pci-tc9563-aux-v2-4-34c625b542c1@oss.qualcomm.com>
References: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
In-Reply-To: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=T8y8ifKQ c=1 sm=1 tr=0 ts=6a992791 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=viGhCAv9QodxNsH3n2EA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: qJUzOIvH3t-51jwGhm7kgy_D5UoxBK8r
X-Proofpoint-ORIG-GUID: qJUzOIvH3t-51jwGhm7kgy_D5UoxBK8r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfX0wbtu1hMH9gB
 tpows3dT3CODAL3MsetO5Axp0Cc5RMxsvb1HgV2siDw8VfsgYg6Et4r75LGK5XhsA7oCr4jRoT0
 lwBCVkljoYYNzO6ILlLe/G6j71Pm6wLej9gMuDRdO/vBe5x78+EIGObaSCMcLfLurssvMl4NSNa
 5FWj28SiajYsrwQxnEWpm0sHckPnHZKXr3n1nzJhbB+IgIsz98QbsJ888U3iBYFj5AGbUDe4O9+
 DTPOQERdXArRWIw/QJVI8GIrbELnKbweRLhFgNJhTg3K30G5gm0WITGTRAlghxFeSMlYZPrEXcm
 LRBbVF14oPa3E5acrA97HMSe0ieMdF9KCggU+Bss8xZu0s5/3lox8sHrlIgd+CbmNC7UDu0JxRF
 Synn94mKW0561URfASldwgPkLO1s+KWnPibFmdpoHPaSBKnfvoPnQX0sfGwyVcA4bkIi6jsUSaW
 +e3Fq43zSs1frPTqepQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfX6Bz6/w4p59fb
 LdTpORfPBK+dXkKWw5H4WqZhtho1DksLkXus3OXGhY4w4ceNpSmPi43/TAgzFwqZa1gx+qpFwIt
 tMdinFoOG7AMdR+6yIo4LalmUPYCBM8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030069

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
index 6df512d78b54..09ab4718db8a 100644
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
@@ -480,6 +537,10 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
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

