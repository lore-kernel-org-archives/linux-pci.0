Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1495471182-12490-3-git-send-email-oza.oza@broadcom.com>
References: <1495471182-12490-1-git-send-email-oza.oza@broadcom.com>
 <1495471182-12490-3-git-send-email-oza.oza@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 30 May 2017 17:42:46 -0500
Message-ID: <CAErSpo6MJbNEyGQC4MwFb6kPoOf1p=mxk-SHAz-+HuDFbvRkmw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] PCI: Add support for PCI inbound windows resources
To: Oza Pawandeep <oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Oza Pawandeep <oza.pawandeep@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 22, 2017 at 11:39 AM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
> This patch adds support for inbound memory window
> for PCI RC drivers.
>
> It defines new function pci_create_root_bus2 which
> takes inbound resources as an argument and fills in the
> memory resource to PCI internal host bridge structure
> as inbound_windows.
>
> Legacy RC driver could continue to use pci_create_root_bus,
> but any RC driver who wants to reseve IOVAS for their
> inbound memory holes, should use new API pci_create_root_bus2.
>
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
> ...

> +struct pci_bus *pci_create_root_bus2(struct device *parent, int bus,
> +               struct pci_ops *ops, void *sysdata, struct list_head *resources,
> +               struct list_head *in_res)
> +{
> +       return pci_create_root_bus_msi(parent, bus, ops, sysdata,
> +                                      resources, in_res, NULL);
> +}
> +EXPORT_SYMBOL_GPL(pci_create_root_bus2);

Based on your response to Lorenzo's "[RFC/RFT PATCH 03/18] PCI:
Introduce pci_scan_root_bus_bridge()", I'm hoping you can avoid adding
yet another variant of pci_create_root_bus().

So I think I can wait for that to settle out and look for a v8?

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
