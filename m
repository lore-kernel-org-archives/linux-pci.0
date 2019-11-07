Return-Path: <SRS0=9PB/=Y7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E0C43331
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 22:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BD421D6C
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573166670;
	bh=ZQe182g+c/eYVo0EqS6LCLvKJ4f/T/pI45S03ZKkLaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Fm4LJkTkk9+RegjrXgrLUpkKRK0gEgR6FSzW3qJiDGmW97mGz6xakZsLc51JpiL3j
	 bHHj6f7nldGnfJOoDjgJEZoy75gLnC/QXK3z8RoT4arvtMW4LRyCDkMp2b9K6wO8t8
	 AZK4FWxtoPKpQnW5Ak9jZ0ajdv+rPoLsQaIJHRec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfKGWoa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfKGWo3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 17:44:29 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70122187F;
        Thu,  7 Nov 2019 22:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573166669;
        bh=ZQe182g+c/eYVo0EqS6LCLvKJ4f/T/pI45S03ZKkLaU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=raWXPjXq6wHXj4lj1fvZ3+GnABXtz80iUdRkf4MnKGmMr7bAG+Yxxv0q1r0oL9bMU
         lZXDLlORSREqJv4q7wngu2q/nAHd6GZ0F/KUlG+DoLh90IWXF8lKB2/FcGKSMzseXG
         R9mo7u06fL5bmBjRtxHX1QhADTHPQM4R9IVAuxHo=
Date:   Thu, 7 Nov 2019 16:44:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] PCI: Clean up PTM message and Kconfig/Makefile nits
Message-ID: <20191107224427.GA130804@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106222420.10216-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:24:15PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The "PTM enabled, 4dns granularity" message has an extra "d" in it; remove
> that.
> 
> Remove the PTM and ASPM Kconfig dependencies on PCIEPORTBUS, since they
> don't depend on it.
> 
> Fix the Makefile so PTM and ASPM can be built without PCIEPORTBUS.
> 
> Bjorn Helgaas (5):
>   PCI/PTM: Remove spurious "d" from granularity message
>   PCI/PTM: Remove dependency on PCIEPORTBUS
>   PCI/ASPM: Remove dependency on PCIEPORTBUS
>   PCI: Remove PCIe Kconfig dependencies on PCI
>   PCI: Allow building PCIe things without PCIEPORTBUS
> 
>  drivers/pci/Makefile     | 3 ++-
>  drivers/pci/pcie/Kconfig | 3 ---
>  drivers/pci/pcie/ptm.c   | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)

Applied with Andrew's reviewed-by to pci/misc for v5.5.  Thanks,
Andrew, for looking these over!
