Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:52151 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762381Ab3DCUHh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2013 16:07:37 -0400
Received: by mail-ob0-f171.google.com with SMTP id x4so1816152obh.16
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2013 13:07:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1729353177.11186718.1365018482308.JavaMail.root@redhat.com>
References: <1364444885-19751-1-git-send-email-yinghai@kernel.org>
 <CAErSpo75xgZHyUtj2vGd-iuJvL8t8mK+EA8npRP2QCMjUbZEOw@mail.gmail.com>
 <CAErSpo6AH_kazannAghUtjwBHM2_ygsFbhqsmtwNLyFKxMWdkw@mail.gmail.com>
 <707419406.5567095.1364921996288.JavaMail.root@redhat.com>
 <20130402172441.GA22478@google.com> <979994016.6599283.1364940427573.JavaMail.root@redhat.com>
 <20130403000731.GA27329@google.com> <1729353177.11186718.1365018482308.JavaMail.root@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 3 Apr 2013 14:07:16 -0600
Message-ID: <CAErSpo66AoSmygVSKNz9VCmSuz7ZVVEgWEAxU5+5AMtxrKiPpw@mail.gmail.com>
Subject: Re: [PATCH 0/2] eisa: fix eisa with PCI
To: Matthew Whitehead <mwhitehe@redhat.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 3, 2013 at 1:48 PM, Matthew Whitehead <mwhitehe@redhat.com> wrote:

> It looks like it fixed /proc/ioports, but demsg is still (null). The boot log is attached.

Huh, I don't see the "(null)" in your patch4_boot.log.  Here's what I see:

[    1.816154] pci 0000:00:07.0: Probing EISA bus 0
[    1.820819] eisa 00:00: [io  0x0c80-0x0c83]
[    1.824092] eisa 00:00: EISA: Mainboard ALR01A4 detected
[    1.833195] eisa 00:04: [io  0x4000-0x40ff]
[    1.836097] eisa 00:04: [io  0x4400-0x44ff]
[    1.840084] eisa 00:04: [io  0x4800-0x48ff]
[    1.844084] eisa 00:04: [io  0x4c00-0x4cff]
[    1.848082] eisa 00:04: EISA: slot 4: TCM5093 detected
[    1.852947] eisa 00:06: [io  0x6000-0x60ff]
[    1.856092] eisa 00:06: [io  0x6400-0x64ff]
[    1.860082] eisa 00:06: [io  0x6800-0x68ff]
[    1.864083] eisa 00:06: [io  0x6c00-0x6cff]
[    1.868083] eisa 00:06: EISA: slot 6: HWP1940 detected (forced enabled)
[    1.873097] eisa 00:07: [io  0x7000-0x70ff]
[    1.876097] eisa 00:07: [io  0x7400-0x74ff]
[    1.880083] eisa 00:07: [io  0x7800-0x78ff]
[    1.884082] eisa 00:07: [io  0x7c00-0x7cff]
[    1.888090] eisa 00:07: EISA: slot 7: TCM5920 detected
[    1.892702] pci 0000:00:07.0: EISA: Detected 3 cards

This now matches exactly what you have in /proc/ioports, which is
good.  Previously there were a bunch of these:

[    1.796731]  (null): [io  0x1000-0x10ff]
[    1.800077]  (null): [io  0x1400-0x14ff]
...

and I couldn't figure out where they came from.  But those were an
artifact of setting up the resources before checking to see whether
there was a device there.  When we discovered there was no device
there, we discarded these resources, so it wasn't harmful, but dmesg
was still ugly.  Now that we check for a device first, we skip the
resources for empty slots 1, 2, 3, 5, and 8, which is much nicer.

Thanks for all your testing!

I put the bugfixes (Yinghai's patches) in my "for-linus" branch for
v3.9.  The other printk fixes and such don't fix any actual bugs, so
I'll put them in my "next" branch for merging into v3.10.

Bjorn
