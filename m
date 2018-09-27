Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA04AC43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 22:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735BE2172A
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 22:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1dDrgot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735BE2172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeI1FRF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbeI1FRF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Sep 2018 01:17:05 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5114C21722;
        Thu, 27 Sep 2018 22:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538088986;
        bh=/W6NXH1mqrskX0MMdMveeTXymKaciiJhsfNmMEmt2sI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1dDrgoti7WHbJzWgVL9yFU+1sAFKWj6OlE5HHQBA5ImEOBn+XtBLpNoVwqOZG6+O
         G/AA+lCY72XGlt9Fvl0Pt1mYpi2g4qtS4CGnxBFAf/Uam3gmfLpEiuq9q/pyLMO/8q
         ih9mZZ2dyTPXQkcUPtOK/h5De1rL5BcVKbRA2w4k=
Date:   Thu, 27 Sep 2018 17:56:25 -0500
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
Message-ID: <20180927225625.GB18434@bhelgaas-glaptop.roam.corp.google.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
 <20180920162717.31066-9-keith.busch@intel.com>
 <20180926220116.GJ28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180926221924.GA17934@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926221924.GA17934@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 26, 2018 at 04:19:25PM -0600, Keith Busch wrote:
> On Wed, Sep 26, 2018 at 05:01:16PM -0500, Bjorn Helgaas wrote:
> > On Thu, Sep 20, 2018 at 10:27:13AM -0600, Keith Busch wrote:
> > > The link reset always used the first bridge device, but AER broadcast
> > > error handling may have reported an end device. This means the reset may
> > > hit devices that were never notified of the impending error recovery.
> > > 
> > > This patch uses the first downstream port in the hierarchy considered
> > > reliable. An error detected by a switch upstream port should mean it
> > > occurred on its upstream link, so the patch selects the parent device
> > > if the error is not a root or downstream port.
> > 
> > I'm not really clear on what "Always use the first downstream port"
> > means.  Always use it for *what*?

And I forgot to ask what "first downstream port" means.

> I'll see if I can better rephrase.
> 
> Error handling should notify all affected pci functions. If an end device
> detects and emits ERR_FATAL, the old way would have only notified that
> end-device driver, but other functions may be on or below the same bus.
> 
> Using the downstream port that connects to that bus where the error was
> detectedas the anchor point to broadcast error handling progression,
> we can notify all functions so they have a chance to prepare for the
> link reset.

So do I understand correctly that if the ERR_FATAL source is:

  - a Switch Upstream Port, you assume the problem is with the Link
    upstream from the Port, and that Link may need to be reset, so you
    notify everything below that Link, including the Upstream Port,
    everything below it (the Downstream Ports and anything below
    them), and potentially even any peers of the Upstream Port (is it
    even possible for a Upstream Port to have peer multi-function
    devices?)

  - a Switch Downstream Port, you assume the Port (and the Link going
    downstream) may need to be reset, so you notify the Port and
    anything below it

  - an Endpoint, you assume the Link leading to the Endpoint may need
    to be reset, so you notify the Endpoint, any peer multi-function
    devices, any related SR-IOV devices, and any devices below a peer
    that happens to be a bridge

And this is different from before because it notifies more devices in
some cases?  There was a pci_walk_bus() in broadcast_error_message(),
so we should have notified several devices in *some* cases, at least.

Bjorn
