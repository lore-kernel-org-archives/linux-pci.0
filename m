Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:46972 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161861AbaKNVem (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Nov 2014 16:34:42 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [193.165.110.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 91C221C0112
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2014 22:34:40 +0100 (CET)
Date: Fri, 14 Nov 2014 22:34:39 +0100
From: Martin Mares <mj@ucw.cz>
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Show device name as exported by BIOS (sysfs label
 attribute) (V2)
Message-ID: <mj+md-20141114.213146.9845.albireo@ucw.cz>
References: <1390856419-35985-1-git-send-email-trenn@suse.de>
 <mj+md-20141101.152159.17702.albireo@ucw.cz>
 <mj+md-20141101.161427.20168.albireo@ucw.cz>
 <15082489.1nYBiW1zHH@skinner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15082489.1nYBiW1zHH@skinner>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> Hm, while using the latest 3.3.0 tarball with our pciutils dist
> package I realized that this diff does not perfectly patch
> anymore.
> 
> Unfortunately without author, looks like a gcc guy added it.
> I paste it in the end
> You may want to incorporate (a shortened version?) it if appropriate.

No, I don't want :-)  While it simplifies the code on Linux, it breaks
many other platforms.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Why is it called "common sense" when nobody seems to have any?
