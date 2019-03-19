Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B386FC43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 11:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9D82085A
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 11:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfCSLf4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:35:56 -0400
Received: from foss.arm.com ([217.140.101.70]:49892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfCSLfz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Mar 2019 07:35:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D00B1596;
        Tue, 19 Mar 2019 04:35:55 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33A583F614;
        Tue, 19 Mar 2019 04:35:53 -0700 (PDT)
Date:   Tue, 19 Mar 2019 11:35:48 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/9] PCI: keystone: Convert to using hierarchy domain
 for legacy interrupts
Message-ID: <20190319113548.2a5b77a7@why.wild-wind.fr.eu.org>
In-Reply-To: <737e20d6-b389-522e-7e04-a381601fb128@ti.com>
References: <20190221101518.22604-1-kishon@ti.com>
        <20190221101518.22604-4-kishon@ti.com>
        <20190221162413.GA5815@e107981-ln.cambridge.arm.com>
        <20190223121143.14c1f150@why.wild-wind.fr.eu.org>
        <4c55487d-213f-f5f5-6d67-93a417d2a0d7@ti.com>
        <867eda28qh.wl-marc.zyngier@arm.com>
        <73780998-919e-1a1c-7b8d-0bf8e33df015@ti.com>
        <20190318111635.7eab3a97@why.wild-wind.fr.eu.org>
        <737e20d6-b389-522e-7e04-a381601fb128@ti.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 19 Mar 2019 16:22:39 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

Hi Kishon,

> Hi Marc,
> 
> On 18/03/19 4:46 PM, Marc Zyngier wrote:
> > On Mon, 18 Mar 2019 11:03:07 +0530
> > Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >   
> >> Hi Marc,
> >>
> >> On 07/03/19 5:32 PM, Marc Zyngier wrote:  
> >>> On Thu, 07 Mar 2019 09:12:30 +0000,
> >>> Kishon Vijay Abraham I <kishon@ti.com> wrote:    


[...]

> >>>> It is pulse triggered at subsystem level. Quoting the TRM
> >>>> "The interrupt request signal at the PCIe SS boundary is a pulse signal that is
> >>>> triggered each time an assert interrupt message is received." The PCIe
> >>>> subsystem also has a level signal (interrupt pending signal) but the interrupt
> >>>> request signal is the one that is connected to GIC.    
> >>>
> >>> This looks completely wrong. MSIs are always edge, and legacy always
> >>> level, end of story. If your HW is any different, then it doesn't seem
> >>> to be compliant with PCI.    
> >>
> >> Agree that Legacy interrupts ought to be level-triggered. I checked this with
> >> HW team and I've copy-pasted the response.
> >>
> >> "The legacy interrupts from the PCIe controller are still level. The PCIe
> >> controller will hold the legacy interrupt lines high until a de-assert message
> >> is sent back. The pulse interrupt is only to send the interrupt from the PCIe
> >> sub-system to the SoC interrupt controller. This should not impact the
> >> operation of the legacy interrupt on the PCIe side."
> >>
> >> Looks like the interrupts are propagated multiple levels and only the last
> >> level to the interrupt controller is pulse.  
> > 
> > Let's take an example: My device (let's assume a network controller of
> > some sort) generates an interrupt. Level is high, and you observe an
> > edge. The driver handles the interrupt, but due to a race, the line
> > stays high (the device has received a new packet).
> > 
> > How is a *new* edge generated? The line never transited to low, and we
> > have more packet to process. With a level triggered interrupt, you just
> > take the interrupt again. With an edge interrupt, you need to actively
> > resample the level and retrigger the interrupt. How is this done?  
> 
> There might be an actual issue in the HW while converting from level to edge
> where new edge interrupt might not be generated in the case you just mentioned.
> I am checking this with HW folks.

There is (non-PCI) HW that does that. On EOI, they force the interrupt
controller to resample the level, which results in a new edge to be
generated if the level is high. This of course require some HW, usually
a register taking the ID of the line that needs resampling. I'd be
surprised if there wasn't something along those lines in your HW, at
least as a debug mechanism.

> Since this might take time, I'll remove this patch and resend only the MSI
> cleanup in order to make progress.

OK.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
