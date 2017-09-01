Return-Path: <SRS0=TwG3=AC=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=TwG3=AC=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170901072744.2409-1-dja@axtens.net>
References: <20170901072744.2409-1-dja@axtens.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 1 Sep 2017 10:21:28 +0100
Message-ID: <CAKv+Gu84njSF5uOvNtknGdOd5auU7zw9scFeTq5v-=OhExgOqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Split default display handling out from VGA arbiter
To: Daniel Axtens <dja@axtens.net>
Cc: linux-pci <linux-pci@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>, Zou Rongrong <zourongrong@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>,
	David Airlie <airlied@linux.ie>, "Vetter, Daniel" <daniel.vetter@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>,
	Lukas Wunner <lukas@wunner.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 1 September 2017 at 08:27, Daniel Axtens <dja@axtens.net> wrote:
> This patch set:
>
>  - splits the default display handling out from VGA arbiter, into its
>    own file and behind its own Kconfig option (and gives the functions
>    better names).
>
>  - adds extra detection of default devices. To be nominated, the vga
>    arbiter and platform hooks must not have nominated a default. A
>    card will then only be nominated if it has a driver attached and
>    has IO or memory decoding enabled.
>
>  - adds relevant documentation.
>
> The practical impact of this is improved X autoconfiguration on some
> arm64 systems.
>
> Changes in v3:
>
>  - Add documentation - thanks Daniel Vetter for pointing it out.
>
>  - Clarify explanations. Thanks to everyone for continuing to bear
>    with my incomplete understanding of PCI and provide some clarity.
>
>  - Split refactoring and adding functionality.
>
> Changes in v2: https://www.spinics.net/lists/linux-pci/msg64007.html
>
> Drop all the powerpc patches. [explanation snipped]
>
> v1: https://www.spinics.net/lists/linux-pci/msg63581.html
>

If we are all in agreement that fixing X is not an option, I think
this is a reasonable approach

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
