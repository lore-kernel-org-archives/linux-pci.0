Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3DBC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 10:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1805F2173C
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 10:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfBZKHe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:07:34 -0500
Received: from 8bytes.org ([81.169.241.247]:41326 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfBZKHd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 05:07:33 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B1F3F247; Tue, 26 Feb 2019 11:07:31 +0100 (CET)
Date:   Tue, 26 Feb 2019 11:07:30 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, dwmw2@infradead.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v3 0/2] Add PGR response PASID requirement check in Intel
 IOMMU.
Message-ID: <20190226100729.GB20740@8bytes.org>
References: <cover.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 19, 2019 at 11:04:50AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> Kuppuswamy Sathyanarayanan (2):
>   PCI/ATS: Add pci_prg_resp_pasid_required() interface.
>   iommu/vt-d: Fix PRI/PASID dependency issue.
> 
>  drivers/iommu/intel-iommu.c   |  4 +++-
>  drivers/pci/ats.c             | 30 ++++++++++++++++++++++++++++++
>  include/linux/pci-ats.h       |  5 +++++
>  include/uapi/linux/pci_regs.h |  1 +
>  4 files changed, 39 insertions(+), 1 deletion(-)

Applied, thanks.
