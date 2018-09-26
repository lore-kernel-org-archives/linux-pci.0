Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DAEC43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 21:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E023321565
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 21:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONtBHxm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E023321565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeI0DSg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeI0DSf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 23:18:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 511FD2152A;
        Wed, 26 Sep 2018 21:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537995826;
        bh=tDwrExSEYhSIcqXos3IkUmtWlaV3qGnvqtCvxjgyL5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ONtBHxm9f95KOqm+cGLnpjt0skx70NFTv/a00yQWp5JTQm1dFH3r3IyWZL3pOqq9U
         HUelZOJ7NeiXlihDOTpYl55FdP6rRG0lFLEJBQRYpSxHXAW1OO9FE3cMIvQRdqZQdB
         RyaRiJM3VPv6dMH9amds+NBCAGXLRI7hZUsW/GiA=
Date:   Wed, 26 Sep 2018 16:03:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
        lukas@wunner.de, andy.shevchenko@gmail.com,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com
Subject: Re: [PATCH v4 2/6] mpt3sas: Separate out
 mpt3sas_wait_for_ioc_to_operational
Message-ID: <20180926210345.GG28024@bhelgaas-glaptop.roam.corp.google.com>
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537935759-14754-3-git-send-email-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537935759-14754-3-git-send-email-suganath-prabu.subramani@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 26, 2018 at 09:52:35AM +0530, Suganath Prabu S wrote:
> Introduce mpt3sas_wait_for_ioc_to_operational.
> 
> This section of code "wait for IOC to be operational"
> is used in many places across the driver,
> and hence moved this section of code in to the function
> "mpt3sas_wait_for_ioc_to_operational".
> 
> Also added HBA hot unplug checks, and this returns with
> error code EFAULT, if it detects HBA is hot unplugged
> or IOC is not in operational state.

This should be two patches:

  1) Factor out the "wait for IOC" code.  This should not cause any
     functional changes (I didn't verify in your code, but this is the
     objective).

  2) Add the hot unplug checks.

This makes the patches much easier to review.

> V2 change set:
> used pci_device_is_present instead of
> mpt3sas_base_pci_device_is_unplugged
> 
> v4 Change set:
> Dont split strings in print statement

I don't know the convention in drivers/scsi, but in driver/pci, I
remove this sort of v2/v3 commentary from the changelog because it's
really not of interest after the patch is merged.  It's nice to have
it in the email, but I think if you put it after a line containing
only "--" it will be in the email but not the changelog.

> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c      | 92 +++++++++++++++++++-------------
>  drivers/scsi/mpt3sas/mpt3sas_base.h      |  4 ++
>  drivers/scsi/mpt3sas/mpt3sas_config.c    | 28 +++-------
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 26 ++-------
>  drivers/scsi/mpt3sas/mpt3sas_transport.c | 75 +++++---------------------
>  5 files changed, 81 insertions(+), 144 deletions(-)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index c880e72..9f1d8fb 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -5176,6 +5176,53 @@ _base_send_ioc_reset(struct MPT3SAS_ADAPTER *ioc, u8 reset_type, int timeout)
>  }
>  
>  /**
> + * mpt3sas_wait_for_ioc_to_operational - IOC's operational
> + *		state and HBA hot unplug status are checked here.
> + * @ioc: per adapter object
> + * @wait_count: timeout in seconds

"wait_count" is really a timeout and maybe should be named "timeout".

> + * Return:  Returns EFAULT, if HBA is hot unplugged or IOC is
> + * not in operational state, within the wait_count.
> + * And returns 0, If not hot unplugged Or ioc is in
> + * operational state.

I think you mean something like:

  Waits up to wait_count seconds for the IOC to become operational.
  Returns 0 if IOC is present and operational; otherwise returns
  -EFAULT.

> + */
> +
> +int
> +mpt3sas_wait_for_ioc_to_operational(struct MPT3SAS_ADAPTER *ioc,
> +	int wait_count)
