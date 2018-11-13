Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7379AC43610
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 06:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F8622507
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 06:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaQTDTk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F8622507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbeKMQBo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbeKMQBn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 11:01:43 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C26392082A;
        Tue, 13 Nov 2018 06:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542089111;
        bh=60jivwk2VRRJghB/gfheJ3jqdcJvfGnAIbrPwVvFeAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaQTDTk90y7jZX8qe4Y59WWT4ogs5DG2omIL8ktwsSi+z6+N15/yiC1iDRmS0Ts1H
         bQpKmkVA1ZM2vzCqQ4kw5Iopjc1Sj2vCm90KxqpDFEMDYloNHq09rO6Mnvhvvke0GS
         /1BdLbi8dic9ErHNtbwk2EdCfmbcqfYWHXNskKLY=
Date:   Tue, 13 Nov 2018 00:05:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20181113060510.GB182139@google.com>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <20161118232544.GI28386@localhost.localdomain>
 <20161123160906.GB16033@bhelgaas-glaptop.roam.corp.google.com>
 <20161128180214.GF2609@localhost.localdomain>
 <20161208175432.GA28827@bhelgaas-glaptop.roam.corp.google.com>
 <20161208193253.GK25959@localhost.localdomain>
 <20161212234226.GA7973@bhelgaas-glaptop.roam.corp.google.com>
 <20161213005547.GA12844@localhost.localdomain>
 <20161213205012.GA29950@bhelgaas-glaptop.roam.corp.google.com>
 <20161213231840.GD12113@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161213231840.GD12113@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 13, 2016 at 06:18:40PM -0500, Keith Busch wrote:
> On Tue, Dec 13, 2016 at 02:50:12PM -0600, Bjorn Helgaas wrote:
> > On Mon, Dec 12, 2016 at 07:55:47PM -0500, Keith Busch wrote:
> > > On Mon, Dec 12, 2016 at 05:42:27PM -0600, Bjorn Helgaas wrote:
> > > > On Thu, Dec 08, 2016 at 02:32:53PM -0500, Keith Busch wrote:
> > > > > Depending on the device and the driver, there are hundreds
> > > > > to thousands of non-posted transactions submitted to the
> > > > > device to complete driver unbinding and removal. Since the
> > > > > device is gone, hardware has to handle that as an error
> > > > > condition, which is slower than the a successful non-posted
> > > > > transaction. Since we're doing 1000 of them for no
> > > > > particular reason, it takes a long time. If you hot remove a
> > > > > switch with multiple downstream devices, the serialized
> > > > > removal adds up to many seconds.
> > > > 
> > > > Another thread mentioned 1-2us as a reasonable config access
> > > > cost, and I'm still a little puzzled about how we get to
> > > > something on the order of a million times that cost.
> > > > 
> > > > I know this is all pretty hand-wavey, but 1000 config accesses
> > > > to shut down a device seems unreasonably high.  The entire
> > > > config space is only 4096 bytes, and most devices use a small
> > > > fraction of that.  If we're really doing 1000 accesses, it
> > > > sounds like we're doing something wrong, like polling without
> > > > a delay or something.
> > > 
> > > Every time pci_find_ext_capability is called on a removed
> > > device, the kernel will do 481 failed config space accesses
> > > trying to find that capability. The kernel used to do that
> > > multiple times to find the AER capability under conditions
> > > common to surprise removal.
> > 
> > Right, that's a perfect example.  I'd rather fix issues like this
> > by caching the position as you did with AER.  The "removed" bit
> > makes these issues "go away" without addressing the underlying
> > problem.
> > 
> > We might still need a "removed" bit for other reasons, but I want
> > to be clear about those reasons, not just throw it in under the
> > general "make it go fast" umbrella.
> > 
> > > But now that we cache the AER position (commit: 66b80809), we've
> > > eliminated by far the worst offender. The counts I'm telling you
> > > are still referencing the original captured traces showing long
> > > tear down times, so it's not up-to-date with the most recent
> > > version of the kernel.
> > >  
> > > > I measured the cost of config reads during enumeration using
> > > > the TSC on a 2.8GHz CPU and found the following:
> > > > 
> > > >   1580 cycles, 0.565 usec (device present)
> > > >   1230 cycles, 0.440 usec (empty slot)
> > > >   2130 cycles, 0.761 usec (unimplemented function of multi-function device)
> > > > 
> > > > So 1-2usec does seem the right order of magnitude, and my
> > > > "empty slot" error responses are actually *faster* than the
> > > > "device present" ones, which is plausible to me because the
> > > > Downstream Port can generate the error response immediately
> > > > without sending a packet down the link.  The "unimplemented
> > > > function" responses take longer than the "empty slot", which
> > > > makes sense because the Downstream Port does have to send a
> > > > packet to the device, which then complains because it doesn't
> > > > implement that function.
> > > > 
> > > > Of course, these aren't the same case as yours, where the link
> > > > used to be up but is no longer.  Is there some hardware
> > > > timeout to see if the link will come back?
> > > 
> > > Yes, the hardware does not respond immediately under this test,
> > > which is considered an error condition. This is a reason why
> > > PCIe Device Capabilities 2 Completion Timeout Ranges are
> > > recommended to be in the 10ms range.
> > 
> > And we're apparently still doing a lot of these accesses?  I'm
> > still curious about exactly what these are, because it may be that
> > we're doing more than necessary.
> 
> It's the MSI-x masking that's our next highest contributor. Masking
> vectors still requires non-posted commands, and since they're not
> going through managed API accessors like config space uses, the
> removed flag is needed for checking before doing significant MMIO.

Sorry for digging up this ancient history, but do you remember where
this MSI-X masking with non-posted commands happens?  The masking is
an MMIO write (posted) and there should only be a non-posted MMIO read
if we use the msi_set_mask_bit() path.

I'm looking at this path:

  nvme_pci_disable
    pci_free_irq_vectors
      pci_disable_msix
        pci_msix_shutdown
          if (pci_dev_is_disconnected())    # added by 0170591bb067
            return                          # (skip hw access)
          for_each_pci_msi_entry(...)       # <-- loop
            __pci_msix_desc_mask_irq
              writel                        # <-- MMIO write
          pci_read_config_word(PCI_MSIX_FLAGS)
          pci_write_config_word(PCI_MSIX_FLAGS)
        free_msi_irqs

whih only does MMIO *writes*, which I think are posted and do not
require completion and should not cause timeouts.  That's wasted
effort, I agree, but it doesn't seem like it should be a performance
issue.

So there must be another path, probably preceding this one (since
pci_disable_msix() cleans everything up), that masks the vectors and
does the non-posted reads?

The only places we do MMIO reads are msix_program_entries(), which is
done at MSI-X enable time, and msi_set_mask_bit(), which is used in
irq_chip.irq_mask() and irq_chip.irq_unmask() methods.  But I haven't
figured out where that irq_chip path is used in a loop.

Bjorn
