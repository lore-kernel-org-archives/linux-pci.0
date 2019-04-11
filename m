Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC0BC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4242184E
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 20:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555012886;
	bh=dN9Fffpho2GTZtkhAZhrjF2+hvzdaaIJu18EdMFpz8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kd/9XBdzeJZVC/suxQPmafrVUsHFg+9vPQnXVFqyOmURlkc3pixh/WIraow27RK3r
	 zuCzKWpFYjFdGsal9z5b0VlLBsuTJNlByQ5TeAlF1Cer6+Ze0V6kmyIX03hDZCpqlR
	 jCNOEBB4rFP0Cz23bRSEnG91fRue18H2VCZ56byI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDKUBZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfDKUBZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 16:01:25 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D207C2184B;
        Thu, 11 Apr 2019 20:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555012884;
        bh=dN9Fffpho2GTZtkhAZhrjF2+hvzdaaIJu18EdMFpz8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sit4zWfP2285ZrUG1dlPANHVZsVzT/Xw4vouNZmd0EHm/dnuOOaNBZPJhXK0HP/hk
         2kSrQO0AxpijAU9MbnZdJHgGeA9mxSxIlVwTRyfBaq5FMux5Oc0bLfUqvQpV13M1d3
         O6ZDICxWBkuad/glDmf2G9UKsccppY/xeln9qTWg=
Date:   Thu, 11 Apr 2019 15:01:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 12/30] PCI: tegra: Add SW fixup for RAW violations
Message-ID: <20190411200121.GQ256045@google.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-13-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-13-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 11, 2019 at 10:33:37PM +0530, Manikanta Maddireddy wrote:
> The logic which blocks read requests till AFI gets ACK for all outstanding
> MC writes does not behave correctly when number of outstanding write
> becomes more than 32 in Tegra124 and 132.
> 
> SW fixup to prevent this issue is to limit outstanding posted writes and
> tweak updateFC timer threshold.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
> @@ -2381,6 +2408,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>  	.program_uphy = true,
>  	.update_clamp_threshold = false,
>  	.program_deskew_time = false,
> +	.raw_violation_fixup = false,
>  	.ectl.enable = false,

It doesn't really matter either way, but you don't *have* to
initialize all these flags to "false" since that's the default for
uninitialized fields in static structs like these.  If you left them
out, the structs would only contain the "true" items, and it'd be
easier to see what's special about each SoC.

>  };
>  
> @@ -2407,6 +2435,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>  	.program_uphy = true,
>  	.update_clamp_threshold = false,
>  	.program_deskew_time = false,
> +	.raw_violation_fixup = false,
>  	.ectl.enable = false,
>  };
