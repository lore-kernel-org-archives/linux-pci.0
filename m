Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V2] PCI: exynos: add support for MSI
Date: Sun, 25 Aug 2013 22:28:20 +0200
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	"'SRIKANTH TUMKUR SHIVANAND'" <ts.srikanth@samsung.com>,
	"'Sean Cross'" <xobs@kosagi.com>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"'Thomas Petazzoni'" <thomas.petazzoni@free-electrons.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <003d01ce9fc6$9c0f1c20$d42d5460$%han@samsung.com> <20130823083539.GB3937@pratyush-vbox> <20130823092238.GJ3535@ulmo>
In-Reply-To: <20130823092238.GJ3535@ulmo>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201308252228.20843.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 23 August 2013, Thierry Reding wrote:
> > > +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > > +               if (of_property_read_u32(np, "msi-base", &pp->msi_irq_start)) {
> > > +                       dev_err(pp->dev, "Failed to parse the number of lanes\n");
> > > +                       return -EINVAL;
> > > +               }
> > > +       }
> > > +
> > 
> > What if an implementor want to use irq_domain method for msi_irq_start
> > allocation? Is it fine to return error if msi-base is not passed from
> > dt?
> 
> I agree. This should be using an IRQ domain to represent the MSI
> controller. Both Tegra and Marvell drivers do that already and if Exynos
> can follow that same path it will increase the chances of refactoring
> common bits.
> 
> Also the error message doesn't quite match up with what the code is
> doing. =)

Agreed. Besides the encoding of "base" irq values in the device tree is always
wrong, since the numbers are not at all a hardware property but an implementation
detail of how Linux currently uses interrupt numbers. When using DT probing,
you *have* to use IRQ domains, and the rest of Exynos does that.

	Arnd
