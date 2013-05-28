Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from server02.mc0.hosteurope.de ([92.51.170.73]:55007 "EHLO
	server02.mc0.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932788Ab3E1FjE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 01:39:04 -0400
To: <linux-pci@vger.kernel.org>
Subject: 14e4:16bc SD card slot not working on Acer Aspire One 756
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Tue, 28 May 2013 07:21:54 +0200
From: Stefan Frings <stefan@stefanfrings.de>
Cc: <1178131@bugs.launchpad.net>
Message-ID: <da540280c592e7bbe5ab96cbe5e47ddc-EhVcX11DRwJZRxoEDQMJVjBXdh9XVlpBXkJHHFtcNkhYS1oKWUF0BUtdMl5cR0wFXlJcQVw=-webmailer2@server03.webmailer.hosteurope.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 14e4:16bc SD card slot not working on Acer Aspire One 756

 The memory card read (Broadcaom BCM57765) does not work on Aver Aspire 
 One 756 because Linux enabled ASPM L1 on the PCIe channel since a 
 related change in Kernel 3.0.20. Please change the code so that only 
 APSN L0s is enabled on that machine on the PCIe channel 00:1c.2.

 Until a solution is available, I use the following command as a 
 workaround: sudo setpci -s 00:1c.2 0x50.B=0x41

 Description of the change that introduced the problem: 
 https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=6cac12dfab9c57a4f76821412224b226a9b08dff

 The full problem description with log files and result of my bisecting 
 can be found in the Ubuntu Bug L#1178131.

 Link to the Ubuntu Bug report: 
 https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1178131

 The problem is still present in Kernel 3.10-rc1, rc2 and rc3.
 Kernels before 3.0.20 are NOT affected by the problem.
 The first problematic Linux version is 3.0.20.

 Steps to reproduce:

 - Boot Linux with any Kernel after 3.0.19 (Using Gnome 3 Desktop)
 - Insert any memory card into the card reader
 - Problem: nothing happens
 - Problem: In dmesg, the mmc driver reports communication timeouts for 
 the card reader
 - Remove the memory card
 - Enter sudo setpci -s 00:1c.2 0x50.B=0x41 (This disables ASPM L1)
 - Insert the memory card
 - Result: It gets detected immediately. Gnome pop-ups a related 
 notification window.
 - Remove the memory card
 - Enter sudo setpci -s 00:1c.2 0x50.B=0x43 (this is the value that the 
 Linux Kernel sets during boot)
 - Insert the memory card
 - Problem: The card is not detected

-- 
 Stefan Frings
 Markenstraße 12
 40227 Düsseldorf


