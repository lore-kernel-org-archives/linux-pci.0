Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714846;
	b=LW7Uc5fcib3nK+2dyocnC4FjA66EgfDEHN/1uGmc4/Pu3Xb2RZjLHFR3xq5j7BYsx8O6
	 /EszDbSv4vNeiRZWIvHV1oLsAQ2dY2yI/HiTxm6rOUI3i++0ZjcGdDgGyzhU+zrKDvz7A
	 X1CgX7UQ/ykJVWFucmxQkOQ+RmbWMDZFJ4RIbwdlKrhLt2Vth40LhChslJOQ9QPsluuQI
	 l0r6ptSbwkftTVRVdUKq2AW2a4YELygUQSSaBilysUQODH3l6tqYYDxV95KS6sU4Y+Lop
	 ms1wc1fzqpNhlhRT84ZDnEIxuUoQt0aTuMk2+YWKGEMhKvhfjj5Cj/qr+ZhqqsKBOvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714846;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ApPclC69wJu5EaKmPWcUZEw51FK93kFoXwnzGQ73cOU=;
	b=SJ7U6tbm/uOrpuLojpEOoggidfh8ygYnPRxtf4t5qM0y4unHQGgqNRTppdgRb2SujJ3s
	 5IKlPOh9Yw0Dl0bQeWg97K4NfuZH3K0qHv6v+CibjCugYd+gNfuwsPfXOrXy/Mx6SVrNy
	 S7P352uM0fZ+CatE2Z/d/fowOEUhYOTWiYZyUJ4chQuUGc2k4yY63TiFxM8+zuqEkNVSP
	 WhD48rBBMV1/Qaix6FvyLqeTOENk1mMqXuCyClXcRfjdnOYEBSaajYo0YTObIJYoIGtpy
	 RmnpLR37+yPfL7cGpHJgnA1StnOMP+jQy2ZwmQtItwOFPogznOf54RCd/lmlE5MJX1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMuC1qR1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643E606A31C;
	Thu, 26 Nov 2026 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMuC1qR1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3B61F000CA;
	Thu, 26 Nov 2026 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714845;
	bh=ApPclC69wJu5EaKmPWcUZEw51FK93kFoXwnzGQ73cOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nMuC1qR1i3+hoilfYdTaW/fzchw6AcBZHiPupI8Ug4LBFBIyQHybLfOHXMW1reE/g
	 nxsyuAELPczQASCQCWQpL/UOjdqcoxyR1L7iI9819YU44pMlCeweU2xj8Z22FboGKd
	 KqdmJIus57CIxEcT+F2qD2VdJa5iErN+u9sfYLAWuRgWiolZU1R9z+e1lmUzF/2lbP
	 yIAWxqtAMOBxTCMdcS5VaUNiKtr6QezcyGzFb14A2HhSU7J1q5EqJc63GUbwWZK2wu
	 CMoeyX0MMnGFztRB4wneW81BscO9kJ0zOd42+tPJtTAsJ2Q3EIPAZJBC0KsmoxpaFN
	 RXiB0ZG8Yyy5Q==
Message-ID: <2618cc81-4594-4ecb-8dda-acb3ab7fafaa@kernel.org>
Date: Thu, 26 Nov 2026 19:40:41 +0200
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/14] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 John Madieu <john.madieu.xa@bp.renesas.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-14-claudiu.beznea@kernel.org>
 <179562719476.5580.14610373538848505541.b4-reply@b4>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <179562719476.5580.14610373538848505541.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/26 19:19, Manivannan Sadhasivam wrote:
