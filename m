Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E07BC43387
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3643D2087E
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 14:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547822512;
	bh=C92em26+svT85O4T+VYVTgy00gG1KI8CJpSZO2Ie2CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PeWM2NgJ7e3xUPHws87ls5kHtAbOibxidk2/bhbwut6KVVUv2UT+SEClftyAMHdcx
	 EGVTceXsJgjhpPJkx0QXtOq5+79EUdUrV72cvbP9/Q9Rx+z+FHjHGgXpHixrWSPXFA
	 AQya0kqD/bbBFt3o6+zC2RxQOXrd2t0Ryqmh5FkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfAROlv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:41:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfAROlv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jan 2019 09:41:51 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB94B2054F;
        Fri, 18 Jan 2019 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547822510;
        bh=C92em26+svT85O4T+VYVTgy00gG1KI8CJpSZO2Ie2CY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRznJryS+gnirPNTjNmuwpV621IE1D6QQ2d6ijidsPwyth7UK5gT48oPvEzqdMsbi
         XAHKm+o2DE/cIZsMV9Oc0YVJ9dXu/fq0RLu7XL6AQwGOHQq79JzlfKSVVb2mXW8IIj
         MdkkBkyzaS105aoQWK9IvXYvnTHX1Mg6Ya0J/pPo=
Date:   Fri, 18 Jan 2019 08:41:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add IPROC PCIe new features
Message-ID: <20190118144149.GA25249@google.com>
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 18, 2019 at 09:53:20AM +0530, Srinath Mannam wrote:
> Add changes related to IPROC PCIe RC IP new features.
> 
> This patch set is based on Linux-5.0-rc2.
> 
> Srinath Mannam (3):
>   PCI: iproc: Add feature to set order mode

Since this apparently refers to a PCIe feature, the subject should use the
exact terminology used in the PCIe spec.

>   PCI: iproc: CRS state check in config request

This subject should start with a verb, not "CRS".

>   PCI: iproc: Add PCIe 32bit outbound memory configuration
> 
>  drivers/pci/controller/pcie-iproc.c | 172 +++++++++++++++++++++++++++++++++++-
>  drivers/pci/controller/pcie-iproc.h |  16 ++++
>  2 files changed, 184 insertions(+), 4 deletions(-)
> 
> -- 
> 2.7.4
> 
