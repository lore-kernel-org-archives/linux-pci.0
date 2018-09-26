Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B7C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 21:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D192156F
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 21:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1gZYcLlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D192156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeI0DsD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbeI0DsD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 23:48:03 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD5221569;
        Wed, 26 Sep 2018 21:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537997587;
        bh=1YsjIyvvryxqb53OEW+csZouRMQ/aobMCIL8Ae6tV5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1gZYcLlWraLb0G84QjYDD1SIxPqbdMDPGM1kOc1sMMefN0r8kx5zHmldTXgzLJOP9
         I2YDWadDa1sPsiqAUX8CAjdMcOTYkeZyRrsDtPdaMyGsdRktYDrD0Ycig8GHtVjmGV
         AU1Oo2op9ih68NQKXns2YJQ0OI9J5fxS1gf6UNbA=
Date:   Wed, 26 Sep 2018 16:33:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
        lukas@wunner.de, andy.shevchenko@gmail.com,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com
Subject: Re: [PATCH v4 3/6] mpt3sas: Introdude  _scsih_get_shost_and_ioc.
Message-ID: <20180926213306.GA86561@bhelgaas-glaptop.roam.corp.google.com>
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

Trivial nits/questions.  In subject:

  s/Introdude/Introduce/
  s/  / /   (remove double space)
  s/\.//    (remove trailing period, also appears in patches 4, 5, 6)

On Wed, Sep 26, 2018 at 09:52:36AM +0530, Suganath Prabu S wrote:
> The code for getting shost and IOC is redundant so
> moved that to function "scsih_get_shost_and_ioc".
> Also checks for NULL are added to IOC and shost.
> 
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>

Per [1], it's good to use full names, e.g., spell out "S" when that
makes sense.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n456

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

There seems to be a convention to capitalize "IOC" and "SCSI" when
used in English text, i.e., when they're not variable names or part of
a function name.

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

I don't see any other uses of dev_printk() in this file; existing
output seems to use sdev_printk(), pr_info(), etc.  Just pointing this
out to make sure dev_printk() is really what you want here.

> +		return -ENXIO;
> +	}

Bjorn
