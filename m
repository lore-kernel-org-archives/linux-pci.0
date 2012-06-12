Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:40815 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab2FLJKI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 05:10:08 -0400
Received: from albireo.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 345641C00D7
	for <linux-pci@vger.kernel.org>; Tue, 12 Jun 2012 11:10:07 +0200 (CEST)
Date: Tue, 12 Jun 2012 11:10:06 +0200
From: Martin Mares <mj@ucw.cz>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PCIUTILS PATCH] Display whether LTR/OBFF are supported and
 enabled
Message-ID: <mj+md-20120612.090933.6448.albireo@ucw.cz>
References: <1339149604-5653-1-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339149604-5653-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> DEVCAP2 and DEVCTL2 capabilities contain information whether LTR and OBFF
> are supported and enabled. Make sure this is displayed to user as well.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Next lecture on time travel will be held on previous Monday.
