Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36346 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbbCTVWu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2015 17:22:50 -0400
Received: by iedm5 with SMTP id m5so38751243ied.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 14:22:49 -0700 (PDT)
Date: Fri, 20 Mar 2015 16:22:46 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V14 14/21] powerpc/powernv: Allocate struct pnv_ioda_pe
 iommu_table dynamically
Message-ID: <20150320212246.GM26935@google.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1426820797-6267-15-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426820797-6267-15-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 20, 2015 at 11:06:30AM +0800, Wei Yang wrote:
> Previously the iommu_table had the same lifetime as a struct pnv_ioda_pe
> and was embedded in it. The pnv_ioda_pe was assigned to a PE on the bootup
> stage. Since PEs are based on the hardware layout which is static in the
> system, they will never get released. This means the iommu_table in the
> pnv_ioda_pe will never get rleased neither.

"will never get released either."
