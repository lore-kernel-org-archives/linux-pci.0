Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:37258 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdGENia (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2017 09:38:30 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 031251C0186
        for <linux-pci@vger.kernel.org>; Wed,  5 Jul 2017 15:30:27 +0200 (CEST)
Date: Wed, 5 Jul 2017 15:30:26 +0200
From: Martin Mares <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Released pciutils-3.5.5
Message-ID: <mj+md-20170705.132916.7135.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, world!\n

The pciutils-3.5.5 have been released. Thanks to Bjorn Helgaas for most
of the patches.

Thus quoth the ChangeLog:

| 2017-07-05  Martin Mares <mj@ucw.cz>
| 
| 	* Released as 3.5.5.
| 
| 	* Better decoding of AER capability.
| 
| 	* "Slot Implemented" flag is decoded for PCI/PCI-X to PCIe bridges.
| 
| 	* Minor fixes of decoding other capabilities.
| 
| 	* As usually, updated pci.ids to the current snapshot of the database.


				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: How many alchemists does it take to change a light bulb?  A: Into what?