> On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
>> From: John Madieu <john.madieu.xa@bp.renesas.com>
>>
>> The RZ/G3{E, S}, RZ/V2{H(P), N} PCIe controllers do not expose the
>> standard PCIe Slot Capability registers, so the generic pciehp driver
>> cannot be used. The only link-state signal the hardware provides is the
>> DL_UpDown bit in the PEIS0 event status register, which is raised on every
>> Data Link layer up/down transition.
>>
>> Enable DL_UpDown in PEIE0 and hook up an interrupt handler so the driver
>> can react to link-state changes: a device that trains after boot gets
>> enumerated, and a device that disappears on link loss is removed. This
>> provides hotplug-like behavior without the PCI hotplug core, which is
>> unavailable for the reason above.
>>
>> On a DL_UpDown event the handler acks the W1C status bit and inspects
>> PCSTAT1.DL_DOWN_STS:
>>
>> - Link up: re-run max link speed negotiation, wait for the link to settle
>>    and rescan the root bus. To cover the case where the device is replaced
>>    or removed while the system is suspended add the
>>    rzg3s_pcie_device_replaced(). It reads the vendor ID, device ID,
>>    revision ID and class code of the device behind the root port and
>>    compares them against the values cached in the corresponding
>>    struct pci_dev, along with the Device Serial Number cached in
>>    struct rzg3s_pcie_host::con_dev_dsn, mirroring pciehp_device_replaced().
>>    If the device is detected as replaced (or no longer present),
>>    pci_dev_set_disconnected() is called for all the devices on the bus
>>    below the root port, so that the teardown of the old devices does not
>>    end up accessing the newly connected device, and the devices are then
>>    removed. If a link up/down cycle occurred while devices are on the bus
>>    (fast link transitions coalesced into a single DL_UpDown event), the
>>    devices are removed and re-enumerated even if the connected device did
>>    not change.
>> - Link down: walk the bus in reverse and pci_stop_and_remove_bus_device()
>>    each child.
>>
>> Both paths take pci_lock_rescan_remove() to serialize against the PCI
>> core.
>>
>> Link events are processed only after the controller has been fully
>> initialized.
>>
>> Add rzg3s_pcie_pm_notifier() to avoid the link event interrupt interfering
>> with the suspend/resume of the other PCIe devices in the topology, and to
>> avoid deadlocks caused by pci_dev_lock() being taken from the link event
>> handler while suspend/resume is in progress. The notifier disables the link
>> event interrupt before suspend and enables it and rescans the bus, on
>> resume, to pick up devices that may have been plugged or unplugged while
>> the system was suspended. struct rzg3s_pcie_host::started was added to
>> avoid touching the controller registers in case the resume failed.
>>
>> While at it, make probe tolerant of an absent device. Previously, if the
>> link failed to come up during rzg3s_pcie_host_setup(), probe tore the
>> controller back down and failed. Ignore the timeout returned by
>> rzg3s_pcie_wait_for_link_up(), leave the controller and refclk running,
>> and let the link-up path enumerate the device once it appears.
>>
> 
> This patch is doing too much things at once which makes it hard to follow.
 > I can easily say that you've combined 4-5 patches into one.

If doing otherwise different bits of this functionality will not work as 
expected. E.g., I you are referring to the code behind 
rzg3s_pcie_device_replaced() and/or rzg3s_pcie_pm_notifier(): these were pointed 
out by Sashiko and I tried to address them. W/o these the functionality that the 
patch tried to cover will not fully work for suspend to RAM. I tried to avoid 
sets like:

patch 1: add functionality X
patch 2: address corner case Y for functionality X

> And even worse, you
> add code to remove devices in this patch and add recovery in the next patch.

This split was requested by you in the previous review round:
https://lore.kernel.org/all/a7koqtuhya3psx7mmest3io5h775jxscivumouv64kbu23pssv@xkkqondobxui

Please let me know if I misunderstood your request.

> If
> you are recovering the link, why do you need to throw the devices away?

The controller don't support native hotplug, but has only IRQ support for link 
up/down events. The idea behind this work was to treat the IRQ link up/down 
events as hotplug events.

The .reset_root_port() was added since it was noticed that on RZ/G3S, the NVME 
connected to PCIE_SLOT don't work after a link down/up sequence w/o it.

Please let me know you thoughts on this approach.

> 
> Please split and organize the patches logically.

This is what I've tried. If you are referring to, at least 
rzg3s_pcie_device_replaced() and/or rzg3s_pcie_pm_notifier(): w/o these, the 
support won't be fully functional for suspend to RAM, as pointed by sashiko in 
the previous review rounds.

> And also take a look at the the
> issues raised by Sashiko too.
It's on my list.

Thank you for your review,
Claudiu

