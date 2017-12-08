Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20171121154931.7724-1-lorenzo.pieralisi@arm.com>
References: <20171121154931.7724-1-lorenzo.pieralisi@arm.com>
From: Khuong Dinh <kdinh@apm.com>
Date: Fri, 8 Dec 2017 10:32:52 -0800
Message-ID: <CAAsHzqv_fYOZTHLWSTSXX=2YziMWcNg15qz1mGaRdyWMa7Hntg@mail.gmail.com>
Subject: Re: [PATCH] PCI: xgene: Remove leftover pci_scan_child_bus() call
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Tanmay Inamdar <tinamdar@apm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Tue, Nov 21, 2017 at 7:49 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> The changes in commit 9af275be15f7 ("PCI: xgene: Convert PCI scan API to
> pci_scan_root_bus_bridge()") converted the xgene PCI host driver to
> the new pci_scan_root_bus_bridge() bus scanning API but erroneously left
> the existing pci_scan_child_bus() call in place which resulted in duplicate
> PCI bus enumerations.
>
> Remove the leftover pci_scan_child_bus() call to properly complete the API
> conversion.
>
> Fixes: 9af275be15f7 ("PCI: xgene: Convert PCI scan API to pci_scan_root_bus_bridge()")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Tanmay Inamdar <tinamdar@apm.com>
> ---
>  drivers/pci/host/pci-xgene.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 465aa2a..e60c457 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -668,7 +668,6 @@ static int xgene_pcie_probe(struct platform_device *pdev)
>
>         bus = bridge->bus;
>
> -       pci_scan_child_bus(bus);
>         pci_assign_unassigned_bus_resources(bus);
>         list_for_each_entry(child, &bus->children, node)
>                 pcie_bus_configure_settings(child);
> --
> 2.9.5
>

It is good with X-Gene

Tested-by: Khuong Dinh <kdinh@apm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
