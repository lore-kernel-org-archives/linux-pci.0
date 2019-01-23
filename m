Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A2EC282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352AE2184B
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfAWTIj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:08:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:31812 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfAWTIj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jan 2019 14:08:39 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 11:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,512,1539673200"; 
   d="scan'208";a="120744894"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 23 Jan 2019 11:08:38 -0800
Date:   Wed, 23 Jan 2019 12:07:38 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alex_Gagniuc@Dellteam.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Austin.Bolen@dell.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190123190738.GC6629@localhost.localdomain>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123184453.GB6629@localhost.localdomain>
 <20190123190204.csjedbvcxkjlr43d@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123190204.csjedbvcxkjlr43d@wunner.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 08:02:04PM +0100, Lukas Wunner wrote:
> On Wed, Jan 23, 2019 at 11:44:53AM -0700, Keith Busch wrote:
> > On Wed, Jan 23, 2019 at 06:20:57PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> > > It's obvious that just relying on presence detect state is prone to race 
> > > conditions. However, if a device is replaced, we'd expect the data link 
> > > layer state to change as well. So I think the best way to proceed is to 
> > > skip the SURPRISE!!!_REMOVAL if the following are true:
> > >   * presence detect is set
> > >   * DLL changed is not set
> > >   * presence detect was not previously set
> > > 
> > > Thoughts?
> > 
> > What is the value of PDS on the Link up event? If it's still "Slot
> > Empty", could we just ignore the Link event instead and wait for the PDC
> > event?
> 
> Well, usually it's desirable to bring up the slot as quickly as possible,
> so once we get any kind of link or presence event, we immediately try to
> bring up the slot.
> 
> We do allow a 20 + 100 ms delay in pcie_wait_for_link() between link up
> and presence detect up, just not 400 ms.

Right, so in Alex's case, it looks like we are observing
pcie_wait_for_link() returning true before the PDC event.

I'm wondering about PDS because if the link is up but Presence reports an
empty slot, does that matter for any implementations? Or is it perfectly
fine to enumerate an active link on an empty slot? An empty slot and
active link doesn't make a lot of sense, but that observation appears to
be what is reported here.
