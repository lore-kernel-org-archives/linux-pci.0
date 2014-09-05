Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sender1.zohomail.com ([72.5.230.103]:38851 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbaIEJ0b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Sep 2014 05:26:31 -0400
Message-ID: <540974F3.4000507@zoho.com>
Date: Fri, 05 Sep 2014 01:31:47 -0700
From: Kyle Auble <kyle.auble@zoho.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Kernel Changing PCI Config at Startup, Deactivating GPU
Content-Type: multipart/mixed;
 boundary="------------000205030206090506030707"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000205030206090506030707
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello, I emailed a while back for some pointers on debugging a PCI
problem and wanted to ask again for feedback.

I was tracking an issue at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1009312,
where my Nvidia 8400M GT [10de:0426], on a Sony VGN-FZ260E, fails to
initialize when the kernel loads, before the video driver even becomes
an issue. I thought it might be a timeout issue, but now I'm thinking
that something is accidentally shutting down the GPU even earlier than
link retraining. I can confirm the problem's still there in v3.17-rc2 of
the x86 kernel.

Recently, through some more googling and debugging, I've figured out
that passing the "pci=bios" kernel parameter gets the GPU to activate.
So I can easily treat the problem for myself now, but I'd like to help
wrap up anything related to an underlying cause. Also, with the
"pci=earlydump" parameter and an init-script (at priority S98) for
running lspci, I've found that something is altering parts of the PCI
config space when the GPU fails. I've included trimmed copies of the
PCIe config space from those two tests (0000:00:01.0 is the bridge in
front of the GPU).

While a lot of the changes seem to just reflect the GPU being off in the
status registers, several other registers get wiped to zero:
1. The SERR driver is disabled in the command register
2. Both cache line size and the subsystem pci id are zeroed out
3. The interrupt line (but not the interrupt pin) goes from 05 to 00
4. The actual memory addresses in the BARs are cleared, but not the
    flags like prefetchable or 64-bit.

What's more suspicious to me is the data between the standard config
space and the first extended capability structure (at 0x60). The
subsystem id is repeated at 0x40, plus a flag of some sort at 0x50, both
of which are wiped to zero when the GPU fails to load. There's also a
single digit at 0x54 and some data at 0x58-0x60 that remain in any case.

I've tried studying the ACPI tables some too, but I'm not experienced
with ASL so it doesn't mean much that nothing stood out to me. I
narrowed things down to the DSDT because that seems to be where all the
action is. Outside of some OSI conditionals and events, the other
possibility that popped into my head is that somehow an ACPI mutex and a
kernel lock are colliding. If anyone is interested, I can send a copy of
the DSDT or any other disassembled tables to the list.

Beyond general ideas and advice about the DSDT, I'm wondering if (or
where) the kernel code is wiping these PCI config values, or if the
zeros are all just from the GPU going into hibernation. I've tried a lot
of grepping for variations of pci_write_config calls but haven't found
anything yet. Also, if this is ultimately an issue with the GPU, how
much could I even help with that? I've practiced dumping a video BIOS
but have no clue how to analyze it.

Thanks in advance,
Kyle Auble

--------------000205030206090506030707
Content-Type: text/plain; charset=UTF-8;
 name="earlydump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="earlydump"

