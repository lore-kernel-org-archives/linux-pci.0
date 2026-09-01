Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA10447A89E
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258540; cv=none; b=LKb5bJ2zido4sJ7RvTcZsIniSGmDw2PNRwuqcjoJMAm/aN887yJCEg/CSLoJLfZ7mhCfgCxcJbBpRLLB2auUqJuc5v+NQBXorY44/BWAUegItMKBpcjjKeB6JrbJ3ybxp5lhKiJUwdO8Nx0XdMTPhMolFcrtRXMReRq4Tyzyk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258540; c=relaxed/simple;
	bh=dPSsgYpE44DjWYiRgf2uTKTF5w6V5cl0L3RhLkcTrio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEpxdIbTsYFJxenKcOB2onKNQhGP23bxwA3VK5eCrPJ5GqbSk8E2CDXR4BILsK6OYo6EEEgE+vwzYTJKM4lqjNBPpC1JhZJOqiCf5Q55k3nrOfMRBdLfy7TC9fXvpZCO6vYFZNARlDFoGSkHw5SPaYhuBr0CZeOtXnnwV03VD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k/vYkALv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hrMBiS+X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k/vYkALv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hrMBiS+X"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJifp2752207
	for <linux-pci@vger.kernel.org>; Tue, 1 Sep 2026 10:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LFwvOqZL4w8bxrrXh1tBzXKb5r9ExtSKU0KswpasHnA=; b=k/vYkALvD2lh/UfB
	d/3CApuBh9+Rj/4SMorv1GB/d8YS1Xn8vC/4EHKGOc6EIF85ZGOQk2ht9XXpnXFl
	kS1fsxk9q67oh9NFfLSb/ahOJcFQhp8xJd87pVLQN2MuxmoqyhDvin6vx2bLMyT0
	mcimXgADlX0Klb3aiBNoj7hQYTxpwNAH1LO5ig6lBpihGSDUp5pqQck8xkXWYgL/
	+YCA/8izz7jE/9aTLmqZav0+Mg5XVge8cTzw0D54s5CTWEQ/x6wDdrtfh6LgVdg4
	aX4zFXboF0TLS+lztrMKrAtdIL/mexTpeHe/pZqm7A7k2aGhCMVhEfmvz4eT3P28
	/BQL5A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdfchbeyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 10:28:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930edb4362dso638469685a.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 03:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788258523; x=1788863323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LFwvOqZL4w8bxrrXh1tBzXKb5r9ExtSKU0KswpasHnA=;
        b=hrMBiS+Xd72wf9VN9oLmL+lSrWde8yvMHKYSA2bkOFs+soao2FuicGkworwhUw9HZt
         kugaLA7t+dSoothqwVbiECfYrJ0C87/NHNwxIaoEKYEdM+j/yhwlZCQsYlqePnPhKx9x
         UY/Zi5JEbTkZ77li//o8UEuLlNIruqslLH1+ucbV6XFr9gBPWW506l0t8WcdLA6tCp31
         kkgiFPrK7f+WJoW6k+KijLIMauDSuX1/JxacDUPHj1ZWms/ukY/n3e2yAdRv2VRjQOMd
         eptlnvfT+ZcMNBli+bn3Qck1JKETfkLS1cCHlkukXOvz79UmsfI+ubvySMu5dM6ugLr2
         gcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258523; x=1788863323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LFwvOqZL4w8bxrrXh1tBzXKb5r9ExtSKU0KswpasHnA=;
        b=V61rlpYwWKL6Y73/teUug9pnGIpvn4/LxywBMbQGZAvUCbfZlho1rDiqZQmJHwjNHA
         cyWOp1LaFRmIX7482rH26dn8uQEaNklgy0ufll4Xe3NONjeusakaQb/CIfBMX6TBDPed
         LV3LLwSijjPhbEO+ZtQsW2g/2G7ysdz8Lh2iZJaN/HmC7hmRZBaz0jKh4iBoJLdrTfuG
         IY4gmz2AS5hxlv8AF0Kry5MFpZU4bOEohpRQVYtgDHyPjgriW0BoU/LV9MSr4R60CV0D
         d8FXQzt04+5KuR6zpzU+hiDuP+4Vpr89x3KJlTfOfsSVn6hIgiZhUUfMCuThBg4Oi92P
         YnZQ==
