Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:56780 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759465Ab3DATw3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2013 15:52:29 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 928E41C0097
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2013 21:52:28 +0200 (CEST)
Date: Mon, 1 Apr 2013 21:52:28 +0200
From: Martin Mares <mj@ucw.cz>
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-pci@vger.kernel.org
Subject: [PCIUTILS] Re: [PATCH] update-pciids: fix PCI_COMPRESSED_IDS value
 when zlib is disabled
Message-ID: <mj+md-20130401.195202.10741.albireo@ucw.cz>
References: <1328025411-8281-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328025411-8281-1-git-send-email-vapier@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> If you build with zlib disabled, then PCI_COMPRESSED_IDS is not defined,
> which generates the line in the update script:
> 	PCI_COMPRESSED_IDS=
> which in turn causes the update script to warn:
> 	bash: [: : integer expression expected
> 
> So default it to 0 to avoid that logic.

I hope that this is already fixed in the current tree, could you please check?

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Outside of a dog, a book is man's best friend. Inside a dog, it's too dark to read.
