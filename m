Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 30 Mar 2017 18:44:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v4 0/7] PCI: dwc: Miscellaneous fixes and cleanups
Message-ID: <20170330234450.GC3912@bhelgaas-glaptop.roam.corp.google.com>
References: <20170313134328.1588-1-kishon@ti.com>
MIME-Version: 1.0
In-Reply-To: <20170313134328.1588-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org,
 nsekhar@ti.com, linux-kernel@vger.kernel.org,
 Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 07:13:21PM +0530, Kishon Vijay Abraham I wrote:
> This should be the final set of cleanups/fixes before endpoint
> support can be merged.
> 
> Keerthy's patch is a general fix in dra7xx driver and is not
> directly related to endpoint mode.
> 
> This v1 of this series was previously sent with a different
> cover letter $subject [1]
> 
> Changes from v3:
> *) instead of changing all the callers of dbi accessors (taking
>    dbi_base and size), manage it using static inline as suggested
>    by Niklas (used static inline instead of macros because of
>    checkpatch error).
> 
> Changes from v2:
> *) Kconfig changes that was spilled into a patch is removed.
> *) In addition to renaming _unroll() to _ob_unroll(), all the
>    _unroll configurations is also moved a separate function.
> 
> Changes from v1:
> *) included a patch to rename _unroll() to _ob_unroll() as
>    similar thing has to be done for inbound window in the case
>    of EP mode.
> *) used 'size_t' instead of 'int' for specifying the size
>    in read_dbi/write_dbi function arguments.
> *) Populate cpu_addr_fixup ops for artpec6 as suggested by
>    Niklas
> 
> This series is based on 4.11-rc1
> 
> [1] -> https://lkml.org/lkml/2017/2/16/270
> 
> Keerthy (1):
>   PCI: dwc: dra7xx: Push request_irq call to the bottom of probe
> 
> Kishon Vijay Abraham I (6):
>   PCI: dwc: designware: Add new *ops* for cpu addr fixup
>   PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
>   PCI: dwc: artpec6: Populate cpu_addr_fixup ops
>   PCI: dwc: all: Modify dbi accessors to take dbi_base as argument
>   PCI: dwc: all: Modify dbi accessors to access data of  4/2/1 bytes
>   PCI: dwc: designware: Move _unroll configurations to a separate
>     function
> 
>  drivers/pci/dwc/pci-dra7xx.c      |  25 +++----
>  drivers/pci/dwc/pci-exynos.c      |  14 ++--
>  drivers/pci/dwc/pcie-artpec6.c    |  15 +++--
>  drivers/pci/dwc/pcie-designware.c | 133 ++++++++++++++++++++++++--------------
>  drivers/pci/dwc/pcie-designware.h |  23 +++++--
>  5 files changed, 135 insertions(+), 75 deletions(-)

Applied to pci/host-designware for v4.12, with Niklas' ack on patches
4 & 5, thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
