Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 15 Dec 2017 13:32:04 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Khuong Dinh <kdinh@apm.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: xgene: Remove leftover pci_scan_child_bus() call
Message-ID: <20171215133204.GC30737@red-moon>
References: <20171121154931.7724-1-lorenzo.pieralisi@arm.com>
 <CAAsHzqv_fYOZTHLWSTSXX=2YziMWcNg15qz1mGaRdyWMa7Hntg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAsHzqv_fYOZTHLWSTSXX=2YziMWcNg15qz1mGaRdyWMa7Hntg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 08, 2017 at 10:32:52AM -0800, Khuong Dinh wrote:
> Hi Lorenzo,
> 
> On Tue, Nov 21, 2017 at 7:49 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > The changes in commit 9af275be15f7 ("PCI: xgene: Convert PCI scan API to
> > pci_scan_root_bus_bridge()") converted the xgene PCI host driver to
> > the new pci_scan_root_bus_bridge() bus scanning API but erroneously left
> > the existing pci_scan_child_bus() call in place which resulted in duplicate
> > PCI bus enumerations.
> >
> > Remove the leftover pci_scan_child_bus() call to properly complete the API
> > conversion.
> >
> > Fixes: 9af275be15f7 ("PCI: xgene: Convert PCI scan API to pci_scan_root_bus_bridge()")
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Tanmay Inamdar <tinamdar@apm.com>
> > ---
> >  drivers/pci/host/pci-xgene.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> > index 465aa2a..e60c457 100644
> > --- a/drivers/pci/host/pci-xgene.c
> > +++ b/drivers/pci/host/pci-xgene.c
> > @@ -668,7 +668,6 @@ static int xgene_pcie_probe(struct platform_device *pdev)
> >
> >         bus = bridge->bus;
> >
> > -       pci_scan_child_bus(bus);
> >         pci_assign_unassigned_bus_resources(bus);
> >         list_for_each_entry(child, &bus->children, node)
> >                 pcie_bus_configure_settings(child);
> > --
> > 2.9.5
> >
> 
> It is good with X-Gene
> 
> Tested-by: Khuong Dinh <kdinh@apm.com>

Thank you. Bjorn, I will queue this for v4.16 - I would add a stable tag
since we have v4.13+ kernels scanning the bus twice on xgene, I am not
too happy about this.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
