Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:44869 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab2GDGdX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 02:33:23 -0400
Received: by ghrr11 with SMTP id r11so6127619ghr.19
        for <linux-pci@vger.kernel.org>; Tue, 03 Jul 2012 23:33:22 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 4 Jul 2012 12:03:22 +0530
Message-ID: <CAJkVMNoYYb3vpP1T5Sq3nmzpwLJUG7oRxUyX5=M9byQQjW1aew@mail.gmail.com>
Subject: 64 bit address to a pcie card
From: sumit chaudhary <flyingbee.linux@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
I have a 64 bit PCIe card that is connected to 64 bit PC running
ubuntu (Linux ubuntu 3.0.0-12-generic #20-Ubuntu SMP Fri Oct 7
14:56:25 UTC 2011 x86_64 x86_64 x86_64 GNU/Linux). Linux enumerate
this PCIe card and assign 64 bit addresses to 64 bit BARS.

Problem is that higher 4 bytes of these addresses are zero, even if
they are 64 bit address
they lies in 32 bit range.

Is it somehow possible to assign real 64 bit addresses ?

This is lspci output on my ubuntu PC.

Region 0: Memory at fddff000 (64-bit, non-prefetchable) [size=4K]
Region 2: Memory at fd000000 (64-bit, prefetchable) [size=8M]
Region 4: Memory at fc800000 (64-bit, prefetchable) [size=8M]

Regards,
Flyingbee.
