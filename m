Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13226 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752941AbdHKQg0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Aug 2017 12:36:26 -0400
Date: Fri, 11 Aug 2017 09:25:06 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
        valmiki <valmikibow@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Lan, Tianyu" <tianyu.lan@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: Support SVM without PASID
Message-ID: <20170811162506.GB41059@otc-nc-03>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
 <eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
 <ee41f5d9-e7fb-8f7c-4b85-87cdb951ec70@gmail.com>
 <ca0d9f94-f5e2-aaaf-2c64-0cd6ecc62754@arm.com>
 <41333a03-bf91-1152-4779-6579845609f6@gmail.com>
 <564ba70b-db95-7fe0-86bb-bb4eefcd87ec@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D57191@SHSMSX101.ccr.corp.intel.com>
 <b973c557-1b4a-18d2-a05e-28680a49daf9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b973c557-1b4a-18d2-a05e-28680a49daf9@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 04, 2017 at 10:42:41AM +0100, Jean-Philippe Brucker wrote:
> Hi Kevin,
> 
> 
> Consider the situation where a userspace driver (no virtualization) is
> built in a client-server fashion: the server controls a device and spawns
> new processes (clients), each sharing a context with the device using its
> own PASID. If the server wants to hide parts of the client address space

Just to be sure, you are't expecting the PASID's to be duplicated or 
recreated after a new process is spawned. I would expect each process to 
get its own PASID by doing a bind. Threads of the same process would be
sharing the same PASID since they all share the same first level 
mappings.


> from the device (e.g. .text), then it could control stage-2 via MAP/UNMAP
> to restrict the address space.

I'm confused.. maybe this is different from Intel IOMMU. the first level 
requiring a second level is only true when virtualization is in play.

First level is gVA->gPA, and second level is gPA->hPA (sort of the cloned
EPT map that is setup via VFIO to set up second level)

When you are in native user application, there is no nesting between first
and second level. The first level is directly VA->hPA. There is no need
for a nested walk in this case?

> 
> It would use different semantics of MAP/UNMAP though, as the ioctl would
> only be used to define 1:1 translation windows, not pin memory.
> 
