Return-Path: <SRS0=ntsD=6I=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEA6C54FCB
	for <linux-pci@archiver.kernel.org>; Fri, 24 Apr 2020 19:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C2721569
	for <linux-pci@archiver.kernel.org>; Fri, 24 Apr 2020 19:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587757046;
	bh=1sBVT2tnDG2zB0qFT/1htfLgMnkz+gC0RG/MisDuvPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=TQIm4m9LwERPNf2M/U1gprg+IG7sMK2iyVkYjSK0AhM+UTMrVheeWIBxh96rcT5J3
	 w12RQJfdP93Rs6USmiU5IuYIEc4PJqxoxMLSmd2OKi7rsxLjEQJZKRTnnr7lA+UESu
	 3hvDU64ptmAzktgu8o5rnN3pIIGwFIyxSTyy/xYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgDXThZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDXThZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 15:37:25 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D292F21569;
        Fri, 24 Apr 2020 19:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587757045;
        bh=1sBVT2tnDG2zB0qFT/1htfLgMnkz+gC0RG/MisDuvPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UjR8DJpihY+VqIyLQMOS6AlHxT/c4Y2FspVrE15+K38G74KFcZdvPJeClXapQSxPM
         dVqHCxIBfuOul00fn5TBjbStEgXUcJanHDrdCCslAOGPxomIBiS/1l6tFdNzFziLIn
         kwVoSfHxL0TRA9kJbpTmssMiF95mcNDfqLFSNVao=
Date:   Fri, 24 Apr 2020 14:37:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: Don't select Kconfig symbols by default
Message-ID: <20200424193723.GA179443@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415001244.144623-1-helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 14, 2020 at 07:12:40PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> A few Kconfig symbols snuck in with "default y".  In general we don't want
> that because we don't want to bloat the kernel with unnecessary drivers.
> 
> Remove the ones that are optional.
> 
> There are a few left, but they depend on something else that seems like the
> real choice, e.g., XEN_PCIDEV_FRONTEND depends on XEN and PCI_XGENE_MSI
> depends on PCI_XGENE.
> 
> Bjorn Helgaas (4):
>   PCI: dra7xx: Don't select CONFIG_PCI_DRA7XX_HOST by default
>   PCI: keystone: Don't select CONFIG_PCI_KEYSTONE_HOST by default
>   PCI/AER: Don't select CONFIG_PCIEAER by default
>   PCI/ASPM: Don't select CONFIG_PCIEASPM by default
> 
>  drivers/pci/controller/dwc/Kconfig | 2 --
>  drivers/pci/pcie/Kconfig           | 2 --
>  2 files changed, 4 deletions(-)

Applied with Sathy's reviewed-by on the AER patch and the tweak Rob
suggested to the dra7xx one to pci/kconfig for v5.8.
