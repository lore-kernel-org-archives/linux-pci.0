Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DFAC282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 20:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4F9217D7
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 20:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555532461;
	bh=w6+k7XrFafMXB4J0ZdJ/JTrbU1zGGBV5NLLdrw96rKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fkyl9fJzqI+a3Y26z6zyy9Rlpk1ElhHMjZWq7jCBtguCs8GIIo1ixjHbhx9OStCO3
	 7ALErqEJ3shVX2Egvo8W19NmhGdj2LnPVgY/0CfCaiwWrTyKqnlZvizNVU3eSUBXW1
	 9GFaXlb7BIekPf7ynrCgtbBzf8hAqdd5RCP++aAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfDQUVA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDQUVA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 16:21:00 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74139206BA;
        Wed, 17 Apr 2019 20:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555532459;
        bh=w6+k7XrFafMXB4J0ZdJ/JTrbU1zGGBV5NLLdrw96rKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToUwRqEqRr+ruGXWoCfUtUnHPpdbAJSje06uDGeaoIU5WK7/2oTIkoHeIO3/3uqLu
         PMSLbzNMg1hAjfPM3nFWXgAoBLeCWhFSfJYXLRETsxnmFuucOqqcZZqqKbhZF7JI1e
         F6y/v9Uhl3tKlAL/BK9PIhU5d6ETfWG7XfxDH020=
Date:   Wed, 17 Apr 2019 15:20:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove pci_request_region_exclusive()
Message-ID: <20190417202058.GS126710@google.com>
References: <20190417082356.7054-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417082356.7054-1-jthumshirn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 17, 2019 at 10:23:56AM +0200, Johannes Thumshirn wrote:
> pci_request_region_exclusive() was introduced with commit e8de1481fd71
> ("resource: allow MMIO exclusivity for device drivers") in 2.6.29 which
> was released 2008.
> 
> It never had an in tree user since then, so after 11 years later let's
> remove it.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Applied to pci/misc for v5.2, thanks a lot!

> ---
>  drivers/pci/pci.c   | 25 -------------------------
>  include/linux/pci.h |  1 -
>  2 files changed, 26 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c1b362f599a..d185b49e105a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3706,31 +3706,6 @@ int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
>  }
>  EXPORT_SYMBOL(pci_request_region);
>  
> -/**
> - *	pci_request_region_exclusive - Reserved PCI I/O and memory resource
> - *	@pdev: PCI device whose resources are to be reserved
> - *	@bar: BAR to be reserved
> - *	@res_name: Name to be associated with resource.
> - *
> - *	Mark the PCI region associated with PCI device @pdev BR @bar as
> - *	being reserved by owner @res_name.  Do not access any
> - *	address inside the PCI regions unless this call returns
> - *	successfully.
> - *
> - *	Returns 0 on success, or %EBUSY on error.  A warning
> - *	message is also printed on failure.
> - *
> - *	The key difference that _exclusive makes it that userspace is
> - *	explicitly not allowed to map the resource via /dev/mem or
> - *	sysfs.
> - */
> -int pci_request_region_exclusive(struct pci_dev *pdev, int bar,
> -				 const char *res_name)
> -{
> -	return __pci_request_region(pdev, bar, res_name, IORESOURCE_EXCLUSIVE);
> -}
> -EXPORT_SYMBOL(pci_request_region_exclusive);
> -
>  /**
>   * pci_release_selected_regions - Release selected PCI I/O and memory resources
>   * @pdev: PCI device whose resources were previously reserved
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 77448215ef5b..5f32275358cf 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1233,7 +1233,6 @@ int __must_check pci_request_regions(struct pci_dev *, const char *);
>  int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
>  void pci_release_regions(struct pci_dev *);
>  int __must_check pci_request_region(struct pci_dev *, int, const char *);
> -int __must_check pci_request_region_exclusive(struct pci_dev *, int, const char *);
>  void pci_release_region(struct pci_dev *, int);
>  int pci_request_selected_regions(struct pci_dev *, int, const char *);
>  int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
> -- 
> 2.16.4
> 
