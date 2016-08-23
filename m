Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753617AbcHWTwc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Aug 2016 15:52:32 -0400
Date: Tue, 23 Aug 2016 14:52:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160823195221.GA3725@localhost>
References: <20160817213745.GE27353@localhost>
 <20160817230951.GD25146@localhost.localdomain>
 <20160818195656.GH27353@localhost>
 <20160818224610.GA28276@localhost.localdomain>
 <20160822165524.GC18628@localhost>
 <20160822211536.GE28276@localhost.localdomain>
 <20160823133913.GN18628@localhost>
 <20160823171018.GB10224@localhost.localdomain>
 <eed69a47-633b-0c0c-e5c1-663bf37a9ec3@codeaurora.org>
 <20160823192330.GA10866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160823192330.GA10866@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 03:23:31PM -0400, Keith Busch wrote:
> On Tue, Aug 23, 2016 at 01:14:03PM -0400, Sinan Kaya wrote:
> > On 8/23/2016 1:10 PM, Keith Busch wrote:
> > > It's superficially related to pciehp only because that's the only module
> > > that touches Slot Control, and this particular hardware interprets
> > > pciehp's control commands differently than the specification.
> > > 
> > > Since the hardware can't be changed, is there any guidance you can
> > > recommend we follow to appropriately fence off pciehp from attention and
> > > power indicator control? I initially attempted the least invasive method,
> > > but I'm happy to explore other possibilities.
> > 
> > Most other non-standard HW require an LED driver for hotplug in the kernel. 
> > IBM has one. It sound like you need another one.
> 
> We'd still need to fence off pciehp from LED control since it manipulates
> these in response to hot plug events handled by that driver.

Everybody probably knows this, but the problem is not with LED control
per se.  The problem is multiple writers to the Slot Control register.
Each write to Slot Control is a "command", and software is responsible
for waiting for one command to complete before writing another (see
PCIe r3.0, sec 6.7.3.2).

It's no problem to make pciehp keep its mitts off the LEDs; the
problem is if ledmon writes Slot Control for the indicators, and
pciehp writes Slot Control for some other reason at about the same
time.

Sinan has a very interesting idea...  Maybe we can work with that.
Hmm, it looks like if we have an attention indicator, we already put
an "attention" file in sysfs (see attention_write_file()).  That
should eventually call into pciehp_set_attention_status(), where we
currently only support off/on/blink states.

What if you made a quirk that replaced pciehp_set_attention_status()
with a special version that supported the extra states you need and
made ledmon use that sysfs file instead of writing Slot Control
directly?  Would everything just work?

Bjorn
