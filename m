Return-Path: <SRS0=Ig+T=6O=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=Ig+T=6O=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <201707112000.h3N0wEJq%fengguang.wu@intel.com>
References: <1499698794-1718-5-git-send-email-deathsimple@vodafone.de> <201707112000.h3N0wEJq%fengguang.wu@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 11 Jul 2017 20:50:18 +0300
Message-ID: <CAHp75VdaO+-AyMObfS_p3+y+6RR1Qa6_o783mjhsZBAYzC3wyg@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] x86/PCI: Enable a 64bit BAR on AMD Family 15h
 (Models 30h-3fh) Processors v4
To: kbuild test robot <lkp@intel.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>,
	kbuild-all@01.org, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 11, 2017 at 3:07 PM, kbuild test robot <lkp@intel.com> wrote:

>         make ARCH=i386

Yeah, either this code shouldn't have been built on 32-bit arch at
all, or be portable.

>    arch/x86/pci/fixup.c: In function 'pci_amd_enable_64bit_bar':
>>> arch/x86/pci/fixup.c:674:15: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>      res->start = 0x100000000ull;
>                   ^~~~~~~~~~~~~~
>    arch/x86/pci/fixup.c:675:13: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>      res->end = 0xfd00000000ull - 1;
>                 ^~~~~~~~~~~~~~~
>>> arch/x86/pci/fixup.c:686:22: warning: right shift count >= width of type [-Wshift-count-overflow]

I suppose explicit casting will help.

>      high = ((res->start >> 40) & AMD_141b_MMIO_HIGH_MMIOBASE_MASK) |
>                          ^~
>    arch/x86/pci/fixup.c:687:21: warning: right shift count >= width of type [-Wshift-count-overflow]
>       ((((res->end + 1) >> 40) << AMD_141b_MMIO_HIGH_MMIOLIMIT_SHIFT)
>                         ^~

These can be done via upper_32_bits() + shift.

-- 
With Best Regards,
Andy Shevchenko
