Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx02-out.cloud.vadesecure.com ([109.197.246.59]:24599 "EHLO
        mx02-out.cloud.vadesecure.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752628AbeC2NC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 09:02:27 -0400
Received: from mx01-out.cloud.vadesecure.com (vcfr1mtao01p.vadesecure-cloud.local [172.17.25.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx02-out.cloud.vadesecure.com (vcfr1mtao02p) with ESMTPS id D22DE8029B
        for <linux-pci@vger.kernel.org>; Thu, 29 Mar 2018 14:56:17 +0200 (CEST)
Received: from mail01.bodet.com (unknown [84.239.65.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx01-out.cloud.vadesecure.com (vcfr1mtao01p) with ESMTPS id ABA787EC93
        for <linux-pci@vger.kernel.org>; Thu, 29 Mar 2018 14:56:17 +0200 (CEST)
From: "quentin.aebischer@bodet-timesport.com"
        <quentin.aebischer@bodet-timesport.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: imx6 : Problem with PCIe switch and intel i110 ethernet cards
Date: Thu, 29 Mar 2018 12:56:16 +0000
Message-ID: <dbf9ae2a715f4e83b632774546029b24@bodet-timesport.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi everyone,

This problem might be linked to the following discussion (same switch ?) : https://patchwork.kernel.org/patch/10163363/

I'm currently facing a problem with an ASmedia PCIe switch (ASM1184e - 1 to 4 ports) connected to an imx6 based board.
Endpoints devices are intel igb 110 ethernet cards.
What I see is that a random number of ethernet cards are recognized at boot (from 0 to n connected cards).
In the kernel logs, we see that the BAR assignments for the PCIe switch are changing randomly too.
I used latest kernel from linus's git repo for testing.

Kernel logs - not working (only 1 ethernet card behind switch detected) :

[    0.471337] PCI: OF: host bridge /soc/pcie@1ffc000 ranges:
[    0.471462] PCI: OF:    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.471673] PCI: OF:   MEM 0x01000000..0x01efffff -> 0x01000000
[    0.696418] imx6q-pcie 1ffc000.pcie: link up
[    0.696470] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.696512] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.697402] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.697466] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.697514] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.697558] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.699708] PCI: bus0: Fast back to back transfers disabled
[    0.700782] pci 0000:01:00.0: enabling Extended Tags
[    0.702818] PCI: bus1: Fast back to back transfers disabled
[    0.702888] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.704224] pci 0000:02:01.0: enabling Extended Tags
[    0.706516] pci 0000:02:03.0: enabling Extended Tags
[    0.708702] pci 0000:02:05.0: enabling Extended Tags
[    0.710969] pci 0000:02:07.0: enabling Extended Tags
[    0.713151] PCI: bus2: Fast back to back transfers disabled
[    0.713216] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.713317] pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.713414] pci 0000:02:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.713510] pci 0000:02:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.714213] PCI: bus3: Fast back to back transfers enabled
[    0.717967] PCI: bus4: Fast back to back transfers disabled
[    0.718704] PCI: bus5: Fast back to back transfers enabled
[    0.719446] PCI: bus6: Fast back to back transfers enabled
[    0.720060] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.720125] pci 0000:00:00.0: BAR 14: assigned [mem 0x01100000-0x013fffff]
[    0.720176] pci 0000:00:00.0: BAR 6: assigned [mem 0x01400000-0x0140ffff pref]
[    0.720235] pci 0000:01:00.0: BAR 14: assigned [mem 0x01100000-0x013fffff]
[    0.720289] pci 0000:02:03.0: BAR 14: assigned [mem 0x01100000-0x013fffff]
[    0.720334] pci 0000:02:01.0: PCI bridge to [bus 03]
[    0.720491] pci 0000:04:00.0: BAR 0: assigned [mem 0x01100000-0x011fffff]
[    0.720567] pci 0000:04:00.0: BAR 6: assigned [mem 0x01200000-0x012fffff pref]
[    0.720614] pci 0000:04:00.0: BAR 3: assigned [mem 0x01300000-0x01303fff]
[    0.720684] pci 0000:02:03.0: PCI bridge to [bus 04]
[    0.720759] pci 0000:02:03.0:   bridge window [mem 0x01100000-0x013fffff]
[    0.720864] pci 0000:02:05.0: PCI bridge to [bus 05]
[    0.721000] pci 0000:02:07.0: PCI bridge to [bus 06]
[    0.721135] pci 0000:01:00.0: PCI bridge to [bus 02-06]
[    0.721207] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x013fffff]
[    0.721310] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    0.721357] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x013fffff]
[    0.723153] pcieport 0000:00:00.0: Signaling PME with IRQ 301
[    0.724167] pcieport 0000:00:00.0: AER enabled with IRQ 301
[    0.725332] pcieport 0000:01:00.0: enabling device (0140 -> 0142)
[    0.729659] pcieport 0000:02:03.0: enabling device (0140 -> 0142)

Kernel logs - working (2 ethernet cards behind switch detected) :

