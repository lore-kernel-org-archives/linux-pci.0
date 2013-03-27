Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:54142 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab3C0RBS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 13:01:18 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so736251wgg.12
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 10:01:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMOw1v4jZXqT5Zm2ssSM8A2-ztQr1ovRi1BhQkbiCMoO3ss9Qg@mail.gmail.com>
References: <515213CF.7000804@gentoo.org> <CAErSpo5wG8FUyomySdze56-e9Jr+3DevoCGGAnhLM8vpOBvQ5w@mail.gmail.com>
 <CAMOw1v4jZXqT5Zm2ssSM8A2-ztQr1ovRi1BhQkbiCMoO3ss9Qg@mail.gmail.com>
From: Kay Sievers <kay@vrfy.org>
Date: Wed, 27 Mar 2013 18:00:56 +0100
Message-ID: <CAPXgP13z3aoL+9zRpYnSkxYTdO6GFNgGRwaHbCAwFSRhnXtyjQ@mail.gmail.com>
Subject: Re: lspci -k is broken with depmod from kmod since it doesn't
 generate modules.pcimap anymore
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Samuli Suominen <ssuominen@gentoo.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	=?UTF-8?Q?Martin_Mare=C5=A1?= <mj@ucw.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 27, 2013 at 4:11 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> On Tue, Mar 26, 2013 at 7:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Mar 26, 2013 at 3:31 PM, Samuli Suominen <ssuominen@gentoo.org> wrote:
>>> The depmod from kmod no longer generates file modules.pcimap, and lspci -k
>>> relies on that as noted at:
>>>
>>> https://bugs.gentoo.org/show_bug.cgi?id=462982
>>>
>>> null pciutils-3.1.10 # grep -r modules.*map *
>>> ls-kernel.c:      sprintf(name, "/lib/modules/%s/modules.pcimap",
>>> uts.release);
>>> lspci.c:char *opt_pcimap;                       /* Override path to Linux
>>> modules.pcimap */
>>> lspci.c:"-p <file>\tLook up kernel modules in a given file instead of
>>> default modules.pcimap\n"
>>> lspci.man:.RI /lib/modules/ kernel_version /modules.pcimap.
>>
>> I don't think this is a kernel problem, and I don't know where to
>> point you.  Maybe Lucas or Kay will know?
>
> I don't see why modules.{pci,usb}map are needed here. Could we change
> lspci to do the equivalent to the following instead (either by calling
> modprobe or using libkmod)?
>
> for i in /sys/bus/pci/*/modalias;
> do
>     modprobe -R  `cat $i`
> done
>
> Kay, am I missing anything?

Yes, that needs to be converted to use modaliases, if that feature is
desired in lspci. The information is available in /sys and modprobe
can be used to resolve that to module names. The old hotplug maps
files are gone.

Kay
