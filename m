Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 5 Jun 2015 11:53:13 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
	the arch/x86 maintainers <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-mediatek@lists.infradead.org
Subject: Re: [RFT v2 00/48] Refine irq interfaces to reduce number of
 parameters
Message-ID: <20150605035313.GA7707@wfg-t540p.sh.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <CAMuHMdUfGMU3m35xWD9vE1RNW80jjHx_KLM3a4GWq=JfuGcGBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdUfGMU3m35xWD9vE1RNW80jjHx_KLM3a4GWq=JfuGcGBw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > The patch set passes Fengguang's 0day test suites as below. And tests
> > with other platforms and configurations will be appreciated:)
> > ----------------------------------------------------------
> > configs tested: 95
> 
> [...]
> 
> > m68k                          amiga_defconfig
> > m68k                       m5475evb_defconfig
> > m68k                          multi_defconfig
> 
> For Fengguang: amiga_defconfig is a subset of multi_defconfig.
> But sun3_defconfig is distinct, as Sun-3 has a different MMU and thus support
> for it cannot be included in multi-platform kernels.
> So I think you better replace amiga_defconfig by sun3_defconfig for build tests.

Got it and changed the code accordingly, thank you for the suggestion!

Thanks,
Fengguang
