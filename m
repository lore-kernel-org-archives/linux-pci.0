Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC64FC10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 21:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B6D20857
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 21:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554847171;
	bh=eUysAgs8ZhhS7EjhPRkrkNra5qoZYOYSU3eitf0TBGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kwX3iygrlrKHvS49n7Xxf/cdq39HGf7h1WBdBk7VmKvlNWvr78Xbqmxf4z1BjCSQu
	 9zEiCtJl2smt4uGDIrjsLqoNlnop68z4KMB/1+l9makaO7pJqwtQlIxPoca2bVWZgk
	 yivXlAmiku+uSf+0cKbkwKgocyptdM/4Oqf9n3Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfDIV7a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfDIV7a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Apr 2019 17:59:30 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DAE320820;
        Tue,  9 Apr 2019 21:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554847169;
        bh=eUysAgs8ZhhS7EjhPRkrkNra5qoZYOYSU3eitf0TBGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuC8FmxwMTOeDKPFqQTXK+M5wxL4LA5rMPjaoLPMONVX22Rl4s6ZQhS84O+FioQFa
         bhx5UCfdvplnyWS0Fytv1MdpmkUH/X1Ptry8RFs99e5iHxa0OyzGpe7pQohM1biqkP
         MUuqeSAQfDyNEKzNTqex8dRm9kTpVWzjYpr+yOQo=
Date:   Tue, 9 Apr 2019 16:59:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nikolai Kostrigin <nickel@altlinux.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD Radeon R7
 GPUs
Message-ID: <20190409215927.GC256045@google.com>
References: <20190408103725.30426-1-nickel@altlinux.org>
 <20190408103725.30426-2-nickel@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408103725.30426-2-nickel@altlinux.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

This claims to be a resend, but I don't see a previous posting.

There *was* discussion when the quirk was added two years ago for a
different device.  As part of that, Alex thought only that device
would be affected and ATS was validated on other GPUs:

  https://lore.kernel.org/lkml/BN6PR12MB165278346BE8A76B1E4412AFF7EA0@BN6PR12MB1652.namprd12.prod.outlook.com/

On Mon, Apr 08, 2019 at 01:37:25PM +0300, Nikolai Kostrigin wrote:
> ATS is broken on this hardware (at least for Stoney Ridge
> based laptop) and causes IOMMU stalls and
> system failure. Disable ATS on these devices to make them
> usable again with IOMMU enabled
> Thanks to Joerg Roedel <jroedel@suse.de> for help.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=194521
> 
> Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>

Joerg, I'm happy to merge this if you would review or ack it.  I don't
know enough to conclude that this is the root cause.  It'd be nice to
have an actual AMD erratum.  Maybe it would even have a list of
affected devices so we could get them all at once so people wouldn't
have to trip over them one by one.

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4700d24e5d55..abb2532e16bf 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4876,6 +4876,7 @@ static void quirk_no_ats(struct pci_dev *pdev)
>  
>  /* AMD Stoney platform GPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
>  #endif /* CONFIG_PCI_ATS */
>  
>  /* Freescale PCIe doesn't support MSI in RC mode */
> -- 
> 2.21.0
> 
