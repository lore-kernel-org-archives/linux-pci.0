Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65E0C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 11:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE11204EC
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 11:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfDWLVn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:21:43 -0400
Received: from foss.arm.com ([217.140.101.70]:54756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDWLVn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 07:21:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E91D374;
        Tue, 23 Apr 2019 04:21:43 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 710193F557;
        Tue, 23 Apr 2019 04:21:40 -0700 (PDT)
Date:   Tue, 23 Apr 2019 12:21:38 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        okaya@kernel.org, zhongmiao@hisilicon.com, eric.auger@redhat.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Add PCI ATS support to Arm SMMUv3
Message-ID: <20190423112138.GC3439@fuggles.cambridge.arm.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 17, 2019 at 07:24:39PM +0100, Jean-Philippe Brucker wrote:
> This series enables PCI ATS in SMMUv3. Changes since v2 [1]:
> 
> * Fix build failure when building arm-smmu-v3 without CONFIG_PCI
>   Patches 1 and 2 are new.
> 
> * Only enable ATS if the root complex supports it. For the moment, only
>   IORT provides this information. I have patches for devicetree but
>   they are less mature and I'd rather make it a separate series.
> 
> * Tried to address most comments. I'll see if I can improve the firmware
>   code when adding devicetree support (see [2]).
> 
> Note that there is a small conflict with the SVA API. This series
> applies on top of Joerg's api-features branch for v5.2.

I'll pick this up via the SMMU queue, since the conflict with api-features
is trivial to resolve.

Will
