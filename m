Return-Path: <SRS0=f7a+=NU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466ABC43441
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 00:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD6020883
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 00:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z7yF3rt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD6020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeKIKAD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 05:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbeKIKAD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 05:00:03 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E57220840;
        Fri,  9 Nov 2018 00:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541722919;
        bh=OSN03HVgPsQZON3BcSygDZ+c8jWcUqPVSotvP8Hjshw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z7yF3rt2aAy4nsbBryur/i8WIBZmFWmm3xZS5+N2XluhJ9B8yFmELS1N04ux//WKW
         wOHBnOS5dP1QX475CdNoXLC6kr1ciMO+r2x9elT8IIlRLgopdD0Y40yEGITFOFvtOt
         R1jzQkpJgJWgScyaDk9WbuDZ3aD5phNRHAK9pl+Y=
Date:   Thu, 8 Nov 2018 18:21:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pci: prevent sk hynix nvme from entering D3
Message-ID: <20181109002157.GK41183@google.com>
References: <20181106071214.12745-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106071214.12745-1-acelan.kao@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 06, 2018 at 03:12:13PM +0800, AceLan Kao wrote:
> It leads to the power consumption raises to 2.2W during s2idle, while
> it consumes less than 1W during long idle if put SK hynix nvme to D3
> and then enter s2idle.
> From SK hynix FE, MS Windows doesn't put nvme to D3, and uses its own
> APST feature to do the power management.
> To leverage its APST feature during s2idle, we can't disable nvme
> device while suspending, too.

I don't know how APST works, but it sounds like you want to disable D3
if you're using APST.  But that's not what this patch does; this
disables it always.

I'm not sure we want a quirk for this at all, since as Christoph
points out, it doesn't fix a functional issue as the other uses of
quirk_no_ata_d3() do.

From your emails with Christoph, it sounds like this quirk is a
workaround for a firmware defect.  If we *do* end up wanting a quirk,
the changelog should at least mention the firmware defect and maybe
check whether it has been fixed.

> BTW, prevent it from entering D3 will increase the power consumtion around
> 0.13W ~ 0.15W during short/long idle, and the power consumption during
> s2idle becomes 0.77W.
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/pci/quirks.c    | 1 +
>  include/linux/pci_ids.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4700d24e5d55..b7e6492e8311 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1332,6 +1332,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
>     occur when mode detecting */
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
>  				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SK_HYNIX, 0x1527, quirk_no_ata_d3);
>  
>  /*
>   * This was originally an Alpha-specific thing, but it really fits here.
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 69f0abe1ba1a..5f5adda07de0 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3090,4 +3090,6 @@
>  
>  #define PCI_VENDOR_ID_NCUBE		0x10ff
>  
> +#define PCI_VENDOR_ID_SK_HYNIX		0x1c5c
> +
>  #endif /* _LINUX_PCI_IDS_H */
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
