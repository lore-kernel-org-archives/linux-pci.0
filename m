Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE642C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 09:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FF52147C
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 09:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfBZJet (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:34:49 -0500
Received: from 8bytes.org ([81.169.241.247]:41296 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfBZJet (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 04:34:49 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8492241A; Tue, 26 Feb 2019 10:34:47 +0100 (CET)
Date:   Tue, 26 Feb 2019 10:34:46 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>
Subject: Re: [PATCH v2 00/12] Support using MSI interrupts in ntb_transport
Message-ID: <20190226093445.GC19617@8bytes.org>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 13, 2019 at 10:54:42AM -0700, Logan Gunthorpe wrote:
>   iommu/vt-d: Add helper to set an IRTE to verify only the bus number
>   iommu/vt-d: Allow interrupts from the entire bus for aliased devices

Applied these two to the iommu tree, thanks.
