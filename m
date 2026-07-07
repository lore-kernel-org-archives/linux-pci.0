Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8CF3FA5F1
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426135; cv=none; b=MKmxBTGzHJ77kQHcNqdJ787SQJTEWUeZEmmrC42KTqPmbYtqDXdSg08Z2RLxshIMWhpCO9Hj1LPoC7Ry/32gMxNYYbTgODvxTku/LL1JtOYDsIxyvE3y5gg6d2gZXiLmaudbg9dCjaGLgMPqGO9AWwmiM/bov6apEqHJBcoMJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426135; c=relaxed/simple;
	bh=FE4Q4J59n//A4uFc3yN4qYGca9bvrf4i7h16gvytKXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS6xy099Zmfu2Camw/k5zhpOpxsRA5rlqbZY5wlHAiVYI99sKXhhdDgEw5ajz9HX9gYyiHgHJblC6W2c5s4bgSzfyR2/1YZSU9V75qWjnWq31mCUqDdLw8134WSDM/1XBbuUuczqYLC/R/B6NWcU7qlc2JhEyIz0KVCp5/Fd8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mK5onVF6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U6x6s3Xu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mK5onVF6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U6x6s3Xu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667C8pq03749131
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 12:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+22W3zxkIQEX0DVYt9xjZ+Fp+yJcU7xn5AILKh1DvgQ=; b=mK5onVF6LMrDIT0f
	460oV7k/TtZ/UeTVRCkuW830fKv2OHsxoj/qUvjGeIgf+fcH6oEhDHz+H7LGVoU0
	IjsFJGzI9ph3D4D3EcMxb6NLm263QmRxVS6GDd97BxaQygZO/BRNCnfocs+37Pqj
	oxGYges4Zaq7GbRNmo2ijPf1Bsc2s7dWbyGwz8fWDy8aSdgsV1HDqqqKPBfyw4Hv
	LD1g90JB+Y139LW7+qgduEMbv5835t7H1kQrfgAzjGa6g3xhGAkWh1S27UU/9Bcc
	Mcd2Jx992+0nrE9si98KEMHnFAvqxQNsm1KPU1/Q9QxFIv1M4MhLLwGhXFsIeFPD
	Ca+RdQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdj99su-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 12:08:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8952346bb9so3705472a12.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783426132; x=1784030932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+22W3zxkIQEX0DVYt9xjZ+Fp+yJcU7xn5AILKh1DvgQ=;
        b=U6x6s3XuxB8N+DmEmv1XaBa5F6wEYdjkLTt1wOJmViRPHf1ypbPJwcCQhUNILLZo87
         btAPH64VMNtJmyVbQYA4DD0JnVkhx+9gglOVmeIY6U65Rxy6pu4Cin41E6oNdWwoOwqT
         zHSnwZz56icfat64cY9jjemSU1Vxxb2ZhaofPJO2At1/ATo+SXLlXfbF20Y/kxPmohr1
         WB0j2bK3qgHU5PU8hXUjvuRB1+jPU+BkhWKZpWuTbFAUzjUFflmrhx0g4IrwPbUzHwD+
         usJD+uQ1xchqMPJ9ZmzIPcCLqodcHwaVnlcmGggB6ty/kP8jkZ6aHoFadQbXoBzDUCsj
         Xfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783426132; x=1784030932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+22W3zxkIQEX0DVYt9xjZ+Fp+yJcU7xn5AILKh1DvgQ=;
        b=YRYEpvmN6qDOj5R2V+8hO1wF+FgGstr+dw7AZLUi+znkvIfxuB5E0663cxztC7L8QU
         gYIy10paEi2chDwNflRXUMA9R8Cm1HYygoL6EAfu31xIZYTAMRqAvQ9payHsSatm1f86
         UNtwpqtasKe2/V5kfjsjs9SwO5VG5eLk/OjLDEpQ/pjwkmSDHHwMsQvlx4V9xsm378rN
         Lh1cAXkupVfs9SrGzikAhQpLZ9I0crWKzgi1pVfqR1LJ9YHAxISo/OvqmgOSdATiHCaJ
         NGCUtlsdmbHD2FxHcX5yeHK1NSXcpxtgtWdItOTNGFPbnM1bvHvOKM22mjP5Q/5oVwH4
         a7Iw==
X-Gm-Message-State: AOJu0YwWiuzRSGAyFRz1bnk1EkhQt6SCZ/OH+5GPPB5bz1K8qseYTpmr
	k6BmTGCl+dqZ1mQ/CXHiUKySL3mdbFGp8MRUGN2NS1fQuLCJ2EmUDR1o1M/NPhpSJXvhRCMBE6p
	e96ldO+Ls/DIRNAFf6bpA7T44lTugrIIPEEaWm6Ld3paP/A1E9UuMO5Tjv/LYYag=
