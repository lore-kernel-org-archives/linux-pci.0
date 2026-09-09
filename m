Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E438856E059
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965822; cv=none; b=FR7LvCPzf0TGEWASJQn+hfyPwG17L+eUDe/GGWMeURbdvhSC/yxHbBp0EBlM6iZs1/BXWnPjUUxoJXhFjK3lyCusGJ53QyVsqSaV+fbNGDjkrbT01DxrkaAmxE5O6uUzqJPP2MC39B6IM/h16cuKyVVGhXY60jNNny+FGHMWQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965822; c=relaxed/simple;
	bh=4+wWYRihNb+YzSTuxUwaI+YyiQAKimBV6A6X2ehKKqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USm251Xs+ff6fweIHwkRT4LI4fErd0sHd672gtNwdS6fnNrivzpdSTWU1hdguK4c6DjZH6kf3zLE/5r163DbtjMs286UcFHKkiW+Qw2k69365Q5kJkLpQfx+f0RWmwiYzFZnMNRtFUhoCnyRveH5QvZwRHEUxoNgGvm8lN3mZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aUDtA2K6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=acT3d2rr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aUDtA2K6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="acT3d2rr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689DIYXi2081128
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 14:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3KhxPlRqUMRagUmeRkRUzkyJQ3R0AyB2krXH1rMDJss=; b=aUDtA2K6fq/boux4
	AWwMJy4HNiSgUk6DQySxu59at9VQNCT9Z3FDLTJNhxu37l4dJP8ISe6R5zMgXpGo
	By/uwF6A4W7hH5zAt1pUqAveDSy1AYz45RfCsyIOQb62ahd6gsJ03sd5oA2PkSVp
	+l0MqPJkms3PdRZYlEpunTX4i9Ii4NMfx20XPhRYRMQDxg4+W78fgNeu0iOgQzb9
	6fJFVU3mQoRfi3zPbKw1sQ3PrgNsdIZ5/k1rl8HRG331MBa3Ae/ftAtbprdfWedC
	O4CRrk/Nn2KqpmJW0UT88hIwkH8yS2pv/BWb9HeNbXT9XTf1OlevdempYXdKjdDs
	36oe2Q==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk87r0frv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 14:57:00 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97cb32961e3so3419171241.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965819; x=1789570619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3KhxPlRqUMRagUmeRkRUzkyJQ3R0AyB2krXH1rMDJss=;
        b=acT3d2rr+fZAQLmrVSifUp+lDOQdpQD20SU8G8zuBaid66YPorHAnx+fdUxsVcXm5q
         3vTiuexF/wkhJOBwtxJz8F2R9lIzXzP9VfsFpZZbe8m3/kO6WquoJ//7bnkulLYkDWKq
         qnZCf0irPiKk04ZXhnVr8t8mDP8efsUBVhP1dc5cQMBz4QcEGtfEFkR8H8NFBL4N+9yf
         BN9BsSoiD02zvGvzgK7zzw7wdmTR6eJTzcgqT4EzOGS03meWi24z3JSqfn5PO1XT8nHE
         PnNQqxaptHz2Vh9+les0WHAq2CHShSSnEfydCcwMnl0TYsiFEEChjUFSHhtIRrusf0D/
         2Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965819; x=1789570619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3KhxPlRqUMRagUmeRkRUzkyJQ3R0AyB2krXH1rMDJss=;
        b=Y+9ZQ2Y2H7dQda3eUhTLVeQjTso/aFBukGY5hlZGXMECKx85el3dgb0ZE5EeYFls61
         fEXxcUXhLsLhpI8bPbmOjdn0U0jf9NwOAfAYoV+ea88jEw0K9RrD2KzvvN1pW2ty3gzS
         TUI16x8wuHjlKnL9JSyxjFpEjvTPBOkZohs+LUbzl8hnYgHDjBJxUu0m4L2jw34Hrodk
         iwAoXC+2TIx3dRe2jZFNnB808B88+siwyGsEvP/Mhq2fvkfDqTyA5/+H1AoZ/GcOStL2
         N4Y5uid7JMiUhaTNjclv+LqXJ1mLtQO266RUmaBaQrk+uiH91DZBAYJK1CCmglKtuHFU
         PGFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYlO8F20AjnbIXMw4H2hF0CdBfA7VqOSub81MPVbip875hugV+STG2FdthXdkCp+HP8t0vR+tec9M=@vger.kernel.org
X-Gm-Message-State: AFuF++lowKqHv9DboylPBPm7zvHZh9rUuN/BkokmSDr/5ju8jth1wZFN
	yEOFcts9lGxRgkCyj9fNDHzEoiPC+ki+dWWi1Jl++5LliZjTJGhTs2+FX5Z5W4YK4sD5lN0UN5X
	zNIENtFK/HyGqJtMQy57/2B4Xyz7g+u6kR+3w/Bg1cjaf+dbDP7agO1cCguLfJKU=
X-Gm-Gg: AYBFou3WMXnHxI5UljDuBiTou80mQcWuEo8vC0X8BbkMNwxBTn2NM0HXZrz8AqnD7L2
	Ng3ug/2075UlO/vv8p31Nn4ZJwP6kgFTXJ4ohAGjVCBp1UVdR/xeXRAsudV1SP4wLOXWa6qEG3c
	Rso8G6563uL/zJDYabBzNWLAjLl85eWN+TG4bLcX/jtG+4nF+j4mdmlhelfdbJ4SjaSprBHK9B4
	0gXaghF7tlC+39xu4AWvOKjcpnxEpcKNA5/G+9mVEKrApW9tyCvXdI109XPR2Qixk5hApPsVqHN
	wxcE0Hf43ooeIjpdbio1CMB81qvj+/PZ2BezeI4WvmPjRubXI0o7FDL2N8nMnKyN5bdcbGT2sFW
	F9BQkMRQnHO1+bw==
