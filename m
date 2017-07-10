Return-Path: <SRS0=31GW=6N=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=31GW=6N=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: Resizeable PCI BAR support V8
Date: Mon, 10 Jul 2017 16:59:48 +0200
Message-Id: <1499698794-1718-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi everyone,

This is the eighth incarnation of this set of patches. It enables device
drivers to resize and most likely also relocate the PCI BAR of devices 
they manage to allow the CPU to access all of the device local memory at once.

This is very useful for GFX device drivers where the default PCI BAR is only
about 256MB in size for compatibility reasons, but the device easily have
multiple gigabyte of local memory.

Some changes since the last version:
1. Rebased on Linus current master tree, going to rebase on 4.13-rc1 as soon as that is out.
2. Some more documentation on how to use the new functionality in drivers.
3. Only re-enable decoding when everything looks good.
4. Rename the new amdgpu function to better match what it is doing.

Bjorn what's you'r feeling on getting this into 4.14?

Regards,
Christian.
