Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1133B6D5
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484379; cv=none; b=TLrh/brJiOdCROLnJV6yRb5Gc2GIRQHZRbi37kcg1CAg0qDUyiXYB3uyJn0H4Jvnnxw7by5sU1ltImM19eLu8FR1ba7TGsztKKqsk3G9HQD5yEm1v0O1H58SWCJRWcIhTjjWzTJaSwWzMNIkTjToHHoVxqlKKHsYzUvoV5l2NBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484379; c=relaxed/simple;
	bh=i8Yyz0ZCuBm3XBHanTWChKPqfIgQA1TqFVjRia84hUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qyG4OuyFgIrBM5meCHocAO7Oiqxl9wCRvZnm2zDqCulOXvhxQE2sbMcNAubRpZ5KWISisNgIaY+2iGfOPLE/uwCoVm2e9VUnwyjqLlKrpXAqEMxBqzrtu+8A/sR+HDl8OnHbvzA7I+I767eMFXRvQXyWHEcXul1JnPB5FqN/CuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mKnJ4IrG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y1AeD6/R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mKnJ4IrG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y1AeD6/R"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B6gdpT775058
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 07:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o7Ts/JhfwpX8NcwtQcS78S8XKhopAOpHR5vNKYS1Xa0=; b=mKnJ4IrGbbURNJZ/
	aAXfEej06lMzhoASjg1U+FAfrw4SgFguvekH0ZgZMcmg9tdsnQYwLlq4P7YscGNi
	KUkKsaygaJ8FEUBOGTtL2NxVknAWbp2Mu2MTfnVD+fPNZpn+du5S/zUiq0NGKT6m
	FmUADh2KfgxPz+KPYCY82PajaPNZHWDPvv1fUvEY2vTh3OCiEuu0OCzTjEWnNhnc
	N018Bh8xnyUNUoUnlp4ck81Nvinfl93jQytJHNmm3co3PkZJ4yGdKoHWiqWzrjfh
	Z3upsBMrbb9Fyu1JEMnyscl+WeEIx6IfvaJlezxNSIHCVyiK8r/g/AO3SHbsLGfj
	Cn8vDA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3a32g4q4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 07:26:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-365e70c39d0so5232987a91.0
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778484376; x=1779089176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7Ts/JhfwpX8NcwtQcS78S8XKhopAOpHR5vNKYS1Xa0=;
        b=Y1AeD6/RYbNP6D3h1M7RYZYxAjlO6L1mLrsKlotXM9ZMU9i8VpYvUcTkaygn+bFCF9
         L0UwLV8jNqEnqylTpmECHqboCaPeH1ASPtXD59LCZC5G86v87OjYiMDLs+/VvtQhPBk8
         AZMsK7rRc/HIv7dtx2+aPqQOMNw+L6a7n+boFWROu4L94JQ+N7t4DPsKR+Jl5i+G5NuP
         l4XWQouIoGOTK/tOz6a1oQrSOpLSWeEPlyZRcecFY2eGPh9OGDplwtqiIjommNb+zqpC
         hMZNV1nmZOBeOtE4wQ0sL8gWohTNAM+LtL3TBJq0MNLachMoFfzTkxYaLTDTXnckrYXa
         zDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778484376; x=1779089176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o7Ts/JhfwpX8NcwtQcS78S8XKhopAOpHR5vNKYS1Xa0=;
        b=qHtPBuXnyqV5aNIBTXvgbqP5Q/3OReng8QPAzuNo2Dj/uNjrCMgeuWyiVRz1+I1grR
         04QpJANGI63SQIJEDtgw4/vQveYTG3QdEEFo0rgm2rtAwIgdD5CSgXjD1eGRA7WrseCI
         +vIwDjlZu3JcJvD8tSMmhvyyA0sCAEoQ7Z7Gb/uYmljKRrCfpkSfiKvH/Tb6+Sb57EJN
         gsDm7TTXpVnJ/orK6u+2mn9MulupERKSctnjO9pt5gsF2yaZZ46RNfcUH+VO6sTSxzbx
         nu4L6MODWgG93HbNNoYHqDyjaFhYh1CBl6gkEXltnzqrDynsEl/LwixiCm1v4HBHD04J
         TUsA==
