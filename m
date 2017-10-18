Return-Path: <SRS0=alSj=BR=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=alSj=BR=gmail.com=ckoenig.leichtzumerken@kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: Resizable PCI BAR support V9
Date: Wed, 18 Oct 2017 15:58:16 +0200
Message-Id: <20171018135821.3248-1-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi everyone,

This is the ninth and hopefully last incarnation of this set of patches. It
enables device drivers to resize and most likely also relocate the PCI BAR of
devices they manage to allow the CPU to access all of the device local memory
at once.

This is very useful for GFX device drivers where the default PCI BAR is only
about 256MB in size for compatibility reasons, but the device easily have
multiple gigabyte of local memory.

Some changes since the last version:
1. Rebased on drm-next, so should be ready to be merged for 4.15.
2. The fixup of the 64bit root window on AMD Family 15h CPUs/APUs is only
   enabled when we compile a kernel supporting that hw.
3. Some minor error handling improvements for the amdgpu side. We now
   gracefully abort driver loading in case of a critical error instead of
   calling BUG().

Bjorn any more comments or can we finally get this into 4.15? I will remove the
version tags from the patches when I send you a pull request if you want this.

I only work on this as a background task, so sorry for the ~3 month delay
between each version of the patchset.

Regards,
Christian.
