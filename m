Return-Path: <SRS0=i8fg=YS=8bytes.org=joro@kernel.org>
Return-Path: <SRS0=i8fg=YS=8bytes.org=joro@kernel.org>
Date: Wed, 4 Jan 2017 15:39:09 +0100
From: Joerg Roedel <joro@8bytes.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	g@bhelgaas-glaptop.roam.corp.google.com, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	rwright@hpe.com
Subject: Re: possible dmar_init_reserved_ranges() error
Message-ID: <20170104143909.GD10632@8bytes.org>
References: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
 <20161227234417.GA24366@bhelgaas-glaptop.roam.corp.google.com>
 <20161228032139.GA254916@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161228032139.GA254916@otc-nc-03>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 27, 2016 at 07:21:39PM -0800, Raj, Ashok wrote:
> This sounds reasonable, if we can reserve from the host bridge apertures 
> it should take care of hot-plug cases as well, and should simply how the
> reservation is made.

Agreed, I have this on my todo list already since I converted the AMD
IOMMU driver to the iova allocator. Just reserving the pci windows is
much better than what we are currently doing.


	Joerg
