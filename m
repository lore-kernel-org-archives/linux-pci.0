Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62919 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752592AbeDQP4P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Apr 2018 11:56:15 -0400
From: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To: Christoph Hellwig <hch@infradead.org>,
        Frederick Lawler <fred@fredlawl.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] IB/hfi1: Cleanup PCIe link configuration
Date: Tue, 17 Apr 2018 15:56:13 +0000
Message-ID: <32E1700B9017364D9B60AED9960492BC627FF54C@fmsmsx120.amr.corp.intel.com>
References: <20180417002825.2737-1-fred@fredlawl.com>
 <20180417065343.GA29193@infradead.org>
In-Reply-To: <20180417065343.GA29193@infradead.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> 
> Btw, why is the driver configuring the PCIe link speed?  Isn't this
> something we should be handling in the PCI core?

The device comes out of reset at the 5GT/s speed. The driver downloads device firmware, programs PCIe registers, and co-ordinates the transition to 8GT/s.

This recipe is device specific and is therefore implemented in the hfi1 driver built on top of PCI core functions and macros.

Mike
