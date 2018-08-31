Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50242 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeHaWHK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Aug 2018 18:07:10 -0400
Subject: Re: [PATCH for-rc 1/2] PCI: Fix faulty logic in pci_reset_bus()
To: Dennis Dalessandro <dennis.dalessandro@intel.com>,
        bhelgaas@google.com, jgg@ziepe.ca, dledford@redhat.com
Cc: "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180831173132.21741.25892.stgit@scvm10.sc.intel.com>
 <20180831173359.21741.61944.stgit@scvm10.sc.intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <590c7cc7-b6e7-5ac6-9f4d-5b4b1fbc1e29@codeaurora.org>
Date: Fri, 31 Aug 2018 10:58:32 -0700
MIME-Version: 1.0
In-Reply-To: <20180831173359.21741.61944.stgit@scvm10.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/31/2018 10:34 AM, Dennis Dalessandro wrote:
> The pci_rest_bus() function calls into pci_probe_reset_slot() to determine
> whether to call the slot or bus reset. The check has faulty logic in that
> it does not account for pci_probe_reset_slot() being able to return an
> errno. Fix by only calling the slot reset when the function returns 0.
> Treat < 1 and > 1 the same.
> 
> Cc: Sinan Kaya<okaya@codeaurora.org>
> Fixes: 811c5cb37df4 ("PCI: Unify try slot and bus reset API")
> Reviewed-by: Michael J. Ruhl<michael.j.ruhl@intel.com>
> Signed-off-by: Dennis Dalessandro<dennis.dalessandro@intel.com>

Nit. Small typo on the first sentence (pci_rest_bus()).

Reviewed-by: Sinan Kaya <okaya@kernel.org>
