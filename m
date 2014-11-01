Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:43640 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbaKAPcN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Nov 2014 11:32:13 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 9457A1C0149
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2014 16:23:00 +0100 (CET)
Date: Sat, 1 Nov 2014 16:23:00 +0100
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Decode Interrupt Pin and Interrupt Line for
 PCI-PCI bridges
Message-ID: <mj+md-20141101.152255.17833.albireo@ucw.cz>
References: <20140308002617.1013.98008.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140308002617.1013.98008.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> Bridges can implement interrupt pins, so decode this information.  See
> PCI-to-PCI Bridge spec r1.2, sec 3.2.5.17.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Lottery -- a tax on people who can't do math.
