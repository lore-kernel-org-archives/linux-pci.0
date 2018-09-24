Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4978C433F4
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 12:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAB720842
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 12:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAB720842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeIXSsk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:48:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34610 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbeIXSsj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 14:48:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61F5E18A;
        Mon, 24 Sep 2018 05:46:40 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA2243F5BD;
        Mon, 24 Sep 2018 05:46:38 -0700 (PDT)
Date:   Mon, 24 Sep 2018 13:46:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jan Kundr??t <jan.kundrat@cesnet.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180924124620.GA10322@e107981-ln.cambridge.arm.com>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
 <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
 <20180924101213.GO30658@n2100.armlinux.org.uk>
 <20180924122614.70738b5c@windsurf>
 <20180924111341.GP30658@n2100.armlinux.org.uk>
 <20180924141203.3df9707a@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924141203.3df9707a@windsurf>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 24, 2018 at 02:12:03PM +0200, Thomas Petazzoni wrote:

[...]

> > Trying to address a regression with further development means that
> > _that_ development needs thought and review, which is a slower
> > process.
> > 
> > I do understand the desire to keep moving forward and never take a
> > step backwards, but sometimes backwards steps are the best way to
> > resolve a regression.  But I also do appreciate that a simple revert
> > in this case is not possible.
> 
> Well, I can revert:
> 
> 42342073e38b50113354944cd51dcfed28d857a1 PCI: mvebu: Convert to use
> pci_host_bridge directly ee1604381a371b3ea6aec7d5e43b6e3f5e153854 PCI:
> mvebu: Only remap I/O space if configured
> 
> so it's not a big deal either. I can revert those, and then resubmit a
> more complete series later on that moves pci-mvebu to use
> pci_remap_iospace().
> 
> > I'll accept your patch on the condition that the ARM private
> > pci_ioremap_io() will go away in the very near future (please _try_
> > to get agreement on that before this patch is merged.)
> 
> Bjorn, Lorenzo, what do you prefer ? 
> 
> If we want to get rid of pci_ioremap_io(), then we need a way to tell
> pci_remap_iospace() the memory attributes that should be used for the
> mapping, because on Armada 38x, we need to map the I/O space mapped
> MT_UNCACHED instead of MT_DEVICE. I'm not sure how to achieve this yet.
> Should pgprot_device() be changed to return MT_UNCACHED on a
> platform-specific basis ? Any other idea ?

I think we should address Russell's concern, he has more insights into
code that predates the PCI host developments.

What I think you can do short term, given that AFAICS MVEBU is not
removable, instead of using pci_host_probe() you move part of its code
into the driver and make sure that you remap IO as last operation before
probe completion (ie after scanning the host bridge) so that you do not
need to unmap it on failure; write a commit log summarising/linking this
thread please and when v4.20 lands we will give this a more thorough
look as Russell requested.

How does that sound ?

Thanks,
Lorenzo
