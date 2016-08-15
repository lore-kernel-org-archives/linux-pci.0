Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 15 Aug 2016 13:59:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] PCI: Add Precision Time Measurement (PTM) support
Message-ID: <20160815185931.GD9790@localhost>
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160613190534.12503.18923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <57AA984E.8040308@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57AA984E.8040308@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jonathan,

On Wed, Aug 10, 2016 at 10:58:22AM +0800, Yong, Jonathan wrote:
> On 06/14/2016 03:05, Bjorn Helgaas wrote:
> > From: Jonathan Yong <jonathan.yong@intel.com>
> > 
> > Add Precision Time Measurement (PTM) support (see PCIe r3.1, sec 6.22).
> > 
> > Enable PTM on PTM Root devices and switch ports.  This does not enable PTM
> > on endpoints.
> > 
> > There currently are no PTM-capable devices on the market, but it is
> > expected to be supported by the Intel Apollo Lake platform.
> > 
> > [bhelgaas: complete rework]
> > Signed-off-by: Jonathan Yong <jonathan.yong@intel.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Hi,
> 
> Any updates on the PTM changes?

I guess I was hoping you could test these patches.  Do you have any
way to do that?

I rebased them and pushed them to pci/ptm.  If everything looks good,
I'll merge them for v4.9.

Bjorn
