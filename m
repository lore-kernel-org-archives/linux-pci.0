Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35348 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755068AbeEAMou (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 May 2018 08:44:50 -0400
Date: Tue, 1 May 2018 07:44:49 -0500
From: Rob Herring <robh@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org, hch@lst.de,
        joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com,
        laurentiu.tudor@nxp.com, leoyang.li@nxp.com
Subject: Re: [PATCH v4 2/6] iommu: of: make of_pci_map_rid() available for
 other devices too
Message-ID: <20180501124449.GA3009@rob-hp-laptop>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-3-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525069641-8523-3-git-send-email-nipun.gupta@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 30, 2018 at 11:57:17AM +0530, Nipun Gupta wrote:
> iommu-map property is also used by devices with fsl-mc. This
> patch moves the of_pci_map_rid to generic location, so that it
> can be used by other busses too.
> 
> 'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
> functional change done in the API.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  drivers/iommu/of_iommu.c |   5 +--
>  drivers/of/base.c        | 102 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/irq.c         |   5 +--
>  drivers/pci/of.c         | 101 ----------------------------------------------
>  include/linux/of.h       |  11 +++++
>  include/linux/of_pci.h   |  10 -----
>  6 files changed, 117 insertions(+), 117 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