[    0.471535] PCI: OF: host bridge /soc/pcie@1ffc000 ranges:
[    0.471661] PCI: OF:    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.471873] PCI: OF:   MEM 0x01000000..0x01efffff -> 0x01000000
[    0.696635] imx6q-pcie 1ffc000.pcie: link up
[    0.696687] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.696728] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.697615] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.697677] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.697726] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.697770] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.699909] PCI: bus0: Fast back to back transfers disabled
[    0.700990] pci 0000:01:00.0: enabling Extended Tags
[    0.703031] PCI: bus1: Fast back to back transfers disabled
[    0.703103] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.704443] pci 0000:02:01.0: enabling Extended Tags
[    0.706741] pci 0000:02:03.0: enabling Extended Tags
[    0.708923] pci 0000:02:05.0: enabling Extended Tags
[    0.711197] pci 0000:02:07.0: enabling Extended Tags
[    0.713383] PCI: bus2: Fast back to back transfers disabled
[    0.713447] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.713549] pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.713646] pci 0000:02:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.713741] pci 0000:02:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.714443] PCI: bus3: Fast back to back transfers enabled
[    0.718190] PCI: bus4: Fast back to back transfers disabled
[    0.718928] PCI: bus5: Fast back to back transfers enabled
[    0.722577] PCI: bus6: Fast back to back transfers disabled
[    0.723199] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.723263] pci 0000:00:00.0: BAR 14: assigned [mem 0x01100000-0x016fffff]
[    0.723314] pci 0000:00:00.0: BAR 6: assigned [mem 0x01700000-0x0170ffff pref]
[    0.723362] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.723424] pci 0000:01:00.0: BAR 14: assigned [mem 0x01100000-0x016fffff]
[    0.723468] pci 0000:01:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.723529] pci 0000:02:03.0: BAR 14: assigned [mem 0x01100000-0x013fffff]
[    0.723573] pci 0000:02:07.0: BAR 14: assigned [mem 0x01400000-0x016fffff]
[    0.723617] pci 0000:02:07.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.723662] pci 0000:02:01.0: PCI bridge to [bus 03]
[    0.723821] pci 0000:04:00.0: BAR 0: assigned [mem 0x01100000-0x011fffff]
[    0.723897] pci 0000:04:00.0: BAR 6: assigned [mem 0x01200000-0x012fffff pref]
[    0.723944] pci 0000:04:00.0: BAR 3: assigned [mem 0x01300000-0x01303fff]
[    0.724016] pci 0000:02:03.0: PCI bridge to [bus 04]
[    0.724090] pci 0000:02:03.0:   bridge window [mem 0x01100000-0x013fffff]
[    0.724197] pci 0000:02:05.0: PCI bridge to [bus 05]
[    0.724352] pci 0000:06:00.0: BAR 0: assigned [mem 0x01400000-0x014fffff]
[    0.724426] pci 0000:06:00.0: BAR 6: assigned [mem 0x01500000-0x015fffff pref]
[    0.724472] pci 0000:06:00.0: BAR 3: assigned [mem 0x01600000-0x01603fff]
[    0.724544] pci 0000:06:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    0.724615] pci 0000:02:07.0: PCI bridge to [bus 06]
[    0.724666] pci 0000:02:07.0:   bridge window [io  0x1000-0x1fff]
[    0.724738] pci 0000:02:07.0:   bridge window [mem 0x01400000-0x016fffff]
[    0.724840] pci 0000:01:00.0: PCI bridge to [bus 02-06]
[    0.724889] pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
[    0.724961] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x016fffff]
[    0.725063] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    0.725104] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    0.725149] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x016fffff]
[    0.727070] pcieport 0000:00:00.0: Signaling PME with IRQ 301
[    0.728084] pcieport 0000:00:00.0: AER enabled with IRQ 301
[    0.729244] pcieport 0000:01:00.0: enabling device (0140 -> 0143)
[    0.733422] pcieport 0000:02:03.0: enabling device (0140 -> 0142)
[    0.737584] pcieport 0000:02:07.0: enabling device (0140 -> 0143)


I must admit I have little to no experience dealing with PCIe driver issues, or even reporting problems on mailing lists for that matter.
Hope I didn't make any big mistake reporting this issue !


Best regards,

Quentin Aebischer



Ce message et toutes les pieces jointes (ci-apres le "message") sont etablis a l'intention exclusive de ses destinataires.
Si vous recevez ce message par erreur, merci de le detruire et d'en avertir immediatement l'expediteur par e-mail.
Toute utilisation de ce message non conforme a sa destination, toute diffusion ou toute publication, totale ou partielle, est interdite, sauf autorisation expresse. Les communications sur Internet n'etant pas securisees, l'expediteur informe qu'il ne peut accepter aucune responsabilite quant au contenu de ce message.
This mail message and attachments (the "message") are solely intended for the addresses. It is confidential in nature.
If you receive this message in error, please delete it and immediately notify the sender by e-mail.
Any use other than its intended purpose, dissemination or disclosure, either whole or partial, is prohibited except if formal approval is granted. As communication on the Internet is not secure, the sender does not accept responsibility for the content of this message.
