Return-Path: <SRS0=qc/6=ET=ziepe.ca=jgg@kernel.org>
Return-Path: <SRS0=qc/6=ET=ziepe.ca=jgg@kernel.org>
Date: Wed, 24 Jan 2018 15:24:17 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, linux-pci@vger.kernel.org,
	oded.gabbay@gmail.com, Jay.Cornwall@amd.com,
	Michal Kalderon <Michal.Kalderon@cavium.com>,
	Ram Amrani <Ram.Amrani@cavium.com>,
	Doug Ledford <dledford@redhat.com>,
	Ariel Elior <Ariel.Elior@cavium.com>
Subject: Re: [PATCH 1/2] PCI: Add pci_enable_atomic_ops_to_root
Message-ID: <20180124222417.GB10706@ziepe.ca>
References: <1515113100-4718-1-git-send-email-Felix.Kuehling@amd.com>
 <20180124213648.GK5317@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180124213648.GK5317@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 24, 2018 at 03:36:48PM -0600, Bjorn Helgaas wrote:
> I applied these two patches to pci/enumeration for v4.16, thanks!
> 
>   430a23689dea PCI: Add pci_enable_atomic_ops_to_root()
>   20c3ff6114b0 RDMA/qedr: Use pci_enable_atomic_ops_to_root()
> 
> Doug, Jason, the second changes drivers/infiniband/hw/qedr/main.c to
> use the new interface.  Ordinarily that would go through the
> Infiniband tree, but since it depends on the PCI patch I included it.
> Let me know if you'd like something else.

Sounds reasonable, it doesn't look like we have any work for 4.16 that
will conflict with it at this point.

Thanks,
Jason
