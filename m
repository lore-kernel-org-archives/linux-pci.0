Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Jun 2015 22:47:03 +0200
From: Borislav Petkov <bp@suse.de>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: mingo@kernel.org, arnd@arndb.de, bhelgaas@google.com,
	luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com,
	benh@kernel.crashing.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH v8 0/9] pci: add pci_iomap_wc() and pci_ioremap_wc_bar()
Message-ID: <20150625204703.GC4898@pd.tnic>
References: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 06:22:13PM -0700, Luis R. Rodriguez wrote:
> Luis R. Rodriguez (9):
>   pci: add pci_ioremap_wc_bar()
>   video: fbdev: i740fb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
>   video: fbdev: kyrofb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
>   video: fbdev: gxt4500: use pci_ioremap_wc_bar() for framebuffer
>   PCI: Add pci_iomap_wc() variants
>   lib: devres: add pcim_iomap_wc() variants
>   video: fbdev: arkfb: use arch_phys_wc_add() and pci_iomap_wc()
>   video: fbdev: s3fb: use arch_phys_wc_add() and pci_iomap_wc()
>   video: fbdev: vt8623fb: use arch_phys_wc_add() and pci_iomap_wc()
> 
>  drivers/pci/pci.c                | 14 ++++++++
>  drivers/video/fbdev/arkfb.c      | 36 +++----------------
>  drivers/video/fbdev/gxt4500.c    |  2 +-
>  drivers/video/fbdev/i740fb.c     | 35 ++++--------------
>  drivers/video/fbdev/kyro/fbdev.c | 33 ++++++-----------
>  drivers/video/fbdev/s3fb.c       | 35 ++++--------------
>  drivers/video/fbdev/vt8623fb.c   | 31 ++++------------
>  include/asm-generic/pci_iomap.h  | 14 ++++++++
>  include/linux/pci.h              |  3 ++
>  include/video/kyro.h             |  4 +--
>  lib/devres.c                     | 76 ++++++++++++++++++++++++++++++++++++++++
>  lib/pci_iomap.c                  | 61 ++++++++++++++++++++++++++++++++
>  12 files changed, 204 insertions(+), 140 deletions(-)

Took those, modulo the devres one.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
