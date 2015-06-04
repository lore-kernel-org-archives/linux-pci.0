Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Date: Thu, 4 Jun 2015 08:59:37 +0200
Message-ID: <CAMuHMdUfGMU3m35xWD9vE1RNW80jjHx_KLM3a4GWq=JfuGcGBw@mail.gmail.com>
Subject: Re: [RFT v2 00/48] Refine irq interfaces to reduce number of parameters
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Wu Fengguang <fengguang.wu@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>,
	"the arch/x86 maintainers" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gerry,

On Thu, Jun 4, 2015 at 6:13 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> You may get the patch set from:

Missing link?

> The patch set passes Fengguang's 0day test suites as below. And tests
> with other platforms and configurations will be appreciated:)
> ----------------------------------------------------------
> configs tested: 95

[...]

> m68k                          amiga_defconfig
> m68k                       m5475evb_defconfig
> m68k                          multi_defconfig

For Fengguang: amiga_defconfig is a subset of multi_defconfig.
But sun3_defconfig is distinct, as Sun-3 has a different MMU and thus support
for it cannot be included in multi-platform kernels.
So I think you better replace amiga_defconfig by sun3_defconfig for build tests.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
