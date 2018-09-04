Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36938 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeIEB0t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Sep 2018 21:26:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id f1-v6so2193510plt.4
        for <linux-pci@vger.kernel.org>; Tue, 04 Sep 2018 13:59:59 -0700 (PDT)
Date: Tue, 4 Sep 2018 14:59:56 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>,
        bhelgaas@google.com, dledford@redhat.com,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 1/2] PCI: Fix faulty logic in pci_reset_bus()
Message-ID: <20180904205956.GA14349@ziepe.ca>
References: <20180831173132.21741.25892.stgit@scvm10.sc.intel.com>
 <20180831173359.21741.61944.stgit@scvm10.sc.intel.com>
 <590c7cc7-b6e7-5ac6-9f4d-5b4b1fbc1e29@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <590c7cc7-b6e7-5ac6-9f4d-5b4b1fbc1e29@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 10:58:32AM -0700, Sinan Kaya wrote:
> On 8/31/2018 10:34 AM, Dennis Dalessandro wrote:
> > The pci_rest_bus() function calls into pci_probe_reset_slot() to determine
> > whether to call the slot or bus reset. The check has faulty logic in that
> > it does not account for pci_probe_reset_slot() being able to return an
> > errno. Fix by only calling the slot reset when the function returns 0.
> > Treat < 1 and > 1 the same.
> > 
> > Cc: Sinan Kaya<okaya@codeaurora.org>
> > Fixes: 811c5cb37df4 ("PCI: Unify try slot and bus reset API")
> > Reviewed-by: Michael J. Ruhl<michael.j.ruhl@intel.com>
> > Signed-off-by: Dennis Dalessandro<dennis.dalessandro@intel.com>
> 
> Nit. Small typo on the first sentence (pci_rest_bus()).
> 
> Reviewed-by: Sinan Kaya <okaya@kernel.org>

Bjorn,

Are you OK to apply this series through the RDMA tree (for rc3), or do
you want to take it through PCI?

https://patchwork.kernel.org/patch/10584277/

Thanks,
Jason
