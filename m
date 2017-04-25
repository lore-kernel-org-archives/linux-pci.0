Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Resizeable PCI BAR support V4
Date: Tue, 25 Apr 2017 15:19:50 +0200
Message-Id: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi everyone,

This is the fourth incarnation of this set of patches. It enables device
drivers to resize and most likely also relocate the PCI BAR of devices 
they manage to allow the CPU to access all of the device local memory at once.

This is very useful for GFX device drivers where the default PCI BAR is only
about 256MB in size for compatibility reasons, but the device easily have
multiple gigabyte of local memory.

Some changes since V3:
1. A lot of minor style cleanups.
2. Make internal  functions for changing BARs directly private to the PCI subsystem.
3. Fail if any BAR is still in use when we try to change it.
4. Handle intermediate bridges as well.
5. Print some more messages when changing something.

Please review and/or comment,
Christian.
