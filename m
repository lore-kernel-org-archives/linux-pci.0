Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1B273D6D
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780285069; cv=none; b=eNUdq27lVsQ3hpguQxA16/uCd3XiwN3Cg4ZdHqXOuJjMmDL8w7gAdGLjpkbeO4xQJdmc3efB9kSCJoy9KBLfAS46/yaswrRjZMPpKWZOY9WU842LgPFL4tNGhRfhQ4qezi0OBYhOIrI4reau9WbUmJH/iC+3HTMm0sckiTfSYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780285069; c=relaxed/simple;
	bh=73AB8+jHnZfSkvML33QHKeofofxU7hQeM/SK1HUl6k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IokOP4QnjCjt6UHz+q72mGRGQhU9xtMtoMEQXqUzHyIaSlnlTWfUoN/sETfulPBNpwi77bs3498NzZPX+zcG0F+nsIGcU9lXPnDgn9LHtJttiWGST59AG8Bls0Gf3y7hK+YuIxQXFLdC/eLr1KqbreQyLCLGP+mStLF1y/2tkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DEcPCzdp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gkZAzprn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DEcPCzdp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gkZAzprn"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VFK68q3223903
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 03:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lkUsz3VXuUB0spQixXVrnGwdk9ySth3PoHezhWUC3lg=; b=DEcPCzdp8LbS7bMX
	k5H4zJPznVxeQSO5setvVpyJGAkhbV3HaRWMCRrY9yBY3U7Fpjftj/avdy6OTXbb
	aHz3Js4VCFIAJEGNLDhv5ObHAFPBSvvDKmsALZYNmEZJz/9NhiCO6dM0C+tudmbK
	RJuNy1nldHNKr3lgspRt4baVIOIOCR1bMLZdf+3WQyGUiL6LsiEXwF7UUnkJYjIL
	/2Mk8J/TAnwUJj14VdsQuC+phgHX0F9D0pA3RLmmICo6NnwvtqeNefwWHBsDPzF/
	Cp3rIfHBptJgGGPlAuBz/wugR/YTE3ikUTLNYbOlQx4dwGLn4THrCd/hjZS34z+s
	L1+vXQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efqyuweyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 03:37:46 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423f544944so592724b3a.3
        for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 20:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780285065; x=1780889865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkUsz3VXuUB0spQixXVrnGwdk9ySth3PoHezhWUC3lg=;
        b=gkZAzprn1n+8VJoCuva+WBEkj94WgVt+kW5sc0Ah3HCRyswM12mTPtYYVfnUbb6WCm
         UmYp1XkVYn9O7PRtCY5Hl8ejQrLIpQTneiVTVNb5EVbWNARCRSnlkr6ADTBo0WwbC7ZY
         oXukLVZCjNzSuItYbm0rwZwqaK09lebwWYaAeXOa0u6HSm/FiRD7tLrY9cvtbGDXXk1O
         NrWO8U4FIrhY1vmENYh95bhbyuz6MtjwTt4rgCsv8qKLXHaMSSGUUXIvRcStETWDZ9Tc
         WCQu8NqDiZnLU3wI4Y6hrymFhm1wSjAwfHe5BxAoSxSBb7c+93zYCo9MVhfew4BebAw9
         6UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780285065; x=1780889865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkUsz3VXuUB0spQixXVrnGwdk9ySth3PoHezhWUC3lg=;
        b=kDwKakl+965i9wc3ts2Q4mWg65z2QOYOgsFGdnyJt1M4Q5VUa8KCLeJekjp4iTucCj
         vpS3bVYWOipSJmDWEUZzKnvOodIj7c28DZKLsrff/+ruz8eMOR5NHRfUYL2kMsC33kcG
         YytkOdvVbj694R7sWFKH3GGfNPrQtTdLDCNITl7AIqPE6PqF+jDMTjZs9dTCkD6AJiTq
         5Frc7tY79XgHBwb1wFeCa3q/5bq74tTKi8kwW46yLiiOQQP+6xTz5Ykvt7eRgSP2PQBy
         mKXaUfSG3JmXp0YvHVsVSV1wDgPvh+1alNKq/tUCdrI7qhNVAargoFlXu2Ta9RUyzxIa
         mCgA==
