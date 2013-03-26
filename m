Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:51441 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab3CZWoq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 18:44:46 -0400
Received: by mail-oa0-f51.google.com with SMTP id g12so4855381oah.10
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2013 15:44:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51522314.7050203@gentoo.org>
References: <515213CF.7000804@gentoo.org> <CAErSpo5wG8FUyomySdze56-e9Jr+3DevoCGGAnhLM8vpOBvQ5w@mail.gmail.com>
 <51522314.7050203@gentoo.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 26 Mar 2013 16:44:25 -0600
Message-ID: <CAErSpo5ZSP_udOZp7XZyEfKO-AuwaptR9EXra6ALnhrzfe0Z5w@mail.gmail.com>
Subject: Re: lspci -k is broken with depmod from kmod since it doesn't
 generate modules.pcimap anymore
To: Samuli Suominen <ssuominen@gentoo.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Kay Sievers <kay@vrfy.org>,
	=?ISO-8859-2?Q?Martin_Mare=B9?= <mj@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Martin]

On Tue, Mar 26, 2013 at 4:37 PM, Samuli Suominen <ssuominen@gentoo.org> wrote:
> On 27/03/13 00:35, Bjorn Helgaas wrote:
>>
>> On Tue, Mar 26, 2013 at 3:31 PM, Samuli Suominen <ssuominen@gentoo.org>
>> wrote:
>>>
>>> The depmod from kmod no longer generates file modules.pcimap, and lspci
>>> -k
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
>>
>> I don't think this is a kernel problem, and I don't know where to
>> point you.  Maybe Lucas or Kay will know?
>
>
> This is the mailing list referred at pciutils homepage:
>
> http://mj.ucw.cz/sw/pciutils/
>
> "Feedback:
>
> You can ask questions and report bugs on the linux-pci mailing list running
> on Vger"
>
> Some bug tracking system would be nice.

Don't worry, we'll figure out where this should go.  It's just that I
don't know off the top of my head.  If it's a pciutils problem, Martin
will surely know.
