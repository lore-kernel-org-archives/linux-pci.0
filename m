Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:60415 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab2ANOMv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jan 2012 09:12:51 -0500
Received: from albireo.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id A3B741C00BB
	for <linux-pci@vger.kernel.org>; Sat, 14 Jan 2012 15:06:31 +0100 (CET)
Date: Sat, 14 Jan 2012 15:06:31 +0100
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] Correct the end of CardBus memory windows
Message-ID: <mj+md-20120114.140622.16853.albireo@ucw.cz>
References: <20120111211619.10328.74664.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120111211619.10328.74664.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> The low twelve bits of memory base/limit are assumed to be all zeros
> and all ones, respectively.  Therefore, a window with base == limit
> is a valid 4K window, which we should display by default, and the
> true end of the window is ...fff, not ...000.  For example,

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"When I was a boy I was told that anybody could become President; I'm beginning to believe it." -- C. Darrow
