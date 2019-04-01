Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA931C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 16:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C7521473
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 16:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfDAQo2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:44:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37610 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbfDAQo2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 12:44:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F248AA78;
        Mon,  1 Apr 2019 09:44:27 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B13C3F690;
        Mon,  1 Apr 2019 09:44:26 -0700 (PDT)
Date:   Mon, 1 Apr 2019 17:44:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v4 2/2] PCI: iproc: Add outbound configuration for 32-bit
 I/O region
Message-ID: <20190401164416.GA8616@e107981-ln.cambridge.arm.com>
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
 <1551415936-30174-3-git-send-email-srinath.mannam@broadcom.com>
 <20190329173515.GA10367@e107981-ln.cambridge.arm.com>
 <CABe79T7LwFLST0dwwswv8sdqHcn0T4ked5WtcNpM78XUDUN3Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABe79T7LwFLST0dwwswv8sdqHcn0T4ked5WtcNpM78XUDUN3Jw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 01, 2019 at 11:04:48AM +0530, Srinath Mannam wrote:
> Hi Lorenzo,
> 
> Please see my reply below,
> 
> On Fri, Mar 29, 2019 at 11:06 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Fri, Mar 01, 2019 at 10:22:16AM +0530, Srinath Mannam wrote:
> > > In the present driver outbound window configuration is done to map above
> > > 32-bit address I/O regions with corresponding PCI memory range given in
> > > ranges DT property.
> > >
> > > This patch add outbound window configuration to map below 32-bit I/O range
> > > with corresponding PCI memory, which helps to access I/O region in ARM
> > > 32-bit and one to one mapping of I/O region to PCI memory.
> > >
> > > Ex:
> > > 1. ranges DT property given for current driver is,
> > >     ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
> > >     I/O region address is 0x400000000
> > > 2. ranges DT property can be given after this patch,
> > >     ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
> > >     I/O region address is 0x42000000
> >
> > I was applying this patch but I don't understand the commit log and
> > how it matches the code, please explain it to me and I will reword
> > it.
> Iproc PCIe host controller supports outbound address translation
> feature to translate AXI address to PCI bus address.
> IO address ranges (AXI and PCI) given through ranges DT property have
> to program to controller outbound window registers.
> Present driver has the support for only 64bit AXI address. so that
> ranges DT property has given as 64bit AXI address and 32 bit
> PCI bus address.
> But with this patch 32-bit AXI address also could be programmed to
> Iproc host controller outbound window registers. so that ranges
> DT property can have 32bit AXI address which can map to 32-bit PCI bus address.

The code change seems to add a check for the window size, I see no
notion of 64 vs 32 bit addressing there so I am pretty sure there is
something you are not telling me that is implicit in the IProc outbound
window configuration, for instance why is the lowest index window
considered for 32-bit.

AFAICS you are adding code to allow a window whose size is < than
the lowest index in the ob_map array. How this relates to 64 vs
32 bit addresses is not clear but it should be.

When I read your commit log it is impossible to understand how it
correlates to the code you are changing - I still have not figured it
out myself.

Please explain in detail to me how this works, forget DT changes I
want to understand how HW works.

Lorenzo

> Example given in commit log is describing ranges DT property changes
> with and without this patch.
> In the case, without this patch AXI address is more than 32bit
> "0x400000000". and with this patch AXI address is 32-bit "0x42000000".
> PCI bus address is 32 bit address in both the cases "0x40000000" and 0x42000000.
> 
> Regards,
> Srinath.
> > Thanks,
> > Lorenzo
> >
> > > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > > Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > > ---
> > >  drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > > index b882255..080f142 100644
> > > --- a/drivers/pci/controller/pcie-iproc.c
> > > +++ b/drivers/pci/controller/pcie-iproc.c
> > > @@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> > >                       resource_size_t window_size =
> > >                               ob_map->window_sizes[size_idx] * SZ_1M;
> > >
> > > -                     if (size < window_size)
> > > -                             continue;
> > > +                     /*
> > > +                      * Keep iterating until we reach the last window and
> > > +                      * with the minimal window size at index zero. In this
> > > +                      * case, we take a compromise by mapping it using the
> > > +                      * minimum window size that can be supported
> > > +                      */
> > > +                     if (size < window_size) {
> > > +                             if (size_idx > 0 || window_idx > 0)
> > > +                                     continue;
> > > +
> > > +                             /*
> > > +                              * For the corner case of reaching the minimal
> > > +                              * window size that can be supported on the
> > > +                              * last window
> > > +                              */
> > > +                             axi_addr = ALIGN_DOWN(axi_addr, window_size);
> > > +                             pci_addr = ALIGN_DOWN(pci_addr, window_size);
> > > +                             size = window_size;
> > > +                     }
> > >
> > >                       if (!IS_ALIGNED(axi_addr, window_size) ||
> > >                           !IS_ALIGNED(pci_addr, window_size)) {
> > > --
> > > 2.7.4
> > >
