Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 Jul 2016 16:27:14 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: Re: Purpose of pci_remap_iospace
Message-ID: <20160714152714.GD30657@red-moon>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <8520D5D51A55D047800579B094147198258B8F73@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160714145624.GB30657@red-moon>
 <5073702.5KYvV2f0PW@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5073702.5KYvV2f0PW@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 14, 2016 at 05:12:01PM +0200, Arnd Bergmann wrote:
> On Thursday, July 14, 2016 3:56:24 PM CEST Lorenzo Pieralisi wrote:
> > On Thu, Jul 14, 2016 at 01:32:13PM +0000, Bharat Kumar Gogada wrote:
> > 
> > [...]
> > 
> > > Hi Lorenzo,
> > > 
> > > I missed something in my device tree now I corrected it.
> > > 
> > > ranges = <0x01000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0 0x00010000   //io
> > 
> > You have not missed anything, you changed the PCI bus address at
> > which your host bridge responds to IO space and it must match
> > your configuration.
> 
> I'd always recommend mapping the I/O space to PCI address zero, but
> evidently the hardware is not configured that way here.

+1 and it is a message that must be heeded by Xiling folks before
merging the host controller changes and respective DT bindings/dts.

Lorenzo
