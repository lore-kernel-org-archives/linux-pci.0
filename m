Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20180423233046.21476-5-logang@deltatee.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 8 May 2018 07:31:30 -0700
Message-ID: <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
To: Logan Gunthorpe <logang@deltatee.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 linux-rdma <linux-rdma@vger.kernel.org>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 23, 2018 at 4:30 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> For peer-to-peer transactions to work the downstream ports in each
> switch must not have the ACS flags set. At this time there is no way
> to dynamically change the flags and update the corresponding IOMMU
> groups so this is done at enumeration time before the groups are
> assigned.
>
> This effectively means that if CONFIG_PCI_P2PDMA is selected then
> all devices behind any PCIe switch heirarchy will be in the same IOMMU
> group. Which implies that individual devices behind any switch
> heirarchy will not be able to be assigned to separate VMs because
> there is no isolation between them. Additionally, any malicious PCIe
> devices will be able to DMA to memory exposed by other EPs in the same
> domain as TLPs will not be checked by the IOMMU.
>
> Given that the intended use case of P2P Memory is for users with
> custom hardware designed for purpose, we do not expect distributors
> to ever need to enable this option. Users that want to use P2P
> must have compiled a custom kernel with this configuration option
> and understand the implications regarding ACS. They will either
> not require ACS or will have design the system in such a way that
> devices that require isolation will be separate from those using P2P
> transactions.

>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/Kconfig        |  9 +++++++++
>  drivers/pci/p2pdma.c       | 45 ++++++++++++++++++++++++++++++---------------
>  drivers/pci/pci.c          |  6 ++++++
>  include/linux/pci-p2pdma.h |  5 +++++
>  4 files changed, 50 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index b2396c22b53e..b6db41d4b708 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -139,6 +139,15 @@ config PCI_P2PDMA
>           transations must be between devices behind the same root port.
>           (Typically behind a network of PCIe switches).
>
> +         Enabling this option will also disable ACS on all ports behind
> +         any PCIe switch. This effectively puts all devices behind any
> +         switch heirarchy into the same IOMMU group. Which implies that
> +         individual devices behind any switch will not be able to be
> +         assigned to separate VMs because there is no isolation between
> +         them. Additionally, any malicious PCIe devices will be able to
> +         DMA to memory exposed by other EPs in the same domain as TLPs
> +         will not be checked by the IOMMU.
> +
>           If unsure, say N.

It seems unwieldy that this is a compile time option and not a runtime
option. Can't we have a kernel command line option to opt-in to this
behavior rather than require a wholly separate kernel image?

Why is this text added in a follow on patch and not the patch that
introduced the config option?

I'm also wondering if that command line option can take a 'bus device
function' address of a switch to limit the scope of where ACS is
disabled.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
