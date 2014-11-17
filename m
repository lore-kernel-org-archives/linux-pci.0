Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:53682 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbaKQKJI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Nov 2014 05:09:08 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Liviu Dudau <liviu@dudau.co.uk>,
	Tony Luck <tony.luck@intel.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yijing Wang <wangyijing0307@gmail.com>,
	Suravee.Suthikulpanit@amd.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-ia64@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 01/16] PCI: Enhance pci_scan_root_bus() to support default IO/MEM resources
Date: Mon, 17 Nov 2014 11:08:34 +0100
Message-ID: <2732970.7HG94QvVBv@wuerfel>
In-Reply-To: <1416219710-26088-2-git-send-email-wangyijing@huawei.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com> <1416219710-26088-2-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 17 November 2014 18:21:35 Yijing Wang wrote:
> -       list_for_each_entry(window, resources, list)
> -               if (window->res->flags & IORESOURCE_BUS) {
> -                       found = true;
> -                       break;
> -               }
> +       if (!resources) {
> +               pci_add_resource(&default_res, &ioport_resource);
> +               pci_add_resource(&default_res, &iomem_resource);
> +               pci_add_resource(&default_res, &busn_resource);
> +       } else {
> 

Isn't it almost always wrong to do this? You are adding all of the
I/O ports and memory to the host bridge, which will prevent you from
adding another host bridge, and the iomem_resource normally
includes a lot of addresses that are not accessible by the PCI host.

	Arnd
