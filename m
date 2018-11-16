Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0F4C43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 23:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264E82086C
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 23:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264E82086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeKQJlO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:41:14 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41443 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeKQJlO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Nov 2018 04:41:14 -0500
Received: by mail-oi1-f194.google.com with SMTP id g188-v6so21002658oif.8;
        Fri, 16 Nov 2018 15:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QOTEDtF33pKZ1sZ01uKKEZTtH8KN6Dm9CXjRVOtc4rg=;
        b=NabqZfP8TZlgU+OhaI6hSaKS28VhDVTre1hENiFtrXBGtlDiv7AXBg5To1SrBN1g3S
         J9X0gxYtcNuLkQjrI4Yf+F0est4qKM0Lwl5NlKwa8aloyeFaMQ08kG5Xwv8tb80e7GC9
         KPzQBLPcqAjQmf86t/kCxVu0kMiCCzkUom2DKZPOPKBFJ7fPsw7albp8F6ROBjbREXcY
         GNAD1yec18PswglilV7VsJYian8KnbMDEGImRAb3Q5dy1lRJ9brT8EQ7XPLzqlfBGAOR
         YrFApO2zXie0Wo0PqkhcXK8LvVvpiMvVmOVAeoHIzSJqrGx4q6+ytEH059V9LdPnzy+I
         uk/g==
X-Gm-Message-State: AGRZ1gLX+fiaubZdoUwvG0vzvif8dyDP8XgVn0oyz/ALi5AMr2uggEnv
        nM7Sg7Ab9cmnVCJnFH+XUQ==
X-Google-Smtp-Source: AJdET5cBq+lzy5/459GXYuurDgetZx1DD/VVBVG11WZOsF7eicPspFlOBVSYrqjShgaGI4IY0NzqBQ==
X-Received: by 2002:aca:f1d6:: with SMTP id p205-v6mr2210545oih.332.1542410812196;
        Fri, 16 Nov 2018 15:26:52 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id n6sm17773609ote.56.2018.11.16.15.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 15:26:51 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:26:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com,
        frowand.list@gmail.com, jasowang@redhat.com, robh+dt@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com,
        kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com
Subject: Re: [PATCH v4 3/7] of: Allow the iommu-map property to omit
 untranslated devices
Message-ID: <20181116232648.GA12293@bogus>
References: <20181115165234.43990-1-jean-philippe.brucker@arm.com>
 <20181115165234.43990-4-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115165234.43990-4-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 15 Nov 2018 16:52:30 +0000, Jean-Philippe Brucker wrote:
> In PCI root complex nodes, the iommu-map property describes the IOMMU that
> translates each endpoint. On some platforms, the IOMMU itself is presented
> as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). This isn't supported
> by the current OF driver, which expects all endpoints to have an IOMMU.
> Allow the iommu-map property to have gaps.
> 
> Relaxing of_map_rid() also allows the msi-map property to have gaps, which
> is invalid since MSIs always reach an MSI controller. In that case
> pci_msi_setup_msi_irqs() will return an error when attempting to find the
> device's MSI domain.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/of/base.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