X-Forwarded-Encrypted: i=1; AFNElJ8fdqI3dUORlM3ZrJJ8R3MaspMZSD/rypgZXSrNI/RUcOoYqy7dPG0ocjvSZPBXsUbUCT7ICmVbO7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHI/xFB427eenXBBRVpv6xj6rhLYRgny0lXsT3NC3XOKpbQkAP
	9/E7woqkH40ArAwNwnatWpjyOIxhnjr5aL5TjzINuACPqp0hQsKIjLybo3/eqnFfQ4IVR17vA2u
	YZ3Vy7HxvrpsiR/z6kxYu1gqVyHozAJwI4Cgxk5hjICySs2cB3fFfDcJcTz0bSKg=
X-Gm-Gg: Acq92OG1TZIxZqNA1SL5kzR3t15jiiCFGQXeAgxbYJfhdcmZoMd7UJwx8Kx9boGN043
	NAD9XB0iQra5nuRAx+0WZ6kxRqKJTXAjwzqxrkL/7TC7IsLMBy8FPXKPKLqZTAeaPmqfdlTDWjP
	JX3eslqe6YAgHISCdJL39mTZG75zHOvUtc4vDqhgbmFmDByqJvy9dkgBrUW3rvQbxAFgKS1fNni
	ZYY3ZoxsCZJ5i00uVjxvqRgEsiVMztETzUol8kFmsxsYV6wJEOPK91JF3a6fywnDyt4OLu/xv5T
	eKQt3YbE0NvS6wd1gP1K5wIhGKi0ABIRWXsEvhDMl8l8Fc0lXgl1BO3EgyjAemkOFOlplRhXoXN
	HzZ2D6vbrESQto3UQEn8ybD3aNpmWOLDDmTtYKwTyFNH3+QKI2qM4xgw+
X-Received: by 2002:a17:90b:1c84:b0:35f:b288:8e4c with SMTP id 98e67ed59e1d1-365abe8b23dmr22893433a91.15.1778484376016;
        Mon, 11 May 2026 00:26:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1c84:b0:35f:b288:8e4c with SMTP id 98e67ed59e1d1-365abe8b23dmr22893363a91.15.1778484375442;
        Mon, 11 May 2026 00:26:15 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367beac2c7dsm3314306a91.5.2026.05.11.00.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:26:15 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 11 May 2026 12:55:38 +0530
Subject: [PATCH v10 2/2] PCI: Add support for PCIe WAKE# interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-wakeirq_support-v10-2-c10af9c9eb8c@oss.qualcomm.com>
References: <20260511-wakeirq_support-v10-0-c10af9c9eb8c@oss.qualcomm.com>
In-Reply-To: <20260511-wakeirq_support-v10-0-c10af9c9eb8c@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778484355; l=9436;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=i8Yyz0ZCuBm3XBHanTWChKPqfIgQA1TqFVjRia84hUw=;
 b=mcN0J5wEmMmFZZ4p66VYott070eF3gvl4/yiiUDvszlOtUEnBM+/PLXo+oOGmyxiSJnq/k/ft
 bbjINbvGEP2CBSJlvUjz3UXYdJL9dzGWQH4I/gve16ddhrp3kaSIL8X
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: cfrYwSdHN1n7K139IZ0R8p1tOwEr-ffu
X-Proofpoint-GUID: cfrYwSdHN1n7K139IZ0R8p1tOwEr-ffu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4MSBTYWx0ZWRfX1K4ZyMJd4vHo
 FjiTrlRa5OitkSNjA5VNIrImGlMl0xhSGoesckR0tWfBn8lwLF/onMjZJyyThH3ptpQxRxDJevK
 fOU+GspbWQX2YrTuvU41QXFYJbE7g6HSwHhylMIq79Wpj2Y/mSLH1kMzD+r8bQrG2PmdQad/F0a
 p3n51v7anDX8eFXwTcEqhvo3lQj3Toc4bp2XdmTUTPjaPV+3tYby/pk5QorhIkCc+34nN0kFJOW
 mVYy5oWFB1HLfwcNvXjWep7L0nEYUNoCnkQ6/u33Np6Xko+7whjM9ArjQpO53eXHOsCmcPuFX+8
 xBzEo7MqyqmgCoFhFE3hYfEmbYDq+utzTrvj2AMSKydyMQc7QfuMwrySzo0yB3y2EYKgoPgPnXO
 5DFf4ReGuW+G3Ri+8IQdp+g4Itv9ezscxZXwtpa0P83sX/9GMb6gslVwJhlzuKs0AUqsnuYEy+Q
 THpfGre+0Pb7K9O0Daw==
