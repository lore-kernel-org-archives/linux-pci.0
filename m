Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.mtech-ag.com ([62.225.161.3]:39098 "EHLO gg.mtech-ag.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756106Ab2DDMnu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Apr 2012 08:43:50 -0400
Received: from gg.mtech-ag.com (localhost.mtech-ag.com [127.0.0.1])
	by gg.mtech-ag.com (8.14.3/8.14.3) with ESMTP id q34Chmtp010481
	for <linux-pci@vger.kernel.org>; Wed, 4 Apr 2012 14:43:48 +0200 (CEST)
From: "Ngii Henry (STS/ZES)" <Henry.Ngii@swarco.de>
To: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Date: Wed, 4 Apr 2012 14:43:33 +0200
Subject: How to Execute Patch File for supporting multiple MSI on x86
Message-ID: <E64021631D677D4582E2EFB0A548EFFE04C3F70D67@sue06.swarco.loc>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The following command doesn't work:

[root@localhost patch]# patch -p0 -i 0001-Add-support-for-multiple-MSI-on-x86.patch
(Stripping trailing CRs from patch.)
can't find file to patch at input line 12
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|---
| arch/x86/kernel/apic/io_apic.c |  310 ++++++++++++++++++++++++++++++++++------
| arch/x86/kernel/hpet.c         |    2 +-
| drivers/pci/htirq.c            |    2 +-
| include/linux/irq.h            |    3 +-
| 4 files changed, 271 insertions(+), 46 deletions(-)
|
|diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
|index fadcd74..5e9decc 100644
|--- a/arch/x86/kernel/apic/io_apic.c
|+++ b/arch/x86/kernel/apic/io_apic.c
--------------------------
File to patch: arch/x86/kernel/apic/io_apic.c
arch/x86/kernel/apic/io_apic.c: No such file or directory
Skip this patch? [y] n
File to patch: arch/x86/kernel/hpet.c
arch/x86/kernel/hpet.c: No such file or directory
Skip this patch? [y] n
File to patch:

So How can I proceed in order to make it done?
I am using fedora 12 (Kernel 2.6.31.5). This kernel just include 1 of the 4 files that need to be changed(irq.h )
I would appreciate any advice.

Mit freundlichen Grüßen,Kind regards,

Henry Ngii
Zentrale Entwicklung ZES1

SWARCO TRAFFIC SYSTEMS GMBH
Kelterstraße 67
D-72669 Unterensingen

T. +49 7022 6025-285
F. +49 7022 6025-269
Henry.Ngii@swarco.de

www.swarco.com/sts

Firma: SWARCO TRAFFIC SYSTEMS GMBH
Rechtsform: Gesellschaft mit beschränkter Haftung

Geschäftsführer:
Karl Grüner
Paul Forstreiter

Sitz der Gesellschaft: Unterensingen
Registergericht:  Amtsgericht Stuttgart, HRB 723326

WICHTIGER HINWEIS: Der Inhalt dieser eMail ist ausschliesslich für den bezeichneten Adressaten bestimmt. Wenn Sie nicht der vorgesehene Adressat dieser eMail oder dessen Vertreter sein sollten, so beachten Sie bitte, dass jede Form der Kenntnisnahme, Veröffentlichung, Vervielfältigung oder Weitergabe des Inhalts dieser eMail unzulässig ist. Wir bitten Sie, sich in diesem Fall mit dem Absender der eMail in Verbindung zu setzen. Danke.

IMPORTANT NOTE: This e-mail communication (and any attachment/s) are confidential and are intended only for the individual(s) or entity named above and to others who have been specifically authorized to receive it. If you are not the intended recipient, please do not read, copy, use or disclose the contents of this communication to other. Please notify the sender that you have received this e-mail in error by calling the phone number indicated or by e-mail, and delete the e-mail (including any attachment/s) subsequently. This information may be subject to a professional secrecy (e.g. of auditor, tax or legal advisor), other privilege or otherwise be protected by work product immunity or other legal rules. Thank you.
