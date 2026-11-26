Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719644;
	b=3QVKkd+sQLa1jhiCcHdfs8ppxzy6jjaDes0gYsqUbbIVMOZ69l+boQHyESXXqXL6Xb91
	 EZ8S0nYzqtUGM8AUBKLwo0gq2T4Svv0vZgKzPzCEpNutnxEv0mtoB33DkYNAVwt6a2Qac
	 C5EGBafpTwqL69nsd5O0z40fbl0n3bWpTYHKFlP1dvnKudpqbiiQSVBJVFhCjzjTSA8af
	 iP9lw17qY0Jhg3VSC59sG2g62a8OvR4csbEwqFO8eZLhHBt2K7c9gBIsO5XagQKzFu0x0
	 b90OvT7HMOSAboPESOOiaDoppkeknhgQahl6tqQZuWyyUb8UKNlZ1o5+DG9Oe7ou+7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719644;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hpP9kl81pgIToPRpqYOmQ0/Zx1IHvYVCKMq50UKWD8Q=;
	b=NUabefjJbVfzWdtXiahHqN4sc3DEowvL5g+32z3KFYMR4x87R8rLLL+EOIPKWDj9CLuM
	 +A6Hc1WeQkK7wG+FkdqAzpXZSXOY4Djv0onX+qfYh5bMfBMBuzstbXQF5GJROi7eQgQ/i
	 kcY8XpD0c/1OtDBOlehfxyS7inmKarIG6O+law/ytmu0dsJhyq5Sw78Jhh8KgzqFSuo5u
	 h0djxakOWGZK1BJUNT9Hz9kv8LIv2AF7JYp1c8HEGkfFrSUVzOswIMYTU+/BiqW4t7aUt
	 WU1LnXwADC/P55+oCX7dF2wLtBWQhYQvenoyCWTlYzne3KAypY3r+DoU1Be00USVBqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UVYxaEhj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="D8xINs/q";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E687606A321
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E687606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UVYxaEhj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D8xINs/q
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQFu6Ae1847840
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hpP9kl81pgIToPRpqYOmQ0/Zx1IHvYVCKMq50UKWD8Q=; b=UVYxaEhjntMYa9O0
	dH006SO0nd85FBY0g3QAWB7wSuD7kROeU3PkIETwmNqfVuZZm+mEBbMiyWyFFQtQ
	xEuHFc959NE2Q5oceIxH6kQK0MekS2jwr99qDoct/sZR2gDhZ+CQt+xFVtldiCCJ
	LpH9JbPRHxZpCNt3h1ukrvwFvYMUt+HgZJ6Tm8/kl3w/NYNg+3Ot2lg537Q3nPco
	P/hXTPKPJVtGPC/bBdhLkxztPQmw2iW8ajjs3y1usJBKWEAQPlDUlw4bPv4vaTpJ
	/b2n2OXNJzlwEJ0s1+t98ihe9uOq74D5Ibk3dGz1LmyG/OaTjtQhVeg1sJVraM/v
	0t9DGg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6fw7tgqf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:25 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b25d977b91so7776477c88.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 11:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795719624; x=1796324424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hpP9kl81pgIToPRpqYOmQ0/Zx1IHvYVCKMq50UKWD8Q=;
        b=D8xINs/qIG98Y22RmkxSx4TNbFzEoBrTvpkKIhhkldoxf0j0+wTaDxBFtfWstAGLa8
         3UUrX6WQVPDjKYBHPJjHuUvLN19myHy2DgPQX7Rp/gLmVQQluUa193sc4y3Xq/fXUbGb
         rrCC4rrLYmPfyWLVr9+u3e/YHq2XYuoM88YnsIrfZ+6db/utAfVorkt9LNxaOMdFJ6C5
         bpu8BClLYlFvcbm0ciBAQd46OD1oVaTFhP50ItmMJ6AW6h7R//kkAdKJ96WwUq6bgIQB
         9k1vEznMo7tS3aufHXjn0impzX7yLViR+TFn1gFDQG0YDaj5PCn3Jx1d28y8n5IGU9HV
         x18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795719624; x=1796324424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpP9kl81pgIToPRpqYOmQ0/Zx1IHvYVCKMq50UKWD8Q=;
        b=CHGBuUSy6CLFGBK93O8Nn1bb2LY8D1L5+R/IAD+dY0oS371+dm2B0M2vFV9EsjDAGQ
         n6c5fNSmWZsUuEcFkI3IAFW5cc3lYSAtMKrmrL7baonh03Il/oc5GJV41fOhE3hZqIrg
         11465NkMGoVgbQwu8X9Fwfc5U7u6JjiXaqvdmWa5yRiPO9SwjpBv+ej4aFLi8HJQT4js
         71oYHkO6O6j92pbp5daY6X53Hvk0Gw4jruydmYmXEWo07cm6JQIm6lf8Mb9dW40TinVA
         IhiMV/1w71LMK9Iw/ojMDIVfXN0lAhXbcFwQ0iZXqJIR/RNFv69Q7ILekfqDDsJPMT4Z
         Sn8w==
