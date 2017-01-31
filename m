Return-Path: <SRS0=f+hc=ZN=cavium.com=Jayachandran.Nair@kernel.org>
Return-Path: <SRS0=f+hc=ZN=cavium.com=Jayachandran.Nair@kernel.org>
Date: Tue, 31 Jan 2017 21:49:29 +0000
From: Jayachandran C <jnair@caviumnetworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Skip parent link state check for PCI-to-PCIe
 bridges
Message-ID: <20170131214929.GA1819@localhost>
References: <1485895501-1780-1-git-send-email-jnair@caviumnetworks.com>
 <20170131211323.GB14127@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170131211323.GB14127@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 31, 2017 at 03:13:23PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 31, 2017 at 08:45:01PM +0000, Jayachandran C wrote:
> > Commit 51ebfc92b72b4f7dac1ab45683bf56741e454b8c ("PCI: Enumerate
> > switches below PCI-to-PCIe bridges") sets the has_secondary_link
> > value for device type PCI_EXP_TYPE_PCIE_BRIDGE. With this change
> > the function alloc_pcie_link_state() can be called with devices
> > of this type as well.
> 
> You mean like this:
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=672980c62c684a625fe3a688ca8c6214062d712b
> 
> Practically identical to yours :)
> 

I should have checked the list before sending out the patch...
Anyway, your fix works for me. So,

Tested-by: Jayachandran C. <jnair@caviumnetworks.com>

Thanks,
JC.
