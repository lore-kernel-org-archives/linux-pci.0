Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D1C43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 15:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F43206B6
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 15:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F43206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeI1WEd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:04:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:18590 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729025AbeI1WEd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Sep 2018 18:04:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 08:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="261243778"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 28 Sep 2018 08:40:09 -0700
Date:   Fri, 28 Sep 2018 09:42:20 -0600
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
Message-ID: <20180928154220.GA21996@localhost.localdomain>
References: <20180920162717.31066-1-keith.busch@intel.com>
 <20180920162717.31066-9-keith.busch@intel.com>
 <20180926220116.GJ28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180926221924.GA17934@localhost.localdomain>
 <20180927225625.GB18434@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927225625.GB18434@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 27, 2018 at 05:56:25PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 26, 2018 at 04:19:25PM -0600, Keith Busch wrote:
> > On Wed, Sep 26, 2018 at 05:01:16PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Sep 20, 2018 at 10:27:13AM -0600, Keith Busch wrote:
> > > > The link reset always used the first bridge device, but AER broadcast
> > > > error handling may have reported an end device. This means the reset may
> > > > hit devices that were never notified of the impending error recovery.
> > > > 
> > > > This patch uses the first downstream port in the hierarchy considered
> > > > reliable. An error detected by a switch upstream port should mean it
> > > > occurred on its upstream link, so the patch selects the parent device
> > > > if the error is not a root or downstream port.
> > > 
> > > I'm not really clear on what "Always use the first downstream port"
> > > means.  Always use it for *what*?
> 
> And I forgot to ask what "first downstream port" means.

The "first downstream port" was supposed to mean the first DSP we
find when walking toward the root from the pci_dev that reported
ERR_[NON]FATAL.

By "use", I mean "walking down the sub-tree for error handling".

After thinking more on this, that doesn't really capture the intent. A
better way might be:

  Run error handling starting from the downstream port of the bus
  reporting an error

I'm struggling to make that short enough for a changelog subject.

> > I'll see if I can better rephrase.
> > 
> > Error handling should notify all affected pci functions. If an end device
> > detects and emits ERR_FATAL, the old way would have only notified that
> > end-device driver, but other functions may be on or below the same bus.
> > 
> > Using the downstream port that connects to that bus where the error was
> > detectedas the anchor point to broadcast error handling progression,
> > we can notify all functions so they have a chance to prepare for the
> > link reset.
> 
> So do I understand correctly that if the ERR_FATAL source is:
> 
>   - a Switch Upstream Port, you assume the problem is with the Link
>     upstream from the Port, and that Link may need to be reset, so you
>     notify everything below that Link, including the Upstream Port,
>     everything below it (the Downstream Ports and anything below
>     them), and potentially even any peers of the Upstream Port (is it
>     even possible for a Upstream Port to have peer multi-function
>     devices?)

Yep, the Microsemi Switchtec is one such real life example of an end
device function on the same bus as a USP.


>   - a Switch Downstream Port, you assume the Port (and the Link going
>     downstream) may need to be reset, so you notify the Port and
>     anything below it
> 
>   - an Endpoint, you assume the Link leading to the Endpoint may need
>     to be reset, so you notify the Endpoint, any peer multi-function
>     devices, any related SR-IOV devices, and any devices below a peer
>     that happens to be a bridge
> 
> And this is different from before because it notifies more devices in
> some cases?  There was a pci_walk_bus() in broadcast_error_message(),
> so we should have notified several devices in *some* cases, at least.

broadcast_error_message() had been using the pci_dev that detected the
error, and it's pci_walk_bus() used dev->subordinate. If the pci_dev
that detected an error was an end device, we didn't walk the bus.
