Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40343 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932713AbcAYRt5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jan 2016 12:49:57 -0500
Date: Mon, 25 Jan 2016 17:51:44 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
Message-ID: <20160125175144.GA26999@red-moon>
References: <20160120160427.GD13437@red-moon>
 <569FB210.9090605@codeaurora.org>
 <20160120181003.GF13437@red-moon>
 <HK2PR0601MB1393A8E38392D17EC2DD7900F5C40@HK2PR0601MB1393.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <HK2PR0601MB1393A8E38392D17EC2DD7900F5C40@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Phil,

On Fri, Jan 22, 2016 at 04:28:39PM +0000, Phil Edworthy wrote:
> Hi Lorenzo,
> 
> On 20 January 2016 18:10, Lorenzo Pieralisi wrote:
> > On Wed, Jan 20, 2016 at 11:13:04AM -0500, Sinan Kaya wrote:
> > > On 1/20/2016 11:04 AM, Lorenzo Pieralisi wrote:
> > > > Hi,
> > > >
> > > > I noticed that:
> > > >
> > > > 79953dd22c1d ("PCI: rcar: Remove dependency on ARM-specific struct
> > hw_pci")
> > > > cbce7900598c ("PCI: designware: Make driver arch-agnostic")
> > > >
> > > > added code in the respective host controller drivers to size bridges
> > > > and assign resources only if the PCI_PROBE_ONLY flag is clear, which makes
> > > > me wonder if there exists PCI_PROBE_ONLY set-ups for the respective
> > > > host controllers:
> > > >
> <snip>
>  
> > Resources claiming and assignment should be managed in arch code,
> > not in host controllers specific code, and that's the reason I
> > complained in this RFC about the scattering of PCI_PROBE_ONLY flag
> > checks in host drivers, it is becoming unmanageable (if useful
> > at all on designware and rcar, I would like to know if there are
> > PCI_PROBE_ONLY set-ups probing those host drivers).
> 
> I am pretty sure  there are no rcar set-ups that use PCI_PROBE_ONLY,
> so I am happy for that code to go.

I will remove it then, thank you very much.

Lorenzo
