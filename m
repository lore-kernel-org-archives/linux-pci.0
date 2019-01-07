Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF12C43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 22:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E8E2147C
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 22:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546898895;
	bh=khkYij9MEV+RtAdOR9Nu9Ma027HNxk9omZhovR5OJa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BkuuM9Kf8aQjN6WptG+JQJkgiedfH9/3Ffi/q6Qr8xRkfySmp43EJPOqexCLYnHSR
	 eYnJwVw2UhxdlD0zkD1A2JdZtFmo3UG58/OMB7jMvWYNvgteExcZg0l0wR+eN8+Efn
	 K/cg+OqQe7Ya59y6EZqRnGYrB8xCjBTn6Szrybf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfAGWIP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:08:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfAGWIO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jan 2019 17:08:14 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B7D2070B;
        Mon,  7 Jan 2019 22:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546898894;
        bh=khkYij9MEV+RtAdOR9Nu9Ma027HNxk9omZhovR5OJa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFFKtutq+s4MvJlz+Tl6JBEDzaj2KP6nSzb+72hz4VnvFxIgoXjv8wYCX0KV0iXLn
         eS/24fuAgKec0P9RSwxlFnLyyN6mDXvozDXVAvwWvCwefFy7C9tdyaOia4P7RVgrGy
         GOuAgid/lX687nJieF53ZFoY4BH9rPCL1PFxOWw4=
Date:   Mon, 7 Jan 2019 16:08:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Prestwood <james.prestwood@linux.intel.com>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: quirks: add vendor ID for AR9462 card
Message-ID: <20190107220811.GA165042@google.com>
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

[+cc Alex, Bharat, LKML]

Hi James,

Thanks for finding this issue and for the patch.

Is there any chance you have a PCIe analyzer and could investigate
what's going on at that level?  The bus reset should be fairly similar
to what happens on a cold boot, and obviously *that* works, so I
wonder if we can figure out what the difference here is.

If this is actually broken somehow in the hardware, can you dig up a
hardware erratum and include a URL here?

If there's any chance we could fix or work around this in the kernel,
I'd rather do that than extend this quirk to more devices.

FWIW, here's a similar report, which hasn't been resolved yet:
https://lore.kernel.org/linux-pci/20181127083454.26560-1-Bharat.Bhushan@nxp.com

On Mon, Jan 07, 2019 at 01:32:48PM -0800, James Prestwood wrote:
> This card has similar issues with bus reset as the others present in
> this list.
> 
> Signed-off-by: James Prestwood <james.prestwood@linux.intel.com>
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
