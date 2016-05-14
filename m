Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:43799 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbcENKHq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 May 2016 06:07:46 -0400
Received: from camelot.kam.mff.cuni.cz (camelot.kam.mff.cuni.cz [195.113.17.209])
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTP id A748154544F
	for <linux-pci@vger.kernel.org>; Sat, 14 May 2016 12:07:44 +0200 (CEST)
Date: Sat, 14 May 2016 12:07:44 +0200
From: Martin Mares <mj@ucw.cz>
To: Martin Mansfield <mrmansfield@ntlworld.com>
Cc: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Re: Reason for hang after running lspci -vv as root
Message-ID: <mj+md-20160514.100302.61929.camelot@ucw.cz>
References: <05A7667AE5A84EFC87D025E140351A4C@pc1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <05A7667AE5A84EFC87D025E140351A4C@pc1>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> I have been using lspci (v3.2.1) on Centos 7.2 to find out why a LSI 9420-4i
> raid controller did not work with the linux driver but when I used lspci
> with the -vv option as root the machine locked up completely and even the
> reset button did not work. lspci v3.4.1 does the same.
> As I was curious as to the reason why this could happen I compiled and ran
> it under gdb and found that the cap_vpd() function caused the problem. The
> raid card said that it supported vpd but the first call of read_vpd()
> returned a value of FFh for the variable "tag" and the next call of
> read_vpd() would hang the pc.
> I added code to return from the function after the first read_vpd but when
> the subsequent capability structures were read the values were different
> from those previously dumped using the -xxx option and lspci would crash as
> it followed the modified linked list off into oblivion.
> I commented out the call to cap_vpd() and it worked correctly and I could
> then see all the capability details.
> 
> I would like to make a request that the call to cap_vpd be disabled by
> default and enabled by a command line parameter if necessary as it is very
> likely that it is the cause of problems with the -vv and -vvv options. As
> this incident has shown, the consequences of reading the vpd can be very
> dangerous.

It smells of faulty hardware. Reading the VPD should not have any side
effects.

It seems to be a rather singular problem (your report was the first one
I received since we added dumping of VPD in 2009) and it is not limited
to lspci anyway -- other programs could crash your system by accessing
the particular file in sysfs.

I would recommend blacklisting your device in the kernel, so that VPD
will not be provided by sysfs at all.

Cc-ing linux-pci and asking for other opinions.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Anything is good and useful if it's made of chocolate.
