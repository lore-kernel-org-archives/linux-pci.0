Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F07C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 09:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD0821850
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545211268;
	bh=H064+QOZvPRnogqHQtVDmtqaJyeWrB0GMpAxGBHzdIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vKDTZ7g6Z3A1yaDYADG+UgDoVHL3LIvgKAeeePYTgL7si3760qrHx6Ad70rixVcIq
	 Df9w3t97YIbOzpON+cbWJmndPaWDNRVjpqGESZ0WxfOzTUY8b+KhUXGQ++USNRfR+F
	 jP7Gfc744lI+4H/pZjA/EkYH/fnMUrUaUeSKboco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeLSJVI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbeLSJVH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Dec 2018 04:21:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE95217D9;
        Wed, 19 Dec 2018 09:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545211267;
        bh=H064+QOZvPRnogqHQtVDmtqaJyeWrB0GMpAxGBHzdIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QiIHkgYbleSym9Tt7PmUp45uyopsaqT9AmhPWjMH44yaCz6KJVYvbI+QhHmCqszTt
         +V+Vrxi/+A2kaSE2KFGtb+UQU5fp9D/VWlCvq0Ahrxyv5U5pHHMo9/YhqwUS/Lr0ck
         31MiOffLfOgX3zoAO0AFYbRFvaHF17TrUVco1Tuo=
Date:   Wed, 19 Dec 2018 10:21:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        cyrille.pitchen@free-electrons.com, pombredanne@nexb.com,
        shawn.lin@rock-chips.com, niklas.cassel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv3 4/4] misc: pci_endpoint_test: Add the layerscape EP
 device support
Message-ID: <20181219092104.GA7356@kroah.com>
References: <20181203103505.46885-1-xiaowei.bao@nxp.com>
 <20181203103505.46885-4-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203103505.46885-4-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 03, 2018 at 06:35:05PM +0800, Xiaowei Bao wrote:
> Add the layerscape EP device support in pci_endpoint_test driver.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - no change
> v3:
>  - no change
> 
>  drivers/misc/pci_endpoint_test.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 896e2df..744d10c 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -788,6 +788,8 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
> +	/* 0x81c0: The device id of ls1046a in NXP. */

There is no need for a comment, just this line is fine:

> +	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },

If you note, no other lines have comments.

If you want to say that this is a specific device, then use a #define
with that device name and then use that define here, like the
PCI_DEVICE_ID_TI_DRA72x was done.

thanks,

greg k-h