X-Forwarded-Encrypted: i=1; AL+hErHsHdcAvgY1SXekYN93QkGHshNAdyZSCZprIutM+FcKHiyto9dW3V/Iwl5dn6VrcvSJ1aBZTxwR06I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OoEqfaTy60dMN+xnH6HvTHKPrV+6j3GYJrAaaa95kpUzNc7PD
	DCYdMItHIgDBqKfVgTpUE4i8ovuaahkUyYECbPOfbMj10ciXl8QA1bgV7jE3tbQbCaqB93NGeyb
	M1iTA3hWQ6iwqFrKUixhLd35XKsZ52Hhb+NQqz/Ub8zRGDS8APAITfJz6A0FbEJ4=
X-Gm-Gg: AZFdTZfNFBMjnRlXATpCriMU4EVZ8c4IVeO0MvqNZsK1q1frm+kK/wxn8BiJ5xEATLS
	dD+5cfXYLQp2p9zqI4khW84He/+BmfwbZBT+yZm6XCA3bu62zxfdSZPfYPoBXm1HK5quhFHRUzq
	bgsPLCNWcbqzP/SCIUcKjWgOh0qynHlxMWZzdxMHWVIwq6ZCfatbJ31HO3ka0qBTezAi/D1ydML
	9reHP1QLxTQIxpvT4n56qmsy0KaMT0MQRlOabllEspsgiM8H3u4OkSxuZx6/HSECz5C1MLdT4xf
	26TV4y2XS02+XPWYOzXAwh2U8OPq7K2RY2JDibuSpcAYTq78RKSmifVEMSFa00bQbhXXZ6Rpm03
	mAtEyAoFHpKo/pCw6eG8DuYuKvUchO6/VAQiGPJ798LSxJ6D8XAzQJzPwvsMU5yAauMZlr/YwQn
	nSf30S
X-Received: by 2002:a05:7022:e0b:b0:1a3:8d5f:6f93 with SMTP id a92af1059eb24-1b556882ac7mr32753272c88.17.1795719623807;
        Thu, 26 Nov 2026 11:00:23 -0800 (PST)
X-Received: by 2002:a05:7022:e0b:b0:1a3:8d5f:6f93 with SMTP id a92af1059eb24-1b556882ac7mr32753196c88.17.1795719623073;
        Thu, 26 Nov 2026 11:00:23 -0800 (PST)
