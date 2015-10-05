Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33866 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbJEOXQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2015 10:23:16 -0400
Received: by igcpb10 with SMTP id pb10so63869036igc.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2015 07:23:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mj+md-20151005.101820.16366.nikam@ucw.cz>
References: <1443810216-3215-1-git-send-email-netwerkforens@gmail.com>
	<20151003143056.GA17684@localhost>
	<mj+md-20151005.101820.16366.nikam@ucw.cz>
Date: Mon, 5 Oct 2015 16:23:16 +0200
Message-ID: <CAKsTQn=GEJwk-OFypdVLFQcXrYy4Zc8ADgX6V=rX0azfQspjkg@mail.gmail.com>
Subject: Re: [PATCH] Enumerate all undiscovered PCIe busses
From: Ruud <netwerkforens@gmail.com>
To: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Martin,

I can't check the effect of "-M" at the moment so that will have to wait.
Some context:

I got some buggy BIOS and lots of GPU's. The effect is that I need to
reenumerate busses and to let linux do that it is suggested to use
setpci to clear busnumber etc.
To make sure I do not clobber the linux drivers, I prefer to remove
the switches at the root level (echo 1>remove) and set the registers
using -H1 as hardware access.

Unfortunately on the multiprocessor intel system, three root complexes
exist: one at bus 0x00, One at bux 0x80 (and one at 0x7f IIRC). lspci
-H1 will only report bus 0x00.

It is not a problem for me to use a patched version of pciutils
locally, but hoped to share. Perhaps as an idea: make the base
bus-number configurable at the command line instead of hard coded?

Best regards,

Ruud


2015-10-05 12:21 GMT+02:00 Martin Mares <mj@ucw.cz>:
> Hi!
>
>> This appears to be a patch for pciutils, so I cc'd Martin, who
>> maintains that.
>
> Thanks, I manage to follow linux-pci only very loosely these days...
>
>> On Fri, Oct 02, 2015 at 06:23:36PM +0000, Ruud wrote:
>> > Multiple root complexes have a different start busnumber.
>> > Poll all undiscovered busses for a root complex
>
> Unfortunately, this is not correct to do. Many systems report
> junk on unused bus number (for example, they decode bus numbers
> only partially, so the buses repeat).
>
> In which situation do you need this? Is it on Linux? Only lspci,
> or your own code using libpci?
>
> Does `lspci -M' help?
>
>                                 Have a nice fortnight
> --
> Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
> Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
> "Please try to fit your code to 80 columns. That's decimal 80." -- A. Morton
