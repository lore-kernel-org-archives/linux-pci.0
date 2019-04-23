Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630DEC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28026218B0
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556051941;
	bh=Sjj8m90I7Q9FV88wjR4CX6XVeFw4RPGngMOD+YOzU9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P7qwnWLOP3U1xUQRijDrmNkYOlI2cbsc4llO8VxU9yyV7tyQNMaRlgdOxJFOblPfg
	 Apw2YRUhxqBpPHC0wPs0GsYmqvKEUun+SyyD2U/3L3kUAqimOyk6siDJNEfC+GKkDz
	 okJlEBogCzVrgz1rvhxhkyBUpZPPBrg7UircVKNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfDWUjA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfDWUjA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 16:39:00 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8813218B0;
        Tue, 23 Apr 2019 20:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556051939;
        bh=Sjj8m90I7Q9FV88wjR4CX6XVeFw4RPGngMOD+YOzU9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZixZKbUS9NL/oSRs4mRkRNux8CY01b3l57x6Y1+tyKXq67dm38KXphUh9rS4DSMM7
         81ZrG16zXj4rJNNxGjPkBRiNp1rHNgbyfYgm3w0anSo9m9crEdR/Xcam4ohaTerlQW
         6Or55z+MpzPlQ9uBBiBd5x7FH/vMTpONqJE+Ev6w=
Date:   Tue, 23 Apr 2019 15:38:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Prestwood <james.prestwood@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: quirks: add vendor ID for AR9462 card
Message-ID: <20190423203856.GF14616@google.com>
References: <20190107213248.3034-1-james.prestwood@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107213248.3034-1-james.prestwood@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 07, 2019 at 01:32:48PM -0800, James Prestwood wrote:
> This card has similar issues with bus reset as the others present in
> this list.
> 
> Signed-off-by: James Prestwood <james.prestwood@linux.intel.com>

Applied to pci/virtualization for v5.2, thanks!

I added a stable tag and a Fixes tag to connect it with the other similar
quirks.

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ef7143a274e0..d9d4a95b0309 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3379,6 +3379,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
>  
>  /*
>   * Root port on some Cavium CN8xxx chips do not successfully complete a bus
> -- 
> 2.17.1
> 
