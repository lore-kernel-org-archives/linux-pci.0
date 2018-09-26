Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A6AC43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 21:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F2B20652
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 21:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR0iyFn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F2B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeI0DYK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbeI0DYK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 23:24:10 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6ABF20652;
        Wed, 26 Sep 2018 21:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537996159;
        bh=iIiAQklWhtcg4ClzmPdrxWtnQNxSy8I/QgggdBDqmYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aR0iyFn7HPwo2KCz8uhg2mDesqSdtWQesmzAIWKsbj8OOErOn76uYGUbPspOKuc9l
         kzsNSil4/Gozkk8HyaXl8jF8BI3pyP16fgqE7SE3AmCnBFiNMRWYS5rHRxZ4BlTH1V
         gMltfVESlj/YL339P+TpoWpRYG+uNammYWu8nTQo=
Date:   Wed, 26 Sep 2018 16:09:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
        lukas@wunner.de, andy.shevchenko@gmail.com,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com
Subject: Re: [PATCH v4 3/6] mpt3sas: Introdude  _scsih_get_shost_and_ioc.
Message-ID: <20180926210918.GH28024@bhelgaas-glaptop.roam.corp.google.com>
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537935759-14754-4-git-send-email-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537935759-14754-4-git-send-email-suganath-prabu.subramani@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 26, 2018 at 09:52:36AM +0530, Suganath Prabu S wrote:
> The code for getting shost and IOC is redundant so
> moved that to function "scsih_get_shost_and_ioc".
> Also checks for NULL are added to IOC and shost.
> 
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 98 ++++++++++++++++++++++++++++++------
>  1 file changed, 82 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> index 566a550..f6e92eb 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> @@ -9809,6 +9809,35 @@ _scsih_ir_shutdown(struct MPT3SAS_ADAPTER *ioc)
>  }
>  
>  /**
> + * _scsih_get_shost_and_ioc - get shost and ioc
> + *			and verify whether they are NULL or not
> + * @pdev: PCI device struct
> + * @shost: address of scsi host pointer
> + * @ioc: address of HBA adapter pointer
> + *
> + * Return zero if *shost and *ioc are not NULL otherwise return error number.
> + */
> +static int
> +_scsih_get_shost_and_ioc(struct pci_dev *pdev,
> +	struct Scsi_Host **shost, struct MPT3SAS_ADAPTER **ioc)
> +{
> +	*shost = pci_get_drvdata(pdev);
> +	if (*shost == NULL) {
> +		dev_err(&pdev->dev, "pdev's driver data is null\n");
> +		return -ENXIO;
> +	}
> +
> +	*ioc = shost_priv(*shost);
> +	if (*ioc == NULL) {
> +		dev_err(&pdev->dev, "shost's private data is null\n");
> +		return -ENXIO;

I think it's better to omit NULL pointer checks like these because
there should not be a path where we can execute this code when these
pointers are NULL.

If there *is* such a path, I think that's a serious bug and it's
better to oops when we try to dereference the NULL pointer.  If we
just return an error code, it's likely the bug will be ignored and
never fixed.

Bjorn
