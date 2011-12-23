Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:50753 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab1LWP3D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Dec 2011 10:29:03 -0500
Date: Fri, 23 Dec 2011 16:29:01 +0100
From: Martin Mares <mj@ucw.cz>
To: Christian Inci <chris.pcguy.inci@gmail.com>
Cc: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] fix for a bash issue [...]
Message-ID: <mj+md-20111223.152610.30459.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> diff --git a/update-pciids.sh b/update-pciids.sh
> index 5e77109..708e3b3 100755
> --- a/update-pciids.sh
> +++ b/update-pciids.sh
> @@ -5,7 +5,7 @@
>  set -e
>  SRC="http://pciids.sourceforge.net/v2.2/pci.ids"
>  DEST=pci.ids
> -PCI_COMPRESSED_IDS=
> +PCI_COMPRESSED_IDS=0

It is quite improbable that this patch changes anything -- when sed'ing
update-pciids.sh to get the update-pciids which is really installed,
the right-hand side of this assignment is replaced.

Better change the condition, so that it can cope with an empty variable
(e.g., use "==" instead of "-eq").

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"The road to hell is paved with melting snowballs." -- Larry Wall
