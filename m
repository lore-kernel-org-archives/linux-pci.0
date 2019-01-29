Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E13C282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 22:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4881221473
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 22:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548801460;
	bh=iGo8tCSgKwO46329OhBCVywerfK6lXwTzNiIxn0oTy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K3u67fUrOR861yegjBcr2KmTq9rcxEvN9hUnviDEJGa9dQXDy/X7kHlLEjuklu2O0
	 gBPkSd+OZcCdhHcLFuvBG6K7D0goXzn4DKMWatvR9B7eI+ZmGEmC1GDLmmLK9E5A8W
	 f6WnioHDp+yFnYaLf48d8QTmWmn/rhMZuETzaPhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfA2Whj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:37:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfA2Whj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 17:37:39 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 787AB20856;
        Tue, 29 Jan 2019 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548801458;
        bh=iGo8tCSgKwO46329OhBCVywerfK6lXwTzNiIxn0oTy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubrrcQdR/SnJcELbaOOMO2SgO9rVkeatt2DESOz3vHCdHyVjhrolxR+mPZylBteQ/
         FFRR4dzYniXsVdGaRXHGyNtmgXp4yOOBb1imukydog+dWw5QpRoIjNSf6gPCyYrTH3
         OKoOtbIE0EAruNtT+ztoJFtiQwbJzQOnV7Ltio9U=
Date:   Tue, 29 Jan 2019 16:37:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] PCI/AER: use match_string() helper to simplify the
 code
Message-ID: <20190129223735.GD91506@google.com>
References: <20190128115728.68240-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128115728.68240-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 28, 2019 at 01:57:28PM +0200, Andy Shevchenko wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to pci/aer for v5.1, thanks!

> ---
>  drivers/pci/pcie/aer.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index fed29de783e0..f8fc2114ad39 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -117,7 +117,7 @@ bool pci_aer_available(void)
>  
>  static int ecrc_policy = ECRC_POLICY_DEFAULT;
>  
> -static const char *ecrc_policy_str[] = {
> +static const char * const ecrc_policy_str[] = {
>  	[ECRC_POLICY_DEFAULT] = "bios",
>  	[ECRC_POLICY_OFF] = "off",
>  	[ECRC_POLICY_ON] = "on"
> @@ -203,11 +203,8 @@ void pcie_ecrc_get_policy(char *str)
>  {
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(ecrc_policy_str); i++)
> -		if (!strncmp(str, ecrc_policy_str[i],
> -			     strlen(ecrc_policy_str[i])))
> -			break;
> -	if (i >= ARRAY_SIZE(ecrc_policy_str))
> +	i = match_string(ecrc_policy_str, ARRAY_SIZE(ecrc_policy_str), str);
> +	if (i < 0)
>  		return;
>  
>  	ecrc_policy = i;
> -- 
> 2.20.1
> 
