Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C090C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 21:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992E721535
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 21:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2Wi0iWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992E721535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeIUDDK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeIUDDK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 23:03:10 -0400
Received: from localhost (unknown [207.160.231.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19BA6214C2;
        Thu, 20 Sep 2018 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537478263;
        bh=hcocnvAoa5kVsc9UOAJxtgdTuZAY3KPLJV9Ib2ejjHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2Wi0iWn97alqtrAHZWLrOmDvMo2Gh700JPXDvCHOYYBuSra96GQF0U+DniDqWkqC
         frnSrTjs6v9NPRkO3aAcThubqaLb3iKCkzA0ig+KUCuklOcHE83xZ0Yh3v++UqZxBT
         p6yi5pNTkG+6wyeJe+3goSEW4PdRVwtoFRil8tIY=
Date:   Thu, 20 Sep 2018 16:17:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv4 00/12] pci error handling fixes
Message-ID: <20180920211742.GA224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920162717.31066-1-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 20, 2018 at 10:27:05AM -0600, Keith Busch wrote:
> Changes since v3 are:
> 
>   Initialize port services directly from port driver (suggested by
>   Bjorn)
> 
>   Updated changelogs to match local style
> 
>   Added documentation update for ERR_FATAL behavior
> 
>   Included DPC save/restore state fix that was missing from previous
> 
>   Included AER upstream port fix that was mistakenly added to a
>   different patch set
> 
> Keith Busch (12):
>   PCI: portdrv: Initialize service drivers directly
>   PCI: portdrv: Restore pci state on slot reset
>   PCI: DPC: Save and restore control state
>   PCI: AER: Take reference on error devices
>   PCI: AER: Don't read upstream ports below fatal errors
>   PCI: ERR: Use slot reset if available
>   PCI: ERR: Handle fatal error recovery
>   PCI: ERR: Always use the first downstream port
>   PCI: ERR: Simplify broadcast callouts
>   PCI: ERR: Report current recovery status for udev
>   PCI: Unify device inaccessible
>   PCI: Make link active reporting detection generic
> 
>  Documentation/PCI/pci-error-recovery.txt |  35 ++--
>  drivers/pci/hotplug/pciehp.h             |   6 -
>  drivers/pci/hotplug/pciehp_core.c        |   3 +-
>  drivers/pci/hotplug/pciehp_hpc.c         |  22 +--
>  drivers/pci/pci.c                        |  68 +++++++-
>  drivers/pci/pci.h                        |  74 ++++++++-
>  drivers/pci/pcie/aer.c                   |  25 +--
>  drivers/pci/pcie/dpc.c                   |  72 ++++++--
>  drivers/pci/pcie/err.c                   | 276 ++++++++-----------------------
>  drivers/pci/pcie/pme.c                   |   3 +-
>  drivers/pci/pcie/portdrv.h               |  24 +++
>  drivers/pci/pcie/portdrv_pci.c           |  17 ++
>  drivers/pci/probe.c                      |   1 +
>  drivers/pci/slot.c                       |   2 +-
>  include/linux/pci.h                      |   1 +
>  15 files changed, 331 insertions(+), 298 deletions(-)

Applied with Sinan's reviewed-by to pci/hotplug for v4.20, thanks!
