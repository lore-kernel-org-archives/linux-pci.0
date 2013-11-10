Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:38234 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab3KJLmN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Nov 2013 06:42:13 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id B5AE51C00D2
	for <linux-pci@vger.kernel.org>; Sun, 10 Nov 2013 12:33:42 +0100 (CET)
Date: Sun, 10 Nov 2013 12:33:41 +0100
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/7] lspci: Label PCIe LnkCap "L0s Exit Latency" as
 "L0s", not "L0"
Message-ID: <mj+md-20131110.113322.9169.albireo@ucw.cz>
References: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> The PCIe Link Capabilities "L0s Exit Latency" is the latency to exit
> L0s, not L0, so label it "L0s" instead of "L0".  This matches the
> way we label the Device Capabilities "Endpoint L0s Acceptable Latency"
> field as "Latency L0s".  This also adds "Exit" to the description to
> help distinguish it from the "Acceptable Latency" fields in the
> Device Capabilities register.

Applied the whole patch set.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
To understand a program you must become both the machine and the program.
