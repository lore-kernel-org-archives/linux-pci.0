Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33464 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866AbbJGT6f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2015 15:58:35 -0400
Received: by iofh134 with SMTP id h134so35217782iof.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2015 12:58:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mj+md-20151007.185700.38057.nikam@ucw.cz>
References: <1444244146-714-1-git-send-email-netwerkforens@gmail.com>
	<mj+md-20151007.185700.38057.nikam@ucw.cz>
Date: Wed, 7 Oct 2015 21:58:34 +0200
Message-ID: <CAKsTQnnmxaedSx6Bd+wzJ9LZON=d17OoCZuzE9BRe1Wd5cqHjg@mail.gmail.com>
Subject: Re: [PATCH] pciutil: Enumerate alternative PCIe bus
From: Ruud <netwerkforens@gmail.com>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Martin,

> Sorry, but this is utterly wrong. This function is not specific
> to i386 at all.

No need to say sorry, you are the expert :)

>
> I will add a different work-around soon.

Thanks, looking forward to it.

> (Also, please note that using the i386 access methods on Linux
> is inherently unsafe as there is no locking between accesses by
> different processes and by the kernel. There are available only
> as a last resort when everything else fails.)

I know, if you look at my other posts you will see I got some problems
in hooking up an external chassis to a server. But I will not bother
you with that too much. Problem is that the linux kernel will try to
follow the PCIe busnumbering that the BIOS has installed. That leads
to problems when the chassis contains about 12 switches that need to
fit in the range the bios has set (which of course is too small and
also assigns 64bit bars below 4G).

Turning knobs on the PCIe busnumbering seems to confuse the linux
kernel quite a bit when it has knowledge of that switch. However when
I remove (1 > remove) the switches at the root complex level, they
also disappear from the sysfs. This makes it difficult to manipulate
(clear) settings using the linux kernel. setpci allows to bypass the
kernel, but clearly no locking is implemented on the io ports thus if
the kernel decides to access the PCI configuration io ports at the
same time as setpci its heading for disaster.

I will keep my fingers crossed for now, I expect the kernel not to do
too much PCI config via io once the system is booted.

It would be nice to orchestrate better with the kernel however afaik
there is no lowlevel interface at the sysfs level that allows to
address devices that are not enumerated (e.g. by directly accessing
the MMIO_BASE?) and keeps the kernel "informed". But perhaps I am
wrong.


Best regards,

Ruud