Received: from hu-jkona-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm60868190c88.7.2026.11.26.11.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 11:00:22 -0800 (PST)
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:27:14 +0530
Subject: [PATCH 6/8] phy: qcom: combo: Keep the PHY GDSC ON during host bus
 suspend
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
Message-Id: <20261127-usb-pcie-gdsc-suspend-v1-6-485a08ffdc6f@oss.qualcomm.com>
References: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
In-Reply-To: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Prashanth K <prashanth.k@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX7MP47bK+LwLb
 HuwOcfessy5V+6rpF8BuX0pseME0XVgqD13Wc5Xum1oyzROSBP0hOJYkb5jspldHV7dsld4CR78
 OOkQFZOrYWEchaeX8VZ1wZ1GNeuI4yw=
X-Proofpoint-GUID: M5lyQScIQhRnRnvg0-UpCV4FwtWjlnD_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX/hWN0z/mkb/p
 0HqDN+QieYO4zUtVfVclM0K08+t/Dih6pOP9GtjkeKw69XARZmS24IbKNyyb/Uzx6Ju2DKmMlk8
 vmuyQ18aIHG7H1QT32T5W0bPKJjpnePIIepphqRrU3puVPgU9pRaCrX84BHnWTYO9fqnTJPbiGv
 o7rudTCAjPtgPokAyYiYso+KSpVTKNFuoN96rV/rIHclrUNCkWmqyUS5lzO+bmBGNwQovFEkAE5
 5v5i54u0dINcFzpXn1JSeFvgOy57gFCx3PrBSsdcHrWEBFKenjO/31nSTpfhFq1cOAg+FGv6d3J
 XXIy+r86ALr0zIop1NLhPI3qBfnraKV+dVQZXKCIGbOqhUkepkw11w7TzQEdsOjKtrcr7HcC7QZ
 6I12mcB/O4UWcWyYD64PGgqU683qcAqpuMmS16RFEUTIjY4ntAPldv6JPITio9G63sdw/DK9A1h
 aBhh0Zd0Pg8WtUOmsFA==
X-Proofpoint-ORIG-GUID: M5lyQScIQhRnRnvg0-UpCV4FwtWjlnD_
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6b0881c9 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=bOxi8P5hmqam2w8o8_wA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260074

From: Prashanth K <prashanth.k@oss.qualcomm.com>

Keep the PHY GDSC ON while the PHY is runtime suspended in host mode,
so that PHY can resume without losing PHY state.  Allow it to turn off
when init_count is zero, or when set_hwmode_dev() isn't supported.
This allows PHY to consume lesser power when nothing is connected.

Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index bb921ee643dec46265015b9d11d1f669834fc2d4..d8b7cfd9644d49780d706a14bee9e7f314cbdb19 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -16,6 +16,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -2592,6 +2593,9 @@ struct qmp_phy_cfg {
 	unsigned int pcs_usb_offset;
 
 	bool invert_cc_polarity;
+
+	/* true, if GDSC must stay enabled while this PHY is in use across suspend */
+	bool toggle_gdsc;
 };
 
 struct qmp_combo {
@@ -3432,6 +3436,7 @@ static const struct qmp_phy_cfg glymur_usb3dpphy_cfg = {
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_refgen,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_refgen),
+	.toggle_gdsc		= true,
 };
 
 static const struct qmp_phy_cfg nord_usb3dpphy_cfg = {
@@ -4723,16 +4728,25 @@ static void qmp_combo_disable_autonomous_mode(struct qmp_combo *qmp)
 static int __maybe_unused qmp_combo_runtime_suspend(struct device *dev)
 {
 	struct qmp_combo *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
 	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->phy_mode);
 
 	guard(mutex)(&qmp->phy_mutex);
+	dev_pm_genpd_set_hwmode(dev, false);
 
 	if (!qmp->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}
 
+	/*
+	 * Keep the PHY GDSC ON during suspend, so that phy can resume
+	 * without losing its state after host mode bus suspend.
+	 */
+	if (cfg->toggle_gdsc)
+		dev_pm_genpd_set_hwmode(dev, true);
+
 	qmp_combo_enable_autonomous_mode(qmp);
 
 	clk_disable_unprepare(qmp->pipe_clk);

-- 
2.56.0

