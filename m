Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 4/5] PCI: iproc: Add iProc PCIe MSI support
To: Arnd Bergmann <arnd@arndb.de>
References: <1447806715-30043-1-git-send-email-rjui@broadcom.com>
 <20151118084845.49ba6304@arm.com> <564D27CC.3030505@broadcom.com>
 <6927787.cmOcTVpP16@wuerfel>
CC: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <564E55BB.1030708@broadcom.com>
Date: Thu, 19 Nov 2015 15:05:31 -0800
MIME-Version: 1.0
In-Reply-To: <6927787.cmOcTVpP16@wuerfel>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 11/19/2015 12:31 AM, Arnd Bergmann wrote:
> On Wednesday 18 November 2015 17:37:16 Ray Jui wrote:

>> I haven't spent too much time investigating, and am hoping to eventually
>> enable affinity support with an incremental patch in the future when I
>> have more time to investigate.
>
> Is it possible that you have a set of MSIs per GIC interrupt (as Marc
> suggested earlier) and that the way it is intended to be used is by
> having each one of them target a different CPU? That way you can do
> affinity by switching to a different MSI in .set_affinity(), I think
> that is how the old style MSI all used to work when each CPU had its
> own MSI register.
>
> 	Arnd
>

Okay, I see that Xgene MSI has a very similar implementation to support 
MSI IRQ affinity. I plan to take a closer look and try it out in the 
future. But it likely won't be included in the current round of patch set.

Thanks,

Ray
