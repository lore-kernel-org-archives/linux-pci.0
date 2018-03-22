Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:38654 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeCVSsq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Mar 2018 14:48:46 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 406bKm5RnMz1qtdh
        for <linux-pci@vger.kernel.org>; Thu, 22 Mar 2018 19:48:44 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 406bKm5NMpz1r2Zp
        for <linux-pci@vger.kernel.org>; Thu, 22 Mar 2018 19:48:44 +0100 (CET)
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id QPNQfLX1tKMp for <linux-pci@vger.kernel.org>;
        Thu, 22 Mar 2018 19:48:44 +0100 (CET)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-pci@vger.kernel.org>; Thu, 22 Mar 2018 19:48:44 +0100 (CET)
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
        by janitor.denx.de (Postfix) with ESMTPS id 30A833E3
        for <linux-pci@vger.kernel.org>; Thu, 22 Mar 2018 19:48:41 +0100 (CET)
Received: from gemini.denx.de (localhost [IPv6:::1])
        by gemini.denx.de (Postfix) with ESMTP id E31D4247251
        for <linux-pci@vger.kernel.org>; Thu, 22 Mar 2018 19:48:40 +0100 (CET)
To: linux-pci@vger.kernel.org
Subject: PCIe x4 cards not detected on Z370 mainboards
From: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Date: Thu, 22 Mar 2018 19:48:40 +0100
Message-Id: <20180322184840.E31D4247251@gemini.denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

sorry if this is not an appropriate list for my question - any
pointers are welcome.

Short version:

Both on a GIGABYTE Z370-HD3 and on a MSI Z370 TOMAHAWK mainboard
neither of my LSI SAS controllers (SAS3444 E PCIe x4 and
SAS3442E-R PCIe x4) gets detected.  Not by the system BIOS, there is
not messages from the SAS Controller BIOS, Linux does not see it in
the PCI bus scan - nothing.  Both controllers work find in older
mainboards.

Is this a known problem?  Can it be fixed?


More details:

I tried all combinations of PCIe slots with one or with both cards -
none is working.

I asked MSI support, who told me:

	These are old controllers which don't support UEFI/GOP. this
	is the reason they don't work.  Cards which have only legacy
	support cannot be operated in modern mainboards.

Hm...  but I also have a PCIe x 1 Adaptect SCSI controller
(29320LPE, firmware version v4.31.4 of 2007) which certainly never
heard of UEFI/GOP before, and this is working fine: I see the BIOS
messages when it does the SCSI bus scan, I see the initialization
under Linux, and I can access the SCSI devices under Linux.

Later they told me to make sure Windows 10 WHQL Option is disabled,
and to try switching PCIe speed from Auto to Gen_2 or Gen_1.

None of this helped.

These are two different mainboards from two different vendors, which
otherwise work fine.  the common part is the "Z370" in the name, and
the fact that my PCIe x4 SAS controllers are not detected.

I don't know if thisis relevant, but in Linux (Fedora 27,
4.15.6-300.fc27.x86_64 kernel), I see these error messages:

[    0.138056] ACPI: Added _OSI(Module Device)
[    0.143002] ACPI: Added _OSI(Processor Device)
[    0.147001] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.152001] ACPI: Added _OSI(Processor Aggregator Device)
[    0.158907] ACPI Error: [_SB_.PCI0.RP05.PXSX] Namespace lookup failure, AE_NOT_FOUND (20170831/dswload2-191)
[    0.169002] ACPI Exception: AE_NOT_FOUND, During name lookup/catalog (20170831/psobject-252)
[    0.178001] ACPI Error: Method parse/execution failed \_SB.PCI0.RP04.PXSX, AE_NOT_FOUND (20170831/psparse-550)
[    0.188184] ACPI Error: [_SB_.PCI0.RP09.PXSX] Namespace lookup failure, AE_NOT_FOUND (20170831/dswload2-191)
[    0.198001] ACPI Exception: AE_NOT_FOUND, During name lookup/catalog (20170831/psobject-252)
[    0.207001] ACPI Error: Method parse/execution failed \_SB.PCI0.RP08.PXSX, AE_NOT_FOUND (20170831/psparse-550)
[    0.218089] ACPI: Executed 49 blocks of module-level executable AML code
...

Booting with acpi=off on the kernel command line makes these
disappear (of course), but this does not help either - the SAS
controller does not magically show up.

Has anybody any clue 1) what could be causing these problems and
2) how to fix this, or at least 3) where I should ask for help?

Thanks in advance.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Don't worry about people stealing your ideas. If your ideas are  any
good, you'll have to ram them down people's throats."  - Howard Aiken