X-Gm-Gg: AfdE7cnYAD90Bz43N59eTnxFlcSprINH/aX24WcZaqtIGAVrGC+Kg1J2hULO61np/A5
	bnuTL1MUvqK6ux3GLWzFoSqovOT6GmfZsqHPkWLvgB1E5u/srtHsWBHK1nNvfl+HNL2AELxOlgm
	yKau0OiqkTVpz1Nbv2gBeK1ggb/84/GI1xjL1aYBTiKm+jXyPmTAeigBG4UOx+bF7ZTHJOeB4/x
	Iu5EPPNrTzjvcqb3O9dOmpvqmUfcSJnomXucLvKniANJySuaeHZ9VmUbs3xEoxeTqPJaV4032f3
	Tp3f/RceWSyxXcQsqeSMbnyvawhQAY8dGRT3PpHiUsDAaq9Zt8PSOWdQc209N4Zs1xpUNTs1A7z
	k4vpYIm7BxoIa7fTdE0QZkdm3OZPjLN+CnOWvQZuj1ub/
X-Received: by 2002:a05:6a20:d74c:b0:3bf:ab76:63d with SMTP id adf61e73a8af0-3c08ec8256emr6016567637.11.1783426131638;
        Tue, 07 Jul 2026 05:08:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:d74c:b0:3bf:ab76:63d with SMTP id adf61e73a8af0-3c08ec8256emr6016526637.11.1783426130986;
        Tue, 07 Jul 2026 05:08:50 -0700 (PDT)
Received: from [10.92.203.183] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3a2bf6bsm885732a12.27.2026.07.07.05.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 05:08:50 -0700 (PDT)
Message-ID: <6b526e3f-6cb9-4628-8569-f39088b38246@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 17:38:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12] PCI: Add support for PCIe WAKE# interrupt
To: sashiko-reviews@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org
References: <20260707-wakeirq_support-v12-1-b4453f5bcc97@oss.qualcomm.com>
 <20260707114648.60A091F000E9@smtp.kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260707114648.60A091F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4cec54 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=qWxXvflXNDPLj3OyKCUA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: LfM217Irk6Rovb6YkSJRIVu3Jzp6KijJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDExOCBTYWx0ZWRfX5iMIsIUT1Pfv
 dSaiCmVHS4vXuxazyQmHFmZnqyvoUSPrpzWmkrLM8jolApgTH3rTciouUu+xqh2vsBeEU9H6fsn
 +5vL8xHjJOH/TVNgfhjkdqhSvv9kTdEpMjRsdUocBg4k/o4zrAqHVfcVXtV2bfXorHjWvThoGZP
 Zko4FlMFr02P3htaXCWLzAaUxX1TlrskPKYRY77DUuTVuId0knGclHD0SxQ3uELxhxLhIfm1R5d
 bICofUzq/4ruz/PLDb3PyKA/70C+bZDink6f1oUH+l3JkeASbxkee1Nc4sbZOvlTYyT7PW1ai2M
 OkCODlKtPG80fJ3vIxQ4WeeoSGpDKNrWkb7ax9KNSKbD1TCEWBGCsIslACZtW8fIT2NUJCqLKDQ
 kFcu8MRd6W/7WW0tRG0eEsyTZkEDdElxnYPQLGzDy9yxSPZ1XHy2xcl1GETEhWPJjIpZ87yEibF
 ZEMkrDW1ToCUA30+RPA==
X-Proofpoint-ORIG-GUID: LfM217Irk6Rovb6YkSJRIVu3Jzp6KijJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDExOCBTYWx0ZWRfXwsB9rneDx2wy
 B4KvhosBSc61ZLSW4hj9fOB8bupoU4bEmmzpkgJ8mTQwl1S4uARDAuHZ3/55Bgjj948t3pyu4Ew
 TKIMDJnrkJKRYBzXcgHy/eITG/2OYTw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070118

