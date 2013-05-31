Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.missinglinkelectronics.com ([5.9.45.205]:59024 "EHLO
	smtp.missinglinkelectronics.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757372Ab3EaWWB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 18:22:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.missinglinkelectronics.com (Postfix) with ESMTP id F2A47792007
	for <linux-pci@vger.kernel.org>; Sat,  1 Jun 2013 00:14:31 +0200 (CEST)
Received: from smtp.missinglinkelectronics.com ([127.0.0.1])
	by localhost (smtp.missinglinkelectronics.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsv7rAwV2NiA for <linux-pci@vger.kernel.org>;
	Sat,  1 Jun 2013 00:14:29 +0200 (CEST)
Received: from [192.168.178.26] (unknown [109.235.226.171])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: david)
	by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id 97648792003
	for <linux-pci@vger.kernel.org>; Sat,  1 Jun 2013 00:14:29 +0200 (CEST)
Message-ID: <51A920C5.40209@missinglinkelectronics.com>
Date: Sat, 01 Jun 2013 00:14:29 +0200
From: David Epping <david.epping@missinglinkelectronics.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: MSI-X capability display of pciutils
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I am inspecting the MSI-X setup of some PCIe devices and have questions 
about the output of lspci.

It looks something like this:
Capabilities: [50] MSI-X: Enable+ Count=32 Masked-
     Vector table: BAR=0 offset=00002000
     PBA: BAR=0 offset=00003000

As far as I understand the PCI 3.0 specification MSI-X capabilities 
define a 32 bit register for the upper address portion of the MSI target 
addresses (at capability offset 4) and another 32 bit register pointing 
to the BAR and inter-BAR offset for the table of lower address portions 
of the MSI target addresses (at capability offset 8).
Why are there two lines in the lspci output indicating some BAR and 
offset? What do they mean?

Looking at the source code of pciutils (ls-caps.c) indicates that the 
PBA line is the information pointing to the table of MSI-X entries, 
while the vector table line is actually the upper 32bit of each MSI 
target address. This should however not be split into BAR and offset in 
that case, I believe.

What did I miss?
Thanks for clarifying,
David
