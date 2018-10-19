Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0846ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22CE21479
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 13:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22CE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJSV1P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:27:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727227AbeJSV1P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 17:27:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6833BAEC2;
        Fri, 19 Oct 2018 13:21:07 +0000 (UTC)
Date:   Fri, 19 Oct 2018 15:21:05 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Allow runtime PM without callback functions
Message-ID: <20181019152105.0325a663@endymion>
In-Reply-To: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
References: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jarkko,

On Thu, 18 Oct 2018 15:30:38 +0300, Jarkko Nikula wrote:
> Allow PCI core to do runtime PM to devices without needing to use dummy
> runtime PM callback functions if there is no need to do anything device
> specific beyond PCI device power state management.
> 
> Implement this by letting core to change device power state during
> runtime PM transitions even if no callback functions are defined.

Thank you very much for looking into this and providing a fix.

> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> This is related to my i2c-i801.c fix thread back in June which I completely
> forgot till now: https://lkml.org/lkml/2018/6/27/642
> Discussion back then was that it should be handled in the PCI PM instead
> of having dummy functions in the drivers. I wanted to respin with a
> patch.
> ---
>  drivers/pci/pci-driver.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bef17c3fca67..6185b878ede1 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1239,7 +1239,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  	pci_power_t prev = pci_dev->current_state;
> -	int error;
> +	int error = 0;
>  
>  	/*
>  	 * If pci_dev->driver is not set (unbound), we leave the device in D0,
> @@ -1251,11 +1251,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
>  		return 0;
>  	}
>  
> -	if (!pm || !pm->runtime_suspend)
> -		return -ENOSYS;
> -
>  	pci_dev->state_saved = false;
> -	error = pm->runtime_suspend(dev);
> +	if (pm && pm->runtime_suspend)
> +		error = pm->runtime_suspend(dev);
>  	if (error) {
>  		/*
>  		 * -EBUSY and -EAGAIN is used to request the runtime PM core

Later in this function, pm is dereferenced again. It happens twice in
the "if (error)" condition where it is currently safe (error can't be
non-zero if pm->runtime_suspend() has not been called, and obviously
pm->runtime_suspend() can't have been called if pm was NULL). However
it also happens later without the condition:

	if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
	    && pci_dev->current_state != PCI_UNKNOWN) {
		WARN_ONCE(pci_dev->current_state != prev,
			"PCI PM: State of device not saved by %pF\n",
			pm->runtime_suspend);
		return 0;
	}

I am no expert of the PM framework but is there no risk to dereference
NULL at this point? Or even if pm is non-NULL, pm->runtime_suspend may
be NULL, leading to a confusing warning message?

More generally, I would feel better if instead of initializing error to
0, we would move under the "if (pm && pm->runtime_suspend)" condition
everything that must not be run if pm->runtime_suspend is not defined.
That would make the possible code flows a lot clearer.

> @@ -1292,7 +1290,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
>  
>  static int pci_pm_runtime_resume(struct device *dev)
>  {
> -	int rc;
> +	int rc = 0;
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> @@ -1306,14 +1304,12 @@ static int pci_pm_runtime_resume(struct device *dev)
>  	if (!pci_dev->driver)
>  		return 0;
>  
> -	if (!pm || !pm->runtime_resume)
> -		return -ENOSYS;
> -
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  	pci_enable_wake(pci_dev, PCI_D0, false);
>  	pci_fixup_device(pci_fixup_resume, pci_dev);
>  
> -	rc = pm->runtime_resume(dev);
> +	if (pm && pm->runtime_resume)
> +		rc = pm->runtime_resume(dev);
>  
>  	pci_dev->runtime_d3cold = false;
>  

The rest looks good to me.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
