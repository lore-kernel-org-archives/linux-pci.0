Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170411163313.18577-2-ard.biesheuvel@linaro.org>
References: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
 <20170411163313.18577-2-ard.biesheuvel@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 11 Apr 2017 19:30:48 +0100
Message-ID: <CAKv+Gu_bzdw6V2U3yUrUKcoWSmyRyxmgjUVDJy3A14QjifCaeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: pci: do not disregard parent resources
 starting at 0x0
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 linux-pci <linux-pci@vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Graeme Gregory <graeme.gregory@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Sinan Kaya <okaya@codeaurora.org>,
 Tomasz Nowicki <tn@semihalf.com>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 11 April 2017 at 17:33, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Commit f44116ae8818 ("PCI: Remove pci_find_parent_resource() use for
> allocation") updated the logic that iterates over all bus resources
> and compares them to a given resource, in order to decide whether one
> is the parent of the latter.
>
> This change inadvertently causes pci_find_parent_resource() to disregard
> resources starting at address 0x0, resulting in an error such as the one
> below on ARM systems whose I/O window starts at 0x0.
>
> pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff window]
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
> pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff window]
> pci_bus 0000:00: root bus resource [bus 00-0f]
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:00:02.0: PCI bridge to [bus 02]
> pci 0000:00:03.0: PCI bridge to [bus 03]
> pci 0000:00:03.0: can't claim BAR 13 [io  0x0000-0x0fff]: no compatible bridge window
> pci 0000:03:01.0: can't claim BAR 0 [io  0x0000-0x001f]: no compatible bridge window
>
> While this never happens on x86, it is perfectly legal in general for a
> PCI MMIO or IO window to start at address 0x0, and it was supported in
> the code before commit f44116ae8818.
>
> So let's drop the test for res->start != 0; resource_contains() already
> checks whether [start, end) completely covers the resource, and so it
> should be redundant.
>
> Fixes: f44116ae8818 ("PCI: Remove pci_find_parent_resource() use for allocation")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7904d02ffdb9..53a41b1f7ef7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -454,7 +454,7 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>         pci_bus_for_each_resource(bus, r, i) {
>                 if (!r)
>                         continue;
> -               if (res->start && resource_contains(r, res)) {
> +               if (resource_contains(r, res)) {
>
>                         /*
>                          * If the window is prefetchable but the BAR is

Actually, I managed to confuse myself a bit here: $SUBJECT is
inaccurate, given that it is not the parent resource being disregarded
if it starts at 0x0 but the containee.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
