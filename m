Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56560 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbaHMAdz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Aug 2014 20:33:55 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so13983740pab.33
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 17:33:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <E43BF28E-A4E6-4114-81D5-A7D4C1E22D49@purestorage.com>
References: <1406933232-1560-1-git-send-email-sandeep@purestorage.com>
	<20140812213626.GA6333@google.com>
	<361417F9-AEA8-4C83-BD04-D5DD8CD4A391@purestorage.com>
	<CAA93t1rZ23dUQ4mJfLaHHdDBzEwnm=oYbv=B4fpYxuDieOapew@mail.gmail.com>
	<E43BF28E-A4E6-4114-81D5-A7D4C1E22D49@purestorage.com>
Date: Tue, 12 Aug 2014 17:33:55 -0700
Message-ID: <CAA93t1pK8b80_Yn=0J5Dxrd=hJpqMSpGK9VQALLewz7xaFSswA@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
From: Rajat Jain <rajatxjain@gmail.com>
To: Sandeep S Mann <sandeep@purestorage.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

>> Can you please send lspci -vvvv for the slot? I suspect that your
>> device has a power controller. In absense of it, the link state
>> changes would generate HP events regardless of "surprise" bit.
>
> Yes we are behind a slot with power management.
>
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Actually I was referring to the power controller for the hotplug slot
i.e. in the Slot capabilities register.

However, it is a moot point now since you mentioned that you tree is
behind the current one (these changes are present in 3.15 onwards).

Thanks,

Rajat
