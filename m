Return-Path: <SRS0=3jnD=BD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B18C433E8
	for <linux-pci@archiver.kernel.org>; Fri, 24 Jul 2020 08:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7938F2070B
	for <linux-pci@archiver.kernel.org>; Fri, 24 Jul 2020 08:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGXItD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:49:03 -0400
Received: from 8bytes.org ([81.169.241.247]:59022 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXItD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 04:49:03 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 63D2F46A; Fri, 24 Jul 2020 10:49:02 +0200 (CEST)
Date:   Fri, 24 Jul 2020 10:48:59 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lu Baolu <baolu.lu@intel.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v3 1/1] PCI/ATS: Check PRI supported on the PF device
 when SRIOV is enabled
Message-ID: <20200724084859.GQ27672@8bytes.org>
References: <1595543849-19692-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595543849-19692-1-git-send-email-ashok.raj@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 23, 2020 at 03:37:29PM -0700, Ashok Raj wrote:
> PASID and PRI capabilities are only enumerated in PF devices. VF devices
> do not enumerate these capabilites. IOMMU drivers also need to enumerate
> them before enabling features in the IOMMU. Extending the same support as
> PASID feature discovery (pci_pasid_features) for PRI.
> 
> Fixes: b16d0cb9e2fc ("iommu/vt-d: Always enable PASID/PRI PCI capabilities before ATS")
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>

Acked-by: Joerg Roedel <jroedel@suse.de>

