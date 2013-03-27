Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:45364 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab3C0PLg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 11:11:36 -0400
Received: by mail-ve0-f173.google.com with SMTP id cy12so2135968veb.18
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 08:11:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5wG8FUyomySdze56-e9Jr+3DevoCGGAnhLM8vpOBvQ5w@mail.gmail.com>
References: <515213CF.7000804@gentoo.org> <CAErSpo5wG8FUyomySdze56-e9Jr+3DevoCGGAnhLM8vpOBvQ5w@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 27 Mar 2013 12:11:15 -0300
Message-ID: <CAMOw1v4jZXqT5Zm2ssSM8A2-ztQr1ovRi1BhQkbiCMoO3ss9Qg@mail.gmail.com>
Subject: Re: lspci -k is broken with depmod from kmod since it doesn't
 generate modules.pcimap anymore
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Samuli Suominen <ssuominen@gentoo.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kay Sievers <kay@vrfy.org>,
	=?ISO-8859-2?Q?Martin_Mare=B9?= <mj@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 26, 2013 at 7:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Mar 26, 2013 at 3:31 PM, Samuli Suominen <ssuominen@gentoo.org> wrote:
>> The depmod from kmod no longer generates file modules.pcimap, and lspci -k
>> relies on that as noted at:
>>
>> https://bugs.gentoo.org/show_bug.cgi?id=462982
>>
>> null pciutils-3.1.10 # grep -r modules.*map *
>> ls-kernel.c:      sprintf(name, "/lib/modules/%s/modules.pcimap",
>> uts.release);
>> lspci.c:char *opt_pcimap;                       /* Override path to Linux
>> modules.pcimap */
>> lspci.c:"-p <file>\tLook up kernel modules in a given file instead of
>> default modules.pcimap\n"
>> lspci.man:.RI /lib/modules/ kernel_version /modules.pcimap.
>
> I don't think this is a kernel problem, and I don't know where to
> point you.  Maybe Lucas or Kay will know?

I don't see why modules.{pci,usb}map are needed here. Could we change
lspci to do the equivalent to the following instead (either by calling
modprobe or using libkmod)?

for i in /sys/bus/pci/*/modalias;
do
    modprobe -R  `cat $i`
done

Kay, am I missing anything?

Lucas De Marchi
