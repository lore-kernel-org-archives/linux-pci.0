Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 6/6] pci: Add support for creating a generic host_bridge from device tree
Date: Mon, 10 Mar 2014 20:28:32 +0100
Message-ID: <2669340.5Jm6AjVlSo@wuerfel>
In-Reply-To: <CAMuHMdWzm1D83zquwuQVKwbqRdXmSw7u1ui7iZyC3VGdGhn0HA@mail.gmail.com>
References: <1394020137-1830-1-git-send-email-Liviu.Dudau@arm.com> <1469359.kil5iaOqdU@wuerfel> <CAMuHMdWzm1D83zquwuQVKwbqRdXmSw7u1ui7iZyC3VGdGhn0HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 10 March 2014 20:16:25 Geert Uytterhoeven wrote:
> On Mon, Mar 10, 2014 at 7:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> arch/avr32/include/asm/io.h:#define IO_SPACE_LIMIT    0xffffffff
> >> arch/frv/include/asm/io.h:#define IO_SPACE_LIMIT      0xffffffff
> >
> > They have no MMU, and the code relies on the port number to match
> > both the virtual and the physical address. You could be right about
> > these, but I would guess that the code also needs some other
> > changes if we want to make it work on nommu kernels. It also depends
> > on whether the I/O bus address is the same as the CPU address, or
> > if it starts at bus address 0.
> 
> >> arch/m68k/include/asm/io_no.h:#define IO_SPACE_LIMIT 0xffffffff
> >
> > This looks like a mistake, it should be smaller
> 
> io_no.h is for nommu.

Ah, I missed that. In that case I assume it doesn't matter because
the only m68k with PCI is M54xx and that always has an MMU.

	Arnd
