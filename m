Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:42118 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751763AbdGIJ3Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Jul 2017 05:29:25 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: valmiki <valmikibow@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC: "Lan, Tianyu" <tianyu.lan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Subject: RE: Support SVM without PASID
Date: Sun, 9 Jul 2017 09:29:21 +0000
Message-ID: <A2975661238FB949B60364EF0F2C2574390A3432@shsmsx102.ccr.corp.intel.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
        <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
In-Reply-To: <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of valmiki
> Sent: Sunday, July 9, 2017 11:16 AM
> To: Alex Williamson <alex.williamson@redhat.com>
> Cc: Lan, Tianyu <tianyu.lan@intel.com>; Tian, Kevin <kevin.tian@intel.com>;
> kvm@vger.kernel.org; linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org;
> Pan, Jacob jun <jacob.jun.pan@intel.com>
> Subject: Re: Support SVM without PASID
> 
> >> Hi,
> >>
> >> In SMMUv3 architecture document i see "PASIDs are optional,
> >> configurable, and of a size determined by the minimum of the
> >> endpoint".
> >>
> >> So if PASID's are optional and not supported by PCIe end point, how
> >> SVM can be achieved ?
> >
> > It cannot be inferred from that statement that PASID support is not
> > required for SVM.  AIUI, SVM is a software feature enabled by numerous
> > "optional" hardware features, including PASID.  Features that are
> > optional per the hardware specification may be required for specific
> > software features.  Thanks,
> >
> Thanks for the information Alex. Suppose if an End point doesn't support PASID, is it
> still possible to achieve SVM ?
> Are there any such features in SMMUv3 with which we can achieve it ?

If endpoint has no PASID support, I don't think it is SVM capable. For SMMU, maybe
you can get more info from Jean.

Regards,
Yi L
