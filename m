Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46001 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab2KTVOr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2012 16:14:47 -0500
Subject: Re: [PATCH 016/493] PCI: always build setup-bus when PCI is enabled
To: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 20 Nov 2012 16:14:46 -0500
Cc: gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
In-Reply-To: <CAErSpo5+wynH3LDPZbdoQVh1w1igzuMNS45hDO-69TNjQ8TLMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20121120211446.480A880133@viridian.itc.virginia.edu>
From: wfp5p@viridian.itc.virginia.edu (Bill Pemberton)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas writes:
> 
> On Mon, Nov 19, 2012 at 11:19 AM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> > CONFIG_HOTPLUG is being removed so setup-bus always needs to be built
> > as part of PCI.
> >
> > Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> > Cc: linux-pci@vger.kernel.org
> 
> These all look fine to me.  Please make the changelog subjects
> consistently capitalize the "PCI" acronym and also the first word of
> the rest, e.g., "PCI: Always ..."
> 
> If you want me to take them through my PCI tree, I can, but I assume
> Greg is going to take them through the driver core tree, and that's
> fine with me.
> 
> FWIW, I agree with Grant Likely's comments about squashing the
> devinit/devexit/etc patches.  That would be fine with me.

The plan was for them to go through Greg's driver core tree.

I'll redo the PCI related ones as you've requested and resend them.
I probably won't be able to get to it until tomorrow though.

-- 
Bill
