Return-Path: <SRS0=EjUq=4K=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=EjUq=4K=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	helgaas@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Resizeable PCI BAR support v5
Date: Thu,  4 May 2017 11:31:05 +0200
Message-Id: <1493890270-1188-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi everyone,

this is the fifth incarnation of this set of patches. It enables device
drivers to resize and most likely also relocate the PCI BAR of devices
they manage to allow the CPU to access all of the device local memory at once.

This is very useful for GFX device drivers where the default PCI BAR is only
about 256MB in size for compatibility reasons, but the device easily have
multiple gigabyte of local memory.

Noteable changed compared to v4:
1. Patch #1 is new and a minor cleanup to the PCI code.
2. Some more helpers added to patch #2
3. We now print a note to syslog before releasing resources.
4. Add defines for registers and bits used to add new root hub window.

I've addressed mostly every review comment I've got so far and it looks like we
are getting closer to landing this. Any more suggestions/hints how we could
improve the patchset would be very welcome.

Thanks in advance,
Christian.
