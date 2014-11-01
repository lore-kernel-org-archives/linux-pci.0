Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:43641 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758825AbaKAPcN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Nov 2014 11:32:13 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id AD95F1C014C
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2014 16:25:30 +0100 (CET)
Date: Sat, 1 Nov 2014 16:25:29 +0100
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rajatxjain@gmail.com
Subject: Re: [PATCH] lspci: Correct Root Capabilities "CRS Software
 Visibility" bit
Message-ID: <mj+md-20141101.152518.18073.albireo@ucw.cz>
References: <20140902040346.18691.58345.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140902040346.18691.58345.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> lspci incorrectly tests bit 4, not bit 0, for "CRS Software Visibility" in
> the Root Capabilities register, so it shows "RootCap: CRSVisible-" even for
> devices that do support Software Visibility.
> 
> Use the correct definition for PCI_EXP_RTCAP_CRSVIS.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"The generation of random numbers is too important to be left to chance."
