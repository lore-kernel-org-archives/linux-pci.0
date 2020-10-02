Return-Path: <SRS0=wtdp=DJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995EDC4363C
	for <linux-pci@archiver.kernel.org>; Fri,  2 Oct 2020 17:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640DE2085B
	for <linux-pci@archiver.kernel.org>; Fri,  2 Oct 2020 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601659756;
	bh=CtllLYMk0Gz+Iiir55pP+3jQFilH0kKCtSY4Szn/EEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=LkxVZI18xrdLUi2J32LhwtaO3NIrMZxybKWpvsN+rQeh/3SOiEGRfZAndnHp+ImP0
	 Qwf0Sm3ZNFILpDdsvTUKOxnvbBztgbNWXO/8z9faOHx6CeATASVRtiKhZIjlGsK8BU
	 gZxqIUj8iNkcPNKRVBDhiR+opK9cTXxbY/kx4G+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbgJBR3P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Oct 2020 13:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388335AbgJBR3P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 13:29:15 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B84206C3;
        Fri,  2 Oct 2020 17:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601659755;
        bh=CtllLYMk0Gz+Iiir55pP+3jQFilH0kKCtSY4Szn/EEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ldGDJ4HmbhFANa0MZrBQWZQE1uYa2eGB08xJF0BmHFRQqrvT0IsCmttxDmnXAiQr+
         hwBthftkYplzuAb0C6IYYsRJ1d/veddsSs3F8vPbhXyETTgU4Z94BD7UuVnOGKiMX7
         M1cingYGoc7OZ5TCyr1nQcO4J5kI1hzKCojpQEZw=
Date:   Fri, 2 Oct 2020 12:29:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com, xerces.zhao@gmail.com,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v6 4/5] PCI: only return true when dev io state is really
 changed
Message-ID: <20201002172913.GA2809822@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930070537.30982-5-haifeng.zhao@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sinan]

On Wed, Sep 30, 2020 at 03:05:36AM -0400, Ethan Zhao wrote:
> When uncorrectable error happens, AER driver and DPC driver interrupt
> handlers likely call
> 
>    pcie_do_recovery()
>    ->pci_walk_bus()
>      ->report_frozen_detected()
> 
> with pci_channel_io_frozen the same time.
>    If pci_dev_set_io_state() return true even if the original state is
> pci_channel_io_frozen, that will cause AER or DPC handler re-enter
> the error detecting and recovery procedure one after another.
>    The result is the recovery flow mixed between AER and DPC.
> So simplify the pci_dev_set_io_state() function to only return true
> when dev->error_state is changed.
> 
> Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
> Tested-by: Wen Jin <wen.jin@intel.com>
> Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
> Reviewed-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> Changnes:
>  v2: revise description and code according to suggestion from Andy.
>  v3: change code to simpler.
>  v4: no change.
>  v5: no change.
>  v6: no change.
> 
>  drivers/pci/pci.h | 37 +++++--------------------------------
>  1 file changed, 5 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 455b32187abd..f2beeaeda321 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -359,39 +359,12 @@ struct pci_sriov {
>  static inline bool pci_dev_set_io_state(struct pci_dev *dev,
>  					pci_channel_state_t new)
>  {
> -	bool changed = false;
> -
>  	device_lock_assert(&dev->dev);
> -	switch (new) {
> -	case pci_channel_io_perm_failure:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -		case pci_channel_io_perm_failure:
> -			changed = true;
> -			break;
> -		}
> -		break;
> -	case pci_channel_io_frozen:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -			changed = true;
> -			break;
> -		}
> -		break;
> -	case pci_channel_io_normal:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -			changed = true;
> -			break;
> -		}
> -		break;
> -	}
> -	if (changed)
> -		dev->error_state = new;
> -	return changed;
> +	if (dev->error_state == new)
> +		return false;
> +
> +	dev->error_state = new;
> +	return true;
>  }

IIUC this changes the behavior of the function, but it's difficult to
analyze because it does a lot of simplification at the same time.

Please consider the following, which is intended to simplify the
function while preserving the behavior (but please verify; it's been a
long time since I looked at this).  Then maybe see how your patch
could be done on top of this?

Alternatively, come up with your own simplification patch + the
functionality change.


commit 983d9b1f8177 ("PCI/ERR: Simplify pci_dev_set_io_state()")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue May 19 12:28:57 2020 -0500

    PCI/ERR: Simplify pci_dev_set_io_state()
    
    Truth table:
    
                                  requested new state
      current          ------------------------------------------
      state            normal         frozen         perm_failure
      ------------  +  -------------  -------------  ------------
      normal        |  normal         frozen         perm_failure
      frozen        |  normal         frozen         perm_failure
      perm_failure  |  perm_failure*  perm_failure*  perm_failure
    
      * "not changed", returns false
    
    No functional change intended.
    
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d3f75867106..81408552f7c9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -358,39 +358,21 @@ struct pci_sriov {
 static inline bool pci_dev_set_io_state(struct pci_dev *dev,
 					pci_channel_state_t new)
 {
-	bool changed = false;
-
 	device_lock_assert(&dev->dev);
-	switch (new) {
-	case pci_channel_io_perm_failure:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-		case pci_channel_io_perm_failure:
-			changed = true;
-			break;
-		}
-		break;
-	case pci_channel_io_frozen:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-			changed = true;
-			break;
-		}
-		break;
-	case pci_channel_io_normal:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-			changed = true;
-			break;
-		}
-		break;
+
+	/* Can always put a device in perm_failure state */
+	if (new == pci_channel_io_perm_failure) {
+		dev->error_state == pci_channel_io_perm_failure;
+		return true;
 	}
-	if (changed)
-		dev->error_state = new;
-	return changed;
+
+	/* If already in perm_failure, can't set to normal or frozen */
+	if (dev->error_state == pci_channel_io_perm_failure)
+		return false;
+
+	/* Can always change normal to frozen or vice versa */
+	dev->error_state = new;
+	return true;
 }
 
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
