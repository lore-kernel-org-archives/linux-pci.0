Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE99C10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 23:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76EB217F4
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 23:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554851474;
	bh=kzt1Obrpb6634tF78ZGYwr/I4vgjioLT6Naah1lCkTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CfcYod57Ulv5DxfcrGn2TD1qZxMLLRHpllPLuUG8yXzDXU/DrJkD/fceEEdVIvVSb
	 YOMiV/JPIA9Z9xm/5AyVsHgzfpEaMurgnr1vmBXAaPsBT9AFLTvYMDvRj56jEjOXdy
	 WzFZZCFFucsL0Jow2hVYx0TNHXuPOEmjQa6Yks20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDIXLO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfDIXLO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Apr 2019 19:11:14 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC5620883;
        Tue,  9 Apr 2019 23:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554851473;
        bh=kzt1Obrpb6634tF78ZGYwr/I4vgjioLT6Naah1lCkTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fOL8quSvN3oe3o3rxodrCn5iTyC3c2Nmqi6LtSsFe+JQKcSAETFn1H7uCvwEo5RwB
         X7y/QXuLw96KGLcC9iGT798N9P+8yUcKyKWhnUKHUrLCwP0OY/HPcSe7SxW5Yzk5cd
         nWQcWMridLhvPBfn9ZzxwDSepZxOfxQlZx55CqzA=
Date:   Tue, 9 Apr 2019 18:11:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Jeremy.Linton@arm.com, Grant.Likely@arm.com, Robin.Murphy@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] PCI: Describe external-facing ports in device tree
Message-ID: <20190409231111.GE256045@google.com>
References: <20190402131548.41949-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402131548.41949-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 02, 2019 at 02:15:46PM +0100, Jean-Philippe Brucker wrote:
> Since v1 [1], I improved the wording of patch 1/2 as suggested by Bjorn.
> 
> Add an "external-facing" property to PCI ports in device-tree, to help
> identify untrusted devices. The notion of untrusted PCI devices was
> added to the v5.0 kernel to describe devices that should have strict
> IOMMU protection [2], for example devices that are plugged in a
> Thunderbolt port. ACPI systems use the ExternalFacingPort property [3].
> Add an equivalent mechanism to device tree.
> 
> [1] https://lore.kernel.org/linux-pci/20190318182124.53859-1-jean-philippe.brucker@arm.com/
> [2] https://lkml.org/lkml/2018/11/26/631
> [3] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> 
> Jean-Philippe Brucker (2):
>   dt-bindings: Add external-facing PCIe port property
>   PCI: OF: Support external-facing property

Applied to pci/enumeration for v5.2, with reviewed-by from Robin and Grant
and from Rob (patch 2 only), thanks!

>  Documentation/devicetree/bindings/pci/pci.txt | 50 +++++++++++++++++++
>  drivers/pci/of.c                              |  3 ++
>  2 files changed, 53 insertions(+)
> 
> -- 
> 2.21.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
