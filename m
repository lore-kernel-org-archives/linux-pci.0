Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:19616
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752719AbeBVIXy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Feb 2018 03:23:54 -0500
From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: free_irq(IRQ#0) on PCIe device with MSI enabled issue...
Date: Thu, 22 Feb 2018 08:23:52 +0000
Message-ID: <AM5PR03MB296338FECDD421CF2F438EB7D6CD0@AM5PR03MB2963.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I've been writing some drivers for Linux-can in the past years and want to =
add support of MSI in one of them (see https://git.kernel.org/pub/scm/linux=
/kernel/git/torvalds/linux.git/tree/drivers/net/can/peak_canfd).

This device driver works with legacy shared INTx over a CAN PCIe device. I'=
d like to switch to a full MSI usage of this device, which proposes up to 4=
 vectors (this device is proposed with 1, 2 or 4 CAN FD ports).

I'm running x86_64 Kernel 4.13.0-32 from Ubuntu 17.10. Everything looks ok =
as I successfully get the 4 consecutive IRQ levels. My problem is this one:=
 as soon as the driver free_irq() the FISRT IRQ level, then it does not rec=
eive any interrupt from the device anymore, for all other 3 IRQs... On the =
contrary, when the driver free_irq() one of the 3 other IRQ (instead of the=
 1st one), then there is no problem and all other interrupts (including the=
 first IRQ vector) are working as they should.

I contact you because this "issue" seems to be arch dependent: running the =
same driver and the same board on another arch (ARM), then everything works=
 like a charm: the driver can free_irq() any IRQ in any order without distu=
rbing the other ones. But running on x86, free_irq() on the FIRST MSI seems=
 to (also) free all the other ones...

Note that the driver set up MSI as described in the last version of Documen=
tation/PCI/MSI-HOWTO.txt.

Many thanks for your help in fixing this issue.

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97



--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
--
