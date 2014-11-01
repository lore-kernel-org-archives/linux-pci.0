Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:43644 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758848AbaKAPcN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Nov 2014 11:32:13 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 1A9471C0146
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2014 16:22:31 +0100 (CET)
Date: Sat, 1 Nov 2014 16:22:30 +0100
From: Martin Mares <mj@ucw.cz>
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Show device name as exported by BIOS (sysfs label
 attribute) (V2)
Message-ID: <mj+md-20141101.152159.17702.albireo@ucw.cz>
References: <1390856419-35985-1-git-send-email-trenn@suse.de>
 <1390895462-60699-1-git-send-email-trenn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390895462-60699-1-git-send-email-trenn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> The Device name of a PCI or PCI Express device under OS may be exported via
> ACPI _DSM function with function index 7.
> This allows to connect a described PCI device in the platform documentation
> or as labeled on the chassis with PCI devices shown via lspci.
> The kernel already exports this string through sysfs under a PCI device through
> the "label" sysfs attribute.

Thanks, applied. (With minor changes, like using OBJBUFSIZE instead of
a hard-coded constant 1024.)

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Got mole problems? Call Avogadro, 602-1023!
