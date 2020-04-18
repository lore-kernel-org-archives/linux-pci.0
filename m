Return-Path: <SRS0=EUoI=6C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B30C38A2E
	for <linux-pci@archiver.kernel.org>; Sat, 18 Apr 2020 12:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0BA21D82
	for <linux-pci@archiver.kernel.org>; Sat, 18 Apr 2020 12:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgDRMNW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 18 Apr 2020 08:13:22 -0400
Received: from 8bytes.org ([81.169.241.247]:36294 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgDRMNW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Apr 2020 08:13:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 171EA342; Sat, 18 Apr 2020 14:13:21 +0200 (CEST)
Date:   Sat, 18 Apr 2020 14:13:19 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and
 subdevices
Message-ID: <20200418121319.GB6113@8bytes.org>
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
 <20200409191736.6233-2-jonathan.derrick@intel.com>
 <09c98569-ed22-8886-3372-f5752334f8af@linux.intel.com>
 <CAD8Lp45dJ3-t6qqctiP1a=c44PEWZ-L04yv0r0=1Nrvwfouz1w@mail.gmail.com>
 <32cc4809-7029-bc5e-5a74-abbe43596e8d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32cc4809-7029-bc5e-5a74-abbe43596e8d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 13, 2020 at 10:48:55AM +0800, Lu Baolu wrote:
> I have sync'ed with Joerg. This patch set will be replaced with Joerg's
> proposal due to a race concern between domain switching and driver
> binding. I will rebase all vt-d patches in this set on top of Joerg's
> change.

Okay, but is this patch relevant for v5.7? The other changes we are
working on will not land before v5.8.

Regards,

	Joerg
