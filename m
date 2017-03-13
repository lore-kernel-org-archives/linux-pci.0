Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: helgaas@kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Resizeable PCI BAR support V3
Date: Mon, 13 Mar 2017 13:41:32 +0100
Message-Id: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn and others on the lists,

it's over a year that I initially came up with that, but now I
finally have the time to finish it up.

This set of patches allows device drivers to resize and most likely also
relocate the PCI BAR of devices they manage to allow the CPU to access
all of the device local memory at once.

This is very useful for GFX device drivers where the default PCI BAR is only
about 256MB in size for compatibility reasons, but the device easily have
multiple gigabyte of local memory.

Additional to the pure resize functionality this set also adds a quirk to
enable a 64bit bar above 4GB on AMD Family 15h CPUs/APUs. Doing so is
actually trivial and I plan to extend this to all recent AMD CPUs/APUs.

Open questions:

1. Is this the right location to implement the 64bit BAR above 4GB for AMD CPUs?
I guess that this needs a bit more cleanup.

2. Any idea how to better handle intermediate bridges? Reprogramming them isn't
possible after drivers are loaded, but at least for GFX drivers we need to load
them first to know how large we actually want our BAR to be (and to kick our
vesafb/efifb).

Thanks in advance,
Christian.
