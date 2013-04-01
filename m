Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:57040 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3DAULs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2013 16:11:48 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id AADD11C0098
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2013 22:11:46 +0200 (CEST)
Date: Mon, 1 Apr 2013 22:11:45 +0200
From: Martin Mares <mj@ucw.cz>
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-pci@vger.kernel.org, Kevin Pyle <gentoo@spamgourmet.com>
Subject: [PCIUTILS] Re: [PATCH] install: split out pcilib install to a
 dedicated target
Message-ID: <mj+md-20130401.201133.11441.albireo@ucw.cz>
References: <1328025043-6762-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328025043-6762-1-git-send-email-vapier@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> From: Kevin Pyle <gentoo@spamgourmet.com>
> 
> The "install" target manages one set of files, and the "install-pcilib"
> target manages a different set.  They both install the pci library though
> so if you try to run `make -j install install-pcilib`, things randomly
> fail.  So split out the commonly installed files into a dedicated target.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"C++: an octopus made by nailing extra legs onto a dog." -- Steve Taylor
