Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:35522 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849Ab3CZWiX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Mar 2013 18:38:23 -0400
Message-ID: <51522314.7050203@gentoo.org>
Date: Wed, 27 Mar 2013 00:37:08 +0200
From: Samuli Suominen <ssuominen@gentoo.org>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Kay Sievers <kay@vrfy.org>
Subject: Re: lspci -k is broken with depmod from kmod since it doesn't generate
 modules.pcimap anymore
References: <515213CF.7000804@gentoo.org> <CAErSpo5wG8FUyomySdze56-e9Jr+3DevoCGGAnhLM8vpOBvQ5w@mail.gmail.com>
In-Reply-To: <CAErSpo5wG8FUyomySdze56-e9Jr+3DevoCGGAnhLM8vpOBvQ5w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27/03/13 00:35, Bjorn Helgaas wrote:
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

This is the mailing list referred at pciutils homepage:

http://mj.ucw.cz/sw/pciutils/

"Feedback:

You can ask questions and report bugs on the linux-pci mailing list 
running on Vger"

Some bug tracking system would be nice.
