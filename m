Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825628C5B1
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422026; cv=none; b=Qscn2OeIihgF8ZbIDH0UjtzN/5OrvxkctKQ9G2+v3jzmx2JcHKsD5e5Iyur7VEZ9oT8DT+/1W3jix2Qk+NBde25LQM0KHJTsYSZcefllm3zZXU61mkeJDZZgPvDb9sJhqJRAzj39SUs7hUyoCnZZ1jRXlCVj+m2CNPSRs1MCnKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422026; c=relaxed/simple;
	bh=1A9vpktervyoHNloev8v5ZiEv5XUOm1tcv6zFXWz52I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPwORKEmOHD3KhZ/Cat9iTh6vNNmfvlMmYHToQVH2/vWAnms/8+zw+OUkC/70Yb8s7Nm3jim0kHzlvmi6TrABIDyVRCjo8G9VJeLPo67cdkPiPSI1PvDwjRFPSf/TlU9/iDhgkQVY6ZzG1wkdUiAc+ABJf2gA4x1Rg9ql3w9G3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O9BqQQND; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AAJlCHVA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9BqQQND";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AAJlCHVA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835ldZ83176900
	for <linux-pci@vger.kernel.org>; Thu, 3 Sep 2026 07:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6BoqJqpv1ykNJ6tAd/AAsaKnzfeXgSI8dRGTmykoFBA=; b=O9BqQQNDipt0dwpx
	t5/4PKgYm9dso76RYaFp6UNdAzo+354dND7DWnoHlLX2Bnhd7dJ46JzRBYvBtCJ2
	3Q1zoEZd2L8gJAwl9xMOMtVRfh2/8ChoXOHp1R6X6q54tSZPzs8AIYjh5l4CJCxt
	zR+2HoUdwauL3X4Qo6Oa5kQ4oaUe5UFuyXILZr4whwNoiqzusz2cl/gousMjodY6
	sLwjEfzFiIc8lxKH9699pDZvFB53WtDkI8jlWQBUgUWZCc9EpGWsM/rQZLorqDNx
	RnGRr3znzaisZfj2bKz0b4Xrys/rFW99QHF/e+R37hln7l5Ki2cr88x7hd+1CWvI
	QkZc3A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4v5gb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 07:53:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93975d63ffcso33490085a.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788422022; x=1789026822; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6BoqJqpv1ykNJ6tAd/AAsaKnzfeXgSI8dRGTmykoFBA=;
        b=AAJlCHVAdDO0a6GwHK331xLyRwhpqZpvaDfFbUxTDZsinbBJnewzDboo9TuC01E2Wv
         AM1Nuz6g2aHECZZdS08xZtMu3xMTBC+uqyxldh/ZWBi7B1QHorAxmmh2h02uybI5iYIF
         bmZkaesZ5R/loiTXcY/HZPiN5jN+QFZx8jESTWaw6sbozh9D24cF6/vGcxVVzoTNbpPS
         CWraY251dkZeo671cHqVTJ9qLgWJgt4TSucg8W5QrhYOaUZEwMdVohFT/7lk4hLheuU2
         xYPkVZUueEHEB2KIya4aJep6DW5dCF6g+gH1tM/PSbN0KW4vXzwC8+PFAU/HHqEgsUKw
         I1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422022; x=1789026822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6BoqJqpv1ykNJ6tAd/AAsaKnzfeXgSI8dRGTmykoFBA=;
        b=Q3wXuIHsveVkS8rvjPuJnh/uKueXzq3456eeRyrIHxkVYrR5ug56eXyctryRzysF7X
         A7LG6aRshyH3rdtf3UkU1LONIwZdWLW95PxbJ/BAEPSD8KYoGsVof+htnyJhxX736Y9T
         vUnhNf4Z2C9l6mFYAoW/RqvxKE6sHZGKlfUygkasFWYc/KTA4PWdNuDAHdylpQjfkrU7
         UeHLI/rmzHmFm3bHoQnHnYxqInUaJq6qEh8yVpe1QvdBHUs5BvlhzXOw+rP+5f/yFda9
         l96RL2tURahM3f4u6GGYYAvf8g/ElCrkzfiXDrtoiLd491gQQAD8eaikHNQzencDTIj5
         vPDA==
X-Forwarded-Encrypted: i=1; AKwUvByl6CRS+sSG4dpjh2cQ4h3GwztnURWLCvEXweUyrxDAUbm1Pln1en3Yf+qZcmi/r8N9jqQrNgU1XwE=@vger.kernel.org
X-Gm-Message-State: AFuF++mOZcNoMQecM8pjFdGf6yVJbMGJeeUDn2UeHEMDS9vY+aHhhyTq
	r5CKMraWhy+C1FTPKYkhFGKPY3ut5gVbRMnPCJdG0VmX/zGcDuI6QqZzbgWqKJTbJ9x3YZWuDBD
	7mSgI0NJDFr8SCjshM2v/Y8O57xjZ0vAcCvPSmQCqyC3FlCnsZk9JnBL/QzGc0T0=
