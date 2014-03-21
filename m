Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:51301 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761038AbaCUQtr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Mar 2014 12:49:47 -0400
Date: Fri, 21 Mar 2014 10:49:43 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Phil.Edworthy@renesas.com
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7790
Message-ID: <20140321164943.GB3374@obsidianresearch.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <532C5ADE.4030708@cogentembedded.com>
 <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com>
 <6044873.2S2Xlhp0hC@wuerfel>
 <532C6BF7.1050404@cogentembedded.com>
 <OFCC2858D2.BB49EE27-ON80257CA2.005AA51E-80257CA2.005AC3A0@eu.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFCC2858D2.BB49EE27-ON80257CA2.005AA51E-80257CA2.005AC3A0@eu.necel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 21, 2014 at 04:31:24PM +0000, Phil.Edworthy@renesas.com wrote:
> >     OK, I have found where it does that but the recommended value
> > seems to be "pciex" for PCI-Express case.
> 
> Ok, but why then do all the other PCIe hosts use "pci"?

Because that is what the PCI bus binding standard says to do, and
new drivers have been pushed toward conforming to that document.

I'm not sure if "pciex" was ever standardized, I haven't see a spec
that reflects that at least.

Commit 14e2abb732e485ee57d9d5b2cb8884652238e5c1 introduced support for
the "pciex" word, but it looks driven by proprietary choices by IBM..

In any event there isn't a single 'device_type = "pciex";' pre-exsting
in the kernel bindings today, so please don't add one :)

Regards,
Jason
