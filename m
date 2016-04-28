Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 28 Apr 2016 15:14:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Nowicki <tn@semihalf.com>,
	Jayachandran C <jchandra@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	Jon Masters <jcm@redhat.com>, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, Wangyijing <wangyijing@huawei.com>,
	Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH V6 08/13] PCI: generic, thunder: update to use generic
 ECAM API
Message-ID: <20160428201439.GD25125@localhost>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <3830999.dF71UWYsBP@wuerfel>
 <57189D2F.9070802@semihalf.com>
 <8950494.UV8UrWiFbx@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8950494.UV8UrWiFbx@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 21, 2016 at 11:36:53AM +0200, Arnd Bergmann wrote:
> On Thursday 21 April 2016 11:28:15 Tomasz Nowicki wrote:
> > On 19.04.2016 15:06, Arnd Bergmann wrote:
> > > On Monday 18 April 2016 21:31:54 Tomasz Nowicki wrote:
> > >>
> > >> Basically the whole content of pci-thunder-ecam.c and pci-thunder-pem.c.
> > >>
> > >> pci-thunder-ecam.c contains config space accessors. Similar for
> > >> pci-thunder-pem.c but it also has extra init call (it is now called
> > >> thunder_pem_init) which finds and maps related registers.
> > >
> > > They seem to do much more than just override the accessors, they actually
> > > change the contents of the config space as well. Is that really necessary
> > > on ACPI based systems as well?
> > 
> > Yes, the pci-thunder-ecam.c accessors are meant to emulate config space 
> > capabilities. They are necessary to synthesize EA capabilities (fixed 
> > PCI BARs), it wont work without this, for ACPI boot as well.
> 
> Why is that? I thought the BARs never get reassigned when using ACPI,

In general, there's no reason we can't reassign BARs, whether we're
using DT, ACPI, or whatever.  In many cases, systems with ACPI also
assign all the BARs in firmware, and Linux doesn't reassign them
unless it needs to.  But that's just a coincidence.  There's no
requirement that Linux leave BARs as firmware programmed them.
