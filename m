Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:51817 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbaKJOIt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Nov 2014 09:08:49 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [193.165.110.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 6CD931C00EE
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2014 15:08:47 +0100 (CET)
Date: Mon, 10 Nov 2014 15:08:45 +0100
From: Martin Mares <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: pciutils-3.3.0 released
Message-ID: <mj+md-20141110.140704.10842.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, world!

I have just released pciutils-3.3.0 to the wild.

It has been a long time since the previous version (actually, today
is a one-year anniversary of pciutils-3.2.1) and several interesting
features have been merged.

Here is the changelog:

	* Device names exported by BIOS are displayed on Linux.

	* On Linux systems, HWDB is used to look up device names
	  when our ID database gives no match. (More precisely,
	  HWDB is consulted after local pci.ids, but before using
	  network to query online pci.ids.) Thanks to Tom Gundersen
	  for the initial patch.

	* Added experimental back-end for OS X / Darwin. Thanks to
	  Richard Yao for providing it.

	* Filters now support matching by device class. Original
	  patch by Matthew Wilcox, wrappers for ABI compatibility
	  by me.

	* Interrupt Pin and Interrupt Line registers are displayed
	  for bridge devices, too.

	* Several portability bugs have been fixed.

	* Several typos have been fixed. Also, use of questionable
	  constructs in man pages has been reduced.

	* PCIe link capabilities now include the ASPMOptComp bit.

	* The "CRS Software Visibility" bit is now decoded properly.

	* Updated pci.ids to the current snapshot of the database.

			Enjoy
					Martin
