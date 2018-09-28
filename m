Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BC3C43143
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 23:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCBF2073F
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 23:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KERPoUbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCBF2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeI2FyH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeI2FyG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Sep 2018 01:54:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526D4206B6;
        Fri, 28 Sep 2018 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538177283;
        bh=zHaUNTol0xkPgtVSNRdtJIPAX5a0/Gd/PpRFKy/X0Tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KERPoUbUNbG6Z406Y9sbBIee1BZnd+loDf/d4dRX1PeRvTNdoYd7KVr6Vc9MMm+dC
         oQi1dHLeXJCDutRBWb3QhS85peJKGZsRw4lV2muf6Oil+8x9TteLYzO0IIPS8JCsvB
         IzBOurL78LWF2vdLrOIkxJd1Gw7troAn2+tIQFoU=
Date:   Fri, 28 Sep 2018 18:28:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv4 08/12] PCI: ERR: Always use the first downstream port
Message-ID: <20180928232801.GB119911@bhelgaas-glaptop.roam.corp.google.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
 <20180920162717.31066-9-keith.busch@intel.com>
 <20180926220116.GJ28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180926221924.GA17934@localhost.localdomain>
 <20180927225625.GB18434@bhelgaas-glaptop.roam.corp.google.com>
 <20180928154220.GA21996@localhost.localdomain>
 <20180928205034.GA119911@bhelgaas-glaptop.roam.corp.google.com>
 <20180928213523.GA22508@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928213523.GA22508@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 28, 2018 at 03:35:23PM -0600, Keith Busch wrote:
> On Fri, Sep 28, 2018 at 03:50:34PM -0500, Bjorn Helgaas wrote:
> > On Fri, Sep 28, 2018 at 09:42:20AM -0600, Keith Busch wrote:
> > > On Thu, Sep 27, 2018 at 05:56:25PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Sep 26, 2018 at 04:19:25PM -0600, Keith Busch wrote:
> > > The "first downstream port" was supposed to mean the first DSP we
> > > find when walking toward the root from the pci_dev that reported
> > > ERR_[NON]FATAL.
> > > 
> > > By "use", I mean "walking down the sub-tree for error handling".
> > > 
> > > After thinking more on this, that doesn't really capture the intent. A
> > > better way might be:
> > > 
> > >   Run error handling starting from the downstream port of the bus
> > >   reporting an error
> > 
> > I think the light is beginning to dawn.  Does this make sense (as far
> > as it goes)?
> > 
> >   PCI/ERR: Run error recovery callbacks for all affected devices
> > 
> >   If an Endpoint reports an error with ERR_FATAL, we previously ran
> >   driver error recovery callbacks only for the Endpoint.  But if
> >   recovery requires that we reset the Endpoint, we may have to use a
> >   port farther upstream to initiate a Link reset, and that may affect
> >   components other than the Endpoint, e.g., multi-function peers and
> >   their children.  Drivers for those devices were never notified of
> >   the impending reset.
> > 
> >   Call driver error recovery callbacks for every device that will be
> >   reset.
> 
> Yes!
>  
> > Now help me understand this part:
> > 
> > > This allows two other clean-ups.  First, error handling can only run
> > > on bridges so this patch removes checks for endpoints.  
> > 
> > "error handling can only run on bridges"?  I *think* only Root Ports
> > and Root Complex Event Collectors can assert AER interrupts, so
> > aer_irq() is only run for them (actually I don't think we quite
> > support Event Collectors yet).  Is this what you're getting at?
> 
> I mean the pci_dev sent to pcie_do_recovery(), which may be any device
> in the topology including or below the root port that aer_irq() serviced.

Yep.

> > Probably not, because the "dev" passed to pcie_do_recovery() isn't an
> > RP or RCEC.  But the e_info->dev[i] that aer_process_err_devices()
> > eventually passes in doesn't have to be a bridge at all, does it?
> 
> Yes, e_info->dev[i] is sent to pcie_do_recovery(). That could be an RP,
> but it may also be anything anything below it.

Yep.

> The assumption I'm making (which I think is a safe assumption with
> general consensus) is that errors detected on an end point or an upstream
> port happened because of something wrong with the link going upstream:
> end devices have no other option, 

Is this really true?  It looks like "Internal Errors" (sec 6.2.9) may
be unrelated to a packet or event (though they are supposed to be
associated with a PCIe interface).

It says the only method of recovering is reset or hardware
replacement.  It doesn't specify, but it seems like a FLR or similar
reset might be appropriate and we may not have to reset the link.

Getting back to the changelog, "error handling can only run on
bridges" clearly doesn't refer to the driver callbacks (since those
only apply to endpoints).  Maybe "error handling" refers to the
reset_link(), which can only be done on a bridge?

That would make sense to me, although the current code may be
resetting more devices than necessary if Internal Errors can be
handled without a link reset.

Bjorn
