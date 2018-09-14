Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:55093 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeINRBw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Sep 2018 13:01:52 -0400
Received: by mail-it0-f52.google.com with SMTP id f14-v6so2120674ita.4
        for <linux-pci@vger.kernel.org>; Fri, 14 Sep 2018 04:47:45 -0700 (PDT)
MIME-Version: 1.0
From: Peter Anemone <peter.anemone@gmail.com>
Date: Fri, 14 Sep 2018 14:47:33 +0300
Message-ID: <CAFtaAxH5C_4V5-z5T=CGQMLD4Yy3iKS1-=QiX1dRqpCwZAsNeA@mail.gmail.com>
Subject: REGRESSION: Boot stall related to drivers/pci/hotplug/acpiphp_glue.c
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear kernel developers
I reported a bug at Bugzilla, but Greg Kroah-Hartman pointed me in
this mailing list. Here's my bug report:

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
--Peter
