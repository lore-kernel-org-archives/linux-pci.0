Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:37724 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab2E1N2F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 May 2012 09:28:05 -0400
Received: from albireo.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 0B5A11C00EB
	for <linux-pci@vger.kernel.org>; Mon, 28 May 2012 15:17:40 +0200 (CEST)
Date: Mon, 28 May 2012 15:17:39 +0200
From: Martin Mares <mj@ucw.cz>
To: Aaron Sierra <asierra@xes-inc.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: zero address in IO isn't always unassigned
Message-ID: <mj+md-20120528.131731.11127.albireo@ucw.cz>
References: <bf63b3bc-e471-4928-b871-7327f790bca1@zimbra>
 <f0307c62-e3e1-4cb7-a037-f410a12383cb@zimbra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f0307c62-e3e1-4cb7-a037-f410a12383cb@zimbra>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> Zero is a valid address in I/O space, so display it and it's associated
> size when IO is enabled in the PCI command register.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
The first myth of management is that it exists.
