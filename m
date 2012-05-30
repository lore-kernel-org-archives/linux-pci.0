Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm35-vm8.bullet.mail.sg3.yahoo.com ([106.10.151.63]:44863 "HELO
	nm35-vm8.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753571Ab2E3Mr7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 May 2012 08:47:59 -0400
Message-ID: <1338381700.64703.YahooMailClassic@web15305.mail.cnb.yahoo.com>
Date: Wed, 30 May 2012 20:41:40 +0800 (CST)
From: =?utf-8?B?5LiA6Z2ZIOeOiw==?= <wangyijing0307@yahoo.com.cn>
Subject: acpiphp_sanitize_bus() in acpiphp module is safe and necessary ?
To: rajesh.shah@intel.com
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	wangyijing@huawei.com, wangyijing0307@yahoo.com.cn
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

hi ,
    I was confused with acpiphp_sanitize_bus() function in acpiphp module, first i think list_for_each_entry operation is not safe because pci_remove_bus_device(dev) delete device out of the device list;second,when i hot-add PLX8696(have one upstream port and several downstream ports, and the downstream ports support hotplug pcie devices), acpiphp_sanitize_bus can only check the pci devices under the first bus(the bus between hp-port in system and upstream-port), because the function is not recursive.Can anyone help me? thank you very much!  

static void acpiphp_sanitize_bus(struct pci_bus *bus)
{
    struct pci_dev *dev;
    int i;
    unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;

    list_for_each_entry(dev, &bus->devices, bus_list) {
        for (i=0; i<PCI_BRIDGE_RESOURCES; i++) {
            struct resource *res = &dev->resource[i];
            if ((res->flags & type_mask) && !res->start &&
                    res->end) {
                /* Could not assign a required resources
                 * for this device, remove it */
                pci_remove_bus_device(dev);
                break;
            }
        }
    }
}

