Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:55242 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761031AbaCUQk1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Mar 2014 12:40:27 -0400
Date: Fri, 21 Mar 2014 10:40:15 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Phil.Edworthy@renesas.com,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7790
Message-ID: <20140321164015.GA3374@obsidianresearch.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <532C5ADE.4030708@cogentembedded.com>
 <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com>
 <6044873.2S2Xlhp0hC@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6044873.2S2Xlhp0hC@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 21, 2014 at 03:57:25PM +0100, Arnd Bergmann wrote:
> On Friday 21 March 2014 14:53:48 Phil.Edworthy@renesas.com wrote:
> > 
> > > > +      reg = <0 0xfe000000 0 0x80000>;
> > > > +      #address-cells = >;
> > > > +      #size-cells = <2>;
> > > > +      device_type = "pci";
> > > 
> > >     This legacy property is only meaningful for the true OF firmware and 
> > thus 
> > > have been phased out (it's only actively used for the memory nodes).
> > Ok, thanks for pointing this out.
> > 
> 
> I think the code still relies on it for PCI though.

Right, it must be present for PCI nodes, it triggers special behavior
in the address parsing routines.

What Phil has looks correct to me.

Regards,
Jason
