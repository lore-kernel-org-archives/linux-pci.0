Return-Path: <SRS0=Gf57=4P=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=Gf57=4P=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	helgaas@kernel.org
Subject: Resizeable PCI BAR support v6
Date: Tue,  9 May 2017 18:49:02 +0200
Message-Id: <1494348547-1465-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi everyone,

is is the sixth incarnation of this set of patches. It enables device
drivers to resize and most likely also relocate the PCI BAR of devices
they manage to allow the CPU to access all of the device local memory at once.

This is very useful for GFX device drivers where the default PCI BAR is only
about 256MB in size for compatibility reasons, but the device easily have
multiple gigabyte of local memory.

Noteable changed compared to v5:
1. Added some rb.
2. Followed Andy's suggestion on patch #3 to use a next
   pointer to make it more readable.

Mostly every comment addressed now, so next question is how we want to
merge this upstream?

I would suggest patches #1-#4 through some PCI branch and we send #5 through the drm
maintainer as soon as the dependencies are accepted?

Thanks for all the help,
Christian.
