Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35569 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbISIUe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 19 Sep 2015 04:20:34 -0400
MIME-Version: 1.0
Date: Sat, 19 Sep 2015 10:20:33 +0200
Message-ID: <CAKsTQnn-+13Q=+hM581p=dvWnZXtnG6W-t5K4-ioNUTkEmyLMg@mail.gmail.com>
Subject: PCIe bus (re-)numbering
From: Ruud <netwerkforens@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello all,

Not a patch, not a complaint: a start of a discussion on PCIe bus
renumbering and bus numbering in general..

For bigger PCIe chassis I notice it contains lots of levels of PCIe
switches e.g. as per
commit lopg https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/commit/?h=for-pci-v4.3-rc1&id=d3934f379e3a35aed05b53aeb49b5fb872c55aa1

Imagine this kind of tree is behind a hot-plug interface at
[1c.0-[01-10]]  and is plugged in later. Like

pci tree:
-[0000:00]-+-00.0
           +-1c.0-[01-10]--+-00.0-[02-10]--+-01.0-[03]----00.0  PLX
Technology, Inc. Device 87b1
           |               |
+-02.0-[04-09]--+-00.0-[05-09]--+-01.0-[06]----00.0  PLX Technology,
Inc. Device 87b1
           |               |               |               |
    +-02.0-[07]----00.0  Broadcom Corporation Device 8650
           |               |               |               |
    +-03.0-[08]--
           |               |               |               |
    \-04.0-[09]----00.0  Altera Corporation Device 0201
           |               |               |               +-00.1  PLX
Technology, Inc. Device 87d0
           |               |               |               +-00.2  PLX
Technology, Inc. Device 87d0
           |               |               |               +-00.3  PLX
Technology, Inc. Device 87d0
           |               |               |               \-00.4  PLX
Technology, Inc. Device 87d0
           |               |
+-03.0-[0a-0f]--+-00.0-[0b-0f]--+-01.0-[0c]----00.0  PLX Technology,
Inc. Device 87b1
           |               |               |               |
    +-02.0-[0d]----00.0  Broadcom Corporation Device 8650
           |               |               |               |
    +-03.0-[0e]--
           |               |               |               |
    \-04.0-[0f]----00.0  Altera Corporation Device 0201
           |               |               |               +-00.1  PLX
Technology, Inc. Device 87d0
           |               |               |               +-00.2  PLX
Technology, Inc. Device 87d0
           |               |               |               +-00.3  PLX
Technology, Inc. Device 87d0
           |               |               |               \-00.4  PLX
Technology, Inc. Device 87d0
           |               |               \-04.0-[10]--
           |               +-00.1  PLX Technology, Inc. Device 87d0
           |               +-00.2  PLX Technology, Inc. Device 87d0
           |               +-00.3  PLX Technology, Inc. Device 87d0
           |               \-00.4  PLX Technology, Inc. Device 87d0
           +-1c.3-[11]----00.0

The current algorithm seems to allocate 8 extra busnumbers at the
hotplug switch, but clearly 8 is not sufficient for the whole tree
when it is discovered after initial numbering has been assigned. As
the PCIe routing requires the bus numbers to be consecutive as it
describes ranges there are not that many allocation strategies for bus
numbers. It is impossible to predict at boot-time which switch will
require lots of busses and which do not.

A solution is static assignment (e.g. as described by
http://article.gmane.org/gmane.linux.kernel.pci/45212), but it seems
not convenient to me.

I got the impression the most elegant way is to renumber, but at the
same time I doubt. Would the BIOS become confused? Currently the
kernel becomes confused as it renumbers the ethernet interfaces when
the bus-numbers change. Several drivers seem to be locked to the
device by its geographical routing (aka bus << 16 | device << 11 |
function << 8 ). I got the impression that this is the root of the
evil as the bus need not be as constant as expected.

E.g. the Broadcom device at bus 07 device 00 function 0 could just as
well be at bus 08 device 00 function 0 when an extra busnumber is
assigned to another switch.

Would it be an idea to describe the geographical location for this
device as the full chain..
[0000:00].[1c.0].[00.0].[02.0].[00.0].[02.0].[00.0]. This would be
invariant for busnumbering. Device drivers if in need for the bus
number (why would they in the first place?) could determine the actual
bus number at that moment in time. As a result ethernet interface
renaming would perhaps also not happen?

I am not that deep in the material yet (in respect to the kernel
code). But I got the feeling that by allowing renumbering the
assignment procedure can be greatly simplified and become more robust
for big PCIe configs... probably moving complexity to other parts like
ethernet naming.

What does the community think?

Best regards,

Ruud
