Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4AFC64EB9
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 19:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413C82082A
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 19:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcgwhJ7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413C82082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJCCUX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbeJCCUX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Oct 2018 22:20:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73B8E20666;
        Tue,  2 Oct 2018 19:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538508926;
        bh=36VXcLyogTKz+YEdqcqcVp/w4KN9zY96dMsai9T/VqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcgwhJ7Sqj4v1YmBAxOTY6ZZ6zGOQyuW7WtD71h21hF/6umaI6cjDCWtmy15Qoq3K
         Pz/WLXg2ik1hfBaBBI72O8IsosRENIZ0CoMaKMbhTeHZ+hqrXSs7Zmz+94fQgOWHfZ
         lMElsMsNgAIYKb2OfKoNXXS1Mqumb2beOvZKrBbg=
Date:   Tue, 2 Oct 2018 14:35:22 -0500
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
Message-ID: <20181002193522.GB120535@bhelgaas-glaptop.roam.corp.google.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
 <20180920162717.31066-9-keith.busch@intel.com>
 <20180926220116.GJ28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180926221924.GA17934@localhost.localdomain>
 <20180927225625.GB18434@bhelgaas-glaptop.roam.corp.google.com>
 <20180928154220.GA21996@localhost.localdomain>
 <20180928205034.GA119911@bhelgaas-glaptop.roam.corp.google.com>
 <20180928213523.GA22508@localhost.localdomain>
 <20180928232801.GB119911@bhelgaas-glaptop.roam.corp.google.com>
 <20181001151450.GB22508@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001151450.GB22508@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 01, 2018 at 09:14:51AM -0600, Keith Busch wrote:
> On Fri, Sep 28, 2018 at 06:28:02PM -0500, Bjorn Helgaas wrote:
> > On Fri, Sep 28, 2018 at 03:35:23PM -0600, Keith Busch wrote:
> > > The assumption I'm making (which I think is a safe assumption with
> > > general consensus) is that errors detected on an end point or an upstream
> > > port happened because of something wrong with the link going upstream:
> > > end devices have no other option, 
> > 
> > Is this really true?  It looks like "Internal Errors" (sec 6.2.9) may
> > be unrelated to a packet or event (though they are supposed to be
> > associated with a PCIe interface).
> > 
> > It says the only method of recovering is reset or hardware
> > replacement.  It doesn't specify, but it seems like a FLR or similar
> > reset might be appropriate and we may not have to reset the link.
> 
> That is an interesting case we might want to handle better. I've a couple
> concerns to consider for implementing:
> 
> We don't know an ERR_FATAL occured for an internal reason until we read the
> config register across the link, and the AER driver historically avoided
> accessing potentially unhealthy links. I don't *think* it's harmful to
> attempt reading the register, but we'd just need to check for an "all 1's"
> completion before trusting the result.
> 
> The other issue with trying to use FLR is a device may not implement
> it, so pci reset has fallback methods depending on the device's
> capabilities. We can end up calling pci_parent_bus_reset(), which does the
> same secondary bus reset that already happens as part of error recovery.
> We'd just need to make sure affected devices and drivers have a chance
> to be notified (which is the this patch's intention).
>  
> > Getting back to the changelog, "error handling can only run on
> > bridges" clearly doesn't refer to the driver callbacks (since those
> > only apply to endpoints).  Maybe "error handling" refers to the
> > reset_link(), which can only be done on a bridge?
> 
> Yep, referring to how link reset_link is only sent from bridges.
>  
> > That would make sense to me, although the current code may be
> > resetting more devices than necessary if Internal Errors can be
> > handled without a link reset.
> 
> That sounds good, I'll test some scenarios out here.

The main point here is that we call the driver callbacks for all every
device that might be reset.  If that set of devices is larger than
strictly necessary, that's an opportunity for future optimization,
which we can defer for now.

Here's my proposal for the changelog.  Let me know what I screwed up.


commit 1f7d2967334433d885c0712b8ac3f073f20211ee
Author: Keith Busch <keith.busch@intel.com>
Date:   Thu Sep 20 10:27:13 2018 -0600

    PCI/ERR: Run error recovery callbacks for all affected devices
    
    If an Endpoint reported an error with ERR_FATAL, we previously ran driver
    error recovery callbacks only for the Endpoint's driver.  But if we reset a
    Link to recover from the error, all downstream components are affected,
    including the Endpoint, any multi-function peers, and children of those
    peers.
    
    Initiate the Link reset from the deepest Downstream Port that is
    reliable, and call the error recovery callbacks for all its children.
    
    If a Downstream Port (including a Root Port) reports an error, we assume
    the Port itself is reliable and we need to reset its downstream Link.  In
    all other cases (Switch Upstream Ports, Endpoints, Bridges, etc), we assume
    the Link leading to the component needs to be reset, so we initiate the
    reset at the parent Downstream Port.
    
    This allows two other clean-ups.  First, we currently only use a Link
    reset, which can only be initiated using a Downstream Port, so we can
    remove checks for Endpoints.  Second, the Downstream Port where we initiate
    the Link reset is reliable (unlike the device that reported the error), so
    the special cases for error detect and resume are no longer necessary.
    
    Signed-off-by: Keith Busch <keith.busch@intel.com>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Sinan Kaya <okaya@kernel.org>
