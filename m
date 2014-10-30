Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:53504 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758636AbaJ3RDL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 13:03:11 -0400
Date: Thu, 30 Oct 2014 11:03:05 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [RFC PATCH 0/2] arm: pcibios: remove pci_sys_data domain
Message-ID: <20141030170305.GE26820@obsidianresearch.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141030162552.GC26820@obsidianresearch.com>
 <20141030165246.GC2048@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141030165246.GC2048@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 30, 2014 at 04:52:46PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Oct 30, 2014 at 04:25:52PM +0000, Jason Gunthorpe wrote:
> > On Thu, Oct 30, 2014 at 11:44:46AM +0000, Lorenzo Pieralisi wrote:
> > 
> > > Code in drivers/pci/pci-mvebu.c has been changed to add a domain
> > > number to PCI resources by using the nr value coming from the setup
> > > pcibios32 callback, which may not be correct and should be considered
> > > a temporary solution waiting for review comments.
> > 
> > The intent of the string was to have the domain number so that
> > resources in /proc/iomem can be correlated with lspci.
> > 
> > This would be a 'best practice' - all PCI drivers need to request
> > resource, and the resource should be relatable back to the PCI
> > domain... So it would be best if the domain number was available at
> > this point in a driver's flow.
> 
> It is not available with the new approach and the generic PCI domains since
> the set-up hook is called before creating the pci_bus. That's why
> I mentioned that in the cover letter, and that's good it caught your
> attention.
> 
> On a side note, when the resources are parsed from DT ranges, ie in:
> 
> of_pci_get_host_bridge_resources()
> 
> the resources won't contain the domain number you are looking for here, for
> the records, so we'd better find an agreement sooner rather than later.

Well, it is very unfortunate that things are globally not sequenced to
allow proper resource names :(

But it also isn't really a big deal in the grand scheme of
things. Maybe it can be fixed later :|

> So basically I could go as far as sticking 0000 to the string given the
> current code. I did not drop the 0x04x entirely since I do not want to break
> userspace, I was tempted though, let me know if I am allowed to do that.

I'd just drop it entirely then, nobody is going to parse /proc/iomem

Jason