X-Forwarded-Encrypted: i=1; AFNElJ/cm8pA0hyx/s/TSnMFQEMzKDwJULN8jIhChFLFrnvoLIXejdKSN53NYm6YFYi7rrL1BeHl80NXDZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVf6uEwqywnKNobqU1s/rZJSQDiDzPC2ToxdmHOVIdoVuWy049
	0utwke7LgJkjqiBJqemAN886hyHSV3ESk0kXpJliHQr2M9inF+PVQ7byDXFv7Bks8ueUu7bC5HS
	9zB6MJfXEXg4d1gCrI78BjMc+q8k7HohhhCsCLK0RLbPBDF+3HA72Ciq+XxT0f74=
X-Gm-Gg: Acq92OGAoWu/yJIlMkbWqyg/MQeWvSPKGlfBShj/zDgKyv4NmPN01QBMmX/4+dqEGah
	AOThTlGJOFVwl6zUoa154E9yrIXONkhiV5w7U4wu/60Ge2GuTTnB5Ca2pFNbqSPPscWHt94pjeh
	IcrSUXN6ZM3Igr04djzbgI42KLtGWgFLZiAFA+51RHv7zSh4sAYIrzBmgkfmeGINb8G4KvPyJL6
	Ad4X+CmzWCwHSY73UDFmjVP6vSroJj9aU8TuBhiFaGM3yKZqHU8kcKRPFeZMVjWTEsgvQbgbns2
	S5jfLDOyDCrKnMoDRqCdtSpkL/Mrs5iBjLbU7LZ2Wu5gfE80PTcrhzgpCHwqJpooJj4GWVEKcV+
	Jb6cKgGXXs+1xu++WQKyKhLTemwrP67AxfKNS0K9GwZHwUPOl7dn8By7pOzwOeDDh
X-Received: by 2002:a05:6a00:a24d:b0:842:5711:9a2f with SMTP id d2e1a72fcca58-8425711a141mr1439979b3a.36.1780285065361;
        Sun, 31 May 2026 20:37:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:a24d:b0:842:5711:9a2f with SMTP id d2e1a72fcca58-8425711a141mr1439930b3a.36.1780285064787;
        Sun, 31 May 2026 20:37:44 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b6797esm9862518b3a.26.2026.05.31.20.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 20:37:44 -0700 (PDT)
Message-ID: <7cc5e4f1-7899-4517-81f6-d0f18ea4e2ae@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 09:07:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] PCI: Add support for PCIe WAKE# interrupt
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com,
        sherry.sun@nxp.com, driver-core@lists.linux.dev,
        devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
References: <20260511-wakeirq_support-v10-0-c10af9c9eb8c@oss.qualcomm.com>
 <20260511-wakeirq_support-v10-2-c10af9c9eb8c@oss.qualcomm.com>
 <p7la2n65vkfd4bnvygm533rgglx2og5grltolgizbahptbaf3o@42zkaymebhzz>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <p7la2n65vkfd4bnvygm533rgglx2og5grltolgizbahptbaf3o@42zkaymebhzz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAzMyBTYWx0ZWRfX4/pWq2+K5Zwf
 lTnVPkDVPUgruSqwwRfd7R25A68JJ2ORFEJpssX2qAMcO3EOKtFow1oorlMX8mvQucnekrmfi8x
 VxiSwBrXe9VDmG1qAmiAb7xrEtcwiCuXS+ZAd2R2vZZU7TGHgViG3cnpau6KsHCbmIzjOnsE7XO
 J/JL0HRqap41gsyMuuSqx2LtcFv4gAXiXtMiTg+NU9w+oFXa0Oqt8XFmPiRjy7Z3fhbmARDFTNz
 NcFzsEFrF9h3YnweC+mNZ6yJWSCzs8798q033/991sJSc+l8rkDsBfWRc0Xt/0FTANgIZcJSmKM
 EofWalSEvN/FPCFWMKKO+DTAiYjGhry0XiWmGek134WGVbY7jGpwYRqTiRmjiHel6WnHq+iG94y
 qNqbW9OAVVH6uD42/ObWg/Rcx0iaBzKwcLqBIr+bmHBC+Pm/wspl3E3jVT7zp/S8Tt+sy7fV/X/
 dlqJXR74uAEW1ecCvoQ==
