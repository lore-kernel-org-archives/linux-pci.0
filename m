Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:32807 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbbIJTzm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 15:55:42 -0400
Received: by lbcjc2 with SMTP id jc2so29133592lbc.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2015 12:55:40 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 10 Sep 2015 12:55:40 -0700
Message-ID: <CAHX5tOGkZ+ZtDymyViYrvEi+LdRbYzHU_mOa4uZK_t58G7KcqQ@mail.gmail.com>
Subject: reg: difference in pcie behavior in fedora16 vs fedora20
From: zubin kumar <zubinkumar@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

hi,

i had some queries regarding pcie behavior in fedora16 vs fedora20.

observation on fedora16 -
when i connect a pcie device in slot#3 with fedora16, the pcie device
comes up properly. i am able to see the pcie device ID, class code and
all the memory bars.

observation on fedora20 -
however when i connect the same device to a fedora20 system, the
machine itself does not boot. and the motherboard keeps sending out
the fundamental reset. then it keeps looping in a reset-bootup
sequence.

fedora16 kernel - 3.6.11 fc16 x86x64 arch
fedora20 kernel - 3.11.10-4 fc20 x86x64 arch

queries -
1) i was wondering if pcie enumeration is effected by OS or is it
controlled directly by motherboard and OS settings/kernel etc. dont
impact PCIe enum at all?
2) what could be the differences between fedora16 Vs fedora20 that
could cause the pc to boot properly in fedora16 but go into a
reset-boot loop in fedora20?
3) any log file i can check to see what might be causing the issue on the host?
4) my pcie device enumerates as an memory device. could this impact
the fedora16 / fedora20 differently?

additional observation -
i have tried other pcie slots on both fedora16 and fedora20 machines.
either machines are not able to even detect the pcie device if i use
any slot other than slot#3. i checked the BIOS settings and all the
pcie slots are enabled.

if anyone can give some insight into what could be causing the
difference in behavior in pcie enum in fedora16 vs fedora20, that
would be great.

thanks in advance ...

-- 
Thanks and regards,
Zubin Kumar
