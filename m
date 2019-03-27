Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C95DC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 15:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3328A2082F
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 15:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfC0PCZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:02:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbfC0PCZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Mar 2019 11:02:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCE1880D;
        Wed, 27 Mar 2019 08:02:24 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C6CD3F575;
        Wed, 27 Mar 2019 08:02:22 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] PCIe Host request to reserve IOVA
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c92e07d7-78b2-d4ec-bf1a-29070a9d4145@arm.com>
Date:   Wed, 27 Mar 2019 15:02:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/01/2019 10:13, Srinath Mannam wrote:
> Few SOCs have limitation that their PCIe host can't allow few inbound
> address ranges. Allowed inbound address ranges are listed in dma-ranges
> DT property and this address ranges are required to do IOVA mapping.
> Remaining address ranges have to be reserved in IOVA mapping.
> 
> PCIe Host driver of those SOCs has to list all address ranges which have
> to reserve their IOVA address into PCIe host bridge resource entry list.
> IOMMU framework will reserve these IOVAs while initializing IOMMU domain.

FWIW I'm still only interested in solving this problem generically, 
because in principle it's not specific to PCI, for PCI it's certainly 
not specific to iproc, and either way it's not specific to DT. That 
said, I don't care strongly enough to keep pushing back on this 
implementation outright, since it's not something which couldn't be 
cleaned up 'properly' in future.

One general comment I'd make, though, is that AFAIK PCI has a concept of 
inbound windows much more than it has a concept of gaps-between-windows, 
so if the PCI layer is going to track anything it should probably be the 
actual windows, and leave the DMA layer to invert them into the 
reservations it cares about as it consumes the list. That way you can 
also avoid the undocumented requirement for the firmware to keep the 
ranges property sorted in the first place.

Robin.

> 
> This patch set is based on Linux-5.0-rc2.
> 
> Changes from v2:
>    - Patch set rebased to Linux-5.0-rc2
> 
> Changes from v1:
>    - Addressed Oza review comments.
> 
> Srinath Mannam (3):
>    PCI: Add dma-resv window list
>    iommu/dma: Reserve IOVA for PCI host reserve address list
>    PCI: iproc: Add dma reserve resources to host
> 
>   drivers/iommu/dma-iommu.c           |  8 ++++++
>   drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
>   drivers/pci/probe.c                 |  3 +++
>   include/linux/pci.h                 |  1 +
>   4 files changed, 62 insertions(+), 1 deletion(-)
> 
