Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E13D47C1
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353937; cv=none; b=lIRVnxvo7/mdjvKERC5amjNUGxp2ObCI6R3aipueCbGqu1RgeouwHvV0fMbOba3gygBz9Ox+WXMb/Gkb/YS685XdTWrN3hMdBdfJFq2GhFQ4jW78Xdw35kr/pSmhSku4hJ3WxdQg8ndS+1c0GZqPvK7Q8wcfntI9mdLJ7mQYGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353937; c=relaxed/simple;
	bh=INmeiGJKMXk+0PJEej2mrgVEmYRHxRGrlBMc5p0a5aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVbIq4fnmcaAqxwgmDagqEtBeYRnXmRkccIaHZX2xfuZqkacDDkas3iaIg6WDJNEQCPG9Td1zQDcNhqzhvsFioccgspbKIYAIMBFWGlm9+lQZwIYJb1csaHTkQFgf22Xe4RxM9LIth2iA2LuVQ8LK7MraHX8hsjo4EZWgSyeiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eiiwG5ed; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ByGO/wZh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eiiwG5ed";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ByGO/wZh"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O9wS053039644
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 12:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E5IUEO5PyBIerJfWjfzoqFirzXsSOD9hNzXQV1mXr0E=; b=eiiwG5edacFrpRTZ
	EtFrpYBAz2dzEh8QgxuzMve34/TbRlhIqFNx0EIQC9p4hZ2Sc1R0WIg2sTP6BzrM
	ZMpxlfMwVzsguvbqR5NsG0MiTxuaUDz7gQK9z/PxTLu1TEuNtp0aZM+jWN5B0FTG
	cAEb6aMA1eo/Z0VWzsnyIojgSv0Q7zlmm7vQ+g3Jors7pW4zXq4WIA+Gen1trqxO
	8FKevj/nVzz62rhyId8j2AORT2bDOzfq1W9g4Gu+AsQMotjMluRzjhztxSKw7emf
	qjozK5HoD7x8HTa7uMYLbYLYuYjcsGG4hg2oWm9+adG+aTQzddUtS3YHqtw1B3gb
	YkEiWw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3rf0gf85-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 12:05:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b064f043adso75411155ad.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 05:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774353831; x=1774958631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5IUEO5PyBIerJfWjfzoqFirzXsSOD9hNzXQV1mXr0E=;
        b=ByGO/wZhHkNCfRtNzd1cWKYIk+yqjgVvcHWz1qtlz0D2awkgtOI7dNlRXDmrU0Ag/Y
         BpqSzHy+W85eb/bADDL83GXly35Bem0OlZARvt5kCtW7uVV7AHlwySJ49Klk1wMsou71
         pJvHr5+zv+BPeoWe6Fhdz3mt2jSP2Dq3go/N2gwnTMpMqYQXxye/4/VjtZtqnQNqPsvH
         aB7J/7Kfwpz79/HsOhoChNdIIMrDmJS8mE/scs6eVX/qJl4hfaZTWNrNbS5VVXQGC6Uq
         tgMjbZC/Mw9k6/LKuIgI6kkJlJaKhPZsehOBjSgNRfJTe2aZR8wQ266lw3dsRtHAEWNt
         /X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774353831; x=1774958631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5IUEO5PyBIerJfWjfzoqFirzXsSOD9hNzXQV1mXr0E=;
        b=T2uQ+ntelaOppAjfa6Bi+CYPi+RjvAQnfknSJBanWKYjNpkyLVKgpXI0qD0/IUk2/W
         MMyC0DyNj/QSMy5LiyhiV4fgSTCPq8FU3O+KtwMNebXuGs0tjOMrVrUBwCQnib87FZM0
         TfaB+9A6KOY3+hYMbvIj4NN3BfOgeVZUuedf/uDNuoP50eZZV7WVZxkHVwgOumsGQ93b
         XB4U7srto67uOb1oRvEvI3WhAdQDAdvNbUr6kA4Ss9m33olPKXyNF3ymREIn2/vypOt+
         mvpmVbb26asO2SCFRcOOxPSx6m4WqnnMnISSazmQTg49t32EcPKjMkVemgF2R86YI5xk
         ny8A==
