Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
From: Peter Anemone <peter.anemone@gmail.com>
Date: Mon, 17 Sep 2018 08:58:50 +0300
Message-ID: <CAFtaAxE8G15vU40jCKzqzuwpt_-bDfVpWuaeuy6cQ-sh=Ap2XQ@mail.gmail.com>
Subject: [REGRESSION][BISECTED] Boot stall related to drivers/pci/hotplug/acpiphp_glue.c
To: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        mika.westerberg@linux.intel.com
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear kernel developers
I reported a bug at Bugzilla, but Greg Kroah-Hartman pointed me in
mailing lists. Here's my bug report:

Linux has been unbootable for me from 4.18 upwards. Even the fallback
image does not boot. This has not been fixed yet in 4.19-rc3. acpi=off
kernel parameter lets me boot 4.18.6 and 4.19-rc3.

I used git bisect to track down the first bad commit:
84c8b58ed3addf17d3beb2e5037b001ffa65c5ef

The commit is about:
"ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=84c8b58ed3addf17d3beb2e5037b001ffa65c5ef

Linux 4.17 booted fine. Reverting commit
84c8b58ed3addf17d3beb2e5037b001ffa65c5ef makes 4.18 and 4.19-rc3
bootable again (without the acpi=off parameter).

Information about my system:
Model: HP 6730b laptop
CPU: Intel Core 2 Duo P8600
Boot manager: systemd-boot (UEFI)
More information of my system as attachments on the bug report at Bugzilla.

Link to the bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=201127

Thanks for all the good work!
-Peter
