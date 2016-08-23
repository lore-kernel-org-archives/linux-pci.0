Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from static.146.197.76.144.clients.your-server.de ([144.76.197.146]:36433
        "EHLO desertbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756858AbcHWJpA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2016 05:45:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by desertbit.com (Postfix) with ESMTP id EB47475A10A5
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2016 11:24:49 +0200 (CEST)
Received: from desertbit.com ([127.0.0.1])
        by localhost (mail.desertbit.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Uc9p44w5LYWq for <linux-pci@vger.kernel.org>;
        Tue, 23 Aug 2016 11:24:48 +0200 (CEST)
To: linux-pci@vger.kernel.org
From: Roland Singer <roland.singer@desertbit.com>
Subject: Kernel Freeze with American Megatrends BIOS
Message-ID: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
Date: Tue, 23 Aug 2016 11:23:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

hope somebody can help me fix this kernel problem which affects the following machines:

- Clevo P651RA (i7-6700HQ/GTX 965M, part of the P6xxRx family which are also affected)
- MSI GE62 Apache Pro (i7-6700HQ/GTX 960M)
- Gigabyte P35V5 (i7-6700HQ/GTX 970M)
- Razer Blade 14" (2016) (i7-6700HQ/GTX 970M) (BIOS 5.11, 04/07/2016)


The kernel freezes if the graphical user session (Xorg & Wayland) is
started with a switched off discrete GPU card (NVIDIA).
If the discrete GPU is switched off after the graphical session start,
then everything works as expected, until the graphical session is restarted.

This problem seams to be linked to specific BIOS settings. If the computer
is started with the following command line:

acpi_osi=! acpi_osi="Windows 2009"

then the kernel freeze does not occur anymore. However this required a special
ACPI DSDT firmware patch for the Razer Blade 2016 laptop:

https://github.com/m4ng0squ4sh/razer_blade_14_2016_acpi_dsdt

I strongly recommend to fix this in the kernel and I am ready to help and solve
this problem with some help.

Here is a link to the GitHub issue with further information:

https://github.com/Bumblebee-Project/Bumblebee/issues/764#issuecomment-241212595

Here are some more detailed information:

https://github.com/Lekensteyn/acpi-stuff/blob/master/Clevo-P651RA/notes.txt

Hope somebody can help.

Thanks!

Roland Singer
