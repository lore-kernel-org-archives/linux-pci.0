Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 14 Jun 2018 08:50:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: Requirement to get BAR pci_bus_address in user space
Message-ID: <20180614085015.3f39b367@w520.home>
In-Reply-To: <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de>
 <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
 <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
 <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci-owner@vger.kernel.org, Abhishek Shah <abhishek.shah@broadcom.com>,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Vikram Prakash <vikram.prakash@broadcom.com>,
 Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 14 Jun 2018 16:18:15 +0530
Srinath Mannam <srinath.mannam@broadcom.com> wrote:

> Hi Sinan Kaya,
> 
> Here are the details,
> 
> The issue is, For CMB cards SQs are allocated inside device BAR memory
> which is different from normal cards.
> In Normal cards SQ memory allocated at host side.
> In both the cases physical address of CQ memory is programmed in NVMe
> controller register.
> This method works for normal cards because CQ memory is at host side.
> But in CMB cards pci bus address equivalent to CQ memory needs to program.
> 
> More details are in the patch: nvme-pci: Use PCI bus address for
> data/queues in CMB.
> 
> With the above patch issue is fixed in the NVMe kernel driver, But
> similar fix is required in SPDK library also.
> So, We need a mechanism to get pci_bus_address in user space libraries
> to address this issue.

I don't understand the CQ vs CMB, but I think I gather that there's some
sort of buffer that's allocated from within the devices MMIO BAR and
some programming of the device needs to reference that buffer.
Wouldn't you therefore use the vfio type1 IOMMU MAP_DMA ioctl to map
the BAR into the IOVA address space and you can then use the IOVA +
offset into the BAR for the device to reference the buffer?  It seems
this is the same way we'd setup a peer-to-peer mapping, but we're using
it for the device to reference itself effectively.  Thanks,

Alex

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
