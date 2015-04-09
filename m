Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:41274 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbbDIOy5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 10:54:57 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [193.165.110.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id DA02B1C00EC
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2015 16:45:35 +0200 (CEST)
Date: Thu, 9 Apr 2015 16:45:33 +0200
From: Martin Mares <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Released pciutils-3.3.1
Message-ID: <mj+md-20150409.144429.16127.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, world!\n

I have released pciutils-3.3.1 with a couple of minor improvements.

>From the ChangeLog:

	* Released as 3.3.1.

	* Removed hacks for backward compatibility with Linux libc5,
	  which were breaking newer non-glibc Linux systems. Thanks
	  to Felix Janda.

	* Display VirtIO vendor-specific capability. Patch by Gerd
	  Hoffmann.

	* Fixed memory leak in name cache.

	* Updated pci.ids to the current snapshot of the database.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A: No.   Q: Should I include quotations after my reply?
