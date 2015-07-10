Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: mingo@kernel.org
Cc: bp@suse.de, tomi.valkeinen@ti.com, airlied@redhat.com,
	arnd@arndb.de, dan.j.williams@intel.com, hch@lst.de,
	luto@amacapital.net, hpa@zytor.com, tglx@linutronix.de,
	geert@linux-m68k.org, ralf@linux-mips.org, hmh@hmh.eng.br,
	ross.zwisler@linux.intel.com, akpm@linux-foundation.org,
	jgross@suse.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
	tj@kernel.org, x86@kernel.org, mst@redhat.com, toshi.kani@hp.com,
	stefan.bader@canonical.com, syrjala@sci.fi,
	ville.syrjala@linux.intel.com, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH v6 0/4] atyfb: atyfb: address MTRR corner case
Date: Thu,  9 Jul 2015 18:24:55 -0700
Message-Id: <1436491499-3289-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Ingo,

Boris is on vacation so sending these through you. This v6 addresses one code
comment update requested by Ville. Boris had picked up these patches on his
tree and this series had gone through 0-day bot testing. The only issue it
found was the lack of ioremap_uc() implementation on some architectures which
have an IOMMU. There are two approaches to this issue, one is to go and define
ioremap_uc() on all architectures, another is to provide a default for
ioremap_uc() as architectures catch up. I've gone with the later approach [0],
and so to ensure things won't build-break this patch series must also go
through the same tree as the patch-fixes for ioremap_uc() for missing
ioremap_uc() implementations go through. I intend on following up with
implementing ioremap_uc() for other architectures but for that I need to get
feedback from other architecture developers and that will take time.

Tomi, the framebuffer maintainer had already expressed he was OK for this to go
through you. The driver maintainer, Ville, has been Cc'd on all the series, but
has only provided feedback for the comment request as I noted above. This
series addresses the more complex work on the entire series I've been putting
out and as such I've provided a TL;DR full review of what this series does in
my previous v5 patch series, that can be looked at for more details if needed
[1].

This series depends on the patch which I recently posted to address compilation
issue on architectures missing ioremap_uc() [0]. If that goes through then it
should be safe to apply this series, otherwise we have to sit and wait until
all architectures get ioremap_uc() properly defined.

Please let me know if there are any questions.

[0] http://lkml.kernel.org/r/1436488096-3165-1-git-send-email-mcgrof@do-not-panic.com
[1] http://lkml.kernel.org/r/1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com

Luis R. Rodriguez (4):
  drivers/video/fbdev/atyfb: Carve out framebuffer length fudging into a
    helper
  drivers/video/fbdev/atyfb: Clarify ioremap() base and length used
  drivers/video/fbdev/atyfb: Replace MTRR UC hole with strong UC
  drivers/video/fbdev/atyfb: Use arch_phys_wc_add() and ioremap_wc()

 drivers/video/fbdev/aty/atyfb.h      |   5 +-
 drivers/video/fbdev/aty/atyfb_base.c | 109 ++++++++++++++++-------------------
 2 files changed, 51 insertions(+), 63 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

