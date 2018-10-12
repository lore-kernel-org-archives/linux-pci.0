Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764A0C43441
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 11:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41512077C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 11:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41512077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeJLSrW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:47:22 -0400
Received: from foss.arm.com ([217.140.101.70]:50032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeJLSrW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 14:47:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFDEAED1;
        Fri, 12 Oct 2018 04:15:25 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0BD3F5D3;
        Fri, 12 Oct 2018 04:15:24 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:15:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Douglas <adouglas@cadence.com>
Cc:     kishon@ti.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        gustavo.pimentel@synopsys.com, cyrille.pitchen@bootlin.com
Subject: Re: [PATCH v4 0/4] Fixes for cadence EP driver
Message-ID: <20181012111521.GC23257@e107981-ln.cambridge.arm.com>
References: <1539274503-30876-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539274503-30876-1-git-send-email-adouglas@cadence.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 05:15:03PM +0100, Alan Douglas wrote:
> These patches were previously in the patch series:
>   "Add MSI-X support for cadence EP driver"
> 
> They add fixes for MSI issues discovered during testing of MSI-X
>   - Use AXI region 0 for interrupt signalling
>   - Write MSI with 32bit value rather than 16bit
>   - Check for masking before sending MSI
>   - Check link is up before sending IRQ
> 
> Changes since v3:
>   - Rebase on Lorenzo's pci/cadence branch
> 
> Changes since v2:
>   - None
> 
> Changes since v1:
>   - Rebased on 4.18-rc1
>   - Update commit log to mark first 4 patches as fixes
>   - Correct formatting issues pointed out by checkpatch --strict
> 
> 
> Alan Douglas (4):
>   PCI: cadence: Use AXI region 0 to signal interrupts from EP
>   PCI: cadence: Write MSI data with 32bits
>   PCI: cadence: Check whether MSI is masked before sending it
>   PCI: cadence: Check link is up before sending IRQ from EP
> 
>  drivers/pci/controller/pcie-cadence-ep.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Applied to pci/cadence for v4.20, thanks.

Lorenzo
