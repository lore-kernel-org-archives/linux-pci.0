Return-Path: <SRS0=QzeJ=5O=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=QzeJ=5O=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: Resizeable PCI BAR support V5
Date: Fri,  9 Jun 2017 10:59:41 +0200
Message-Id: <1496998787-6371-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi everyone,

This is the fith incarnation of this set of patches. It enables device
drivers to resize and most likely also relocate the PCI BAR of devices 
they manage to allow the CPU to access all of the device local memory at once.

This is very useful for GFX device drivers where the default PCI BAR is only
about 256MB in size for compatibility reasons, but the device easily have
multiple gigabyte of local memory.

Some changes since V4:
1. Rebased on 4.11.
2. added the rb from Andy Shevchenko to patches which look complete now.
3. Move releasing the BAR and reallocating it on error to the driver side.
4. Add amdgpu support for GMC V6 hardware generation as well.

Please review and/or comment,
Christian.
