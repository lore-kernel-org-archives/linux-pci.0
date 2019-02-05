Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34D0C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 23:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7645A2184E
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 23:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549409523;
	bh=Z8Hgo9sluoGqY5nBn5CIcBhL8pveCFzcBJwLbc4VLtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0fLIQmYSttNiv6z1XbmqSKcIhShy/clasLJLMxts3WfN9CV4IGln6q1K6Q1/DslIT
	 AFmRTXymLQ3pZ4LLxYKmRYBwGs/yg3z+EekkHUPqmBAnuzVVFoMjsgDGzhu1VbLMvD
	 3LWQNh4eIR0pWpT9Apu8VN+dA7i0eofy9cmO3S18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbfBEXcC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:32:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbfBEXcC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Feb 2019 18:32:02 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98FDF2175B;
        Tue,  5 Feb 2019 23:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549409521;
        bh=Z8Hgo9sluoGqY5nBn5CIcBhL8pveCFzcBJwLbc4VLtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PXBH7U9++RTP1IDOi1ZiR0EFGHSl20LZE4Wfqp3UIUPKmuvFhX1+zlgRgkdTx6CmW
         xOi29scrbcPzh5YO8/a0+NZLsm38Qfa8gcESE1GaWFnlnXnPht0PlrtdBbFfFO9e2J
         gRes7bwuJlTlJ2CMlQIMM+xWczuaz3CTtRc97rvE=
Date:   Tue, 5 Feb 2019 17:31:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Trent Piepho <tpiepho@impinj.com>,
        John Youn <john.youn@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH RESEND] PCI: Check for USB xHCI class for HAPS platform
Message-ID: <20190205233159.GC7268@google.com>
References: <a28cfcee61f0842efe114c97b566bb3d967ba3d3.1549326366.git.thinhn@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28cfcee61f0842efe114c97b566bb3d967ba3d3.1549326366.git.thinhn@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Richard, Lucas]

On Tue, Feb 05, 2019 at 01:04:28PM -0800, Thinh Nguyen wrote:
> The Synopsys HAPS USB controller has a VID PID (16c3,abcd) that matches
> to an existing PCIe controller. This quirk is intended for USB HAPS
> devices only. To fix this, check for the PCI class USB xHCI to prevent
> matching the PCIe controllers.

So there are at least three different parts with the same Vendor &
Device ID ([16c3:abcd]):

  1) Synopsys HAPS USB3 controller
  2) Synopsys PCIe IP in the NXP i.MX6QP (reported by Lukas)
  3) Synopsys PCIe IP in the NXP i.MX7D (reported by Trent)

I don't know if Synopsys is to blame for 2 & 3, or if NXP was expected
to change the Vendor ID when incorporating the Synopsys IP into the
i.MX designs.  But even leaving the default Device ID of the PCIe IP
the same as another Synopsys device was probably a bad idea.

dwc3-haps claims by Vendor & Device ID; it doesn't look at the Class
Code.  What happens when it tries to claim the PCIe IP in i.MX?

lspci also doesn't look at the Class Code when it looks up the text
name of devices, so it will print the same name for both.  Of course,
the Linux PCI ID database at https://pci-ids.ucw.cz/read/PC/16c3 shows
basically no information for the 0x16c3 Vendor ID, so it won't print
anything useful no matter what.  You could add some things there :)

> Fixes: 03e6742584af ("PCI: Override Synopsys USB 3.x HAPS device class")
> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
> ---
>  drivers/pci/quirks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b0a413f3f7ca..e2a879e93d86 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -639,8 +639,9 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)
>  		break;
>  	}
>  }
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
> -			 quirk_synopsys_haps);
> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
> +			       PCI_CLASS_SERIAL_USB_XHCI, 0,
> +			       quirk_synopsys_haps);
>  
>  /*
>   * Let's make the southbridge information explicit instead of having to
> -- 
> 2.11.0
> 
