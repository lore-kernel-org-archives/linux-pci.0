Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B680C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Jan 2021 22:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAA022E01
	for <linux-pci@archiver.kernel.org>; Tue, 19 Jan 2021 22:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbhASWH1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:07:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbhASWHO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 17:07:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B89122E01;
        Tue, 19 Jan 2021 22:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611093981;
        bh=wD9MUBTJ65IU0EuUhM5UrL+/Tf1ApdfQy/qTRBmGrxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NwHEefx7CWTD6DZN/CfJ9NH9weoHDLE84OJJL7HtVyrG6K5cuWKrc+uSvbaD+TGzY
         VIdqOvzISwtisewZ6vv9CxOntdhFP0eg1Cr1sE/hrLgpbW/pQSGor7fII9BHv1VZDt
         Oe2NMVh1XuuQOZ0hW/9Lee4S+b5WXaIASBYl7c+F3ku1RfUy82yHPh5oX3Wn8xQLLy
         DRgvUP79Kfm5w0SyNZz3bDRXgch5Y02Hvuqs4FLetESBYNPco4OJfoIRB/VOjREDNQ
         nhkhvLNZuK65Aj5OjYBZFP2vSzGoTP0u5R8CbIl0UHOMMWXLNPhXbewyJReFx+rH3/
         jPLnLbgtxwL0w==
Date:   Tue, 19 Jan 2021 16:06:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniele Palmas <dnlplm@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH 1/1] PCI: add Telit Vendor ID
Message-ID: <20210119220619.GA2510101@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119102757.2395-1-dnlplm@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 19, 2021 at 11:27:57AM +0100, Daniele Palmas wrote:
> Add Telit Vendor ID to pci_ids.h

From the top of the file:

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.

If this is the case, include this patch in a series that adds multiple
uses or mention the uses in this commit log.

> Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
> ---
> Reference: https://pcisig.com/membership/member-companies?combine=telit
> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d8156a5dbee8..b10a04783287 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2590,6 +2590,8 @@
>  
>  #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
>  
> +#define PCI_VENDOR_ID_TELIT		0x1c5d
> +
>  #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
>  #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD	0x0001
>  
> -- 
> 2.17.1
> 