cGNpIDAwMDA6MDA6MDEuMCBjb25maWcgc3BhY2U6CjAwOiA4NiA4MCAwMSAyYSAwNyAwMSAx
MCAwMCAwYyAwMCAwNCAwNiAxMCAwMCAwMSAwMAoxMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDEgMDEgMDAgMjAgMjAgMDAgMDAKMjA6IDAwIGNjIGYwIGNlIDAxIGQwIGYxIGRm
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCjMwOiAwMCAwMCAwMCAwMCA4OCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwNSAwMSAxYSAwMAo0MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAKNTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwCjYwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMAo3MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAKODA6IDAxIDkwIDAzIGM4IDAwIDAwIDAwIDAwIDBkIDgwIDAwIDAw
IDRkIDEwIDA1IDkwCjkwOiAwNSBhMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMAphMDogMTAgMDAgNDEgMDEgMDAgODAgMDAgMDAgMDAgMDAgMDAgMDAgMDEg
MmQgMDEgMDIKYjA6IDQzIDAwIDAxIDExIGMwIDI1IDBjIDAwIGMwIDAxIDQ4IDAwIDAwIDAw
IDAwIDAwCmMwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMAoKCnBjaSAwMDAwOjAxOjAwLjAgY29uZmlnIHNwYWNlOgowMDogZGUgMTAgMjYgMDQg
MDcgMDEgMTAgMDAgYTEgMDAgMDAgMDMgMTAgMDAgMDAgMDAKMTA6IDAwIDAwIDAwIGNlIDBj
IDAwIDAwIGQwIDAwIDAwIDAwIDAwIDA0IDAwIDAwIGNjCjIwOiAwMCAwMCAwMCAwMCAwMSAy
MCAwMCAwMCAwMCAwMCAwMCAwMCA0ZCAxMCAwNSA5MAozMDogMDAgMDAgMDAgMDAgNjAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDUgMDEgMDAgMDAKNDA6IDRkIDEwIDA1IDkwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCjUwOiAwMSAwMCAwMCAwMCAwMSAwMCAwMCAw
MCBjZSBkNiAyMyAwMCAwMCAwMCAwMCAwMAo2MDogMDEgNjggMDIgMDAgMDAgMDAgMDAgMDAg
MDUgNzggODAgMDAgMDAgMDAgMDAgMDAKNzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDEw
IDAwIDAxIDAwIGUwIDg0IDJjIDAxCjgwOiAxMCAyOCAwMCAwMCAwMSAzZCAwMSAwMCA0YiAw
MCAwMSAxMSAwMCAwMCAwMCAwMAo5MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAKYTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwCmIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMApjMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAK
--------------000205030206090506030707
Content-Type: text/plain; charset=UTF-8;
 name="init-lspci"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="init-lspci"

cGNpIDAwMDA6MDA6MDEuMCBjb25maWcgc3BhY2U6CjAwOiA4NiA4MCAwMSAyYSAwNyAwNSAx
MCAwMCAwYyAwMCAwNCAwNiAxMCAwMCAwMSAwMAoxMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDEgMDEgMDAgMjAgMjAgMDAgMjAKMjA6IDAwIGNjIGYwIGNlIDAxIGQwIGYxIGRm
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCjMwOiAwMCAwMCAwMCAwMCA4OCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwNSAwMSAxYSAwMAo0MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAKNTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwCjYwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMAo3MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAKODA6IDAxIDkwIDAzIGM4IDAwIDAwIDAwIDAwIDBkIDgwIDAwIDAw
IDRkIDEwIDA1IDkwCjkwOiAwNSBhMCAwMSAwMCAwYyAzMCBlMCBmZSA2OSA0MSAwMCAwMCAw
MCAwMCAwMCAwMAphMDogMTAgMDAgNDEgMDEgMDAgODAgMDAgMDAgMDAgMDAgMDAgMDAgMDEg
MmQgMDEgMDIKYjA6IDQzIDAwIDAxIDExIGMwIDI1IDBjIDAwIGMwIDAxIDQ4IDAwIDAwIDAw
IDAwIDAwCmMwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMApkMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAKZTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
CmYwOiAwMCAwMCAwMSA4NCAwYyAwMCAwMCBhMCA5MCAwZiAwNCAwMCAzMSAwMCAwMCAwMAoK
CnBjaSAwMDAwOjAxOjAwLjAgY29uZmlnIHNwYWNlOgowMDogZGUgMTAgMjYgMDQgMDMgMDAg
MTAgMDAgYTEgMDAgMDAgMDMgMDAgMDAgMDAgMDAKMTA6IDAwIDAwIDAwIDAwIDBjIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDA0IDAwIDAwIDAwCjIwOiAwMCAwMCAwMCAwMCAwMSAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAozMDogMDAgMDAgMDAgMDAgNjAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDEgMDAgMDAKNDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwCjUwOiAwMCAwMCAwMCAwMCAwMSAwMCAwMCAwMCBjZSBk
NiAyMyAwMCAwMCAwMCAwMCAwMAo2MDogMDEgNjggMDIgMDAgMDAgMDAgMDAgMDAgMDUgNzgg
ODAgMDAgMDAgMDAgMDAgMDAKNzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDEwIDAwIDAx
IDAwIGUwIDg0IDJjIDAxCjgwOiAxMCAyOCAwYSAwMCAwMSAzZCAwMSAwMCAwOCAwMCAwMSAx
MSAwMCAwMCAwMCAwMAo5MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAKYTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwCmIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMApjMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAKZDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwCmUwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MApmMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAK

--------------000205030206090506030707--

