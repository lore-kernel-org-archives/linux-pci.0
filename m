Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out-mta4.ai270.net ([94.126.40.171]:43428 "EHLO
	out-mta1.ai270.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1426214AbcBRKrt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2016 05:47:49 -0500
From: Richard F <lists@keynet-technology.com>
Subject: Hint HB6 / KMC4400R
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Message-ID: <56C5A151.7080909@keynet-technology.com>
Date: Thu, 18 Feb 2016 10:47:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just to close this issue off...

I eventually abandoned the Foxconn motherboard as it was clearly at
fault, either because of the ITE 8893 bridge, BIOS, or both, and am now
using an HP 8300 CMT (Q77 chipset, 3 PCI slots, no 3rd party bridge)

The KMC4400R card works as advertised (I amended the Linux TV wiki with
some additional findings)
I posted the dmesg log to
https://bugzilla.kernel.org/show_bug.cgi?id=110851 FYI

Thanks for your help
Richard
