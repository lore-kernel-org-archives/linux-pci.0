Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05451C43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 22:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B2921104
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 22:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyCFPS5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B2921104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbeK0J3W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:29:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbeK0J3W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 04:29:22 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D61208E7;
        Mon, 26 Nov 2018 22:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543271623;
        bh=X7UJjgpBjz0pPMdhcuGIMWm0fPuxjkZmHbzd+EFR/Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyCFPS5sQ4LSP+dsatdHfPyFUyMKUXPlBm8+9mrI2lwdXijU58B61c9FdtI/unTU0
         TluxlzK9DN6j9RanAivhLgpLiOwSyVvehYDsZMIEoSQCiWAcYkpMZ6mWp6B/4y40fy
         Lrits4+s5COcff7EgkRnyl8tuR0lMH60CiMAsnUA=
Date:   Mon, 26 Nov 2018 16:33:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-pci@vger.kernel.org, Tal Gilboa <talgi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] pci: fix incorrect value returned from pcie_get_speed_cap
Message-ID: <20181126223340.GA212532@google.com>
References: <alpine.LRH.2.02.1810301232310.23106@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1810301232310.23106@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 30, 2018 at 12:36:08PM -0400, Mikulas Patocka wrote:
> The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks. We must mask
> the register and compare it against them.
> 
> This patch fixes errors "amdgpu: [powerplay] failed to send message 261
> ret is 0" errors when PCIe-v3 card is plugged into PCIe-v1 slot, because
> the slot is being incorrectly reported as PCIe-v3 capable.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Applied the patch below to for-linus for v4.20 and backport to v4.17+
stable kernels, thanks!

I removed the "if (lnkcap)" test because the LNKCAP case is not
parallel to the LNKCAP2 case.  LNKCAP2 is optional so we have to test
for lnkcap2 being non-zero.  But LNKCAP is required for all devices.
If the config read of it fails, we should get either 0 or ~0, and
neither one will satisfy the 5.0 or 2.5 checks.

> Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link speed")
> Cc: stable@vger.kernel.org	# v4.17+
> 
> ---
>  drivers/pci/pci.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-4.19/drivers/pci/pci.c
> ===================================================================
> --- linux-4.19.orig/drivers/pci/pci.c	2018-10-30 16:58:58.000000000 +0100
> +++ linux-4.19/drivers/pci/pci.c	2018-10-30 16:58:58.000000000 +0100
> @@ -5492,13 +5492,13 @@ enum pci_bus_speed pcie_get_speed_cap(st
>  
>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
>  	if (lnkcap) {
> -		if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
> +		if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_16_0GB)
>  			return PCIE_SPEED_16_0GT;
> -		else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
> +		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_8_0GB)
>  			return PCIE_SPEED_8_0GT;
> -		else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
> +		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) ==PCI_EXP_LNKCAP_SLS_5_0GB)
>  			return PCIE_SPEED_5_0GT;
> -		else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
> +		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
>  			return PCIE_SPEED_2_5GT;
>  	}
>  

commit 94ea01a6d9a6
Author: Mikulas Patocka <mpatocka@redhat.com>
Date:   Mon Nov 26 10:37:13 2018 -0600

    PCI: Fix incorrect value returned from pcie_get_speed_cap()
    
    The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks.  We must mask
    the register and compare it against them.
    
    This fixes errors like this:
    
      amdgpu: [powerplay] failed to send message 261 ret is 0
    
    when PCIe-v3 card is plugged into a PCIe-v1 slot, because the slot is being
    incorrectly reported as PCIe-v3 capable.
    
    6cf57be0f78e, which appeared in v4.17, added pcie_get_speed_cap() with the
    incorrect test of PCI_EXP_LNKCAP_SLS as a bitmask.  5d9a63304032, which
    appeared in v4.19, changed amdgpu to use pcie_get_speed_cap(), so the
    amdgpu bug reports below are regressions in v4.19.
    
    Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link speed")
    Fixes: 5d9a63304032 ("drm/amdgpu: use pcie functions for link width and speed")
    Link: https://bugs.freedesktop.org/show_bug.cgi?id=108704
    Link: https://bugs.freedesktop.org/show_bug.cgi?id=108778
    Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
    [bhelgaas: update comment, remove use of PCI_EXP_LNKCAP_SLS_8_0GB and
    PCI_EXP_LNKCAP_SLS_16_0GB since those should be covered by PCI_EXP_LNKCAP2,
    remove test of PCI_EXP_LNKCAP for zero, since that register is required]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Alex Deucher <alexander.deucher@amd.com>
    Cc: stable@vger.kernel.org      # v4.17+

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d068f11d08a7..c9d8e3c837de 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5556,9 +5556,13 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 	u32 lnkcap2, lnkcap;
 
 	/*
-	 * PCIe r4.0 sec 7.5.3.18 recommends using the Supported Link
-	 * Speeds Vector in Link Capabilities 2 when supported, falling
-	 * back to Max Link Speed in Link Capabilities otherwise.
+	 * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.  The
+	 * implementation note there recommends using the Supported Link
+	 * Speeds Vector in Link Capabilities 2 when supported.
+	 *
+	 * Without Link Capabilities 2, i.e., prior to PCIe r3.0, software
+	 * should use the Supported Link Speeds field in Link Capabilities,
+	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
 	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
 	if (lnkcap2) { /* PCIe r3.0-compliant */
@@ -5574,16 +5578,10 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 	}
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-	if (lnkcap) {
-		if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
-			return PCIE_SPEED_16_0GT;
-		else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
-			return PCIE_SPEED_8_0GT;
-		else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
-			return PCIE_SPEED_5_0GT;
-		else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
-			return PCIE_SPEED_2_5GT;
-	}
+	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
+		return PCIE_SPEED_5_0GT;
+	else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
+		return PCIE_SPEED_2_5GT;
 
 	return PCI_SPEED_UNKNOWN;
 }
