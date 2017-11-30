Return-Path: <SRS0=caaC=C4=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=caaC=C4=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 30 Nov 2017 10:24:37 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>, thierry.reding@gmail.com,
	jonathanh@nvidia.com, robh+dt@kernel.org, frowand.list@gmail.com,
	bhelgaas@google.com, rjw@rjwysocki.net, tglx@linutronix.de,
	vidyas@nvidia.com, kthota@nvidia.com, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 5/9] PCI: Export pci_flags
Message-ID: <20171130102436.GB10349@red-moon>
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
 <1511638333-22951-6-git-send-email-mmaddireddy@nvidia.com>
 <20171129170133.GC6469@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171129170133.GC6469@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 29, 2017 at 11:01:33AM -0600, Bjorn Helgaas wrote:
> [+cc Lorenzo]
> 
> On Sun, Nov 26, 2017 at 01:02:09AM +0530, Manikanta Maddireddy wrote:
> > pci_flags variable is used in inline functions in 'pci.h', Tegra PCIe
> > driver use one of these functions pci_add_flags() and includes 'pci.h'.
> > Export pci_flags to allow Tegra PCIe host controller driver to be
> > compiled as loadable kernel module.
> 
> Here's the usage in tegra_pcie_probe():
> 
>   pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
> 
> We've probably had this discussion before, but  I don't know why Tegra
> needs PCI_REASSIGN_ALL_RSRC and PCI_REASSIGN_ALL_BUS.
> 
> I would prefer to drop this usage of pci_add_flags() if possible.  It
> seems to be just an arm/powerpc thing and I'm not convinced it's
> really necessary.

It is hard to say if it is really necessary (because it depends
on firmware configuration - ie pci_scan_bridge()), that's the
problem.

I suspect it can trigger regressions if we do not set it (since
it affects what pcibios_assign_all_busses() returns on eg arm/arm64).

There are two things we can do:

1) Set it unconditionally in arch code (in a hook to be defined)
2) We remove it on a per-host bridge basis and ask for testing

I agree this may have trickled from host bridge to host bridge through
copy'n'paste and it is not based on any firmware assumtpion but I can't
say if it is really needed.

Lorenzo