X-Gm-Gg: AYBFou3kzyc4/rbLr/oVPUXB689NLVQ40SO7npNLyqQixgkthSMj7f0/vhuy30ySHSn
	0xuErP640AJY+75eDSwLvgrMl+kxTqvV22HZJwRax+G69+pjJaeen0kn+2Iw1kZWiYek6czX4Mp
	guKeo68dha+mPqbHKPI8Ob+Bt40NdLoNc5y4ELA6WkmilQrksDKHwmp88K3+WsZgIjs0lzK5i8m
	jSyLsKsyt/sANG/cHyqRj1L5bOS+LwkGbUkgsb29dP1bqkcT/o5TES8V+4dxMNlVkeDhqPq4DBD
	JRIXSeRdcmJuHsfcaDp/gtXe7W0ajyqZGP1qO34+uR7Jpxi/qy5RvT5wLub+mT6HqHAJQLx0pmQ
	C5G5jc8rukoiSGA==
X-Received: by 2002:a05:620a:8399:b0:936:9f46:cec8 with SMTP id af79cd13be357-93960f29cb6mr1212240085a.20.1788422022000;
        Thu, 03 Sep 2026 00:53:42 -0700 (PDT)
X-Received: by 2002:a05:620a:8399:b0:936:9f46:cec8 with SMTP id af79cd13be357-93960f29cb6mr1212236385a.20.1788422021502;
        Thu, 03 Sep 2026 00:53:41 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f9114sm49088205e9.5.2026.09.03.00.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:53:40 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 09:52:59 +0200
Subject: [PATCH v2 3/5] PCI/pwrctrl: tc9563: add GPIO auxiliary device
 support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-pci-tc9563-aux-v2-3-34c625b542c1@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfX1tFbkdZETQuG
 7WKsB+gD++GpTlnRXgzjW4hHLrrBM5LD4nutX+U/XVCVgo8+ujnOfpBkt/Aa8MM3+JEBKDo1pcZ
 av3xMFPvj+tHw/vuS11mTx6pSUpH67a2GjVVcWkl+onKKHkDPQ38rPtNyilwHev+5T6y7eNVkqd
 Yqh0cTuO4buutl0XY6po+HAoq+I+SQaj4k0a/ZenztQxfTCX0FHWfeYdUzi9I2CXZwTHsS0FHjE
 213NF1tvO161HWY8vVW6nFkrDH0dwOsmq09l9XjCEkmEr2VUP3U/GiwYi1oTxJMw0OKWMP71aE2
 fiHh28KFxRJ4JAarr5K3HFN9OaIb6QiiLCWFxzVwKpxBaHDfoJTvT+cI598kSDdQlRyAAZSiFgq
 /Eg6Ym7tN/ZzAaVDYgUYLoGZyiUVqlE/KJV0GqXKqOpPwchfHD2jZLLzg64PAFrrBIq5NYvv6d6
 G/KUEIaTQUVUjDzNlLw==
X-Proofpoint-ORIG-GUID: eaKX-6ZD7DOu3B84FF3xFYcqTWnFR8Qx
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a992786 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=PJtxGifwbofezjXE9ZwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: eaKX-6ZD7DOu3B84FF3xFYcqTWnFR8Qx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfXwnsZx74MzPVd
 MPoQFOo6AV30wT5wsbk9lssCegFawIV2EJOfTyg+pR8f6AQ1EyAVnCcqjIXcc4B67ghSSv/OPZF
 biCs0aCquMRYoIkUvAo8xx4+eWrlG+k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030069

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
 drivers/pci/pwrctrl/Kconfig              |  1 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 80 ++++++++++++++++++++++++++++++--
 2 files changed, 78 insertions(+), 3 deletions(-)

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
index b0d8912690a2..6df512d78b54 100644
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
 
@@ -393,6 +393,73 @@ static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
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
+	if (!adev)
+		return -ENOMEM;
+
+	adev->id = id;
+	adev->name = name;
+	adev->dev.parent = dev;
+	adev->dev.platform_data = priv_data;
+	adev->dev.release = tc9563_pwrctrl_adev_release;
+	adev->dev.of_node = of_node_get(of_node);
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
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
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	fwnode = gpiochip_node_get_first(dev);
+	if (!fwnode)
+		return 0;
+
+	ret = tc9563_pwrctrl_adev_add(dev, TC9563_GPIO_DEV_NAME, 0,
+				      to_of_node(fwnode), tc9563->regmap);
+	fwnode_handle_put(fwnode);
+
+	return ret;
+}
+
 static int tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 {
 	struct tc9563_pwrctrl *tc9563 = container_of(pwrctrl,
@@ -565,6 +632,9 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	 */
 	port = TC9563_USP;
 	for_each_child_of_node_scoped(node, child) {
+		if (!of_node_is_type(child, "pci"))
+			continue;
+
 		if (++port >= TC9563_MAX)
 			break;
 
@@ -596,6 +666,10 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
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

