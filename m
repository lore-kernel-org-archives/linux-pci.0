Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from phd-imap.ethz.ch ([129.132.80.51]:48494 "EHLO phd-imap.ethz.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932510AbdHVOQ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Aug 2017 10:16:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 22 Aug 2017 16:10:29 +0200
From: =?UTF-8?Q?G=C3=BCrkan_Myczko?= <gurkan@phys.ethz.ch>
To: linux-pci@vger.kernel.org
Cc: mroos@linux.ee
Subject: pci layer problem
Message-ID: <0c50a5ba7ceadc93555c6c6dedb22829@phys.ethz.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

hello

i've been told on #debian-sparc to report this (SUN UltraSparc, SPARC64, 
Debian):

some dmesg output:
[ 2683.006327] e1000: Intel(R) PRO/1000 Network Driver - version 
7.3.21-k8-NAPI
[ 2683.006792] e1000: Copyright (c) 1999-2006 Intel Corporation.
[ 2683.007379] e1000 0000:02:02.0: can't ioremap BAR 0: [mem size 
0x00020000]
[ 2683.007772] e1000: probe of 0000:02:02.0 failed with error -5

root@sun:/# lspci
00:01.0 PCI bridge: Oracle/SUN Simba Advanced PCI Bridge (rev 13)
00:01.1 PCI bridge: Oracle/SUN Simba Advanced PCI Bridge (rev 13)
01:01.0 Bridge: Oracle/SUN EBUS (rev 01)
01:01.1 Ethernet controller: Oracle/SUN Happy Meal 10/100 Ethernet [hme] 
(rev 01)
01:02.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] 3D Rage Pro PCI (rev 5c)
01:03.0 IDE interface: Silicon Image, Inc. PCI0646 (rev 03)
02:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 
26)
02:02.0 Ethernet controller: Intel Corporation 82541PI Gigabit Ethernet 
Controller (rev 05)

root@sun:/# lspci -n
00:01.0 0604: 108e:5000 (rev 13)
00:01.1 0604: 108e:5000 (rev 13)
01:01.0 0680: 108e:1000 (rev 01)
01:01.1 0200: 108e:1001 (rev 01)
01:02.0 0300: 1002:4750 (rev 5c)
01:03.0 0101: 1095:0646 (rev 03)
02:01.0 0100: 1000:000f (rev 26)
02:02.0 0200: 8086:107c (rev 05)

root@sun:/# uname -a
Linux sun 4.9.0-2-sparc64 #1 Debian 4.9.16-1 (2017-03-22) sparc64 
GNU/Linux

thanks &yours,
