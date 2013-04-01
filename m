Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:56468 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab3DAT0v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2013 15:26:51 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 31F3E1C009B
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2013 21:26:49 +0200 (CEST)
Date: Mon, 1 Apr 2013 21:26:48 +0200
From: Martin Mares <mj@ucw.cz>
To: Samuli Suominen <ssuominen@gentoo.org>
Cc: Kay Sievers <kay@vrfy.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: lspci -k is broken with depmod from kmod since it doesn't
 generate modules.pcimap anymore
Message-ID: <mj+md-20130401.192620.9562.albireo@ucw.cz>
References: <515213CF.7000804@gentoo.org>
 <CAErSpo5wG8FUyomySdze56-e9Jr+3DevoCGGAnhLM8vpOBvQ5w@mail.gmail.com>
 <CAMOw1v4jZXqT5Zm2ssSM8A2-ztQr1ovRi1BhQkbiCMoO3ss9Qg@mail.gmail.com>
 <CAPXgP13z3aoL+9zRpYnSkxYTdO6GFNgGRwaHbCAwFSRhnXtyjQ@mail.gmail.com>
 <mj+md-20130401.114439.12968.albireo@ucw.cz>
 <mj+md-20130401.134601.23475.albireo@ucw.cz>
 <51599529.1070401@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51599529.1070401@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> First, $PKG_CONFIG is not respected and call to pkg-config is
> hardcoded, this is likely to break cross-compiling

It's respected now.

> Since kmod is optional even in systemd source tree, and module
> loading is optional in the kernel, some embedded Linux users likely
> wants to enable/disable libkmod at will, for this there should be a
> ./configure flag of some sort

Just use "make LIBKMOD=no".

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A: No.   Q: Should I include quotations after my reply?
