Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46827 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbcFATEf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Jun 2016 15:04:35 -0400
Date: Wed, 1 Jun 2016 14:04:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/3] pci: introduce read_bridge/write_bridge pci ops
Message-ID: <20160601190430.GA19546@localhost>
References: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
 <20160601150929.GA13882@localhost>
 <4890460.9IGW89muCc@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4890460.9IGW89muCc@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 01, 2016 at 05:41:53PM +0200, Arnd Bergmann wrote:
> On Wednesday, June 1, 2016 10:09:29 AM CEST Bjorn Helgaas wrote:
> > Hi Arnd,
> > 
> > On Wed, Jun 01, 2016 at 02:31:22PM +0200, Arnd Bergmann wrote:
> > > A lot of PCI host bridges require different methods for initiating
> > > type 0 and type 1 config space accesses, leading to duplication of
> > > code.
> > > 
> > > This adds support for the two different kinds at the pci_ops
> > > level, with the newly added map_bridge/read_bridge/write_bridge
> > > operations for type 1 accesses.
> > > 
> > > When these are not set, we fall back to the regular map_bus/read/write
> > > operations, so all existing drivers keep working, and bridges that
> > > have identical operations continue to only require one set.
> > 
> > This adds new config accessor functions to struct pci_ops and makes
> > the callers responsible for figuring out which one to use.  The
> > benefit is to reduce code duplication in some host bridge drivers
> > (DesignWare and MVEBU so far).
> > 
> > From a design perspective, I'm not comfortable with moving this burden
> > from the host bridge drivers to the callers of the config accessors.
> ...

> Maybe we can simply change them to use the normal API and come up with
> a way to make the pci_ops harder to misuse? Would it make you feel better
> if we also renamed .read/.write into .read_type0/.write_type0 or something
> like that?

I'm trying to get a better feel for the tradeoff here.  It seems like
an API complication vs. code duplication.

I don't really think the callers should have to figure out which
accessor to use.  How much of a benefit do we really gain by
complicating the callers?  We've managed for quite a few years with
the current scheme, and it seems like only a couple new ARM platforms
would benefit.

Bjorn
