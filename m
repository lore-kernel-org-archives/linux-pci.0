Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:47376 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757028AbcBIQxT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 11:53:19 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, qiujiang <qiujiang@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"tn@semihalf.com" <tn@semihalf.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"jcm@redhat.com" <jcm@redhat.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [RFC PATCH v2 1/3] PCI: hisi: re-architect Hip05/Hip06
 controllers driver to preapare for ACPI
Date: Tue, 9 Feb 2016 16:52:38 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ECAF48D@lhreml503-mbs>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
 <3113837.YSNyDAf4HQ@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECAD249@lhreml503-mbs>
 <5968234.D2a3VCM72k@wuerfel>
In-Reply-To: <5968234.D2a3VCM72k@wuerfel>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 09 February 2016 16:27
> To: Gabriele Paoloni
> Cc: linux-arm-kernel@lists.infradead.org; Guohanjun (Hanjun Guo);
> Wangzhou (B); liudongdong (C); Linuxarm; qiujiang; bhelgaas@google.com;
> Lorenzo.Pieralisi@arm.com; tn@semihalf.com; linux-pci@vger.kernel.org;
> linux-kernel@vger.kernel.org; xuwei (O); linux-acpi@vger.kernel.org;
> jcm@redhat.com; zhangjukuo; Liguozhu (Kenneth)
> Subject: Re: [RFC PATCH v2 1/3] PCI: hisi: re-architect Hip05/Hip06
> controllers driver to preapare for ACPI
> 
> On Monday 08 February 2016 16:51:19 Gabriele Paoloni wrote:
> > > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > > On Monday 08 February 2016 16:06:54 Gabriele Paoloni wrote:
> > > > > On Monday 08 February 2016 12:41:02 Gabriele Paoloni wrote:
> > > int
> > > > > size,
> > > > > > +                         u32 *val)
> > > > > > +{
> > > > > > +   u32 reg;
> > > > > > +   u32 reg_val;
> > > > > > +   void *walker = &reg_val;
> > > > > > +
> > > > > > +   walker += (where & 0x3);
> > > > > > +   reg = where & ~0x3;
> > > > > > +   reg_val = readl(reg_base + reg);
> > > > > > +
> > > > > > +   if (size == 1)
> > > > > > +           *val = *(u8 __force *) walker;
> > > > > > +   else if (size == 2)
> > > > > > +           *val = *(u16 __force *) walker;
> > > > > > +   else if (size == 4)
> > > > > > +           *val = reg_val;
> > > > > > +   else
> > > > > > +           return PCIBIOS_BAD_REGISTER_NUMBER;
> > > > > > +
> > > > > > +   return PCIBIOS_SUCCESSFUL;
> > > > > > +}
> > > > >
> > > > > Isn't this the same hack that Qualcomm are using?
> > > >
> > > > As far as I can see Qualcomm defines its own config access
> > > > mechanism only for RC config read and also it seems they're
> > > > having problems with reporting the device class...
> > > >
> > > >
> https://github.com/torvalds/linux/blob/master/drivers/pci/host/pcie-
> > > qcom.c#L474
> > > >
> > > > Our problem is that our HW can only perform 32b rd/wr accesses
> > > > So we can't use readw/readb/writew/writeb...
> > > >
> > > >
> > >
> > > Sorry, my mistake, I meant Cavium not Qualcomm.
> > > See https://lkml.org/lkml/2016/2/5/689 for the patches.
> >
> > Well, looking at it Cavium seems quite different,
> >
> > On read they need to trigger the retrieval of the
> > config space info writing to the lower 32b of a 64b register,
> > then they need to read data back on the upper 64b of the
> > same register and adjust the content to remove the garbage...
> >
> > We just use 32b accesses and adjust grab the appropriate
> > bytes depending on the read/write sizes...
> 
> Hmm, I must have misremembered that too then, let me try once more ;-)
> 
> The above appears to reimplement pci_generic_config_read32(). Can you
> just use that instead?

Nope I don't think so,

When we read the root complex config space we need to use a configuration
address space that is different from the one used to map the rest of the
hierarchy; I think this is something to do with Designware itself. It
is clear if you look at

http://lxr.free-electrons.com/source/drivers/pci/host/pcie-designware.c#L657

Here you can see that in calling "dw_pcie_wr_own_conf" Designware does not
pass "bus" and "devfn" that are actually required by pci_generic_config_read32()
to map the addr...

Many Thanks

Gab

> 
> 	Arnd
