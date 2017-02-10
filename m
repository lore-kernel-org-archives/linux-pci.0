Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25013 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751990AbdBJUpd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Feb 2017 15:45:33 -0500
Date: Fri, 10 Feb 2017 15:54:45 -0500
From: Keith Busch <keith.busch@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHv6 3/5] pci: No config access for disconnected devices
Message-ID: <20170210205445.GE12778@localhost.localdomain>
References: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
 <1486495957-26177-4-git-send-email-keith.busch@intel.com>
 <20170208060410.GA1026@wunner.de>
 <20170210183852.GD12778@localhost.localdomain>
 <20170210195413.GB2243@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170210195413.GB2243@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 10, 2017 at 08:54:13PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 10, 2017 at 01:38:52PM -0500, Keith Busch wrote:
> > Didn't mean to remove the unlikely. The micro-optimization isn't in a
> > performance path, but I'll build it back in.
> 
> Only do so if you can measure the difference, otherwise it is useless,
> and can actually hurt.

Okay, that sounds good to me then, and I can't measure a difference here
in either case.

Bjorn,
What do you think? Is this series okay or any other conerncs I may
help address?

Thanks,
Keith
