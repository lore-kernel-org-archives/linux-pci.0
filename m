Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:35516 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab3FPSvj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jun 2013 14:51:39 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so2066486pbc.10
        for <linux-pci@vger.kernel.org>; Sun, 16 Jun 2013 11:51:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Stephen Warren <swarren@wwwdotorg.org>,
	Jay Agarwal <jagarwal@nvidia.com>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <51B8956B.8020704@wwwdotorg.org>
Cc: linux@arm.linux.org.uk, thierry.reding@avionic-design.de,
	bhelgaas@google.com, ldewangan@nvidia.com, olof@lixom.net,
	hdoyu@nvidia.com, pgaikwad@nvidia.com, pdeschrijver@nvidia.com,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	jtukkinen@nvidia.com, kthota@nvidia.com
References: <1371021223-6709-1-git-send-email-jagarwal@nvidia.com>
 <51B8956B.8020704@wwwdotorg.org>
Message-ID: <20130616185132.7541.680@quantum>
Subject: Re: [PATCH V4 1/4] ARM: tegra30: clocks: Fix pciex clock registration
Date: Sun, 16 Jun 2013 11:51:33 -0700
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Quoting Stephen Warren (2013-06-12 08:36:11)
> On 06/12/2013 01:13 AM, Jay Agarwal wrote:
> > Registering pciex as peripheral clock instead of fixed clock
> > as tegra_perih_reset_assert(deassert) api of this clock api
> > gives warning and ultimately does not succeed to assert(deassert)
> > 
> > Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> > ---
> > Patch is based on remotes/gitorious_thierryreding_linux/tegra/next and should be applied on top of this.
> 
> In this case, it would make more sense to apply this to the clock tree,
> since it's a standalone bug-fix.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Pulled into clk-fixes for -rc7.

Regards,
Mike
