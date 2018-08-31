Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:10601 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbeHaVm0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 17:42:26 -0400
Subject: [PATCH for-rc 0/2] IB/hfi1: PCI bug due to pci core changes
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
To: bhelgaas@google.com, jgg@ziepe.ca, dledford@redhat.com
Cc: Sinan Kaya <okaya@codeaurora.org>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Fri, 31 Aug 2018 10:33:54 -0700
Message-ID: <20180831173132.21741.25892.stgit@scvm10.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Doug and Jason,

As discussed on the pci list [1] our driver was broken with the following three
changes in 4.19 merge window:

c6a44ba950d1 ("PCI: Rename pci_try_reset_bus() to pci_reset_bus()")
409888e0966e ("IB/hfi1: Use pci_try_reset_bus() for initiating PCI Secondary Bus Reset")
811c5cb37df4 ("PCI: Unify try slot and bus reset API")

Ideally I'd like to see those patches reverted but we could also go with
something like the following series. I know there is a desire to have a more
clean API but since this is already the rc phase I think that is best delayed.
Clearly the first attempt at an API clean up did not work out so well.

I'm not sure how you maintainers want to handle this since the fix straddles
both subsystems so I'm sending it to both linux-rdma and linux-pci.

At the request of discussion on the linux-pci list I have also filed a bug [2].

[1] https://marc.info/?l=linux-pci&m=153539692917785&w=2
[2] https://bugzilla.kernel.org/show_bug.cgi?id=200985

Thanks


---

Dennis Dalessandro (2):
      PCI: Fix faulty logic in pci_reset_bus()
      IB/hfi1,PCI: Allow bus reset while probing


 drivers/infiniband/hw/hfi1/pcie.c |   11 ++++-------
 drivers/pci/pci.c                 |    3 ++-
 include/linux/pci.h               |    3 +++
 3 files changed, 9 insertions(+), 8 deletions(-)

--
-Denny
