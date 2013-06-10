Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:57911 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab3FJNLT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2013 09:11:19 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id C53B11C00A9
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2013 15:11:17 +0200 (CEST)
Date: Mon, 10 Jun 2013 15:11:16 +0200
From: Martin Mares <mj@ucw.cz>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: kristen.c.accardi@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] lspci: Add L1 PM Substate capability reporting
Message-ID: <mj+md-20130610.130955.16386.albireo@ucw.cz>
References: <y>
 <1370553420-3437-1-git-send-email-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370553420-3437-1-git-send-email-david.e.box@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> From: David Box <david.e.box@linux.intel.com>
> 
> The capabilities are several L1 substates that can enable lower power
> consumption when a PCIe Link is idle.

Looks OK, but please reformat the code to follow coding style of the rest
of the file.

Also, could you please send me a test case? Preferably, it should be
the output of `lspci -vvxxxx' of some device which reports the capability.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
There is no place like ~
