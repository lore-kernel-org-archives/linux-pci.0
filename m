Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 10 Feb 2016 11:12:34 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, qiujiang <qiujiang@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"tn@semihalf.com" <tn@semihalf.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"jcm@redhat.com" <jcm@redhat.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for
 HiSilicon SoCs Host Controllers
Message-ID: <20160210111234.GC2632@leverpostej>
References: <1455039260-6040-1-git-send-email-gabriele.paoloni@huawei.com>
 <1455039260-6040-4-git-send-email-gabriele.paoloni@huawei.com>
 <20160209182429.GD4348@leverpostej>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1591@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1591@lhreml503-mbs>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 10, 2016 at 09:52:36AM +0000, Gabriele Paoloni wrote:
> Hi Mark
> 
> > On Tue, Feb 09, 2016 at 05:34:20PM +0000, Gabriele Paoloni wrote:
> > > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> > > +/*
> > > + * Retrieve rc_dbi base and size from _DSD
> > > + * Name (_DSD, Package () {
> > > + *	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > > + *	Package () {
> > > + *	Package () {"rc-dbi", Package () { 0x0, 0xb0080000, 0x0, 0x10000
> > }},
> > > + *	}
> > > + *	})
> > > + */
> > 
> > As above, this does not look right. ACPI has standard mechanisms for
> > describing addresses. Making something up like this is not a good idea.
>  
> I am quite new to ACPI, may I ask you to explain a bit? 

ACPI has standard mechanisms for describing certain resources, and these
should not be described in _DSD. Memory or IO address regions are such
resources (in _CRS, IIRC), and should not be described in _DSD.

Thanks,
Mark.
