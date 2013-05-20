Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:35471 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab3ETHNI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2013 03:13:08 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 447A21C00D2
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2013 09:06:31 +0200 (CEST)
Date: Mon, 20 May 2013 09:06:30 +0200
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phillip Susi <psusi@ubuntu.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Fully decode ASPM support from Link Capabilities
Message-ID: <mj+md-20130520.070616.5436.albireo@ucw.cz>
References: <20130517194819.20832.31070.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130517194819.20832.31070.stgit@bhelgaas-glaptop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> The ASPM Support field in Link Capabilities is two bits, and all four
> possible encodings are defined as of PCIe spec r3.0.  Previously, lspci
> only decoded values 1, 2, and 3.  This adds 0, so lspci will show "ASPM
> not supported" instead of "ASPM unknown".

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
God is real, unless declared integer.
