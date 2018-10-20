Return-Path: <SRS0=Xsl3=NA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C21CC67863
	for <linux-pci@archiver.kernel.org>; Sat, 20 Oct 2018 16:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C542E2159F
	for <linux-pci@archiver.kernel.org>; Sat, 20 Oct 2018 16:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIZ6B+3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C542E2159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJUAat (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Oct 2018 20:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeJUAas (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Oct 2018 20:30:48 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE2B21550;
        Sat, 20 Oct 2018 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540052390;
        bh=XNRYH54UpCjZ0Z3xksYghmAcB1kTE+qencaGj7Le7Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OIZ6B+3pw4EJW2/o0AHc3iiidXYJ5KRAOfpH3xBd7yqKvYuClX+1SBAtUNMnJ5rGD
         TFnY1QzYOXancM7JOfq6km1l3PZhnacHODb1kNSs1XjrlmnZAQQDHE344YFHYiB81K
         9dLgslETLPRjwJUS/QzJkumrQMcW9EegoI90cRVA=
Date:   Sat, 20 Oct 2018 11:19:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Allow runtime PM without callback functions
Message-ID: <20181020161948.GS5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
 <20181019152105.0325a663@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019152105.0325a663@endymion>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 03:21:05PM +0200, Jean Delvare wrote:
> On Thu, 18 Oct 2018 15:30:38 +0300, Jarkko Nikula wrote:
> > Allow PCI core to do runtime PM to devices without needing to use dummy
> > runtime PM callback functions if there is no need to do anything device
> > specific beyond PCI device power state management.
> > 
> > Implement this by letting core to change device power state during
> > runtime PM transitions even if no callback functions are defined.
> 
> Thank you very much for looking into this and providing a fix.
> 
> > Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > ---
> > This is related to my i2c-i801.c fix thread back in June which I completely
> > forgot till now: https://lkml.org/lkml/2018/6/27/642
> > Discussion back then was that it should be handled in the PCI PM instead
> > of having dummy functions in the drivers. I wanted to respin with a
> > patch.
> > ---
> >  drivers/pci/pci-driver.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index bef17c3fca67..6185b878ede1 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -1239,7 +1239,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
> >  	struct pci_dev *pci_dev = to_pci_dev(dev);
> >  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> >  	pci_power_t prev = pci_dev->current_state;
> > -	int error;
> > +	int error = 0;
> >  
> >  	/*
> >  	 * If pci_dev->driver is not set (unbound), we leave the device in D0,
> > @@ -1251,11 +1251,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
> >  		return 0;
> >  	}
> >  
> > -	if (!pm || !pm->runtime_suspend)
> > -		return -ENOSYS;
> > -
> >  	pci_dev->state_saved = false;
> > -	error = pm->runtime_suspend(dev);
> > +	if (pm && pm->runtime_suspend)
> > +		error = pm->runtime_suspend(dev);
> >  	if (error) {
> >  		/*
> >  		 * -EBUSY and -EAGAIN is used to request the runtime PM core
> 
> Later in this function, pm is dereferenced again. It happens twice in
> the "if (error)" condition where it is currently safe (error can't be
> non-zero if pm->runtime_suspend() has not been called, and obviously
> pm->runtime_suspend() can't have been called if pm was NULL). However
> it also happens later without the condition:
> 
> 	if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
> 	    && pci_dev->current_state != PCI_UNKNOWN) {
> 		WARN_ONCE(pci_dev->current_state != prev,
> 			"PCI PM: State of device not saved by %pF\n",
> 			pm->runtime_suspend);
> 		return 0;
> 	}
> 
> I am no expert of the PM framework but is there no risk to dereference
> NULL at this point? Or even if pm is non-NULL, pm->runtime_suspend may
> be NULL, leading to a confusing warning message?
> 
> More generally, I would feel better if instead of initializing error to
> 0, we would move under the "if (pm && pm->runtime_suspend)" condition
> everything that must not be run if pm->runtime_suspend is not defined.
> That would make the possible code flows a lot clearer.

I agree, this isn't good.  Even if it's safe (and I don't think that
second spot is safe), it's too hard to analyze.  I'm going to drop
this for now.

Jarkko, I assume a9c8088c7988 ("i2c: i801: Don't restore config
registers on runtime PM"), which you reference as "Fixes:" is what
causes the regression.  If you can update the changelog so it mentions
the regression, why it happens, and why this patch fixes it, we'll be
in a better spot to backport it to stable kernels.

Bjorn
