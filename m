Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:59916 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbbINQAT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2015 12:00:19 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [193.165.110.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 330431C00ED
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2015 18:00:18 +0200 (CEST)
Date: Mon, 14 Sep 2015 18:00:16 +0200
From: Martin Mares <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Released pciutils-3.4.0
Message-ID: <mj+md-20150914.155859.17916.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, world!\n

I just released pciutils-3.4.0.

>From the ChangeLog:

2015-09-14  Martin Mares <mj@ucw.cz>

	* Released as 3.4.0.

	* On Linux, we report NUMA nodes of devices.

	* The sysfs back-end does not die on read errors
	  of optional attributes. Instead, a warning is produced.

	* Fixed several minor bugs.

	* Updated pci.ids to the current snapshot of the database.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
98% of the time I am right. Why worry about the other 3%
