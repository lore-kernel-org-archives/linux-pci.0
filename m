Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41374 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeIQL1R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 07:27:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id h138-v6so8417216qke.8
        for <linux-pci@vger.kernel.org>; Sun, 16 Sep 2018 23:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAFtaAxH5C_4V5-z5T=CGQMLD4Yy3iKS1-=QiX1dRqpCwZAsNeA@mail.gmail.com>
In-Reply-To: <CAFtaAxH5C_4V5-z5T=CGQMLD4Yy3iKS1-=QiX1dRqpCwZAsNeA@mail.gmail.com>
From: Peter Anemone <peter.anemone@gmail.com>
Date: Mon, 17 Sep 2018 09:01:13 +0300
Message-ID: <CAFtaAxEf87RmLZBNLZ0hu2Bi+ND2xHs3bBJnDTaiib86575zeQ@mail.gmail.com>
Subject: Re: REGRESSION: Boot stall related to drivers/pci/hotplug/acpiphp_glue.c
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ignore this thread, I missed important recipients, so I re-sent the bug report.
pe 14. syysk. 2018 klo 14.47 Peter Anemone (peter.anemone@gmail.com) kirjoitti:
>
> Dear kernel developers
> I reported a bug at Bugzilla, but Greg Kroah-Hartman pointed me in
> this mailing list. Here's my bug report:
>
> Linux has been unbootable for me from 4.18 upwards. Even the fallback
> image does not boot. This has not been fixed yet in 4.19-rc3. acpi=off
> kernel parameter lets me boot 4.18.6 and 4.19-rc3.
>
> I used git bisect to track down the first bad commit:
> 84c8b58ed3addf17d3beb2e5037b001ffa65c5ef
>
> The commit is about:
> "ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=84c8b58ed3addf17d3beb2e5037b001ffa65c5ef
>
> Linux 4.17 booted fine. Reverting commit
> 84c8b58ed3addf17d3beb2e5037b001ffa65c5ef makes 4.18 and 4.19-rc3
> bootable again (without the acpi=off parameter).
>
> Information about my system:
> Model: HP 6730b laptop
> CPU: Intel Core 2 Duo P8600
> Boot manager: systemd-boot (UEFI)
> More information of my system as attachments on the bug report at Bugzilla.
>
> Link to the bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=201127
>
> Thanks for all the good work!
> --Peter
