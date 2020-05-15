Return-Path: <SRS0=rGTp=65=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1B2C433E0
	for <linux-pci@archiver.kernel.org>; Fri, 15 May 2020 12:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E328D2074D
	for <linux-pci@archiver.kernel.org>; Fri, 15 May 2020 12:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgEOMBx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 May 2020 08:01:53 -0400
Received: from 8bytes.org ([81.169.241.247]:43198 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgEOMBx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 08:01:53 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2B23D379; Fri, 15 May 2020 14:01:52 +0200 (CEST)
Date:   Fri, 15 May 2020 14:01:50 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhelgaas@google.com,
        will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH 2/4] iommu/amd: Use pci_ats_supported()
Message-ID: <20200515120150.GU18353@8bytes.org>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
 <20200515104359.1178606-3-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104359.1178606-3-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 15, 2020 at 12:44:00PM +0200, Jean-Philippe Brucker wrote:
> The pci_ats_supported() function checks if a device supports ATS and is
> allowed to use it. In addition to checking that the device has an ATS
> capability and that the global pci=noats is not set
> (pci_ats_disabled()), it also checks if a device is untrusted.

Hmm, but per patch 1, pci_ats_supported() does not check
pci_ats_disabled(), or do I miss something?


	Joerg
