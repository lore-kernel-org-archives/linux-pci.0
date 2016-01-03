Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:54273 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbcACO24 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jan 2016 09:28:56 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [193.165.110.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 391A91C01EE
	for <linux-pci@vger.kernel.org>; Sun,  3 Jan 2016 15:22:27 +0100 (CET)
Date: Sun, 3 Jan 2016 15:22:25 +0100
From: Martin Mares <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Released pciutils-3.4.1
Message-ID: <mj+md-20160103.142204.7585.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, world!\n

I have just released pciutils-3.4.1.

>From the ChangeLog:

2016-01-03  Martin Mares <mj@ucw.cz>

	* Released as 3.4.1.

	* New capabilities decoded: Process Address Space, Page Request
	  Interface, Enhanced Allocation. Thanks to David Daney and
	  David Woodhouse.

	* DevCap SlotPowerLimit is now decoded for all components with
	  upstream ports.

	* Database mirror at SourceForge moved to GitHub.

	* Updated pci.ids to the current snapshot of the database.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Outside of a dog, a book is man's best friend. Inside a dog, it's too dark to read.
