Return-Path: <SRS0=hkQX=YG=8bytes.org=joro@kernel.org>
Return-Path: <SRS0=hkQX=YG=8bytes.org=joro@kernel.org>
Date: Fri, 23 Dec 2016 11:35:48 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	rwright@hpe.com
Subject: Re: possible dmar_init_reserved_ranges() error
Message-ID: <20161223103548.GH17255@8bytes.org>
References: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
 <20161222162713.GF17255@8bytes.org>
 <20161222202803.GA16855@bhelgaas-glaptop.roam.corp.google.com>
 <20161222233238.GA20861@otc-nc-03>
 <20161222234508.GA20924@otc-nc-03>
 <20161223004801.GA1096@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161223004801.GA1096@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 22, 2016 at 06:48:01PM -0600, Bjorn Helgaas wrote:
> If we didn't want to use pcibios_resource_to_bus() here for some
> reason, we should at least add a comment about why we think it's OK to
> use a CPU physical address as an IOVA.

Even if there are no such x86 systems out there, I think it doesn't hurt
to handle the possibility correctly in the IOMMU drivers.



	Joerg
