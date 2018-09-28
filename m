Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A034DC43143
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 21:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C94A20671
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 21:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C94A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeI2D6v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:58:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:47080 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeI2D6v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Sep 2018 23:58:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 14:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,316,1534834800"; 
   d="scan'208";a="78350984"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga006.jf.intel.com with ESMTP; 28 Sep 2018 14:33:11 -0700
Date:   Fri, 28 Sep 2018 15:35:23 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv4 08/12] PCI: ERR: Always use the first downstream port
Message-ID: <20180928213523.GA22508@localhost.localdomain>
References: <20180920162717.31066-1-keith.busch@intel.com>
 <20180920162717.31066-9-keith.busch@intel.com>
 <20180926220116.GJ28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180926221924.GA17934@localhost.localdomain>
 <20180927225625.GB18434@bhelgaas-glaptop.roam.corp.google.com>
 <20180928154220.GA21996@localhost.localdomain>
 <20180928205034.GA119911@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928205034.GA119911@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 28, 2018 at 03:50:34PM -0500, Bjorn Helgaas wrote:
> On Fri, Sep 28, 2018 at 09:42:20AM -0600, Keith Busch wrote:
> > On Thu, Sep 27, 2018 at 05:56:25PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Sep 26, 2018 at 04:19:25PM -0600, Keith Busch wrote:
> > The "first downstream port" was supposed to mean the first DSP we
> > find when walking toward the root from the pci_dev that reported
> > ERR_[NON]FATAL.
> > 
> > By "use", I mean "walking down the sub-tree for error handling".
> > 
> > After thinking more on this, that doesn't really capture the intent. A
> > better way might be:
> > 
> >   Run error handling starting from the downstream port of the bus
> >   reporting an error
> 
> I think the light is beginning to dawn.  Does this make sense (as far
> as it goes)?
> 
>   PCI/ERR: Run error recovery callbacks for all affected devices
> 
>   If an Endpoint reports an error with ERR_FATAL, we previously ran
>   driver error recovery callbacks only for the Endpoint.  But if
>   recovery requires that we reset the Endpoint, we may have to use a
>   port farther upstream to initiate a Link reset, and that may affect
>   components other than the Endpoint, e.g., multi-function peers and
>   their children.  Drivers for those devices were never notified of
>   the impending reset.
> 
>   Call driver error recovery callbacks for every device that will be
>   reset.

Yes!
 
> Now help me understand this part:
> 
> > This allows two other clean-ups.  First, error handling can only run
> > on bridges so this patch removes checks for endpoints.  
> 
> "error handling can only run on bridges"?  I *think* only Root Ports
> and Root Complex Event Collectors can assert AER interrupts, so
> aer_irq() is only run for them (actually I don't think we quite
> support Event Collectors yet).  Is this what you're getting at?

I mean the pci_dev sent to pcie_do_recovery(), which may be any device
in the topology including or below the root port that aer_irq() serviced.

> Probably not, because the "dev" passed to pcie_do_recovery() isn't an
> RP or RCEC.  But the e_info->dev[i] that aer_process_err_devices()
> eventually passes in doesn't have to be a bridge at all, does it?

Yes, e_info->dev[i] is sent to pcie_do_recovery(). That could be an RP,
but it may also be anything anything below it.

The assumption I'm making (which I think is a safe assumption with
general consensus) is that errors detected on an end point or an upstream
port happened because of something wrong with the link going upstream:
end devices have no other option, and I don't think it's possible a
bus error occurs on "virtual" busses.

The patch then assumes we should avoid sending any traffic through that
link until error recovery completes.
 
> So I can't quite figure out the bridge connection here.

I should have included RP's, or more generically "type 1 header devices".

> > Second, the first accessible port does not inherit the channel error
> > state since we can access it, so the special cases for error detect
> > and resume are no longer necessary.
> 
> When we call pcie_do_recovery(), I guess we specify a "dev" that
> logged an AER event and a pci_channel_state.  It seems a little bit
> weird to handle those separately, as opposed to incorporating into 
> the pci_dev or something.
>
> But if you're just saying that "if A is frozen because of an error,
> that doesn't mean bridges upstream from A are frozen", that makes good
> sense.

Yes. Another way to think of it is in terms of busses instead of
devices. While devices report errors, the error is because of the
bus. Paths going through that bus are considered frozen, and everything
else is not. We can safely communicate with the RP or DSP that connects
to that bus because communicating with those do not go through the
frozen bus.
