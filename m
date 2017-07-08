Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753040AbdGHUC7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Jul 2017 16:02:59 -0400
Date: Sat, 8 Jul 2017 14:02:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: valmiki <valmikibow@gmail.com>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        tianyu.lan@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com
Subject: Re: Support SVM without PASID
Message-ID: <20170708140257.2de02d63@w520.home>
In-Reply-To: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 8 Jul 2017 22:33:01 +0530
valmiki <valmikibow@gmail.com> wrote:

> Hi,
> 
> In SMMUv3 architecture document i see "PASIDs are optional, 
> configurable, and of a size determined by the minimum
> of the endpoint".
> 
> So if PASID's are optional and not supported by PCIe end point, how SVM 
> can be achieved ?

It cannot be inferred from that statement that PASID support is not
required for SVM.  AIUI, SVM is a software feature enabled by numerous
"optional" hardware features, including PASID.  Features that are
optional per the hardware specification may be required for specific
software features.  Thanks,

Alex
