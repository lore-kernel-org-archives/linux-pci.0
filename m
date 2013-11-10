Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:38179 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3KJLhN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Nov 2013 06:37:13 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 76BFF1C00D4
	for <linux-pci@vger.kernel.org>; Sun, 10 Nov 2013 12:30:40 +0100 (CET)
Date: Sun, 10 Nov 2013 12:30:39 +0100
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ben Hutchings <bhutchings@solarflare.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Decode PCIe Link registers only for devices with
 links
Message-ID: <mj+md-20131110.113016.8697.albireo@ucw.cz>
References: <20130828190834.2198.99446.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130828190834.2198.99446.stgit@bhelgaas-glaptop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> Root Complex Integrated Endpoints and Root Complex Event Collectors do not
> have links and are not permitted to implement Link or Link 2 registers,
> per PCIe spec r3.0, sec 1.3.2.3.  Decoding them is useless and misleading.

Applied, thanks.  And sorry for the delay.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: What color is a chameleon on a mirror?   A: The same.
