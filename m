Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:54563 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab3HLVTp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 17:19:45 -0400
Message-ID: <5209516E.3030507@wwwdotorg.org>
Date: Mon, 12 Aug 2013 15:19:42 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 00/14] Rewrite Tegra PCIe driver
References: <1376059772-16669-1-git-send-email-treding@nvidia.com>
In-Reply-To: <1376059772-16669-1-git-send-email-treding@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/09/2013 08:49 AM, Thierry Reding wrote:
> Hi Stephen,
> 
> This is the latest version of the Tegra PCIe driver patch series. I've
> dropped the PCI xclk clamping code as discussed and successfully tested
> on Beaver. The patches that touch the PCI subsystem have Bjorn's
> Acked-by and I've tested this on top of next-20130809, which has Jason's
> common branch. Once he's comfortable with making the branch stable you
> should be able to merge that branch and apply these patches on top.

I have applied this series, as follows:

* All code changes to Tegra's for-3.12/soc branch.
* All *.dts* changes to Tegra's for-3.12/dt branch.
* All defconfig changes to Tegra's for-3.12/defconfig branch.

I split patch 1/14 into separate code and DT changes in order to achieve
the split above. I hope you don't mind. It shouldn't affect
bisectability, since (a) PCIe support wasn't really useful before this
series anyway, and (b) the board *.dts changes were separate patches
anyway, so it wasn't quite fully bisectable in the first place.

Thanks.
