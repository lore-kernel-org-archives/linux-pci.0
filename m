Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3042E7368;
	Thu, 16 Jul 2026 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203504; cv=none; b=dQUYlarU2/kHPtIh4xnHRVdzXF+v6b0d9+YMn7mqBAqNSGs0NMwqQjSRMyfEfARpdqEIjem1FgAnQ8EwTlAQHvg2Wu1DBvIr+EIFtLz+w/qYP2jF+PqFhsby61tG7mMmFpsvCFK3Wbur9TWBNX1p5uxHygqvSeaT0dTcAadiC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203504; c=relaxed/simple;
	bh=zhZnhUzgL40A0difOjRNend+Fb6KE2RX/RbELk4F2qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDggRA9iLvB1FosgjvhnVKaOgJ7l+JL3vJtWS4qz2I/LuTZgNqLNycqOOe6bsPl3LdZAw3EPtCblFa873OWQ9R3dcu2bSAB+49MtQZ+aC6jZHZWPzl0A4M6+cFHSY4D3cferRa8L1oXnTFMu8ZOTDmU9zOdggP14Ee+WF2Kbk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420D81F000E9;
	Thu, 16 Jul 2026 12:04:58 +0000 (UTC)
Message-ID: <80e9582c-9441-4d5a-9931-b77b3c359eea@tuxon.dev>
Date: Thu, 16 Jul 2026 15:04:56 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
To: Manivannan Sadhasivam <mani@kernel.org>,
 John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, john.madieu@gmail.com,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20260630141720.3938514-1-john.madieu.xa@bp.renesas.com>
 <aifual6ttxnrbi3o3lrnprwinmhvkysmebzrscoxhyhxbaqkz5@l66w7bdechqz>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <aifual6ttxnrbi3o3lrnprwinmhvkysmebzrscoxhyhxbaqkz5@l66w7bdechqz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Mani,

On 7/14/26 19:58, Manivannan Sadhasivam wrote:
> On Tue, Jun 30, 2026 at 02:17:20PM +0000, John Madieu wrote:
>> The RZ/G3E PCIe controller does not expose the standard PCIe Slot
>> Capability registers, so the generic pciehp driver cannot be used. The
>> only link-state signal the hardware provides is the DL_UpDown bit in the
>> PEIS0 event status register, which is raised on every Data Link layer
>> up/down transition.
>>
>> Enable DL_UpDown in PEIE0 and hook up an interrupt handler so the driver
>> can react to link-state changes: a device that trains after boot gets
>> enumerated, and a device that disappears on link loss is removed. This
>> provides hotplug-like behaviour without the PCI hotplug core, which is
>> unavailable for the reason above.
>>
>> On a DL_UpDown event the handler acks the W1C status bit and schedules a
>> worker that inspects PCSTAT1.DL_DOWN_STS:
>>
>>    - link up: re-run max link speed negotiation, wait for the link to
>>      settle and pci_rescan_bus() the root bus;
>>    - link down: walk the bus in reverse and
>>      pci_stop_and_remove_bus_device() each child.
>>
>> Both paths take pci_lock_rescan_remove() to serialise against the PCI
>> core.
>>
>> Link events are only acted upon once the controller is fully
>> initialised. A DL_UpDown latched while the registers are not configured,
>> for example when the event IRQ is used as a system wakeup source during
>> resume, is acknowledged but does not schedule a rescan.
> This is not correct. I don't see the patch configuring 'event IRQ' as a wakeup
> source.
> 
> Rest of the patch LGTM. If you confirm above, I can reword while applying.

John is not with Renesas anymore so I confirm on his behalf it is OK for you to 
amend it while applying.

However, I checked if this patch applies on top of next-20260715 or v7.2-rc1 and 
it doesn't on neither of these two HEADs.

I can re-base and re-send. Please let me know otherwise.

Thank you,
Claudiu
