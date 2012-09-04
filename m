Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:48272 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab2IDH6k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Sep 2012 03:58:40 -0400
From: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
To: "Izumi, Taku" <izumi.taku@jp.fujitsu.com>,
	"Izumi, Taku" <izumi.taku@jp.fujitsu.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>
Subject: RE: [PATCH v2 2/6] ACPI, PCI: Notify acpi_pci_drivers when
 hot-plugging PCI root bridges
Date: Tue, 4 Sep 2012 07:58:36 +0000
Message-ID: <4A338DB2991D2A44B9A44B8718AECF650A4A2DCD@G01JPEXMBYT03>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
 <20120903170442.c406455c.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120903170442.c406455c.izumi.taku@jp.fujitsu.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Taku Izumi [mailto:izumi.taku@jp.fujitsu.com]
> Sent: Monday, September 03, 2012 5:05 PM
> To: Izumi, Taku/泉 拓
> Cc: linux-pci@vger.kernel.org; bhelgaas@google.com;
> linux-acpi@vger.kernel.org; Kaneshige, Kenji/金重 憲治;
> yinghai@kernel.org; jiang.liu@huawei.com
> Subject: [PATCH v2 2/6] ACPI, PCI: Notify acpi_pci_drivers when
> hot-plugging PCI root bridges
> 
> From: Jiang Liu <jiang.liu@huawei.com>
> 
>   ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
> 
>   When hot-plugging PCI root bridge, acpi_pci_drivers' add()/remove()
>   methods should be invoked to notify registered drivers.
> 
>   -v2: Move add calling to acpi_pci_root_start by Yinghai
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  drivers/acpi/pci_root.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> Index: Bjorn-next-0808/drivers/acpi/pci_root.c
> ===================================================================
> --- Bjorn-next-0808.orig/drivers/acpi/pci_root.c
> +++ Bjorn-next-0808/drivers/acpi/pci_root.c
> @@ -626,14 +626,25 @@ end:
>  static int acpi_pci_root_start(struct acpi_device *device)
>  {
>  	struct acpi_pci_root *root = acpi_driver_data(device);
> +	struct acpi_pci_driver *driver;
> +
> +	list_for_each_entry(driver, &acpi_pci_drivers, node)
> +		if (driver->add)
> +			driver->add(device->handle);
> 

I think this (invoke .add callback for each acpi pci driver) should be done
after pci_bus_add_devices().

It seems ACPI pci drivers run *after* pci_bus_add_devices() at the boot time
(because no acpi pci drivers is loaded at that time). On the other hand, it
seems that ACPI pci drivers run *before* pci_bus_add_devices() at the hotadd
time. Those should be the same.

Regards,
Kenji Kaneshige

>  	pci_bus_add_devices(root->bus);
> +

