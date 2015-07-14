Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33972 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbGNWT1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 18:19:27 -0400
Received: by oiab3 with SMTP id b3so16347708oia.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 15:19:27 -0700 (PDT)
Date: Tue, 14 Jul 2015 17:19:23 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rami Rosen <ramirose@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: remove a broken link in quirks.c.
Message-ID: <20150714221923.GN24416@google.com>
References: <1435761430-1353-1-git-send-email-ramirose@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435761430-1353-1-git-send-email-ramirose@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 01, 2015 at 05:37:10PM +0300, Rami Rosen wrote:
> This patch removes a broken link in drivers/pci/quirks.c.
> 
> Signed-off-by: Rami Rosen <ramirose@gmail.com>

Applied to pci/misc for v4.3, thanks!

> ---
>  drivers/pci/quirks.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index c6dc1df..f78bcc0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -163,7 +163,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82439TX,	quirk_
>   *	VIA Apollo KT133 needs PCI latency patch
>   *	Made according to a windows driver based patch by George E. Breese
>   *	see PCI Latency Adjust on http://www.viahardware.com/download/viatweak.shtm
> - *	and http://www.georgebreese.com/net/software/#PCI
>   *	Also see http://www.au-ja.org/review-kt133a-1-en.phtml for
>   *	the info on which Mr Breese based his work.
>   *
> -- 
> 2.4.3
> 
