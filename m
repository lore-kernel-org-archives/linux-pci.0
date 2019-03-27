Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12BBC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1EF2146F
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfC0LjQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:39:16 -0400
Received: from foss.arm.com ([217.140.101.70]:53156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfC0LjQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Mar 2019 07:39:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41D5E374;
        Wed, 27 Mar 2019 04:39:16 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7803F557;
        Wed, 27 Mar 2019 04:39:13 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:39:11 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     David Woodhouse <dwmw@amazon.co.uk>
Cc:     Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        vaerov@amazon.com, benh@kernel.crashing.org, alisaidi@amazon.com,
        zeev@amazon.com, ronenk@amazon.com, barakw@amazon.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v2] PCI: al: Add Amazon Annapurna Labs PCIe host
 controller driver
Message-ID: <20190327113911.GB8331@e107981-ln.cambridge.arm.com>
References: <1553512040-4453-1-git-send-email-jonnyc@amazon.com>
 <1553594455-30436-1-git-send-email-jonnyc@amazon.com>
 <20190326121727.GA4171@e107981-ln.cambridge.arm.com>
 <7bab98421e2144a934d369e49454f0424c2a3758.camel@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bab98421e2144a934d369e49454f0424c2a3758.camel@amazon.co.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 27, 2019 at 09:43:26AM +0000, David Woodhouse wrote:
> On Tue, 2019-03-26 at 12:17 +0000, Lorenzo Pieralisi wrote:
> > This code is basically identical to (apart from the string matching
> > the DBI resource)
> > 
> > drivers/pci/controller/pcie-hisi.c
> > 
> > because, as you said, that's a DW quirk that is really not
> > platform specific AFAICS.
> > 
> > Not that I am really fond of the idea but in practice we can
> > create a quirk that applies to all host controllers DW based,
> > in case they want to boot with ACPI, this patch is basically
> > code duplication.
> 
> Having chatted to Jonny in a little more detail... this isn't quite
> duplicate code. On the Annapurna implementation we have fixed the
> alignment constraints so we can just use pci_generic_config_read()
> directly instead of forcing alignment. We only need to filter out the
> "ghost" devices on bus zero.
> 
> There might eventually be scope for some form of consolidation, but it
> doesn't really seem clear at this point that it would be worth it.

The pci_ecam_ops.init function can be certainly reused but I agree
duplicating it is not a big deal either - I just noticed it and asked.

we can merge code as-is and think about writing a common init function
if/when needed.

> There are three separate quirks needed for different versions of the DW
> controller.
> 
> One is that the config space of the controller itself shows up multiple
> times in all slots of bus zero.
> 
> The second is that bus zero cannot be accessed through ECAM and must be
> accessed through a separate MMIO region.
> 
> The third is the requirement for 32-bit alignment of the host
> controller's config space (through the special MMIO region).

I missed this one - thanks for clarifying.

> Some vendors have managed to work around some of these issues, for
> example Annapurna fixing the alignment one. It looks like the three DT
> matches in pci-host-generic.c which use pci_dw_ecam_bus_ops are
> assuming the hardware suffers only issue #1 from the list above, and
> not the other two.
> 
> The Annapurna hardware gives us a new combination, and that's why it
> isn't quite a duplicate. Again, there may be scope for consolidation in
> the future but it's not clear what it should look like. Especially as
> when exposed through DT, both the hisi and al versions seem to do
> things quite differently and need their own specific code there anyway.

DT PCI host bridge bootstrap is a different story and on that
consolidation is all but impossible.

I just want to keep MCFG ECAM quirks as simple as possible, code as it
stands is horrible enough and I wish I could remove the mechanism in
the future rather than adding more to it, hopefully we are getting
there.

> There will be a DT variant of the AL driver coming in the near future,
> but when it's exposed via ACPI in the "as close to ECAM compliant as we
> could make it in this iteration of the hardware" mode, it's relatively
> simple so we did that patch first.

That's fine, no problems with that.

Thanks,
Lorenzo
