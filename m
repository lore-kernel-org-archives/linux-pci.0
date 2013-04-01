Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:56734 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759419Ab3DATsr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2013 15:48:47 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 622AA1C0098
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2013 21:48:46 +0200 (CEST)
Date: Mon, 1 Apr 2013 21:48:44 +0200
From: Martin Mares <mj@ucw.cz>
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-pci@vger.kernel.org, Marek Cruz <programatorfreez@gmail.com>
Subject: [PCIUTILS] Re: [PATCH] lib/configure: match all freebsd os's
Message-ID: <mj+md-20130401.194749.10562.albireo@ucw.cz>
References: <1328025047-6811-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328025047-6811-1-git-send-email-vapier@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

I am preparing a new release of pciutils and I discovered that I forgot about
your patches for a long, long time... Sorry about that.

> From: Marek Cruz <programatorfreez@gmail.com>
> 
> When using targets like "i686-pc-freebsd7.1", the configure script fails
> to match for the freebsd target because it only expects "freebsd".  Add
> a glob to match all freebsd targets.

Applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"The generation of random numbers is too important to be left to chance."
