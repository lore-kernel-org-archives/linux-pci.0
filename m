Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754173AbdLNXqW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 18:46:22 -0500
Date: Thu, 14 Dec 2017 17:46:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: treding@nvidia.com, bhelgaas@google.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, swarren@nvidia.com, mmaddireddy@nvidia.com
Subject: Re: [PATCH V3 3/3] PCI: tegra: Enable ASPM-L1 capability
 advertisement
Message-ID: <20171214234616.GQ30595@bhelgaas-glaptop.roam.corp.google.com>
References: <1510492674-12786-1-git-send-email-vidyas@nvidia.com>
 <1510492674-12786-4-git-send-email-vidyas@nvidia.com>
 <20171120213710.GE16362@bhelgaas-glaptop.roam.corp.google.com>
 <595470ab-9627-8dd6-3008-10ca15040633@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <595470ab-9627-8dd6-3008-10ca15040633@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 10:01:57PM +0530, Vidya Sagar wrote:
> On Tuesday 21 November 2017 03:07 AM, Bjorn Helgaas wrote:
> >s/Enable ASPM-L1 capability advertisement/
> >  /Advertise ASPM L1 PM Substates support/
> This patch controls advertisement of ASPM-L1 capability (not ASPM-L1
> Substates)
> >
> >On Sun, Nov 12, 2017 at 06:47:54PM +0530, Vidya Sagar wrote:
> >>Enables advertisement of ASPM-L1 support in capability
> >>registers of applicable Tegra chips
> >Actually, I'm a little confused about whether this has to do with ASPM
> >L1 support (which would be advertised in the Link Capabilities
> >register) or the ASPM L1 Substates support (which would be advertised
> >in the L1 PM Substates Capabilities register)?
> This is to do with ASPM L1 support (and not ASPM L1 Substates)
> But, since ASPM-L1SS needs ASPM-L1 anyway, I think it is ok to enable
> advertisement of ASPM-L1 in the last patch of the series.

It makes this part of the patch look funny:

> >>@@ -2458,6 +2469,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
> >>  	.RAW_violation_fixup = false,
> >>  	.program_deskew_time = false,
> >>  	.updateFC_threshold = false,

> >>+	.has_aspm_l1 = false,
> >>  	.has_aspm_l1ss = false,
> >>  	.l1ss_rp_wake_fixup = false,
> >>  };

because in PCIe terms, you have to have ASPM before you can have L1SS.
But the code had .has_aspm_l1ss before you add .has_aspm_l1.

It would make more sense if you could:

  1) make ASPM work, *then*
  2) incrementally add ASPM L1SS

But maybe that's not practical, e.g., maybe you can't make the
hardware hide the L1SS capability the way you can make it hide ASPM.

It's not that big a deal to me either way.

Bjorn