X-Received: by 2002:a05:6102:6b03:b0:77b:ae7:1bba with SMTP id ada2fe7eead31-78a4a72eac3mr18480295137.3.1788965818977;
        Wed, 09 Sep 2026 07:56:58 -0700 (PDT)
X-Received: by 2002:a05:6102:6b03:b0:77b:ae7:1bba with SMTP id ada2fe7eead31-78a4a72eac3mr18480262137.3.1788965818465;
        Wed, 09 Sep 2026 07:56:58 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm46529037f8f.4.2026.09.09.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:56:57 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 16:55:55 +0200
Subject: [PATCH v5 3/5] PCI/pwrctrl: tc9563: Add GPIO auxiliary device
 support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pci-tc9563-aux-v5-3-c9b33f56c8d3@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=AImJJIpd c=1 sm=1 tr=0 ts=6aa173bc cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=ee_2aqc6AAAA:8 a=E60cMIZf90sG3wRpYpsA:9
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX0tYczaCpdoGT
 CjiXWDfhB94R6sTPERSZsn+dUDQdARUeqeVHJzzoWPkMnAbwIibNxLKIzqRgaUdUdmy6vzPXjvo
 WJs+FCwNQ/h4zU1y8aCsLSFwgOL+wZV/n88Yl0RxzsTSnSo9UBmNy7sQ4NYc3BFZYE/aqqifbRe
 vCIFiqXUSYfZ0QMCBau4WfLOZx2ZpR2iq0y0oVvTgEc1B2ZM7raAJNhMkZXYelJufOi3nCqFB0T
 lMtGmqrEQLJPqn5I96rm1TQgY/TdH0IKJjnpR7NxvJDCBHScjQbw3cjre5EvMMooglWPxAQit1c
 CBBYuotHnGV9rvWKcbpooOM85yHB6zqmnsrFW8nDmFTaf1u5CvAU13mg39wJqucJyvxlI5kSXU2
 oV8VOYwhefb214CKHNjnSh4Z0tcxN4p2RRqNQWOpp5NL651DMdzsaZj1UWWW9/j3nLFA7OeyaNT
 jZtjPVB0EuC8ivAux9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX64eI6lsvW+CK
 FlxE2Nh8p7899FPbyp6bC783RoOrKDAoFECFUtKxLI8Mvl+34EDcG0h5K/hgxVAlIYR4PS7ohDs
 4lBgLRF+QUbfRySvekPsKy1j9w5jW1g=
X-Proofpoint-ORIG-GUID: 8MEG1Xg8H8yoqdPZTJasUcv1a4YEnHbB
X-Proofpoint-GUID: 8MEG1Xg8H8yoqdPZTJasUcv1a4YEnHbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090167

The TC9563 embeds a GPIO controller used for per-port reset signals.
Create an auxiliary device for it so the gpio-tc9563 driver can
register the GPIO chip and enable DT-based GPIO lookups. Pass the
tc9563 regmap to the auxiliary device as its platform data.

The pwrctrl driver does not wait for the GPIO chip to be probed. The
per-port reset GPIO lookup, returning -EPROBE_DEFER until the chip is
registered, is added in the next patch.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/Kconfig              |  1 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 80 ++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 1952ab4f29b6..38aab596aa04 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -29,6 +29,7 @@ config PCI_PWRCTRL_TC9563
 	select PCI_PWRCTRL
 	default m if ARCH_QCOM
 	depends on I2C
+	depends on GPIO_TC9563
 	select REGMAP_I2C
 	help
 	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 59ad219c26c0..3fb862105fa5 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -4,12 +4,14 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
+#include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -18,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/soc/qcom/tc9563.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -151,6 +154,8 @@ static const struct reg_sequence dsp2_pwroff_seq[] = {
 	{TC9563_PORT_ACCESS_ENABLE, 0x8},
 };
 
+static DEFINE_IDA(tc9563_pwrctrl_ida);
+
 static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl *tc9563,
 				       enum tc9563_pwrctrl_ports port)
 {
@@ -393,6 +398,77 @@ static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
 	return 0;
 }
 
+static void tc9563_pwrctrl_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	ida_free(&tc9563_pwrctrl_ida, adev->id);
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
+				   struct device_node *of_node,
+				   void *priv_data)
+{
+	struct auxiliary_device *adev;
+	int id, ret;
+
+	adev = kzalloc_obj(*adev);
+	if (!adev)
+		return -ENOMEM;
+
+	id = ida_alloc(&tc9563_pwrctrl_ida, GFP_KERNEL);
+	if (id < 0) {
+		kfree(adev);
+		return id;
+	}
+
+	adev->id = id;
+	adev->name = name;
+	adev->dev.parent = dev;
+	adev->dev.platform_data = priv_data;
+	adev->dev.release = tc9563_pwrctrl_adev_release;
+	adev->dev.of_node = of_node_get(of_node);
+	dev_set_of_node_reused(&adev->dev);
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		ida_free(&tc9563_pwrctrl_ida, id);
+		of_node_put(adev->dev.of_node);
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
+
+	if (!of_property_read_bool(dev->of_node, "gpio-controller") ||
+	    !of_property_present(dev->of_node, "#gpio-cells"))
+		return 0;
+
+	return tc9563_pwrctrl_adev_add(dev, TC9563_GPIO_DEV_NAME, dev->of_node,
+				       tc9563->regmap);
+}
+
 static int tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 {
 	struct tc9563_pwrctrl *tc9563 = container_of(pwrctrl,
@@ -596,6 +672,10 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
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

