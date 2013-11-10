Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:38223 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab3KJLlK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Nov 2013 06:41:10 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id B10E01C00CB
	for <linux-pci@vger.kernel.org>; Sun, 10 Nov 2013 12:41:07 +0100 (CET)
Date: Sun, 10 Nov 2013 12:41:05 +0100
From: Martin Mares <mj@ucw.cz>
To: Zheng Huai Cheng <zhenghch@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Skip scanning empty slot in sysfs_fill_slots
Message-ID: <mj+md-20131110.114005.9551.albireo@ucw.cz>
References: <526F4EB4.4090101@linux.vnet.ibm.com>
 <mj+md-20131029.120828.26872.nikam@ucw.cz>
 <1383102327.8618.0.camel@stefan-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383102327.8618.0.camel@stefan-ThinkPad-T420>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> although I am not a expert in PCI, seems this related to PCI hotplug.
> And I also found a description in kernel source code
> 
> "
> Placeholder slots:
[...]

Thanks for the explanation. I have just applied a fix similar to yours.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A LISP programmer knows value of everything, but cost of nothing.
