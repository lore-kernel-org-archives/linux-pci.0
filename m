Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC384C43143
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 20:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DC32073F
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 20:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNQwxz9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DC32073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeI2DQH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeI2DQG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Sep 2018 23:16:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC2A206B8;
        Fri, 28 Sep 2018 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538167837;
        bh=PTLDBhoMrtkfB5of9L0203imi+DFADeGVethPQBTtHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNQwxz9hRBYseye3XFqbFLYDPBm+9iUM/Ngz2ZrZWbVt0zUhjcreKrEc/Pai7Ek8T
         FcOwAmpS47rassr+91T8PyTGuxDJn0Jrtbfa5QPmuC5yTStF7/R/QPCn5Xv3YMgg6n
         UmRLQoXKkHKQI6WfPLJdi4+9SEKcUm8Idct2BCGg=
Date:   Fri, 28 Sep 2018 15:50:34 -0500
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
Message-ID: <20180928205034.GA119911@bhelgaas-glaptop.roam.corp.google.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
 <20180920162717.31066-9-keith.busch@intel.com>
 <20180926220116.GJ28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180926221924.GA17934@localhost.localdomain>
 <20180927225625.GB18434@bhelgaas-glaptop.roam.corp.google.com>
 <20180928154220.GA21996@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928154220.GA21996@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 28, 2018 at 09:42:20AM -0600, Keith Busch wrote:
> On Thu, Sep 27, 2018 at 05:56:25PM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 26, 2018 at 04:19:25PM -0600, Keith Busch wrote:
> > > On Wed, Sep 26, 2018 at 05:01:16PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Sep 20, 2018 at 10:27:13AM -0600, Keith Busch wrote:
> > > > > The link reset always used the first bridge device, but AER broadcast
> > > > > error handling may have reported an end device. This means the reset may
> > > > > hit devices that were never notified of the impending error recovery.
> > > > > 
> > > > > This patch uses the first downstream port in the hierarchy considered
> > > > > reliable. An error detected by a switch upstream port should mean it
> > > > > occurred on its upstream link, so the patch selects the parent device
> > > > > if the error is not a root or downstream port.
> > > > 
> > > > I'm not really clear on what "Always use the first downstream port"
> > > > means.  Always use it for *what*?
> > 
> > And I forgot to ask what "first downstream port" means.
> 
> The "first downstream port" was supposed to mean the first DSP we
> find when walking toward the root from the pci_dev that reported
> ERR_[NON]FATAL.
> 
> By "use", I mean "walking down the sub-tree for error handling".
> 
> After thinking more on this, that doesn't really capture the intent. A
> better way might be:
> 
>   Run error handling starting from the downstream port of the bus
>   reporting an error

I think the light is beginning to dawn.  Does this make sense (as far
as it goes)?

  PCI/ERR: Run error recovery callbacks for all affected devices

  If an Endpoint reports an error with ERR_FATAL, we previously ran
  driver error recovery callbacks only for the Endpoint.  But if
  recovery requires that we reset the Endpoint, we may have to use a
  port farther upstream to initiate a Link reset, and that may affect
  components other than the Endpoint, e.g., multi-function peers and
  their children.  Drivers for those devices were never notified of
  the impending reset.

  Call driver error recovery callbacks for every device that will be
  reset.

Now help me understand this part:

> This allows two other clean-ups.  First, error handling can only run
> on bridges so this patch removes checks for endpoints.  

"error handling can only run on bridges"?  I *think* only Root Ports
and Root Complex Event Collectors can assert AER interrupts, so
aer_irq() is only run for them (actually I don't think we quite
support Event Collectors yet).  Is this what you're getting at?

Probably not, because the "dev" passed to pcie_do_recovery() isn't an
RP or RCEC.  But the e_info->dev[i] that aer_process_err_devices()
eventually passes in doesn't have to be a bridge at all, does it?

So I can't quite figure out the bridge connection here.

> Second, the first accessible port does not inherit the channel error
> state since we can access it, so the special cases for error detect
> and resume are no longer necessary.

When we call pcie_do_recovery(), I guess we specify a "dev" that
logged an AER event and a pci_channel_state.  It seems a little bit
weird to handle those separately, as opposed to incorporating into 
the pci_dev or something.

But if you're just saying that "if A is frozen because of an error,
that doesn't mean bridges upstream from A are frozen", that makes good
sense.

Bjorn
