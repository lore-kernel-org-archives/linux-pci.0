Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out06.msg.oleane.net ([62.161.7.4]:38427 "EHLO
	smtp-out06.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab2L1OZm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Dec 2012 09:25:42 -0500
Received: from smtp29.msg.oleane.net (smtp29.mail.priv [172.17.20.151])
	by smtp-out06.msg.oleane.net with ESMTP id qBS9ujXJ029696
	for <linux-pci@vger.kernel.org>; Fri, 28 Dec 2012 10:56:45 +0100
Received: from ic.fr (LDijon-156-65-26-47.w80-15.abo.wanadoo.fr [80.15.105.47])
	by smtp29.msg.oleane.net (MTA) with ESMTP id qBS9aHbB003660
	for <linux-pci@vger.kernel.org>; Fri, 28 Dec 2012 10:36:17 +0100
Received: from [192.168.4.56] (unknown [192.168.4.56])
	by ic.fr (Postfix) with ESMTPA id 9A67C2222A
	for <linux-pci@vger.kernel.org>; Fri, 28 Dec 2012 10:36:17 +0100 (CET)
Message-ID: <50DD6811.7020301@ic.fr>
Date: Fri, 28 Dec 2012 10:36:17 +0100
From: =?ISO-8859-1?Q?C=E9dric_Cano?= <ccano@interfaceconcept.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Question: how can I get the real PCI address of a BAR?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I'm writing a driver for a DMA engine on the PCI bus. My architecture is 
a 36-bit PowerPC (MPC85xx).

In my DMA driver, I want to configure the DMA to transfer data to/from a 
PCI device.
I get the PCI address of the device BAR with the command pci_resource_start.
This address is 36-bit but the PCI BAR of the device is 32-bit: I can't 
use the 36-bit address to run the DMA.

In kernel documentations, it's advised not to directly read the BAR.

Is there a function which provides the real PCI address i.e. the one 
stored in the BAR?

Thanks.

C. Cano