X-Authority-Analysis: v=2.4 cv=SLVykuvH c=1 sm=1 tr=0 ts=6a018498 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=P4KD2rx45hNmobToXc8A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110081

According to the PCI Express specification (PCIe r7.0, Section 5.3.3.2),
two link wakeup mechanisms are defined: Beacon and WAKE#. Beacon is a
hardware-only mechanism and is invisible to software (PCIe r7.0,
Section 4.2.7.8.1). This change adds support for the WAKE# mechanism
in the PCI core.

According to the PCIe specification, multiple WAKE# signals can exist in
a system or each component in the hierarchy could share a single WAKE#
signal. In configurations involving a PCIe switch, each downstream port
(DSP) of the switch may be connected to a separate WAKE# line, allowing
each endpoint to signal WAKE# independently. From figure 5.4 in sec
5.3.3.2, WAKE# can also be terminated at the switch itself. Such topologies
are typically not described in Device Tree, therefore it is out of scope
for this series.

To support this, the WAKE# should be described in the device tree node of
the endpoint/bridge. If all endpoints share a single WAKE# line, then each
endpoint node shall describe the same WAKE# signal or a single WAKE# in
the Root Port node.

In pci_device_add(), PCI framework will search for the WAKE# in device
node. Once found, register for the wake IRQ through
dev_pm_set_dedicated_wake_irq() associates a wakeup IRQ with a device
and requests it, but the PM core keeps the IRQ disabled by default. The
IRQ is enabled by the PM core, only when the device is permitted to wake
the system, i.e. during system suspend and after runtime suspend, and
only when device wakeup is enabled.

If the same WAKE# GPIO is described in multiple device tree nodes, only the
first device that successfully registers the wake IRQ will succeed, while
subsequent registrations may fail. This limitation does not affect
functional correctness, since WAKE# is only used to bring the link to D0,
and endpoint-specific wakeup handling is resolved later through
PME detection (PME_EN is set in suspend path by PCI core by default).

When the wake IRQ fires, the wakeirq handler invokes pm_runtime_resume() to
bring the device back to an active power state, such as transitioning from
D3cold to D0. Once the device is active and the link is usable, the
endpoint may generate a PME, which is then handled by the PCI core through
PME polling or the PCIe PME service driver to complete the wakeup of the
endpoint.

WAKE# is added in dts schema and merged based on below links.

Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
Link: https://github.com/devicetree-org/dt-schema/pull/170
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/of.c       | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c      | 11 ++++++++
 drivers/pci/pci.h      |  2 ++
 drivers/pci/probe.c    |  2 ++
 drivers/pci/remove.c   |  1 +
 include/linux/of_pci.h |  6 +++++
 include/linux/pci.h    |  2 ++
 7 files changed, 96 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 6da569fd3b8f..ed3ad5b9a253 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt)	"PCI: OF: " fmt
 
 #include <linux/cleanup.h>
+#include <linux/gpio/consumer.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -15,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include "pci.h"
 
 #ifdef CONFIG_PCI
