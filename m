Return-Path: <SRS0=uSZ2=LE=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=uSZ2=LE=intel.com=keith.busch@kernel.org>
Date: Mon, 20 Aug 2018 19:30:32 -0600
From: Keith Busch <keith.busch@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sinan Kaya <okaya@kernel.org>, poza@codeaurora.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
	Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
Message-ID: <20180821013031.GB16932@localhost.localdomain>
References: <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
 <20180820155325.GA16148@localhost.localdomain>
 <cf6de256280be7a2948db6dd2b5bfae92e70e12f.camel@kernel.crashing.org>
 <6aa71d74-e4dc-c627-1496-981278388bce@kernel.org>
 <20180820213544.GA16805@localhost.localdomain>
 <0193e0c5a52d8f2e93958f0683f3acc81cef2bc9.camel@kernel.crashing.org>
 <fd538f20-0754-f127-ceb9-693fec90b4af@kernel.org>
 <44195c0d7159ce4cd01b660002b2f5af5d53678b.camel@kernel.crashing.org>
 <20180820221351.GA16932@localhost.localdomain>
 <cae46bea2b02153d8d6661182b0111d32e8396b9.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cae46bea2b02153d8d6661182b0111d32e8396b9.camel@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 21, 2018 at 08:19:52AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-08-20 at 16:13 -0600, Keith Busch wrote:
> > But anyway, maybe we can change pciehp to ignore PDS and always
> > re-enumerate when PDC is observed, and that may very well simplify a lot
> > of this.
> 
> That sounds reasonable to me.

It seems 4.19 is way ahead of me! The latest pciehp driver looks really
good. This'll be more straight forward to separate errors from enumeration
than I thought, and Sinan's patch earlier is probably just fine in that
direction. Will look again tomorrow.
