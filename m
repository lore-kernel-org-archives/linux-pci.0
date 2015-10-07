Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:39479 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbbJGTAt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2015 15:00:49 -0400
Date: Wed, 7 Oct 2015 21:00:47 +0200
From: Martin Mares <mj@ucw.cz>
To: Ruud <netwerkforens@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pciutil: Enumerate alternative PCIe bus
Message-ID: <mj+md-20151007.185700.38057.nikam@ucw.cz>
References: <1444244146-714-1-git-send-email-netwerkforens@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444244146-714-1-git-send-email-netwerkforens@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> diff --git a/lib/generic.c b/lib/generic.c
> index c219592..5ee37f5 100644
> --- a/lib/generic.c
> +++ b/lib/generic.c
> @@ -69,9 +69,10 @@ void
>  pci_generic_scan(struct pci_access *a)
>  {
>    byte busmap[256];
> +  int basebus = strtol(pci_get_param(a, "i386.basebus"),NULL,16);

Sorry, but this is utterly wrong. This function is not specific
to i386 at all.

I will add a different work-around soon.

(Also, please note that using the i386 access methods on Linux
is inherently unsafe as there is no locking between accesses by
different processes and by the kernel. There are available only
as a last resort when everything else fails.)

				Martin
