Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:65212 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbaIESer (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Sep 2014 14:34:47 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Fix uninitialized variable in mvebu_get_tgt_attr()
Date: Fri, 05 Sep 2014 20:34:14 +0200
Message-ID: <5898856.RmRf87KNto@wuerfel>
In-Reply-To: <20140905202044.4c166a43@free-electrons.com>
References: <1407512045-26969-1-git-send-email-geert+renesas@glider.be> <20140905174122.GD8080@google.com> <20140905202044.4c166a43@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 05 September 2014 20:20:44 Thomas Petazzoni wrote:
> Hum, I think I would actually prefer something like:
> 
>                 if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
>                         rtype = IORESOURCE_IO;
>                 else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
>                         rtype = IORESOURCE_MEM;
> +               else
> +                       continue;
> 
> So that we're explicit with the fact that we only care about I/O and
> MEM32 resource types.

Agreed, that looks better than my patch as well.

	Arnd
