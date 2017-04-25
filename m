Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1493139603.3041.74.camel@redhat.com>
Subject: Re: [PATCH 5/7] IB/hfi1: use pcie_flr instead of duplicating it
From: Doug Ledford <dledford@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
        "Byczkowski, Jakub" <jakub.byczkowski@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
Date: Tue, 25 Apr 2017 13:00:03 -0400
In-Reply-To: <20170424143507.GA28812@lst.de>
References: <20170414191131.14286-1-hch@lst.de>
         <20170414191131.14286-6-hch@lst.de>
         <A33E225544E47D4DB5713032774B132783960382@irsmsx105.ger.corp.intel.com>
         <20170424143507.GA28812@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2017-04-24 at 16:35 +0200, Christoph Hellwig wrote:
> On Mon, Apr 24, 2017 at 02:16:31PM +0000, Byczkowski, Jakub wrote:
> > 
> > Tested-by: Jakub Byczkowski <jakub.byczkowski@intel.com>
> 
> Are you (and Doug) ok with queueing this up in the PCI tree?

I'm fine with that.  Feel free to add my Acked-by to the hfi1 patch.

-- 
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
   
Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
