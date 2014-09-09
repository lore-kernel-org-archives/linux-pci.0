Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50698 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbaIIKZD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Sep 2014 06:25:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: keystone: update to support multiple pci ports
Date: Tue, 09 Sep 2014 12:24:48 +0200
Message-ID: <5974944.bS5MvrslRo@wuerfel>
In-Reply-To: <540DD0CF.4000501@ti.com>
References: <1409938782-31460-1-git-send-email-m-karicheri2@ti.com> <5769746.NkKjYOOUiv@wuerfel> <540DD0CF.4000501@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 08 September 2014 11:52:47 Murali Karicheri wrote:
> On 09/05/2014 05:11 PM, Arnd Bergmann wrote:
> > But the driver can only do root complex mode, and we would probably
> > want a completely different driver if we were to start supporting
> > endpoint mode.
> 
> Good point! I will drop index#2 handling in the driver code and will 
> handle the same in boot loader. But I have a question though. The 
> original driver which is queued up for merge to v3.18 has index #2 for 
> this reg offset and is documented in the DT documentation as
> 
> 	index 2 is the base address and length of PCI mode configuration
> 	register.
> 	index 3 is the base address and length of PCI device ID register.
> 
> 
> Will this create any issue in terms of backward compatibility if I 
> remove it and move index3 to index2 and update the code for the same? I 
> assume since this patch also will likely be on the next branch soon, and 
> gets merged together with original driver to v3.18, this should be fine. 
> But for some reason, if this patch doesn't make to v3.18, then won't 
> this break the backward compatibility?
> 
> I think the other option is document index2 as obsolete and update the 
> document and remove the code for handling it. Any suggestion?

Since the driver is not merged into Linus' tree yet and (more importantly)
has not been in a release yet, we can still fix it. Please just send a
patch on top to remove it now, it's not too late yet.

	Arnd