X-Proofpoint-ORIG-GUID: gzx6XMDfO-o04yfcYkJC4-nRCxccvCDG
X-Proofpoint-GUID: gzx6XMDfO-o04yfcYkJC4-nRCxccvCDG
X-Authority-Analysis: v=2.4 cv=B5uJFutM c=1 sm=1 tr=0 ts=6a1cfe8a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=slkGKw8Z9QmxrnLXOEIA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010033



On 5/13/2026 8:30 PM, Manivannan Sadhasivam wrote:
> On Mon, May 11, 2026 at 12:55:38PM +0530, Krishna Chaitanya Chundru wrote:
>> According to the PCI Express specification (PCIe r7.0, Section 5.3.3.2),
>> two link wakeup mechanisms are defined: Beacon and WAKE#. Beacon is a
>> hardware-only mechanism and is invisible to software (PCIe r7.0,
>> Section 4.2.7.8.1). This change adds support for the WAKE# mechanism
>> in the PCI core.
>>
>> According to the PCIe specification, multiple WAKE# signals can exist in
>> a system or each component in the hierarchy could share a single WAKE#
>> signal. In configurations involving a PCIe switch, each downstream port
>> (DSP) of the switch may be connected to a separate WAKE# line, allowing
>> each endpoint to signal WAKE# independently. From figure 5.4 in sec
>> 5.3.3.2, WAKE# can also be terminated at the switch itself. Such topologies
>> are typically not described in Device Tree, therefore it is out of scope
>> for this series.
>>
>> To support this, the WAKE# should be described in the device tree node of
>> the endpoint/bridge. If all endpoints share a single WAKE# line, then each
>> endpoint node shall describe the same WAKE# signal or a single WAKE# in
>> the Root Port node.
>>
>> In pci_device_add(), PCI framework will search for the WAKE# in device
>> node. Once found, register for the wake IRQ through
>> dev_pm_set_dedicated_wake_irq() associates a wakeup IRQ with a device
>> and requests it, but the PM core keeps the IRQ disabled by default. The
>> IRQ is enabled by the PM core, only when the device is permitted to wake
>> the system, i.e. during system suspend and after runtime suspend, and
>> only when device wakeup is enabled.
>>
>> If the same WAKE# GPIO is described in multiple device tree nodes, only the
>> first device that successfully registers the wake IRQ will succeed, while
>> subsequent registrations may fail. This limitation does not affect
>> functional correctness, since WAKE# is only used to bring the link to D0,
>> and endpoint-specific wakeup handling is resolved later through
>> PME detection (PME_EN is set in suspend path by PCI core by default).
>>
>> When the wake IRQ fires, the wakeirq handler invokes pm_runtime_resume() to
>> bring the device back to an active power state, such as transitioning from
>> D3cold to D0. Once the device is active and the link is usable, the
>> endpoint may generate a PME, which is then handled by the PCI core through
>> PME polling or the PCIe PME service driver to complete the wakeup of the
>> endpoint.
>>
>> WAKE# is added in dts schema and merged based on below links.
>>
>> Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
>> Link: https://github.com/devicetree-org/dt-schema/pull/170
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Hi Bjorn,

can you please check this series once.

