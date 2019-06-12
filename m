Return-Path: <SRS0=8YRl=UM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6D3C31E4B
	for <linux-pci@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48102063F
	for <linux-pci@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfFMRQE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:16:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:38087 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbfFLVqZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 17:46:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5CLk38d011699;
        Wed, 12 Jun 2019 16:46:04 -0500
Message-ID: <204ad129fa4098b8041e979dc2c2142a4e269802.camel@kernel.crashing.org>
Subject: Re: [PATCH/RESEND] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Date:   Thu, 13 Jun 2019 07:46:03 +1000
In-Reply-To: <20190612132730.GB13533@google.com>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
         <20190604014945.GE189360@google.com>
         <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
         <20190604124959.GF189360@google.com>
         <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
         <d53fc77e1e754ddbd9af555ed5b344c5fa523154.camel@kernel.crashing.org>
         <20190611233908.GA13533@google.com>
         <97fd2516fdde7f9f01688af426c103806f68dd2c.camel@kernel.crashing.org>
         <20190612132730.GB13533@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-06-12 at 08:27 -0500, Bjorn Helgaas wrote:
> On Wed, Jun 12, 2019 at 10:06:06AM +1000, Benjamin Herrenschmidt
> wrote:
> > On Tue, 2019-06-11 at 18:39 -0500, Bjorn Helgaas wrote:
> > > This is fine, but can we make a tiny step toward doing this in
> > > generic
> > > code instead of adding more arch-specific stuff?
> > > 
> > > E.g., evaluate the _DSM in the generic acpi_pci_root_add(), set a
> > > "preserve_config" bit in the struct acpi_pci_root, and test the
> > > bit
> > > here?
> > 
> > I'd rather have the flag in the host bridge no ?
> 
> Oh, of course, that would make more sense.

Thinking of this ... I still believe eventually the default should be
to preseve the BIOS config (see ongoing discussions about converging
everybody toward the x86 model), so the flag should be the other way
around.

I'm thinking moving PROBE_ONLY and REASSIGN_ALL_RSRC/BUS to be host
bridge flags (initially copied from the global flags).

To not break things, ARM64 would start setting that 'reassign all' by
default, then we can flip it.

> > Talking of which, look at the ongoing discussion I have with Lorenzo
> > when it comes to pci_bus_claim_resources vs. what x86 does, I'd love
> > for you to chime in. I'd like to try to consolidate things further
> > accross architectures but there might be reasons I don't see as to why
> > things are different in that area, so ...
> 
> I don't know any reasons why things are different per arch.  In most
> cases I suspect FUD.
>
> Speaking of which, *this* patch looks like FUD because it essentially
> says "Linux shouldn't change the PCI configuration on this system" but
> it offers no explanation of *why* the config needs to be preserved.  I
> would really like some note like "run-time firmware depends on the
> addresses of device X".

Oh there are a number of reasons as to why but yes, that's one of them.
I can improve the comments.

That said, I think everybody tends to agree that reassigning everything
by default isn't a great idea, so while I still need something like
this patch in asap, I'll be working towards making that stuff more
common accross archs.

My logic is that x86 is the most tested arch with the widest range of
PCI devices and broken BIOSes. So what works for x86 should work for
others (minus maybe a handful of quirks). So it doesn't make sense to
have the main resource survey logic stuck in arch/x86 and everybody
else growing different things.

Cheers,
Ben.


