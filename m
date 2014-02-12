Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:52371 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752013AbaBLTtw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 14:49:52 -0500
Date: Wed, 12 Feb 2014 19:49:10 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Message-ID: <20140212194909.GM29132@mudshark.cambridge.arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <201402092130.25615.arnd@arndb.de>
 <20140210173450.GA5554@obsidianresearch.com>
 <2006726.HhIT01YuXY@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2006726.HhIT01YuXY@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 11, 2014 at 10:42:52AM +0000, Arnd Bergmann wrote:
> On Monday 10 February 2014 10:34:50 Jason Gunthorpe wrote:
> 
> > I noticed this on mvebu as well..
> > 
> > 3.13 w/ mvebu driver:
> > 
> > e0001000-e0001fff : /mbus/pex@e0000000/pcie@1,0/fpga@0/fpga_sysmon@1000
> > e0006000-e0006fff : /mbus/pex@e0000000/pcie@1,0/fpga@0/qdr2p@6000
> > 
> > 3.10 w/ old kirkwood driver:
> > 
> > e0000000-e7ffffff : PCIe 0 MEM
> >   e0000000-e001ffff : 0000:00:01.0
> >     e0001000-e0001fff : /mbus/pex@e0000000/pcie@1,0/fpga@0/fpga_sysmon@1000
> >     e0006000-e0006fff : /mbus/pex@e0000000/pcie@1,0/fpga@0/qdr2p@6000
> > 
> > The latter is obviously correct and matches x86. I'm not sure where
> > the new style host drivers are going wrong, even the resource that
> > should be added by the PCI core itself for the BAR is missing..
> 
> I looked briefly at the code and found that mach-kirkwood/pcie.c does
> both request_resource() and pci_add_resource_offset(), while
> drivers/pci/host/pci-mvebu.c only does the latter. Does the patch
> below restore the previous behavior?

Making the equivalent changes in my generic driver fixes the issue, cheers
Arnd!

  bash-4.2# cat /proc/ioports
  00000000-0000ffff : /pci
    00006200-000065ff : virtio-pci
    00006600-000069ff : virtio-pci
    00006a00-00006dff : virtio-pci
    00006e00-000071ff : virtio-pci
  bash-4.2# cat /proc/iomem
  41000000-7fffffff : /pci
    41000000-410003ff : virtio-pci
    41000400-410005ff : virtio-pci
    41000800-41000bff : virtio-pci
    41000c00-41000dff : virtio-pci
    41001000-410013ff : virtio-pci
    41001400-410015ff : virtio-pci
    41001800-41001bff : virtio-pci
    41001c00-41001dff : virtio-pci
  80000000-93ffffff : System RAM
    80008000-80697e4f : Kernel code
    806f6000-8077b4c3 : Kernel data

Will