- Krishna Chaitanya.
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
>
> - Mani
>
>> ---
>>  drivers/pci/of.c       | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pci.c      | 11 ++++++++
>>  drivers/pci/pci.h      |  2 ++
>>  drivers/pci/probe.c    |  2 ++
>>  drivers/pci/remove.c   |  1 +
>>  include/linux/of_pci.h |  6 +++++
>>  include/linux/pci.h    |  2 ++
>>  7 files changed, 96 insertions(+)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 6da569fd3b8f..ed3ad5b9a253 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -7,6 +7,7 @@
>>  #define pr_fmt(fmt)	"PCI: OF: " fmt
>>  
>>  #include <linux/cleanup.h>
>> +#include <linux/gpio/consumer.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/kernel.h>
>>  #include <linux/pci.h>
>> @@ -15,6 +16,7 @@
>>  #include <linux/of_address.h>
>>  #include <linux/of_pci.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_wakeirq.h>
>>  #include "pci.h"
>>  
>>  #ifdef CONFIG_PCI
>> @@ -586,6 +588,76 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>>  	return irq_create_of_mapping(&oirq);
>>  }
>>  EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
>> +
>> +static void pci_configure_wake_irq(struct pci_dev *pdev, struct gpio_desc *wake)
>> +{
>> +	int ret, wake_irq;
>> +
>> +	wake_irq = gpiod_to_irq(wake);
>> +	if (wake_irq < 0) {
>> +		pci_err(pdev, "Failed to get wake irq: %d\n", wake_irq);
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * dev_pm_set_dedicated_wake_irq() associates a wakeup IRQ with the
>> +	 * device and requests it, but the PM core keeps it disabled by default.
>> +	 * The IRQ is enabled only when the device is allowed to wake the system
>> +	 * (during system suspend and after runtime suspend), and only if device
>> +	 * wakeup is enabled.
>> +	 *
>> +	 * When the wake IRQ fires, the wakeirq handler invokes pm_runtime_resume()
>> +	 * to bring the device back to an active power state (e.g. from D3cold to D0).
>> +	 * Once the device is active and the link is usable, the endpoint may signal
>> +	 * a PME, which is then handled by the PCI core (either via PME polling or the
>> +	 * PCIe PME service driver) to wakeup particular endpoint.
>> +	 */
>> +	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, wake_irq);
>> +	if (ret < 0) {
>> +		pci_err(pdev, "Failed to set WAKE# IRQ: %d\n", ret);
>> +		return;
>> +	}
>> +
>> +	ret = irq_set_irq_type(wake_irq, IRQ_TYPE_LEVEL_LOW);
>> +	if (ret < 0) {
>> +		dev_pm_clear_wake_irq(&pdev->dev);
>> +		pci_err(pdev, "Failed to set irq_type: %d\n", ret);
>> +	}
>> +}
>> +
>> +void pci_configure_of_wake_gpio(struct pci_dev *dev)
>> +{
>> +	struct device_node *dn = pci_device_to_OF_node(dev);
>> +	struct gpio_desc *gpio;
>> +
>> +	if (!dn)
>> +		return;
>> +	/*
>> +	 * fwnode_gpiod_get() may fail with -EBUSY (e.g. shared WAKE#), but the
>> +	 * actual WAKE# trigger from the device would still work and the host
>> +	 * controller driver will enable power to the topology.
>> +	 *
>> +	 * -EPROBE_DEFER cannot be propagated here since pci_device_add() has no
>> +	 *  retry mechanism.
>> +	 */
>> +	gpio = fwnode_gpiod_get(of_fwnode_handle(dn), "wake", GPIOD_IN, NULL);
>> +	if (!IS_ERR(gpio)) {
>> +		dev->wake = gpio;
>> +		pci_configure_wake_irq(dev, gpio);
>> +	}
>> +}
>> +
>> +void pci_remove_of_wake_gpio(struct pci_dev *dev)
>> +{
>> +	struct device_node *dn = pci_device_to_OF_node(dev);
>> +
>> +	if (!dn)
>> +		return;
>> +
>> +	dev_pm_clear_wake_irq(&dev->dev);
>> +	gpiod_put(dev->wake);
>> +	dev->wake = NULL;
>> +}
>>  #endif	/* CONFIG_OF_IRQ */
>>  
>>  static int pci_parse_request_of_pci_ranges(struct device *dev,
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 8f7cfcc00090..5bffed535dc2 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/lockdep.h>
>>  #include <linux/msi.h>
>>  #include <linux/of.h>
>> +#include <linux/of_pci.h>
>>  #include <linux/pci.h>
>>  #include <linux/pm.h>
>>  #include <linux/slab.h>
>> @@ -1123,6 +1124,16 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>>  	return acpi_pci_bridge_d3(dev);
>>  }
>>  
>> +void platform_pci_configure_wake(struct pci_dev *dev)
>> +{
>> +	pci_configure_of_wake_gpio(dev);
>> +}
>> +
>> +void platform_pci_remove_wake(struct pci_dev *dev)
>> +{
>> +	pci_remove_of_wake_gpio(dev);
>> +}
>> +
>>  /**
>>   * pci_update_current_state - Read power state of given device and cache it
>>   * @dev: PCI device to handle.
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 4a14f88e543a..85539c238743 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -284,6 +284,8 @@ void pci_msix_init(struct pci_dev *dev);
>>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>>  void pci_bridge_d3_update(struct pci_dev *dev);
>>  int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
>> +void platform_pci_configure_wake(struct pci_dev *dev);
>> +void platform_pci_remove_wake(struct pci_dev *dev);
>>  
>>  static inline bool pci_bus_rrs_vendor_id(u32 l)
>>  {
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index b63cd0c310bc..143b0bd35b3c 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2775,6 +2775,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>>  	/* Establish pdev->tsm for newly added (e.g. new SR-IOV VFs) */
>>  	pci_tsm_init(dev);
>>  
>> +	platform_pci_configure_wake(dev);
>> +
>>  	pci_npem_create(dev);
>>  
>>  	pci_doe_sysfs_init(dev);
>> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>> index e9d519993853..d781b41e57c4 100644
>> --- a/drivers/pci/remove.c
>> +++ b/drivers/pci/remove.c
>> @@ -35,6 +35,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>>  	if (pci_dev_test_and_set_removed(dev))
>>  		return;
>>  
>> +	platform_pci_remove_wake(dev);
>>  	pci_doe_sysfs_teardown(dev);
>>  	pci_npem_remove(dev);
>>  
>> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
>> index 29658c0ee71f..649fe8eafcfa 100644
>> --- a/include/linux/of_pci.h
>> +++ b/include/linux/of_pci.h
>> @@ -30,12 +30,18 @@ static inline void of_pci_check_probe_only(void) { }
>>  
>>  #if IS_ENABLED(CONFIG_OF_IRQ)
>>  int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
>> +void pci_configure_of_wake_gpio(struct pci_dev *dev);
>> +void pci_remove_of_wake_gpio(struct pci_dev *dev);
>>  #else
>>  static inline int
>>  of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>>  {
>>  	return 0;
>>  }
>> +
>> +static inline void pci_configure_of_wake_gpio(struct pci_dev *dev) { }
>> +
>> +static inline void pci_remove_of_wake_gpio(struct pci_dev *dev) { }
>>  #endif
>>  
>>  #endif
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 2c4454583c11..4289b60dcc83 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -588,6 +588,8 @@ struct pci_dev {
>>  	/* These methods index pci_reset_fn_methods[] */
>>  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
>>  
>> +	struct gpio_desc *wake; /* Holds WAKE# gpio */
>> +
>>  #ifdef CONFIG_PCIE_TPH
>>  	u16		tph_cap;	/* TPH capability offset */
>>  	u8		tph_mode;	/* TPH mode */
>>
>> -- 
>> 2.34.1
>>

