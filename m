Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AAFC352A1
	for <linux-pci@archiver.kernel.org>; Wed,  7 Dec 2022 14:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiLGOhQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Dec 2022 09:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiLGOhK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 09:37:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DBF48418;
        Wed,  7 Dec 2022 06:37:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB595619E2;
        Wed,  7 Dec 2022 14:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD9AC433C1;
        Wed,  7 Dec 2022 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670423828;
        bh=22PFwb1B5NkSwicvtZ7zgj5d+acyjLEqmPdDNTaDdKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aeOvDp2mrLeQz4DMz0MbNu3lrQhRvq3m1H0581NF8drCytRXK34LBb8UQKOO13RKI
         cg+6BYC/Aqhltn9QKxpyhXTWcayQDDt09UWE1GiAVQjaVNHYQBuZYTtv6/RM6PJE/3
         KeIwrFYZ5f4dA2eeyUln/2nDGZ39MGOz5K5OUS0D4Bh+FghbOIO1+6cAN3gFGUay9T
         btda0F8jkoUtxoN6Xh19w6rvnSzv8I93bKZofURCSj4Vm8W7cSc/OUJyfdX8GvZemN
         QRJeHTyjF6l+7gSS8sgNRIf2FI7L6PpSETglI3mNHBIg+5n9bMypp/1YogMS3OcL3a
         YnOR4AjvA6SQA==
Date:   Wed, 7 Dec 2022 08:37:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: SHPC: removed unused get_mode1_ECC_cap callback
Message-ID: <20221207143706.GA1441026@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112142859.319733-1-ian@linux.cowan.aero>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 12, 2022 at 09:28:56AM -0500, Ian Cowan wrote:
> In the SHPC module, the get_mode1_ECC_cap callback is never used from
> the hpc_ops struct, so this patch series removes that callback from both the
> definition of the struct and the definition of the shpchp_hps_ops
> struct. Additionally, this removes the reference in the TODO of the SHPC
> module.
> 
> Ian Cowan (3):
>   PCI: SHPC: remove unused get_mode1_ECC_cap callback declaration
>   PCI: SHPC: remove unused get_mode1_ECC_cap callback from definition
>   PCI: SHPC: update todo
> 
>  drivers/pci/hotplug/TODO         |  3 ---
>  drivers/pci/hotplug/shpchp.h     |  1 -
>  drivers/pci/hotplug/shpchp_hpc.c | 18 ------------------
>  3 files changed, 22 deletions(-)

Applied to pci/hotplug for v6.2, thanks, Ian!
