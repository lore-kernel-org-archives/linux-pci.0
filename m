Return-Path: <SRS0=7uyK=MA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580EFECE564
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 21:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132FB21471
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 21:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZQpMjV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132FB21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbeISDMq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbeISDMq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 23:12:46 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BBEB20C0E;
        Tue, 18 Sep 2018 21:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537306695;
        bh=AuVNJPonUaM9djmjA24Ga7szKu3ZbV2Jy9Un8iYLstk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZQpMjV9zZalyBfBKn3HI/UNu8TVshjB8QyCSLdMA+TSZLQeQ6qBPpoYs4uvPY28v
         Q30WVgAvOW/zJRveyrQg9/cbXILsqLahPl6nMiF5xYsVdE0LJei99zUALLWFb8yDlV
         9xRtVV0zFqiYY97neJrqkv3yXR7nXfSBUY7HI7O8=
Date:   Tue, 18 Sep 2018 16:38:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH RESEND v2 01/10] PCI: Do not skip power managed bridges
 in pci_enable_wake()
Message-ID: <20180918213813.GF13616@bhelgaas-glaptop.roam.corp.google.com>
References: <153688100.j3IOAyprJL@aspire.rjw.lan>
 <20180914083134.27217-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914083134.27217-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180918213813.CteIfzaCPzdZ-RBx9SbZq77tol1ds_vLf3K_rkFT-94@z>

On Fri, Sep 14, 2018 at 11:31:34AM +0300, Mika Westerberg wrote:
> Commit baecc470d5fd ("PCI / PM: Skip bridges in pci_enable_wake()")
> changed pci_enable_wake() so that all bridges are skipped when wakeup is
> enabled (or disabled) with the reasoning that bridges can only signal
> wakeup on behalf of their subordinate devices.
> 
> However, there are bridges that can signal wakeup itself. For example
> PCIe downstream and root ports supporting hotplug may signal wakeup upon
> hotplug event.
> 
> For this reason change pci_enable_wake() so that it skips all bridges
> except those that we power manage (->bridge_d3 is set). Those are the
> ones that can go into low power states and may need to signal wakeup.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied to pci/enumeration for v4.20, thanks!

> ---
> Resending this because for some reason it did not hit the mailing lists.
> Added tag from Rafael as well.
> 
>  drivers/pci/pci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 29ff9619b5fa..1af6f1887986 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2133,10 +2133,13 @@ static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable
>  	int ret = 0;
>  
>  	/*
> -	 * Bridges can only signal wakeup on behalf of subordinate devices,
> -	 * but that is set up elsewhere, so skip them.
> +	 * Bridges that are not power-manageable directly only signal
> +	 * wakeup on behalf of subordinate devices which is set up
> +	 * elsewhere, so skip them. However, bridges that are
> +	 * power-manageable may signal wakeup for themselves (for example,
> +	 * on a hotplug event) and they need to be covered here.
>  	 */
> -	if (pci_has_subordinate(dev))
> +	if (!pci_power_manageable(dev))
>  		return 0;
>  
>  	/* Don't do the same thing twice in a row for one device. */
> -- 
> 2.18.0
> 
