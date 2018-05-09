Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 9 May 2018 08:44:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Stephen  Bates" <sbates@raithlin.com>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all
 devices behind switches
Message-ID: <20180509084445.626d2732@w520.home>
In-Reply-To: <B5BFCF39-6BB4-4E45-B805-C8FCC8B79EF3@raithlin.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
 <64C231F5-DE36-415F-B308-3A423B0BBACB@raithlin.com>
 <15433946-f7f5-f610-4e80-380fb59920e5@redhat.com>
 <3C9FB262-A93C-4C8F-B1E0-85C6D6F78BC2@raithlin.com>
 <c5f30ced-7bbf-9420-db1a-72519fc78b3a@redhat.com>
 <20180508180157.7c7b393f@w520.home>
 <B5BFCF39-6BB4-4E45-B805-C8FCC8B79EF3@raithlin.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 =?UTF-8?B?SsOpcsO0?= =?UTF-8?B?bWU=?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Don Dutile <ddutile@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 9 May 2018 12:35:56 +0000
"Stephen  Bates" <sbates@raithlin.com> wrote:

> Hi Alex and Don
> 
> >    Correct, the VM has no concept of the host's IOMMU groups, only
> > the hypervisor knows about the groups,   
> 
> But as I understand it these groups are usually passed through to VMs
> on a pre-group basis by the hypervisor? So IOMMU group 1 might be
> passed to VM A and IOMMU group 2 passed to VM B. So I agree the VM is
> not aware of IOMMU groupings but it is impacted by them in the sense
> that if the groupings change the PCI topology presented to the VM
> needs to change too.

Hypervisors don't currently expose any topology based on the grouping,
the only case where such a concept even makes sense is when a vIOMMU is
present as devices within the same group cannot have separate address
spaces.  Our options for exposing such information is also limited, our
only real option would seem to be placing devices within the same group
together on a conventional PCI bus to denote the address space
granularity.  Currently we strongly recommend singleton groups for this
case and leave any additional configuration constraints to the admin.

The case you note of a group passed to VM A and another passed to VM B
is exactly an example of why any sort of dynamic routing change needs to
have the groups fully released, such as via hot-unplug.  For instance,
a routing change at a shared node above groups 1 & 2 could result in
the merging of these groups and there is absolutely no way to handle
that with portions of the group being owned by two separate VMs after
the merge.  Thanks,

Alex

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
