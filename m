Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:62986 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab3FKWRN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2013 18:17:13 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so4353451pdi.7
        for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2013 15:17:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Stephen Warren <swarren@wwwdotorg.org>,
	Jay Agarwal <jagarwal@nvidia.com>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <51AE3B18.9010604@wwwdotorg.org>
Cc: linux@arm.linux.org.uk, thierry.reding@avionic-design.de,
	bhelgaas@google.com, ldewangan@nvidia.com, olof@lixom.net,
	hdoyu@nvidia.com, pgaikwad@nvidia.com, pdeschrijver@nvidia.com,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	jtukkinen@nvidia.com, kthota@nvidia.com
References: <1370372252-4332-1-git-send-email-jagarwal@nvidia.com>
 <51AE3B18.9010604@wwwdotorg.org>
Message-ID: <20130611221709.8816.15602@quantum>
Subject: Re: [PATCH V3 1/4] ARM: tegra30: clocks: Fix pciex clock registration
Date: Tue, 11 Jun 2013 15:17:09 -0700
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Quoting Stephen Warren (2013-06-04 12:08:08)
> On 06/04/2013 12:57 PM, Jay Agarwal wrote:
> > Registering pciex as peripheral clock instead of fixed clock
> > as tegra_perih_reset_assert(deassert) api of this clock api
> > gives warning and ultimately does not succeed to assert(deassert).
> > 
> > Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> > ---
> > Patch is based on remotes/gitorious_thierryreding_linux/tegra/next and should be applied on top of this.
> 
> For this change, Mike may as well apply it directly to the clock tree.
> Thierry can then pick it up when he rebases his tegra/next tree.
> 
> That said, I don't think you should need any of the
> TEGRA_CLK_DUPLICATE() entries; the PCIe driver should get its clocks
> from device tree now, and hence the driver name in the clock
> registration shouldn't be necessary. All of these TEGRA_CLK_DUPLICATE()
> entries should be removed en mass sometime soon with luck. So, can you
> simply leave the two TEGRA_CLK_DUPLICATE() entries untouched, rather
> than changing them?

Ping on this patch.  I can take it through my tree, but is there going
to be rework based on Stephen's comments?

Regards,
Mike