On 7/7/2026 5:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Exclusive allocation of a shared WAKE# GPIO breaks wakeup capability for remaining devices if the first device is hot-removed.
> - [High] The IRQ trigger type is configured after requesting the wake IRQ, causing the request to fail on irqchips requiring a trigger type.
> - [High] Incorrect resource lifecycle check in `pci_remove_of_wake_gpio()` causes GPIO and IRQ leaks if the OF node is detached.
> - [Medium] Unconditional system wakeup enablement bypasses standard PCI PM policy.
> - [Medium] Unchecked return value of `device_init_wakeup()` can leave the device in a half-configured state.
> --
>
> --- Patch [1]: [PATCH v12] PCI: Add support for PCIe WAKE# interrupt ---
> commit 788f29e12a6c04e2d11d2db4e00c40903e8d0022
> Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Subject: PCI: Add support for PCIe WAKE# interrupt
>
> This commit adds support for the PCIe WAKE# mechanism in the PCI core.
> It searches for a WAKE# GPIO described in the device tree for the endpoint
> or bridge, registers a dedicated wake IRQ, and handles waking the device
> from low power states to an active state.
>
> Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
> Link: https://github.com/devicetree-org/dt-schema/pull/170
>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 8b18c4ba845cf..5df6b11cdf9f9 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
> [ ... ]
>
>> @@ -586,6 +588,82 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>>  	return irq_create_of_mapping(&oirq);
>>  }
>>  EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
>> +
>> +static void pci_configure_wake_irq(struct pci_dev *pdev, struct gpio_desc *wake)
>> +{
>> +	int ret, wake_irq, irq_type;
>> +
>> +	wake_irq = gpiod_to_irq(wake);
>> +	if (wake_irq < 0) {
>> +		pci_err(pdev, "Failed to get wake irq: %d\n", wake_irq);
>> +		return;
>> +	}
>> +
> [ ... ]
>
>> +	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, wake_irq);
>> +	if (ret < 0) {
>> +		pci_err(pdev, "Failed to set WAKE# IRQ: %d\n", ret);
>> +		return;
>> +	}
>> +
>> +	irq_type = gpiod_is_active_low(wake) ? IRQ_TYPE_LEVEL_LOW :
>> +						IRQ_TYPE_LEVEL_HIGH;
>> +	ret = irq_set_irq_type(wake_irq, irq_type);
> [Severity: High]
> Does this attempt to configure the IRQ trigger type too late?
>
> If the irqchip requires a valid trigger type during IRQ allocation,
> calling dev_pm_set_dedicated_wake_irq() before irq_set_irq_type() will fail.
> This is because dev_pm_set_dedicated_wake_irq() calls request_threaded_irq()
> without IRQF_TRIGGER_MASK flags, resulting in an -EINVAL return.
>
> Should the trigger type be configured before requesting the wake IRQ?
This is not valid for device tree case. This code will be executed for device tree
models only.
>> +	if (ret < 0) {
>> +		dev_pm_clear_wake_irq(&pdev->dev);
>> +		pci_err(pdev, "Failed to set irq_type: %d\n", ret);
>> +		return;
>> +	}
>> +
>> +	device_init_wakeup(&pdev->dev, true);
> [Severity: Medium]
> Does unconditionally enabling system wakeup here bypass standard PCI power
> management policy?
>
> Standard PCI policy, as seen in pci_pm_init(), makes devices wakeup-capable
> but leaves the enablement decision to user-space. Setting this to true
> unconditionally might lead to unexpected battery drain or spurious wakeups.

if the client driver wants to enable wakeup IRQ, and if the WAKE# is described for
root port only, then we can't ask client driver to enable root port device wake up
capability and in suspend noirq we are not allowed to enable wakeirq, so we
are enabling here.

> [Severity: Medium]
> What happens if device_init_wakeup() fails?
>
> If it returns an error such as -ENOMEM when allocating the wakeup source,
> dev->power.should_wakeup remains false. This leaves the device with a
> dedicated wake IRQ requested but system wakeup disabled.
>
> The PM core will then never enable the wake IRQ via
> dev_pm_enable_wake_irq_check() during system suspend.
>
> Should this check the return value and unroll the wake IRQ registration on
> failure?
>> +}
>> +
>> +void pci_configure_of_wake_gpio(struct pci_dev *dev)
>> +{
>> +	struct device_node *dn = pci_device_to_OF_node(dev);
>> +	struct gpio_desc *gpio;
>> +
>> +	if (!dn && !dev->wake)
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
> [Severity: High]
> How does this exclusive GPIO acquisition handle hot-removal of shared wake
> lines?
>
> If multiple PCI devices share a WAKE# GPIO in the device tree,
> fwnode_gpiod_get() grants exclusive access to the first probed device.
> Subsequent devices receive -EBUSY and skip wake IRQ setup.
>
> If the first device is later hot-removed or unbound,
> pci_remove_of_wake_gpio() frees the GPIO and deregisters the wake IRQ.
>
> This leaves the remaining active devices with no wake IRQ registered and
> no way to acquire it, breaking their ability to wake the system.
>
> Can this be handled to avoid permanent loss of wakeup capability for the
> remaining devices?
In this scenarios, ideally bridge also share same WAKE# gpio, so if the bridge is
removed below device will also get removed and bridge is one which gets
discovered first and bridge will get the gpio first.
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
> [Severity: High]
> Does checking the OF node pointer here cause resource leaks if the node
> is detached?
>
> During device teardown, pci_stop_dev() executes before pci_destroy_dev().
> If the device's OF node was dynamically created (common in PCI hotplug with
> device tree overlays), pci_stop_dev() calls of_pci_remove_node(), which
> clears dev->dev.of_node.
>
> When pci_destroy_dev() later calls pci_remove_of_wake_gpio(), this early
> return will bypass the gpiod_put() and dev_pm_clear_wake_irq() calls because
> the OF node was already cleared.
>
> Should this check for the presence of the resource itself via
> if (!dev->wake) instead of the OF node pointer?
Will the dynamically created of nodes will include the wake gpios & perst gpios ?

- Krishna Chaitanya.
>> +
>> +	device_init_wakeup(&dev->dev, false);
>> +	dev_pm_clear_wake_irq(&dev->dev);
>> +	gpiod_put(dev->wake);
>> +	dev->wake = NULL;
>> +}

