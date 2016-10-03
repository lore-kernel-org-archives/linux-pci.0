Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:54390 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbcJCUBw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2016 16:01:52 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id C38491C0106
        for <linux-pci@vger.kernel.org>; Mon,  3 Oct 2016 22:01:49 +0200 (CEST)
Date: Mon, 3 Oct 2016 22:01:48 +0200
From: Martin Mares <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: pciutils 3.5.2 released
Message-ID: <mj+md-20161003.200043.6028.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, world!\n

The pciutils version 3.5.2 has just hit kernel.org.
>From the changelog:

2016-10-03  Martin Mares <mj@ucw.cz>

	* Released as 3.5.2.

	* The L1 power management capability is now decoded more
	  thoroughly. Thanks to Rajat Jain for the patch.

	* The table of configuration registers used by setpci
	  had a bug in the definition of SUBSYSTEM_VENDOR_ID.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: How many Prolog programmers does it take to change a light bulb?  A: No.
