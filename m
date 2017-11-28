Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbdK1KAh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Nov 2017 05:00:37 -0500
Subject: Re: [PATCH 01/10] genirq: Export irq_set_msi_desc()
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, rjw@rjwysocki.net,
        vidyas@nvidia.com, kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
 <1511538800-8275-2-git-send-email-mmaddireddy@nvidia.com>
 <alpine.DEB.2.20.1711250050520.2316@nanos>
 <600a7b65-670e-b164-913c-99e18ae593d2@nvidia.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <be79bf6f-b24a-6292-5eb1-3bcf97890421@arm.com>
Date: Tue, 28 Nov 2017 10:00:32 +0000
MIME-Version: 1.0
In-Reply-To: <600a7b65-670e-b164-913c-99e18ae593d2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 25/11/17 19:41, Manikanta Maddireddy wrote:
> 
> 
> On 25-Nov-17 5:25 AM, Thomas Gleixner wrote:
>> On Fri, 24 Nov 2017, Manikanta Maddireddy wrote:
>>
>> Please CC the proper mailing list for irq related changes.
>>
>>> PCI bus support MSI interrupts, allow PCI host driver to set MSI descriptor
>>> data for an irq.
>>
>> This is not really an explanation why this export is needed.
>>
>> Thanks,
>>
>> 	tglx
>>
> Updated the commit log with why Tegra PCIe driver is using this function in V2.
> Please review.

Well, to review it, I would like to be on Cc.

My current position on this is that if you need to export this function,
then you're using a deprecated API, and you should instead consider
moving to the generic MSI model, which doesn't need any of this.

I've done that a distant past, but never actually published the patch
(not tested it):

https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/kill-msi-controller&id=83b3602fcee7972b9d549ed729b56ec28de16081

But without seeing the patches, I may be barking up the wrong tree...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