X-Forwarded-Encrypted: i=1; AJvYcCWGalHEx0B1QUdMyTaCQITgXhsqUMkIlEQox08A9RjS8MpOJNPpWFd7FE09bGe+QzbsQcY3i7S01a8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9fPVlUmso+w7rJz0y+FHI3Xz6Q5PXHZi+3L54Oiwj34dB5QXt
	YMMTeXu3+biTLWC2LELteBlYIrwutmOLc0j4II+qJBTMcnwNyplgOZs8SRzpGNnDOs+hQEhbiFm
	fYoVpWQdIOBSYKg0VyhsUIsJHNDSTjEfwyIBX/LjjQmmbkC73Z16ge6g7wfgk04c=
X-Gm-Gg: ATEYQzzbZGMF/+eCJz/5e84qDxNj6BMcZz1xgfANX4JP8TarMTalt42CUce0Y6GRN52
	36YAY96bs0mIlG1f4XLsFwUI4z7nzvkGwHw1Jo8bHNBcCs4DbbPqMSaNnwte/hV29Y5cBcQ8ml6
	rYmpPNrTnQqXZV0+xM1VUZdtii+ApYUDA2+D5L1/HOYGfji75MM9DEFd8OKKENRJg8aXRHo8otf
	3450xjnEGYqg+41kZUyNp1ZVFlk+/MPahyw/IarrmBoIrh7C8FhGXr9PhTj1YtP0bA8R88aDxTV
	wfh86smAQv9Bp0Iy0H2oy3Ycrb9fBHRfPYVkF+TqY21+0POiFeTPrX9IvpPphedkbiqElRS+XvL
	u/CbnNnGqKal3nYu1/rHJ5BcR42pMBfcdmXlyYrGIfQG5S2aBcUy0Gg==
X-Received: by 2002:a17:903:3ba5:b0:2b0:5aab:c40a with SMTP id d9443c01a7336-2b08277aecamr143662575ad.31.1774353831147;
        Tue, 24 Mar 2026 05:03:51 -0700 (PDT)
X-Received: by 2002:a17:903:3ba5:b0:2b0:5aab:c40a with SMTP id d9443c01a7336-2b08277aecamr143662045ad.31.1774353830506;
        Tue, 24 Mar 2026 05:03:50 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656f65sm208995095ad.45.2026.03.24.05.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 05:03:50 -0700 (PDT)
Message-ID: <f97c6dfa-55dc-4792-95d6-4aa1bce3694d@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 17:33:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] PCI: Add support for PCIe WAKE# interrupt
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com,
        sherry.sun@nxp.com, driver-core@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20260313-wakeirq_support-v8-0-48a0a702518a@oss.qualcomm.com>
 <20260313-wakeirq_support-v8-3-48a0a702518a@oss.qualcomm.com>
 <4n5heks4oymfz75wiajyc5zuzzulmwyfj2couudbi7gi67h2rk@smpnmyhdjkns>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <4n5heks4oymfz75wiajyc5zuzzulmwyfj2couudbi7gi67h2rk@smpnmyhdjkns>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA5NiBTYWx0ZWRfX5eckMh39RcyU
 gYkJZolcYCpXR4JQXqQRGCAul8k6UaV1wrkIhoL0m+4k/TxGt9DZrFTcO8Afr9GhfjA1mAuXgVT
 wiem5AThf5Mq84uqhot6AZw8tulPZ0wLX/X5bDh4X3K64Dyln0dDHCwPGHntaxIkPceRhKVUx8O
 R3Xj1XctJGyhMO/cHPYjqYBfJPRK9o6aUzLvnw2GrkOPSeBswKxLT/T2zysYy8w5zbGMqlJqJeo
 32BnzsmlsyE9mJkYaE/lLix0vRw80FhcP2NI9ovsmSOlc6m0sG5xrCyCGM5khjd6nKijc/m3a9n
 KeIQGAy5EuVXKyyJHz3kAzxZd8PfJsC8AIDtwasOCTFCdAyzf/fKA5uLd+lCNOWgpn/pId9VauA
 2J4BkAIzRcfzlBpNa+NXYH5MjgoRSkNx+YknxQmVDVKWq7hef9TUkevhm7pNIMk80VDLxsnilNn
 epkcvAo6uVs8OuEhg6Q==