X-Gm-Message-State: AFuF++njOvs6ZH3Jp/mXJ/gNfazLlIUHMTc5MeHGkkVyissg43ldTGfQ
	4/k5bIoYDsNdLE+eFM3nyInDpKRYGVWpQOBOohE+ZCTITGrJJJ9nZvNePME8rSBDTXA8Y2NIo0y
	I6EBDJqbyBFoJg1FTqFQz0Rg6d7o6RPG6J6kitSfcXrTRRRw4wmaeDvB27jwn3RY=
X-Gm-Gg: AR+sD105GjDwm/7f+7pO+hXc6TWqO+m8WLpg/M0I5MeUDolBNYpHY8XXlQ4ox1ymPDK
	TgYFzDmjgTn58pG+eH+0ab2Mu7RlT4cJveMuCBsMDYTOYOXJUGZC1i4CYTQ5rk0w5AjtnJahCe3
	9R8Qiu6OnnWmgZCBBrnbOYV0MVm5lmBRfoifQPSC3b3VNTPvxDxIOrVvw7Zg6X3hLeL4uk5zEzM
	0gvOvHCVGGp5OrjFcS4OOs/NNV2G8G3/l0hTvJIBOhR43Eit1g1FiV9CS2ZdKguobN9J4yL7bEZ
	y/OnvQtIjq5TD3xi/QtMpLWT/CFVZnmU0U7u3OH0ba3MFnO6Vds/NqSrQDPjsECjgnDNmqQ3yap
	ABf8emmeUVm5w7A==
X-Received: by 2002:a05:620a:8086:b0:939:16f6:4d01 with SMTP id af79cd13be357-93916f64e85mr3542935285a.21.1788258523024;
        Tue, 01 Sep 2026 03:28:43 -0700 (PDT)
X-Received: by 2002:a05:620a:8086:b0:939:16f6:4d01 with SMTP id af79cd13be357-93916f64e85mr3542922985a.21.1788258521727;
        Tue, 01 Sep 2026 03:28:41 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce11b00sm56362005e9.8.2026.09.01.03.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:28:40 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 01 Sep 2026 12:27:55 +0200
Subject: [PATCH 3/5] PCI/pwrctrl: tc9563: add GPIO auxiliary device support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pci-tc9563-aux-v1-3-dd9b80738e70@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Ldv3FeyU2DYvDZJRxSNJKzymEPzhT8tV
X-Authority-Analysis: v=2.4 cv=G9Ms1dk5 c=1 sm=1 tr=0 ts=6a96a8e8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=PJtxGifwbofezjXE9ZwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Ldv3FeyU2DYvDZJRxSNJKzymEPzhT8tV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5MSBTYWx0ZWRfX6ybgIMR55PHo
 jXmwmBRpD1sSj92OlHjvOoYEf5gI1o9f5yVZYHpLibAEMajdEOCjX4TVxKVXAcOGDC7aggfC0sQ
 eSB9ITcmE/8llN/aRdhfU1wo3+iDEYI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5MSBTYWx0ZWRfX+1Q7aCrO/M4H
 8N/2AURL5GU6EVYATjzUPNRpRb4JQIfP9Ototv5bEGibLXLOszQYctw3EzWKEKBaQ2X/IJ5MwGn
 dBv9+X+04hYNo3ACBnI6cbOD3B9nVDnq8pmKauZg5YaIameN27DTlR4HDQZkJ6P6WEB75/EyYrh
 I+jC7IGV1PkQDDj/NLq95nodCjAn/5sbtPpk9lRTKezFRtOLiziorovzKf+e/WLKKy3hJjAof9C
 Fg/gkz1ttR1wuS1cC486v4fEaRQ5wJNV9eCpdeZMrevn5bsq/wbm8sz68dyPc7+HIkExk33qd8C
 m61C8WLfQK2WQix8sAZgGYm4RHMs0+k7Y+2sebQG4D8zMXwyjm36g2GiB8nIWCRygFFAmyuQuZG
 mDv1RMzKEF6d7nWcOD3RbbldjdIxa/cXwcK44lcAfB7RvxakLOLWGyJfhJIcroQ2nlZXShaSHmv
 dQn7jHmESmB2t/vAnkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010091

