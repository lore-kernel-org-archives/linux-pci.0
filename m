Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 15 Aug 2017 11:51:53 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Khuong Dinh <kdinh@apm.com>
Subject: Re: [PATCH v3 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in
 ACPI boot for X-Gene v1
Message-ID: <20170815105153.GA27248@red-moon>
References: <1502496173-6017-1-git-send-email-kdinh@apm.com>
 <20170814181503.GA3093@red-moon>
 <CAAsHzqu6Mu99iDcJwFtK-h0kqgxw4cCk8xCEZX8BP+GEmCJR=A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAsHzqu6Mu99iDcJwFtK-h0kqgxw4cCk8xCEZX8BP+GEmCJR=A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 msalter@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 patches <patches@apm.com>, jcm@redhat.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 14, 2017 at 04:17:35PM -0700, Khuong Dinh wrote:

[...]

> >> +static acpi_status acpi_create_msi_device(acpi_handle handle, u32 Level,
> >> +                                     void *context, void **retval)
> >> +{
> >> +     struct acpi_device *device = NULL;
> >> +     int type = ACPI_BUS_TYPE_DEVICE;
> >> +     unsigned long long sta;
> >> +     acpi_status status;
> >> +     int ret = 0;
> >> +
> >> +     acpi_bus_get_device(handle, &device);
> >> +     status = acpi_bus_get_status_handle(handle, &sta);
> >> +     if (ACPI_FAILURE(status))
> >> +             sta = 0;
> >> +
> >> +     device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
> >> +     if (!device)
> >> +             return -ENOMEM;
> >> +
> >> +     acpi_init_device_object(device, handle, type, sta);
> >> +     ret = acpi_device_add(device, NULL);
> >> +     if (ret)
> >> +             return ret;
> >> +     device->parent = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
> >> +     INIT_LIST_HEAD(&device->parent->physical_node_list);
> >> +
> >> +     acpi_device_add_finalize(device);
> >> +
> >> +     ret = device_attach(&device->dev);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     acpi_create_platform_device(device, NULL);
> >> +     acpi_device_set_enumerated(device);
> >> +
> >> +     return ret;
> >> +}
> >
> > Can't this be implemented through acpi_bus_scan(handle) ?
> >
> > (where handle is your MSI controller acpi_handle ?)
> 
> I had an experiment to use acpi_bus_scan(handle) to register MSI
> driver, but it's not success as @handle for acpi_bus_scan is the root
> of the namespace scope to scan.
> The driver registration to ACPI platform happens with the following code path:
> acpi_bus_scan
>    acpi_bus_check_add
>    acpi_bus_attach
>       device_attach
>       acpi_default_enumeration
>          acpi_create_platform_device
>          acpi_device_set_enumerated
> 
> acpi_bus_attach is recursively happened through ACPI nodes in order.

What I was saying is to call acpi_bus_scan() on the MSI controller
handle (as start_object - see acpi_walk_namespace()).

> > [...]
> >
> >>  static int xgene_msi_probe(struct platform_device *pdev)
> >>  {
> >>       struct resource *res;
> >> @@ -469,7 +487,18 @@ static int xgene_msi_probe(struct platform_device *pdev)
> >>               goto error;
> >>       }
> >>       xgene_msi->msi_addr = res->start;
> >> -     xgene_msi->node = pdev->dev.of_node;
> >> +
> >> +     xgene_msi->fwnode = of_node_to_fwnode(pdev->dev.of_node);
> >> +     if (!xgene_msi->fwnode) {
> >> +             xgene_msi->fwnode =
> >> +                     irq_domain_alloc_fwnode((void *)xgene_msi->msi_addr);
> >> +             if (!xgene_msi->fwnode) {
> >> +                     dev_err(&pdev->dev, "Failed to create fwnode\n");
> >> +                     rc = ENOMEM;
> >> +                     goto error;
> >> +             }
> >> +     }
> >> +
> >>       xgene_msi->num_cpus = num_possible_cpus();
> >>
> >>       rc = xgene_msi_init_allocator(xgene_msi);
> >> @@ -540,6 +569,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
> >>       .driver = {
> >>               .name = "xgene-msi",
> >>               .of_match_table = xgene_msi_match_table,
> >> +             .acpi_match_table = ACPI_PTR(xgene_msi_acpi_ids),
> >>       },
> >>       .probe = xgene_msi_probe,
> >>       .remove = xgene_msi_remove,
> >
> > AFAIK you still have not solved the link ordering problem, creating
> > the platform device before scanning the PCI root bridge is not enough,
> > because you are not guaranteed to probe the MSI driver first, there
> > has to be way for registering your driver from the ACPI scan hook.
> 
> With this implementation, I added a hook to enforce the MSI driver
> initialization and registration before acpi_bus_scan happens.

I do not know if I am mistaken but all I see is still:

subsys_initcall(xgene_pcie_msi_init);

which is not guaranteed to be called before the PCI host bridge
is scanned. You have to have a way to _probe_ the MSI driver before
the PCI host bridge is scanned, which is different.

> It will walk through the HID to get the MSI device (e.g:
> acpi_get_devices). When the device is found, the callback will be
> called and we will initialize MSI device by its handle, start to
> attach MSI device to a driver, create ACPI platform device for MSI
> APCI device node and marked it as visited.

But if the MSI driver is still not registered the whole concept still
does not work. You are not guaranteed ordering between initcalls at
the same level.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
