Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:38837 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab3KJMoK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Nov 2013 07:44:10 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 10B1D1C00D3
	for <linux-pci@vger.kernel.org>; Sun, 10 Nov 2013 13:44:09 +0100 (CET)
Date: Sun, 10 Nov 2013 13:44:08 +0100
From: Martin Mares <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: pciutils-3.2.1 released
Message-ID: <mj+md-20131110.124302.12395.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, world!\n

I have just released version 3.2.1 of the pciutils. It's purely
a maintenance release with a couple of minor bug fixes and minor
improvements. Thus quoth the changelog:

2013-11-10  Martin Mares <mj@ucw.cz>

	* Released as 3.2.1.

	* CardBus bridge capabilities are displayed.

	* PCIe L1 PM substates are decoded.

	* Various bugs were fixed in decoding of PCIe capabilities.

	* The sysfs back-end does not spit out unnecessary warnings when
	  empty slots report only a partial device address. This actually
	  happens on IBM pSeries.

	* Updated pci.ids to the today's snapshot of the database.

				Martin
