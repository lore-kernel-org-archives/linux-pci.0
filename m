Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33316 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbbJGHaa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2015 03:30:30 -0400
Received: by iofh134 with SMTP id h134so13210981iof.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2015 00:30:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKsTQn=GEJwk-OFypdVLFQcXrYy4Zc8ADgX6V=rX0azfQspjkg@mail.gmail.com>
References: <1443810216-3215-1-git-send-email-netwerkforens@gmail.com>
	<20151003143056.GA17684@localhost>
	<mj+md-20151005.101820.16366.nikam@ucw.cz>
	<CAKsTQn=GEJwk-OFypdVLFQcXrYy4Zc8ADgX6V=rX0azfQspjkg@mail.gmail.com>
Date: Wed, 7 Oct 2015 09:30:29 +0200
Message-ID: <CAKsTQnne+knY2owNTYVG9hL93fDSwKK2TRQ8sp-zgjJD2qZ_ng@mail.gmail.com>
Subject: Re: [PATCH] Enumerate all undiscovered PCIe busses
From: Ruud <netwerkforens@gmail.com>
To: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Martin,

I did some more digging
>
> Does `lspci -M' help?

The -M option shows all busses (but not a tree view), but more
important setpci doesn't have the option and thus does not allow to do
settings on the alternative busses.

With respect to the "incorrectness" of the patch, one could argue that
scanning all busses is allowed as they should read 0xFF for unassigned
busses IIRC.
>From that respect it may  make more sense to have a command line
option that forces a single bus, but scans by default instead of the
other way around.

What do you think?

Best regards,

Ruud

2015-10-05 16:23 GMT+02:00 Ruud <netwerkforens@gmail.com>:
> Hi Martin,
>
> I can't check the effect of "-M" at the moment so that will have to wait.
> Some context:
>
> I got some buggy BIOS and lots of GPU's. The effect is that I need to
> reenumerate busses and to let linux do that it is suggested to use
> setpci to clear busnumber etc.
> To make sure I do not clobber the linux drivers, I prefer to remove
> the switches at the root level (echo 1>remove) and set the registers
> using -H1 as hardware access.
>
> Unfortunately on the multiprocessor intel system, three root complexes
> exist: one at bus 0x00, One at bux 0x80 (and one at 0x7f IIRC). lspci
> -H1 will only report bus 0x00.
>
> It is not a problem for me to use a patched version of pciutils
> locally, but hoped to share. Perhaps as an idea: make the base
> bus-number configurable at the command line instead of hard coded?
>
> Best regards,
>
> Ruud
>
>
> 2015-10-05 12:21 GMT+02:00 Martin Mares <mj@ucw.cz>:
>> Hi!
>>
>>> This appears to be a patch for pciutils, so I cc'd Martin, who
>>> maintains that.
>>
>> Thanks, I manage to follow linux-pci only very loosely these days...
>>
>>> On Fri, Oct 02, 2015 at 06:23:36PM +0000, Ruud wrote:
>>> > Multiple root complexes have a different start busnumber.
>>> > Poll all undiscovered busses for a root complex
>>
>> Unfortunately, this is not correct to do. Many systems report
>> junk on unused bus number (for example, they decode bus numbers
>> only partially, so the buses repeat).
>>
>> In which situation do you need this? Is it on Linux? Only lspci,
>> or your own code using libpci?
>>
>> Does `lspci -M' help?
>>
>>                                 Have a nice fortnight
>> --
>> Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
>> Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
>> "Please try to fit your code to 80 columns. That's decimal 80." -- A. Morton
