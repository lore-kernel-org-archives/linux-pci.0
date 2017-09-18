Return-Path: <SRS0=EwLP=AT=axtens.net=dja@kernel.org>
Return-Path: <SRS0=EwLP=AT=axtens.net=dja@kernel.org>
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com, gabriele.paoloni@huawei.com, helgaas@kernel.org, airlied@linux.ie, daniel.vetter@intel.com, alex.williamson@redhat.com, dri-devel@lists.freedesktop.org, lukas@wunner.de, ard.biesheuvel@linaro.org, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/3] Split default display handling out from VGA arbiter
In-Reply-To: <20170901072744.2409-1-dja@axtens.net>
References: <20170901072744.2409-1-dja@axtens.net>
Date: Mon, 18 Sep 2017 15:49:45 +1000
Message-ID: <87d16oeeti.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Hi all,

The merge window is well over by now - is there anything else I can do
to get this series to a mergeable state? I'm not particularly across the
rules for drm-misc, so please let me know if there are things I need to
be doing.

Regards,
Daniel

Daniel Axtens <dja@axtens.net> writes:

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
> Regards,
> Daniel
>
> Daniel Axtens (3):
>   drm: split default display handler out of VGA arbiter
>   drm: add fallback default device detection
>   drm: documentation for default display device
>
>  Documentation/gpu/default_display.rst |  93 +++++++++++++++++++
>  Documentation/gpu/index.rst           |   1 +
>  arch/ia64/pci/fixup.c                 |   6 +-
>  arch/powerpc/kernel/pci-common.c      |   6 +-
>  arch/x86/pci/fixup.c                  |   6 +-
>  arch/x86/video/fbdev.c                |   4 +-
>  drivers/gpu/vga/Kconfig               |  12 +++
>  drivers/gpu/vga/Makefile              |   1 +
>  drivers/gpu/vga/default_display.c     | 163 ++++++++++++++++++++++++++++++++++
>  drivers/gpu/vga/vga_switcheroo.c      |   8 +-
>  drivers/gpu/vga/vgaarb.c              |  61 +++----------
>  drivers/pci/pci-sysfs.c               |   4 +-
>  include/linux/default_display.h       |  44 +++++++++
>  include/linux/vgaarb.h                |  15 ----
>  14 files changed, 344 insertions(+), 80 deletions(-)
>  create mode 100644 Documentation/gpu/default_display.rst
>  create mode 100644 drivers/gpu/vga/default_display.c
>  create mode 100644 include/linux/default_display.h
>
> -- 
> 2.11.0
