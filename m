Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:37902 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab2E1Nju (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 May 2012 09:39:50 -0400
Received: from albireo.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 733E31C00EB
	for <linux-pci@vger.kernel.org>; Mon, 28 May 2012 15:39:49 +0200 (CEST)
Date: Mon, 28 May 2012 15:39:47 +0200
From: Martin Mares <mj@ucw.cz>
To: Ben Hutchings <bhutchings@solarflare.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] Only decode defined fields of PCI Express Link Control
 2
Message-ID: <mj+md-20120528.133942.12427.albireo@ucw.cz>
References: <1337264056.2496.8.camel@bwh-desktop.uk.solarflarecom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337264056.2496.8.camel@bwh-desktop.uk.solarflarecom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> On a PCI Express multi-function device associated with an upstream
> port, all bits of the Link Control 2 register are currently reserved
> on functions > 0.
> 
> The Selectable De-emphasis field is reserved on all but downstream
> ports.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Got mole problems? Call Avogadro, 602-1023!
