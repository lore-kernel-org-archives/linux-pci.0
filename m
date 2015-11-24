Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-am1on0147.outbound.protection.outlook.com ([157.56.112.147]:39776
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753605AbbKXM6e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2015 07:58:34 -0500
From: Ramon Fried <ramon.fried@tandemg.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: PCIe endpoint generic driver
Date: Tue, 24 Nov 2015 12:26:54 +0000
Message-ID: <AM2PR02MB06895C98FE39F8BB6D958389E8060@AM2PR02MB0689.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi.
Sorry for the noob question :)
I'm currently developing a PCIe endpoint driver for a board that runs Linux.
The board will be used as an expansion PCIe card for x86 PC's.
Is there any guidelines, documentation related to PCI endpoint drivers for Linux kernel ?
I didn't find any, and I guess that I'm left with a platform driver.

If indeed the platform driver is the way to go, are there any implementations upstream I can look at ?

Thanks !
Ramon.