The TC9563 embeds a GPIO controller used for per-port reset signals.
Create an auxiliary device for it so the gpio-tc9563 driver can
register the GPIO chip and enable DT-based GPIO lookups. Pass the
tc9563 regmap to the auxiliary device as its platform data.

The downstream port DT parsing loop gains an of_node_is_type() filter
to skip non-PCI child nodes such as the GPIO controller node.

The pwrctrl driver does not wait for the GPIO chip to be probed. The
per-port reset GPIO lookup, returning -EPROBE_DEFER until the chip is
registered, is added in the next patch.

Select AUXILIARY_BUS and GPIO_TC9563 in Kconfig.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/Kconfig              |  2 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 78 ++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 1952ab4f29b6..a07694fae0c9 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -30,6 +30,8 @@ config PCI_PWRCTRL_TC9563
 	default m if ARCH_QCOM
 	depends on I2C
 	select REGMAP_I2C
+	select AUXILIARY_BUS
+	select GPIO_TC9563
 	help
 	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
 	  switch.
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index b0d8912690a2..ee9c26b8f5cb 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -4,11 +4,13 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -20,12 +22,10 @@
 #include <linux/regulator/consumer.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/soc/qcom/tc9563.h>
 
 #include "../pci.h"
 
-#define TC9563_GPIO_CONFIG		0x801208
-#define TC9563_RESET_GPIO		0x801210
-
 #define TC9563_PORT_L0S_DELAY		0x82496c
 #define TC9563_PORT_L1_DELAY		0x824970
 
@@ -393,6 +393,71 @@ static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
 	return 0;
 }
 
+static void tc9563_pwrctrl_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	of_node_put(adev->dev.of_node);
+	kfree(adev);
+}
+
+static void tc9563_pwrctrl_adev_remove(void *data)
+{
+	struct auxiliary_device *adev = data;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int tc9563_pwrctrl_adev_add(struct device *dev, const char *name,
+				   u32 id, struct device_node *of_node,
+				   void *priv_data)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc_obj(*adev);
+	if (!adev) {
+		of_node_put(of_node);
+		return -ENOMEM;
+	}
+
+	adev->id = id;
+	adev->name = name;
+	adev->dev.parent = dev;
+	adev->dev.platform_data = priv_data;
+	adev->dev.release = tc9563_pwrctrl_adev_release;
+	adev->dev.of_node = of_node;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		of_node_put(of_node);
+		kfree(adev);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, tc9563_pwrctrl_adev_remove, adev);
+}
+
+static int tc9563_pwrctrl_add_gpio_adev(struct tc9563_pwrctrl *tc9563)
+{
+	struct device *dev = tc9563->pwrctrl.dev;
+	struct device_node *node;
+
+	node = to_of_node(gpiochip_node_get_first(dev));
+	if (!node)
+		return 0;
+
+	return tc9563_pwrctrl_adev_add(dev, TC9563_GPIO_DEV_NAME, 0, node,
+				       tc9563->regmap);
+}
+
 static int tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 {
 	struct tc9563_pwrctrl *tc9563 = container_of(pwrctrl,
@@ -565,6 +630,9 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	 */
 	port = TC9563_USP;
 	for_each_child_of_node_scoped(node, child) {
+		if (!of_node_is_type(child, "pci"))
+			continue;
+
 		if (++port >= TC9563_MAX)
 			break;
 
@@ -596,6 +664,10 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	tc9563->pwrctrl.power_on = tc9563_pwrctrl_power_on;
 	tc9563->pwrctrl.power_off = tc9563_pwrctrl_power_off;
 
+	ret = tc9563_pwrctrl_add_gpio_adev(tc9563);
+	if (ret)
+		goto remove_i2c;
+
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &tc9563->pwrctrl);
 	if (ret)
 		goto power_off;

-- 
2.55.0

