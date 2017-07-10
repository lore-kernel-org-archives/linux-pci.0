Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34491 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdGJTbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2017 15:31:55 -0400
Date: Mon, 10 Jul 2017 15:31:41 -0400
From: Jerome Glisse <j.glisse@gmail.com>
To: valmiki <valmikibow@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, tianyu.lan@intel.com,
        kevin.tian@intel.com, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        jacob.jun.pan@intel.com
Subject: Re: Support SVM without PASID
Message-ID: <20170710193141.GA3813@gmail.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 09, 2017 at 08:45:57AM +0530, valmiki wrote:
> > > Hi,
> > > 
> > > In SMMUv3 architecture document i see "PASIDs are optional,
> > > configurable, and of a size determined by the minimum
> > > of the endpoint".
> > > 
> > > So if PASID's are optional and not supported by PCIe end point, how SVM
> > > can be achieved ?
> > 
> > It cannot be inferred from that statement that PASID support is not
> > required for SVM.  AIUI, SVM is a software feature enabled by numerous
> > "optional" hardware features, including PASID.  Features that are
> > optional per the hardware specification may be required for specific
> > software features.  Thanks,
> > 
> Thanks for the information Alex. Suppose if an End point doesn't support
> PASID, is it still possible to achieve SVM ?
> Are there any such features in SMMUv3 with which we can achieve it ?

You can achieve SVM in software, this is what HMM is for. But the hardware
must have an mmu with similar features as you get on CPU mmu. Device like
GPU do have such MMU.

You can also mix HMM with PASID/ATS to leverage device memory. HMM allows
you to use device memory inside process address space for device threads
(ie device memory is still consider as un-accessible from CPU, only device
can access it). Again very useful for GPU.

Cheers,
Jérôme

(1) https://lwn.net/Articles/726691/
