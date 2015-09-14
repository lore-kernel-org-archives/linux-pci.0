Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:59124 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbbINPLu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2015 11:11:50 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [193.165.110.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id B0D1B1C010A
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2015 17:04:24 +0200 (CEST)
Date: Mon, 14 Sep 2015 17:04:24 +0200
From: Martin Mares <mj@ucw.cz>
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] Report NUMA node in lspci -v
Message-ID: <mj+md-20150914.150326.15859.albireo@ucw.cz>
References: <20150422202721.GY4003@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150422202721.GY4003@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Matthew!

> In multi-socket systems, it's useful to see which node a particular
> PCI device belongs to.  Linux provides this information through sysfs,
> but some users don't like poking through sysfs themselves to find it,
> and it's pretty straightforward to report it in lspci.

First of all, sorry for the delay.

I have applied your patch and improved it slightly: NUMA nodes are
reported also in "-vv" and "-nv" modes and everything is done in
an ABI-compatible way. Look at the public Git repo, if you wish.

Thanks for the patch!

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
System going down at 5 pm to install scheduler bug.
