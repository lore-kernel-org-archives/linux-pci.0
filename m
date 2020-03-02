Return-Path: <SRS0=J54v=4T=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C75C3F2D1
	for <linux-pci@archiver.kernel.org>; Mon,  2 Mar 2020 16:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0607924676
	for <linux-pci@archiver.kernel.org>; Mon,  2 Mar 2020 16:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCBQQR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:16:17 -0500
Received: from 8bytes.org ([81.169.241.247]:49626 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgCBQQR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 11:16:17 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4EB2D5BC; Mon,  2 Mar 2020 17:16:15 +0100 (CET)
Date:   Mon, 2 Mar 2020 17:16:12 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        jacob.jun.pan@intel.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200302161611.GD7829@8bytes.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228172537.377327-2-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 28, 2020 at 06:25:36PM +0100, Jean-Philippe Brucker wrote:
> This solution isn't elegant nor foolproof, but is the best we can do at
> the moment and works with existing virtio-iommu implementations. It also
> enables an IOMMU for lightweight hypervisors that do not rely on
> firmware methods for booting.

I appreciate the enablement on x86, but putting the conmfiguration into
mmio-space isn't really something I want to see upstream. What is the
problem with defining an ACPI table instead? This would also make things
work on AARCH64 UEFI machines.

Regards,

	Joerg
