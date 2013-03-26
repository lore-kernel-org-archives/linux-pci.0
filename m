Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:59898 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab3CZVdO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Mar 2013 17:33:14 -0400
Received: from [10.170.225.34] (85-76-17-66-nat.elisa-mobile.fi [85.76.17.66])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ssuominen)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 76E8533DAFD
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2013 21:33:13 +0000 (UTC)
Message-ID: <515213CF.7000804@gentoo.org>
Date: Tue, 26 Mar 2013 23:31:59 +0200
From: Samuli Suominen <ssuominen@gentoo.org>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: lspci -k is broken with depmod from kmod since it doesn't generate
 modules.pcimap anymore
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The depmod from kmod no longer generates file modules.pcimap, and lspci 
-k relies on that as noted at:

https://bugs.gentoo.org/show_bug.cgi?id=462982

null pciutils-3.1.10 # grep -r modules.*map *
ls-kernel.c:      sprintf(name, "/lib/modules/%s/modules.pcimap", 
uts.release);
lspci.c:char *opt_pcimap;			/* Override path to Linux modules.pcimap */
lspci.c:"-p <file>\tLook up kernel modules in a given file instead of 
default modules.pcimap\n"
lspci.man:.RI /lib/modules/ kernel_version /modules.pcimap.

Since this is not fixed in git, I figured it's time to let people know 
of it here

Thanks for looking into it,
Samuli
