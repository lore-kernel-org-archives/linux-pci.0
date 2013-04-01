Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:50815 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758222Ab3DALzu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2013 07:55:50 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 7C68E1C009A
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2013 13:45:07 +0200 (CEST)
Date: Mon, 1 Apr 2013 13:45:05 +0200
From: Martin Mares <mj@ucw.cz>
To: Kay Sievers <kay@vrfy.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samuli Suominen <ssuominen@gentoo.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: lspci -k is broken with depmod from kmod since it doesn't
 generate modules.pcimap anymore
Message-ID: <mj+md-20130401.114439.12968.albireo@ucw.cz>
References: <515213CF.7000804@gentoo.org>
 <CAErSpo5wG8FUyomySdze56-e9Jr+3DevoCGGAnhLM8vpOBvQ5w@mail.gmail.com>
 <CAMOw1v4jZXqT5Zm2ssSM8A2-ztQr1ovRi1BhQkbiCMoO3ss9Qg@mail.gmail.com>
 <CAPXgP13z3aoL+9zRpYnSkxYTdO6GFNgGRwaHbCAwFSRhnXtyjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPXgP13z3aoL+9zRpYnSkxYTdO6GFNgGRwaHbCAwFSRhnXtyjQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> Yes, that needs to be converted to use modaliases, if that feature is
> desired in lspci. The information is available in /sys and modprobe
> can be used to resolve that to module names. The old hotplug maps
> files are gone.

I'm looking into that. Expect a pciutils patch soon.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
The computer is mightier than the pen, the sword, and usually, the programmer.
