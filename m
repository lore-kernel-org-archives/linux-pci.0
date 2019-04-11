Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C95C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 21:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1CB21872
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 21:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555017507;
	bh=NLd1CQQqrnx6/JL0few4z+lC4VV0he9I4H4t2cADfck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HQcQ2QHoc1M/R3f1KfYTDjFP1Pmwy+bIyhBvFBHgWNHo+ya6NP1blTfMOWFPRVmPz
	 nME7kzzH0/FoOHLlxYiiskiwZk1dc8hpPIrTJ2yhcSGL9b34MUUoL4WkYUWIwU/6Hc
	 MA8M9zK5Rdul2utGBgCTCRjHidyPe9NfBSl7ecYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDKVS0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbfDKVSZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 17:18:25 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42312075B;
        Thu, 11 Apr 2019 21:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555017504;
        bh=NLd1CQQqrnx6/JL0few4z+lC4VV0he9I4H4t2cADfck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpQRDejqeGlNltPQa3fWHpXYon/Wm+DLaZmAQLo5MxUf6GyhfRVN7pCZX5FoAAVpO
         Rk2JvzzJU9PZ3mFjzupRYuX/kj8x85BVfBt7AAvPRsqB38JjAVfBLInscgeC7nm2cm
         iKO0sJjh9MeGb5CRQWonBFo3XLFm/TLQFy68RVxI=
Date:   Thu, 11 Apr 2019 16:18:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Robin.Murphy@arm.com, robh+dt@kernel.org, Mark.Rutland@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Grant.Likely@arm.com
Subject: Re: [PATCH v3 0/2] PCI: Describe external-facing ports in device tree
Message-ID: <20190411211823.GU256045@google.com>
References: <20190411124027.9490-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411124027.9490-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 11, 2019 at 01:40:25PM +0100, Jean-Philippe Brucker wrote:
> Since v2 [1] I fixed a possible NULL dereference reported by smatch,
> sorry about that. I dropped all tags for patch 2.
> 
> Add an "external-facing" property to PCI ports in device-tree, to help
> identify untrusted devices. The notion of untrusted PCI devices was
> added to the v5.0 kernel to describe devices that should have strict
> IOMMU protection [2], for example devices that are plugged in a
> Thunderbolt port. ACPI systems use the ExternalFacingPort property [3].
> Add an equivalent mechanism to device tree.
> 
> [1] https://lore.kernel.org/linux-pci/20190402131548.41949-1-jean-philippe.brucker@arm.com/
> [2] https://lkml.org/lkml/2018/11/26/631
> [3] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> 
> Jean-Philippe Brucker (2):
>   dt-bindings: Add external-facing PCIe port property
>   PCI: OF: Support external-facing property
> 
>  Documentation/devicetree/bindings/pci/pci.txt | 50 +++++++++++++++++++
>  drivers/pci/of.c                              | 14 ++++--
>  2 files changed, 60 insertions(+), 4 deletions(-)

Applied to pci/enumeration for v5.2, thanks, and thanks for fixing the NULL
pointer issue!
