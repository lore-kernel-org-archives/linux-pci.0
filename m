Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE70C43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 21:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA4121B68
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550179584;
	bh=WI1QmcOyy/0Wivhhry7Y7TZqKL/+Bxs3/rSslkhVn1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MZWcscjOv8Vb/tpB+r1tjG2UIIccjQYewJDEzWOEZMQ691sO0+SxOJAGySadQyOk2
	 t0AV9eImafuSENy5UOs2w2TyDplY51lFueuY9yxYvg7IktZzpAyzGwElPVPc4hdFyU
	 fkZyHgNpuW1WZT/2r8WsoWnsJDvnq2MTV3mOhZcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438029AbfBNV0X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:26:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388263AbfBNV0X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Feb 2019 16:26:23 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 016B121900;
        Thu, 14 Feb 2019 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550179582;
        bh=WI1QmcOyy/0Wivhhry7Y7TZqKL/+Bxs3/rSslkhVn1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGwRMeGYXasbairlftRGWTx8bRRKJwaraw5F45XkiiioAYGBL1DvlD67PHJKOy5vF
         K9987LYnCLjGeF7QwMyWbVCJspPJ+/d8tvxaasAzA4LNznd5Ysm80/JxUefRHc0WUa
         PRYbcIfrNRxBun8qQP25yotc7CkUItVTpbRsWU0c=
Date:   Thu, 14 Feb 2019 15:26:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: Fix runtime PME generation from D3hot
Message-ID: <20190214212619.GO96272@google.com>
References: <20190131170746.7604-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131170746.7604-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 08:07:44PM +0300, Mika Westerberg wrote:
> Hi all,
> 
> Heiner reported [1] that runtime PME generation of his network card does
> not work after commit 0e157e528604 ("PCI/PME: Implement runtime PM
> callbacks") that landed in v4.20. Reverting the commit helps but it has
> another drawback, which I originally tried to solve with the commit, that
> the PCIe hierarchy wakes up immediately after being put into D3cold.
> 
> This series of two patches tries to fix both issues so that PME wakes up
> from D3hot and that the hierarchy does not wake up immediately from D3cold.
> 
> The previous version of the series can be found here:
> 
>   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1892241.html
> 
> Changes from the previous version:
> 
>   * Add tags from Heiner and Rafael
>   * Update changelog to mention relevent PCIe spec sections
>   * Add comment to pcie_disable_interrupt() explaining why and what is
>     masked
> 
> [1] https://www.spinics.net/lists/linux-pci/msg79051.html
> 
> Mika Westerberg (2):
>   Revert "PCI/PME: Implement runtime PM callbacks"
>   PCI: pciehp: Disable Data Link Layer State Changed event on suspend

I tentatively applied these to pci/pm for v5.1.

I suspect these should be marked for stable (v4.20+)?

I don't think the bugzilla in the second patch is directly relevant to
that patch.  I'd like to update the patch with a more relevant
bugzilla if you have or can open one?

>  drivers/pci/hotplug/pciehp_hpc.c | 17 +++++++++++++++--
>  drivers/pci/pcie/pme.c           | 27 ---------------------------
>  2 files changed, 15 insertions(+), 29 deletions(-)
> 
> -- 
> 2.20.1
> 