@@ -586,6 +588,76 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq_create_of_mapping(&oirq);
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
+
+static void pci_configure_wake_irq(struct pci_dev *pdev, struct gpio_desc *wake)
+{
+	int ret, wake_irq;
+
+	wake_irq = gpiod_to_irq(wake);
+	if (wake_irq < 0) {
+		pci_err(pdev, "Failed to get wake irq: %d\n", wake_irq);
+		return;
+	}
+
+	/*
+	 * dev_pm_set_dedicated_wake_irq() associates a wakeup IRQ with the
+	 * device and requests it, but the PM core keeps it disabled by default.
+	 * The IRQ is enabled only when the device is allowed to wake the system
+	 * (during system suspend and after runtime suspend), and only if device
+	 * wakeup is enabled.
+	 *
+	 * When the wake IRQ fires, the wakeirq handler invokes pm_runtime_resume()
+	 * to bring the device back to an active power state (e.g. from D3cold to D0).
+	 * Once the device is active and the link is usable, the endpoint may signal
+	 * a PME, which is then handled by the PCI core (either via PME polling or the
+	 * PCIe PME service driver) to wakeup particular endpoint.
+	 */
+	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, wake_irq);
+	if (ret < 0) {
+		pci_err(pdev, "Failed to set WAKE# IRQ: %d\n", ret);
+		return;
+	}
+
+	ret = irq_set_irq_type(wake_irq, IRQ_TYPE_LEVEL_LOW);
+	if (ret < 0) {
+		dev_pm_clear_wake_irq(&pdev->dev);
+		pci_err(pdev, "Failed to set irq_type: %d\n", ret);
+	}
+}
+
+void pci_configure_of_wake_gpio(struct pci_dev *dev)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	struct gpio_desc *gpio;
+
+	if (!dn)
+		return;
+	/*
+	 * fwnode_gpiod_get() may fail with -EBUSY (e.g. shared WAKE#), but the
+	 * actual WAKE# trigger from the device would still work and the host
+	 * controller driver will enable power to the topology.
+	 *
+	 * -EPROBE_DEFER cannot be propagated here since pci_device_add() has no
+	 *  retry mechanism.
+	 */
+	gpio = fwnode_gpiod_get(of_fwnode_handle(dn), "wake", GPIOD_IN, NULL);
+	if (!IS_ERR(gpio)) {
+		dev->wake = gpio;
+		pci_configure_wake_irq(dev, gpio);
+	}
+}
+
+void pci_remove_of_wake_gpio(struct pci_dev *dev)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+
+	if (!dn)
+		return;
+
+	dev_pm_clear_wake_irq(&dev->dev);
+	gpiod_put(dev->wake);
+	dev->wake = NULL;
+}
 #endif	/* CONFIG_OF_IRQ */
 
 static int pci_parse_request_of_pci_ranges(struct device *dev,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..5bffed535dc2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -17,6 +17,7 @@
 #include <linux/lockdep.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
@@ -1123,6 +1124,16 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return acpi_pci_bridge_d3(dev);
 }
 
+void platform_pci_configure_wake(struct pci_dev *dev)
+{
+	pci_configure_of_wake_gpio(dev);
+}
+
+void platform_pci_remove_wake(struct pci_dev *dev)
+{
+	pci_remove_of_wake_gpio(dev);
+}
+
 /**
  * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..85539c238743 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -284,6 +284,8 @@ void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
+void platform_pci_configure_wake(struct pci_dev *dev);
+void platform_pci_remove_wake(struct pci_dev *dev);
 
 static inline bool pci_bus_rrs_vendor_id(u32 l)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..143b0bd35b3c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2775,6 +2775,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Establish pdev->tsm for newly added (e.g. new SR-IOV VFs) */
 	pci_tsm_init(dev);
 
+	platform_pci_configure_wake(dev);
+
 	pci_npem_create(dev);
 
 	pci_doe_sysfs_init(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e9d519993853..d781b41e57c4 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -35,6 +35,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	if (pci_dev_test_and_set_removed(dev))
 		return;
 
+	platform_pci_remove_wake(dev);
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
 
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 29658c0ee71f..649fe8eafcfa 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -30,12 +30,18 @@ static inline void of_pci_check_probe_only(void) { }
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
+void pci_configure_of_wake_gpio(struct pci_dev *dev);
+void pci_remove_of_wake_gpio(struct pci_dev *dev);
 #else
 static inline int
 of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return 0;
 }
+
+static inline void pci_configure_of_wake_gpio(struct pci_dev *dev) { }
+
+static inline void pci_remove_of_wake_gpio(struct pci_dev *dev) { }
 #endif
 
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..4289b60dcc83 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -588,6 +588,8 @@ struct pci_dev {
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
+	struct gpio_desc *wake; /* Holds WAKE# gpio */
+
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
 	u8		tph_mode;	/* TPH mode */

-- 
2.34.1

