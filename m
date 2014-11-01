Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:44161 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbaKAQQM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Nov 2014 12:16:12 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 4288E1C0146
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2014 17:16:10 +0100 (CET)
Date: Sat, 1 Nov 2014 17:16:08 +0100
From: Martin Mares <mj@ucw.cz>
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Show device name as exported by BIOS (sysfs label
 attribute) (V2)
Message-ID: <mj+md-20141101.161427.20168.albireo@ucw.cz>
References: <1390856419-35985-1-git-send-email-trenn@suse.de>
 <1390895462-60699-1-git-send-email-trenn@suse.de>
 <mj+md-20141101.152159.17702.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mj+md-20141101.152159.17702.albireo@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Thanks, applied. (With minor changes, like using OBJBUFSIZE instead of
> a hard-coded constant 1024.)

... I realized that your way of reading the label attribute was
completely different from reading of most other device attributes.

I changed it, now it read only on request by pci_fill_info() with the
PCI_FILL_LABEL flag.

Could you please check that the version in pciutils.git still works
for you?

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A jury consists of 12 persons chosen to decide who has the better lawyer.
