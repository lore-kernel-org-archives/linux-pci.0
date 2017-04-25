Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934374AbdDYTj7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Apr 2017 15:39:59 -0400
Date: Tue, 25 Apr 2017 14:39:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Byczkowski, Jakub" <jakub.byczkowski@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
        "Benedetto, Salvatore" <salvatore.benedetto@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        qat-linux <qat-linux@intel.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] IB/hfi1: use pcie_flr instead of duplicating it
Message-ID: <20170425193955.GC29024@bhelgaas-glaptop.roam.corp.google.com>
References: <20170414191131.14286-1-hch@lst.de>
 <20170414191131.14286-6-hch@lst.de>
 <A33E225544E47D4DB5713032774B132783960382@irsmsx105.ger.corp.intel.com>
 <20170424143507.GA28812@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170424143507.GA28812@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 24, 2017 at 04:35:07PM +0200, Christoph Hellwig wrote:
> On Mon, Apr 24, 2017 at 02:16:31PM +0000, Byczkowski, Jakub wrote:
> > Tested-by: Jakub Byczkowski <jakub.byczkowski@intel.com>
> 
> Are you (and Doug) ok with queueing this up in the PCI tree?

Applied this with Jakub's tested-by and Doug's ack to pci/virtualization
for v4.12.

This still leaves these:

  [PATCH 4/7] ixgbe: use pcie_flr instead of duplicating it
  [PATCH 6/7] crypto: qat: use pcie_flr instead of duplicating it
  [PATCH 7/7] liquidio: use pcie_flr instead of duplicating it

I haven't seen any response to 4 and 6.  Felix reported an unused
variable in 7.  Let me know if you'd like me to do anything with
these.

Bjorn
