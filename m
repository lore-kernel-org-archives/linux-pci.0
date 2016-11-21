Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 21 Nov 2016 16:31:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "liudongdong (C)" <liudongdong3@huawei.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jcm@redhat.com" <jcm@redhat.com>,
        "Chenxin (Charles)" <charles.chenxin@huawei.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH V5 2/2] PCI/ACPI: hisi: Add ACPI support for HiSilicon
 SoCs Host Controllers
Message-ID: <20161121223145.GC4832@bhelgaas-glaptop.roam.corp.google.com>
References: <1479460951-49281-1-git-send-email-liudongdong3@huawei.com>
 <1479460951-49281-3-git-send-email-liudongdong3@huawei.com>
 <20161118170821.GH25762@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F9270ED@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F9270ED@lhreml507-mbx>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 21, 2016 at 09:09:28AM +0000, Gabriele Paoloni wrote:

> > > +config PCI_HISI_ACPI
> > > +	depends on ACPI && ARM64
> > > +	bool "HiSilicon Hip05 and Hip06 and Hip07 SoCs ACPI PCIe
> > controllers"
> > > +	select PNP
> > > +	help
> > > +	  Say Y here if you want ACPI PCIe controller support on
> > HiSilicon
> > > +	  Hip05 and Hip06 and Hip07 SoCs
> > 
> > I'm not sure about this Kconfig setup.  Do we really want to force
> > people to enable a special config option to get this support?
> > 
> > I'm comparing it in my mind with other PCI quirks.  They're all
> > enabled as a group by CONFIG_PCI_QUIRKS.  Ultimately we want an ACPI
> > kernel to work without requiring any platform-specific config options.
> > 
> > I'm wondering if we should consolidate all the ECAM quirk code in a
> > single place (maybe pci/ecam-quirks.c, pci/ecam.c, or pci/pci-acpi.c),
> > under a config option like CONFIG_PCI_ECAM_QUIRKS or maybe even plain
> > CONFIG_PCI_QUIRKS (of course, it could still be qualified by
> > CONFIG_ACPI and CONFIG_ARM64).
> 
> What about having a single config options but keeping separate files
> for each vendors (at least as first step)?

That sounds fine.  The main thing is that we're trying to build a
generic kernel that can run on any ACPI arm64 platform, so we really
shouldn't have to turn on platform-specific config options.

> Maybe if we see that we can consolidate all the vendors in one file
> we can do it as a second step...
