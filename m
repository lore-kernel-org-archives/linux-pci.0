Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: Convert to using %pOF instead of full_name
To: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20170718214339.7774-41-robh@kernel.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 4 Aug 2017 09:38:42 -0700
MIME-Version: 1.0
In-Reply-To: <20170718214339.7774-41-robh@kernel.org>
Message-Id: <dd5a317b-9e72-97bc-0386-8470998421c3@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 07/18/2017 02:43 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  drivers/pci/host/pci-mvebu.c        | 8 ++++----
>  drivers/pci/host/pci-tegra.c        | 3 +--
>  drivers/pci/hotplug/pnv_php.c       | 4 ++--
>  drivers/pci/hotplug/rpadlpar_core.c | 4 ++--
>  drivers/pci/hotplug/rpaphp_core.c   | 2 +-
>  drivers/pci/hotplug/rpaphp_pci.c    | 4 ++--
>  drivers/pci/hotplug/rpaphp_slot.c   | 4 ++--
>  drivers/pci/pci-sysfs.c             | 4 ++--
>  drivers/pci/pci.c                   | 4 ++--
>  9 files changed, 18 insertions(+), 19 deletions(-)
> 

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
