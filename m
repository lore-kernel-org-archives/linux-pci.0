Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Feb 2017 16:27:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Abylay Ospan <aospan@netup.ru>
Subject: Re: [PATCH] PCI: iproc: fix resource allocation for BCMA PCIe
Message-ID: <20170208222736.GA9094@bhelgaas-glaptop.roam.corp.google.com>
References: <1484265521-13497-1-git-send-email-aospan@netup.ru>
 <20170128204407.GA20550@bhelgaas-glaptop.roam.corp.google.com>
 <CAK3bHNV-O+k1rHSj-KTKOBNNDXpWxp7rXw8bi7ve7-T9qqs8dw@mail.gmail.com>
 <20170208204831.GA2206@bhelgaas-glaptop.roam.corp.google.com>
 <CAK3bHNVz1O7pWL8xV+gf4M-MMKBsq6Bwkt654FOAEOZn=AUH-w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK3bHNVz1O7pWL8xV+gf4M-MMKBsq6Bwkt654FOAEOZn=AUH-w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Wenrui Li <wenrui.li@rock-chips.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 08, 2017 at 05:07:27PM -0500, Abylay Ospan wrote:
> Hi Bjorn,
> 
> I have checked first listed driver
> (drivers/pci/host/pcie-designware.c). Seems like into
> 'devm_request_pci_bus_resources' we supply same stack allocated 'res'
> (actual insert of this pointer to 'iomem_resource' was done inside
> '__request_resource'). This 'res' is not changed inside
> 'of_pci_get_host_bridge_resources'.
> I don't have this platforms on hand and cannot test it on real
> hadrware (to 100% verify). But investigating this code I see that the
> problem exist.
> 
> Here is a summary of flow for 'res' to show the problem:
> 
> pcie-designware.c:
>   LIST_HEAD(res);
>   ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res,
> &pp->io_base); <--- 'res' not changing here
>   ret = devm_request_pci_bus_resources(&pdev->dev, &res);
> 
>   drivers/pci/bus.c:
>     err = devm_request_resource(dev, parent, res);
> 
>     kernel/resource.c:
>       conflict = request_resource_conflict(root, new);
>         conflict = __request_resource(root, new);
>           *p = new;  <--- here we introduce stack allocated res into
> global 'iomem_resource'
> 
> 
> Please check and correct me if i'm wrong ?

The "res" in dw_pcie_host_init() is a list_head (not a struct
resource) and is on the stack.

When we call of_pci_get_host_bridge_resources(), we pass a pointer
("&res") to the empty list.  It kzallocs a struct resource for the bus
range and more for any bridge windows, and adds them to the list.

When we call devm_request_pci_bus_resources(), we pass a pointer
("&res") to the list, which is no longer empty.  It iterates through
the list and calls devm_request_resource() for each resource.  Inside
devm_request_pci_bus_resources(), "res" is the pointer to the resource
(not the list_head), and this resource is the one we kzalloc'd above.

When devm_request_resource() calls request_resource_conflict(), it
passes that pointer to the kzalloc'd resource (the pointer is called
"new" in devm_request_resource()).)

So when __request_resource() assigns "*p = new", it is copying a
pointer to a kzalloc'd struct resource.

This is certainly a twisty maze of similar names for different things,
but I think it is OK if the list_head is on the stack as long as the
struct resources are kzalloc'd.

> >   dw_pcie_host_init
> >     LIST_HEAD(res)                            # on stack
> >     of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base)
> >       res = kzalloc()                         # different "res" from above!
> >       pci_add_resource_offset(resources, res, ...)
> >     devm_request_pci_bus_resources(&pdev->dev, &res)
> >     pci_scan_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops, pp, &res)
> >     error:
> >       pci_free_resource_list(&res)
> 
> > This looks good to me, but I don't think it's necessary to keep the
> > list_head in the struct iproc_pcie.  It should be safe to use
> > "LIST_HEAD(res)" on the stack like the other drivers do.  Can you
> > verify that and get an ack from Ray, Scott, or Jon?
> 
> if my investigation above is true then we need to keep 'res' all the
> time we working with the driver (or find another way to fix this
> issue).
> 
> -- 
> Abylay Ospan,
> NetUP Inc.
> http://www.netup.tv

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
