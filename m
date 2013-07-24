Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH V3] pci: exynos: split into two parts such as Synopsys part and Exynos part
Date: Wed, 24 Jul 2013 23:02:40 +0200
Cc: "'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"'Pratyush Anand'" <pratyush.anand@st.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	"'Kukjin Kim'" <kgene.kim@samsung.com>,
	"'Mohit KUMAR'" <Mohit.KUMAR@st.com>,
	"'Sean Cross'" <xobs@kosagi.com>,
	"'Thierry Reding'" <thierry.reding@gmail.com>,
	"'SRIKANTH TUMKUR SHIVANAND'" <ts.srikanth@samsung.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <002801ce8376$a807dbf0$f81793d0$@samsung.com> <51EE22DF.6090902@ti.com> <001301ce8772$522dfc50$f689f4f0$@samsung.com>
In-Reply-To: <001301ce8772$522dfc50$f689f4f0$@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201307242302.40934.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 23 July 2013, Jingoo Han wrote:
> > 
> > Also I have one more query.
> > In your dt binding, your pci address and cpu address is the same. But the pci
> > address should start at 0x00000000 and end at 0xffffffff (for 32bit). Shouldn't
> > the cpu address map to something within this range of pci address?

The size is limited by the window available (e.g. 0x80000000-0x8FFFFFFF), it can
never be the full 4GB on a 32 bit non-LPAE system. If you only care about memory
space here (in practice you want at least also config space) that means you could
either have an identity map

	<0x82000000 0 0x80000000 0x80000000 0 0x1fffffff>;

or use bus address 0

	<0x82000000 0 0 0x80000000 0 0x1fffffff>;

but the length is always limited by the upstream bus.

> Sorry, I cannot answer it exactly.
> DT binding was confirmed by Arnd Bergmann.
> He will answer it exactly.

Normally you want the pci and cpu addresses to be the same, i.e. identity mapped.
This simplifies PCI bus master DMA as it ensures that there is no aliasing between
PCI memory space and RAM addresses visible to the host.

If you know that there is never any RAM at CPU address 0, you can also make the
PCI memory space be mapped from bus address 0, which has the advantage of allowing
access to low PCI addresses, e.g. for legacy VGA output using the 0xa0000-0xbffff
range, but it's less common. In particular on x86 there is always an identity
mapping.

The driver should be able to handle any mapping that can be described by the binding
and is physically possible to be programmed into the translation windows.

	Arnd
