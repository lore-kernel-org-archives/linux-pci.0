Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63730 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751918AbaBRSpA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 13:45:00 -0500
Date: Tue, 18 Feb 2014 18:44:20 +0000
From: Will Deacon <will.deacon@arm.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140218184420.GD2010@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <1392726043-31088-4-git-send-email-will.deacon@arm.com>
 <20140218182142.GF29304@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140218182142.GF29304@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 18, 2014 at 06:21:42PM +0000, Jason Gunthorpe wrote:
> On Tue, Feb 18, 2014 at 12:20:43PM +0000, Will Deacon wrote:
> > +
> > +    // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
> > +    ranges = <0x1000000 0x0 0x00000000  0x0 0x00000000  0x0 0x00010000>,
>                                            ^^^^^^^^^^^^^^
> 
> This probably shouldn't be 0 in the example, nor in your kvm tool
> output. For example purposes any value will do.

Hmm, so kvmtool actually provides a PC ioport at 0x0, which is handy since
there's an 8250 down there. That means we have:

0x0    - 0x6200  : Weird PC stuff
0x6200 - 0x10000 : PCI IO space

Should I just change everything to be offset by 0x6200?

Will
