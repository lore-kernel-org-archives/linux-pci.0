Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:60017 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab3H1QvT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 12:51:19 -0400
Received: by mail-ie0-f179.google.com with SMTP id m16so6326795ieq.10
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 09:51:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130828133337.GA8544@jtlinux>
References: <20130828133337.GA8544@jtlinux>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 28 Aug 2013 10:50:58 -0600
Message-ID: <CAErSpo5sa2cJXOUhfe5VDzxwabf0Um42ZfBwOMhF1TbwCW9G=w@mail.gmail.com>
Subject: Re: PCI reset problem
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Wed, Aug 28, 2013 at 7:33 AM, Johannes Thumshirn
<johannes.thumshirn@men.de> wrote:
> Hi List,
>
> I have a rather odd problem with a PCIe swicht/bridge which does not get
> enumerated correctly. If I issue _two_ manual rescans of the PCI bus via sysfs,
> everything get setup correctly. To work around the problem I decided to make a
> platform specific PCI quirk (for the embedded system I'm on, to not break
> anything else) and issue the pci_rescan_bus() myself as a "final" fixup. However
> this does not have any effect at all.
>
> Does anyone have an idea what I could do wrong?

A rescan doesn't really do anything differently from the initial
boot-time scan.  Maybe there's an issue with the switch taking a long
time to respond after reset?  But that doesn't seem likely, because if
you do manual rescans via sysfs, that should give plenty of time and
you wouldn't have to do it *twice*.

Maybe there's some resource or bus number allocation issue such that
we don't even get down to the problem switch the first couple of
times?

> Example:
> root@generic-powerpc:~# lspci -tv
> -[0000:00]---00.0-[01]--
> root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
> [...]
> root@generic-powerpc:~# lspci -tv
> -[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]--
>                                            +-02.0-[04]--
>                                            \-03.0-[05]--
> root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
> [...]
> root@generic-powerpc:~# lspci -tv
> -[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]----00.0  Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
>                                            +-02.0-[04]--
>                                            \-03.0-[05]--+-00.0  Pericom Semiconductor Device 400e
>                                                         +-00.1  Pericom Semiconductor Device 400e
>                                                         \-00.2  Pericom Semiconductor Device 400f

I bet that's what's happening: the first lspci shows the 00:00.0
bridge leading only to bus 01.  The second lspci shows 00:00.0 leading
to [bus 01-05], so its bus number aperture has been reconfigured.

On x86 the BIOS typically configures all the bridges so we can see all
the devices.  But it looks like your platform doesn't, and the Linux
paths that do similar configuration are not as well exercised.

Can you collect a complete dmesg log including initial boot and your
manual sysfs rescansand attach it to a new bugzilla report at
https://bugzilla.kernel.org/enter_bug.cgi?component=PCI&product=Drivers
?  There might be some generic way we can fix this.

Bjorn

> "My" rescan quirk:
> #if CONFIG_PCI
> static DEFINE_MUTEX(rescan_mutex);
> static void xm51_fixup_bridge(struct pci_dev *dev)
> {
>         struct pci_bus *b = NULL;
>
>         mutex_lock(&rescan_mutex);
>         while((b = pci_find_next_bus(b)) != NULL)
>                 pci_rescan_bus(b);
>         mutex_unlock(&rescan_mutex);
> }
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, 0x0401, xm51_fixup_bridge);
> #endif
>
>
> Thanks in advance,
> Johannes
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
