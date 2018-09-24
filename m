Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D2AECE561
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 10:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFE52098A
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 10:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFE52098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeIXQ1v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:27:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59669 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbeIXQ1v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 12:27:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 345F0208B1; Mon, 24 Sep 2018 12:26:26 +0200 (CEST)
Received: from windsurf (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1FD97208C7;
        Mon, 24 Sep 2018 12:26:14 +0200 (CEST)
Date:   Mon, 24 Sep 2018 12:26:14 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180924122614.70738b5c@windsurf>
In-Reply-To: <20180924101213.GO30658@n2100.armlinux.org.uk>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
        <87zhwm4kl6.fsf@tkos.co.il>
        <20180912231050.GX30658@n2100.armlinux.org.uk>
        <20180913094515.351967bb@windsurf>
        <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
        <20180913104241.65db8243@windsurf>
        <20180924101213.GO30658@n2100.armlinux.org.uk>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Mon, 24 Sep 2018 11:12:13 +0100, Russell King - ARM Linux wrote:

> > Thanks for the testing. I'll wait for Russell to say if he is happy
> > (or not) with the addition of pci_unmap_io() in the ARM code, if that's
> > the case, I'll send a proper patch to fix the issue.  
> 
> I'd prefer not to provide an unmapping API, because it gives the
> impression that it's okay to unmap the IO space mapping, and we'll
> end up with drivers that decide to call it in their cleanup path.
> IO space isn't expected to ever go away - eg, on a PC, it's always
> present.

But being able to unmap it would also be needed to be able to remove
PCI host controller drivers, and therefore compile them as module, and
make them more like any other drivers.

I'm not sure why we need to guarantee that the I/O space is always
mapped:

 - It isn't mapped before the PCI controller driver does the mapping.

 - There is no reason for it to be accessed when the PCI controller
   driver is not initialized: PCI devices can only be probed and
   initialized when the PCI controller driver is probed/initialized.

Also, in general, pci_ioremap_io() is ARM specific, and is now only
used by very few drivers:

 - Dove (Marvell platform)
 - IOP13xx
 - MV78xx0 (Marvell platform, should be moved to use pci-mvebu)
 - Orion5x (Marvell platform, should be moved to use pci-mvebu)
 - pci-mvebu
 - at91_cf

All other drivers, including on ARM, use pci_remap_iospace(), which
does provide the pci_unmap_iospace() counter part.

The only reason I have not changed pci-mvebu to use
pci_{remap,unmap}_iospace() is because it doesn't allow to change the
memory attributes.

But to me, the general direction is that the ARM-specific
pci_remap_io() API is fading away, and its replacement already provides
an unmapping capability. So why not add the same unmapping capability
to pci_remap_io() ?

> I've been toying with the idea of making pci_map_io() ignore
> subsequent attempts to overwrite the mapping with an identical
> mapping, and WARN() if there is an attempt to overwrite an existing
> mapping with other physical address, but I'm not entirely happy
> with that either (which is why I haven't responded sooner.)
> 
> At the moment, I don't have a way forward that I'm happy with for
> this.

But we have a regression and we need to fix it. Do you suggest to not
use the new pci_host_probe() API ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
