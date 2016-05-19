Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:48855 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbcESQBA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2016 12:01:00 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [193.165.110.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 364491C0156
	for <linux-pci@vger.kernel.org>; Thu, 19 May 2016 18:00:52 +0200 (CEST)
Date: Thu, 19 May 2016 18:00:50 +0200
From: Martin Mares <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Released pciutils-3.5.0
Message-ID: <mj+md-20160519.160023.4433.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, world!\n

I have just released pciutils-3.5.0.

>From the ChangeLog:

	* New capabilities decoded: Downstream Port Containment,
	  Precision Time Measurement. Thanks to Keith Busch and
	  Jonathan Yong.

	* Domain numbers extended to 31 bits. This will be used by the
	  Linux kernel on some machines in near future.

	* Enhanced allocation regions are now decoded on Linux.

	* The NetBSD back-end supports PCIe extended configuration space.

	* Updated pci.ids to the current snapshot of the database.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Weather forecast for tonight: dark.
