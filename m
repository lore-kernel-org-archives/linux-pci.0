Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09B4DD6DB;
	Tue, 14 Jul 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048242; cv=none; b=CVUPvvSTiYSlJOQvGW8WkWKY94+iObWX3agZIcESKifwBmk0ZWY6/PImo5AYjBG6NESJ0N4DJAYOFH/9phi2LKzz9jdD/xdYDs/0H4/CIMna3fIVeWEd4BTSa5ElMhgwpA04OioWp/kIxdP6IrWjEmJtlvGBihBOJMToPNip3g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048242; c=relaxed/simple;
	bh=sY2tl84JejcmJYBseZy3zgZ0sNWjGsiO/e6ANhpg3go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFK9KuLb1Rhd3/7P+aeGmDmhDFIxcnP13EntUtcv53Ej15D4LX17ss308g/7WUE7nAogSLAp/hpn+MxjOEUVhKSZVPe3SpAgE1WJJv/qywV/R+Z3dt9CARZ9+HsDQsyeCK7OfKFB1yycrhZd5Htreby123mt3jFLTpUYPMuOrqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=wXD8NEDs; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="wXD8NEDs"
Message-ID: <76243051-e391-45d2-b47a-d4a904f0a36f@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1784048232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElhmPfVqBToQ9P063X0Nq/IxRb7L6/7x/Xi/WmPp8q8=;
	b=wXD8NEDs6UrKZDXX4nd5fYxC/7tBzufTuVhWqv8zYjnFqy5Q2LeX1zJB0H/vQ1BiRrWQDV
	9PIla8gaoYKbb2W9MT+o0bAUg+tQ7ia6DaIjgLVCqBn9vmYuM8tmpu6jioeEVzSsyVxH2x
	UYU6EfIakwLmTnKBtexaM7af2+KxcCc=
Date: Tue, 14 Jul 2026 18:57:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] PCI: apple: Integrate pwrctrl API
To: Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: Yureka Lilian <yureka@cyberchaos.dev>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20260707-apple-pcie-pwren-v1-0-5a281b182fe2@cyberchaos.dev>
 <20260707-apple-pcie-pwren-v1-1-5a281b182fe2@cyberchaos.dev>
 <86a4s3p2vy.wl-maz@kernel.org>
 <8a80a170-a508-4a9e-8090-27cfcedb1cd4@cyberchaos.dev>
 <865x2qq4ts.wl-maz@kernel.org>
 <jqaxvdaxfpm5g3tdwdqpuk2ubkwim6ckmlblocvakloqishvmm@c5ofbdbdj7lf>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <jqaxvdaxfpm5g3tdwdqpuk2ubkwim6ckmlblocvakloqishvmm@c5ofbdbdj7lf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/9/26 14:29, Manivannan Sadhasivam wrote:
> On Tue, Jul 07, 2026 at 02:58:39PM +0100, Marc Zyngier wrote:
>> On Tue, 07 Jul 2026 13:04:21 +0100,
>> Yureka Lilian <yureka@cyberchaos.dev> wrote:
>>> On 7/7/26 11:25, Marc Zyngier wrote:
>>>> On Mon, 06 Jul 2026 23:38:27 +0100,
>>>> Yureka Lilian <yureka@cyberchaos.dev> wrote:
>>>>> Integrate the PCI pwrctrl framework into the Apple PCIe host driver to
>>>>> provide standardized power management for PCI devices.
>>>>>
>>>>> Notably, this allows enabling powering on the WiFi, SD card reader on
>>>>> various Macs by means of the pwrctrl framework before probing the ports.
>>>>>
>>>>> Previously, a custom solution for powering on the WiFi and SD card
>>>>> reader was proposed[1], but we can now use the new pci-pwrctrl-generic
>>>>> driver for this purpose.
>>>>>
>>>>> Link[1]: https://lore.kernel.org/lkml/20220502093832.32778-4-marcan@marcan.st/
>>>>>
>>>> nit: this paragraph and the accompanying link don't belong in the
>>>> commit message and should be moved below the --- mark or even better,
>>>> to the cover letter.
>>> ack, will leave it out of the commit message of the individual commit in v2
>>>>> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
>>>>> ---
>>>>>    drivers/pci/controller/Kconfig      |  1 +
>>>>>    drivers/pci/controller/pcie-apple.c | 16 ++++++++++++++++
>>>>>    2 files changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>>>>> index 2247709ef6d6..af64630d28fa 100644
>>>>> --- a/drivers/pci/controller/Kconfig
>>>>> +++ b/drivers/pci/controller/Kconfig
>>>>> @@ -46,6 +46,7 @@ config PCIE_APPLE
>>>>>    	depends on OF
>>>>>    	depends on PCI_MSI
>>>>>    	select PCI_HOST_COMMON
>>>>> +	select PCI_PWRCTRL_GENERIC
>>>>>    	select IRQ_MSI_LIB
>>>>>    	help
>>>>>    	  Say Y here if you want to enable PCIe controller support on Apple
>>>>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
>>>>> index c2cffc0659f4..db038a9d4831 100644
>>>>> --- a/drivers/pci/controller/pcie-apple.c
>>>>> +++ b/drivers/pci/controller/pcie-apple.c
>>>>> @@ -30,6 +30,7 @@
>>>>>    #include <linux/msi.h>
>>>>>    #include <linux/of_irq.h>
>>>>>    #include <linux/pci-ecam.h>
>>>>> +#include <linux/pci-pwrctrl.h>
>>>>>      #include "pci-host-common.h"
>>>>>    @@ -825,6 +826,21 @@ static int apple_pcie_init(struct
>>>>> pci_config_window *cfg)
>>>>>    	if (WARN_ON(!pcie))
>>>>>    		return -ENOENT;
>>>>>    +	ret = pci_pwrctrl_create_devices(pcie->dev);
>>>>> +	if (ret) {
>>>>> +		dev_err(pcie->dev, "Failed to create pwrctrl devices: %pe\n", ret);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	ret = pci_pwrctrl_power_on_devices(pcie->dev);
>>>>> +	if (ret) {
>>>>> +		if (ret != -EPROBE_DEFER) {
>>>>> +			dev_err(pcie->dev, "Failed to power on devices: %pe\n", ret);
>>>>> +			pci_pwrctrl_destroy_devices(pcie->dev);
>>>>> +		}
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>> Why is this done globally while the whole driver works on a per-port
>>>> basis, and that the proposed DT updates are also per port?
>>> pci_pwrctrl_power_on_devices takes a struct device as parameter, but
>>> pcie-apple does not allocate device structs for the individual ports.
>>> This could be changed of course. But since pci_pwrctrl_* operate on
>>> the subnodes recursively, it works just fine this way.
>> Works fine is one thing. Being consistent with the way the rest of the
>> driver works is another. pci_pwrctrl_create_device() and
>> pci_pwrctrl_power_on_device() appear to do exactly what would be
>> required for a single port. They just needs to be exported made
>> global/exported.
>>
> I'm fine with exporting pci_pwrctrl_create_device() and
> pci_pwrctrl_power_on_device() and calling them with per-port np.
>
> - Mani

In theory I do agree this would work to power on the slots, and I can 
send a v2 of the patch doing it that way, but I don't quite understand 
yet how this fits better with the existing driver code: If this is the 
case, what is the difference between pcie-apple and pcie-qcom and why 
should pcie-qcom use the recursive function but pcie-apple not?


Thanks,

— Yureka