X-Authority-Analysis: v=2.4 cv=Ua9ciaSN c=1 sm=1 tr=0 ts=69c27e0c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=rFA5VEQNUbPbIC_WhckA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: wPWGEa-lqX1g2dVQsxcQcD3pr-qrjO-5
X-Proofpoint-GUID: wPWGEa-lqX1g2dVQsxcQcD3pr-qrjO-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240096



On 3/17/2026 12:56 PM, Manivannan Sadhasivam wrote:
> On Fri, Mar 13, 2026 at 12:38:42PM +0530, Krishna Chaitanya Chundru wrote:
>> According to the PCI Express specification (PCIe r7.0, Section 5.3.3.2),
>> two link wakeup mechanisms are defined: Beacon and WAKE#. Beacon is a
>> hardware-only mechanism and is invisible to software (PCIe r7.0,
>> Section 4.2.7.8.1). This change adds support for the WAKE# mechanism in
>> the PCI core.
>>
>> According to the PCIe specification, multiple WAKE# signals can exist in
>> a system or each component in the hierarchy could share a single WAKE#
>> signal. In configurations involving a PCIe switch, each downstream port
>> (DSP) of the switch may be connected to a separate WAKE# line, allowing
>> each endpoint to signal WAKE# independently. From figure 5.4 in sec
>> 5.3.3.2, WAKE# can also be terminated at the switch itself. To support
>> this, the WAKE# should be described in the device tree node of the
>> endpoint/bridge. If all endpoints share a single WAKE# line, then each
>> endpoint node should describe the same WAKE# signal or a single WAKE# in
>> the Root Port node.
>>
>> In pci_device_add(), PCI framework will search for the WAKE# in device
>> node, If not found, it searches in its upstream port only if upstream port
>> is Root Port. Once found, register for the wake IRQ in shared mode, as the
>> WAKE# may be shared among multiple endpoints.
>>
>> dev_pm_set_dedicated_shared_wake_irq() associates a wakeup IRQ with a
>> device and requests it, but the PM core keeps the IRQ disabled by default.
>> The IRQ is enabled only when the device is permitted to wake the system,
>> i.e. during system suspend and after runtime suspend, and only when device
>> wakeup is enabled.
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
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/of.c       | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.c      | 10 +++++++
>>   drivers/pci/pci.h      |  2 ++
>>   drivers/pci/probe.c    |  2 ++
>>   drivers/pci/remove.c   |  1 +
>>   include/linux/of_pci.h |  4 +++
>>   include/linux/pci.h    |  2 ++
>>   7 files changed, 95 insertions(+)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 9f8eb5df279ed28db7a3b2fd29c65da9975c2efa..b7199d3598b31b62245716c178a5a73565efc89e 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -7,6 +7,7 @@
>>   #define pr_fmt(fmt)	"PCI: OF: " fmt
>>   
>>   #include <linux/cleanup.h>
>> +#include <linux/gpio/consumer.h>
>>   #include <linux/irqdomain.h>
>>   #include <linux/kernel.h>
>>   #include <linux/pci.h>
>> @@ -15,6 +16,7 @@
>>   #include <linux/of_address.h>
>>   #include <linux/of_pci.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_wakeirq.h>
>>   #include "pci.h"
>>   
>>   #ifdef CONFIG_PCI
>> @@ -586,6 +588,78 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>>   	return irq_create_of_mapping(&oirq);
>>   }
>>   EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
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
>> +	device_init_wakeup(&pdev->dev, true);
> Just set wakeup only if dev_pm_set_dedicated_shared_wake_irq() succeeds.
ack.
>> +
>> +	/*
>> +	 * dev_pm_set_dedicated_shared_wake_irq() associates a wakeup IRQ with the
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
>> +	ret = dev_pm_set_dedicated_shared_wake_irq(&pdev->dev, wake_irq,
>> +						   IRQ_TYPE_EDGE_FALLING);
> Isn't WAKE# a level triggered signal?
Ack. I will change IRQ_TYPE_EDGE_FALLING to IRQ_TYPE_LEVEL_LOW.
>> +	if (ret < 0) {
>> +		pci_err(pdev, "Failed to set wake IRQ: %d\n", ret);
> s/wake/WAKE#
ack.

- Krishna Chaitanya.
> - Mani
>

