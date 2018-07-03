Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 03 Jul 2018 20:42:12 +0530
From: poza@codeaurora.org
To: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <20180703143434.GA4086@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703143434.GA4086@wunner.de>
Message-ID: <fda77cee8e379f2e9b7ab55fefe17cad@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-03 20:04, Lukas Wunner wrote:
> On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
>> @@ -308,8 +310,17 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, 
>> u32 service)
>>  		pci_dev_put(pdev);
>>  	}
>> 
>> +	hpsvc = pcie_port_find_service(udev, PCIE_PORT_SERVICE_HP);
>> +	hpdev = pcie_port_find_device(udev, PCIE_PORT_SERVICE_HP);
>> +
>> +	if (hpdev && hpsvc)
>> +		hpsvc->mask_irq(to_pcie_device(hpdev));
>> +
>>  	result = reset_link(udev, service);
>> 
>> +	if (hpdev && hpsvc)
>> +		hpsvc->unmask_irq(to_pcie_device(hpdev));
>> +
> 
> We've already got the ->reset_slot callback in struct hotplug_slot_ops,
> I'm wondering if we really need additional ones for this use case.
> 
> If you just do...
> 
> 	if (!pci_probe_reset_slot(dev->slot))
> 		pci_reset_slot(dev->slot)
> 	else {
> 		/* regular code path */
> 	}
> 
> would that not be equivalent?
> 

pcie_do_fatal_recovery() calls
           reset_link()
              which calls dpc_reset_link() or aer_root_reset() depending 
on the event.

and dpc_reset_link() and aer_root_reset() do their own cleanup stuffs.
infact, aer_root_reset() is the only function which actually triggers 
pci_reset_bridge_secondary_bus().

So if we try to fit in your suggestion:

if (!pci_probe_reset_slot(dev->slot))
{
     pci_reset_slot(dev->slot)
     result = reset_link(udev, service); >> in this case aer_root_reset 
must not call pci_reset_bridge_secondary_bus()
} else
     result = reset_link(udev, service); >> in this case aer_root_reset 
must call pci_reset_bridge_secondary_bus() [since bridge is not hotplug 
capable)

Did I get your suggestion right ?

Regards,
Oza.

> (It's worth noting though that pciehp is the only hotplug driver
> implementing the ->reset_slot callback.  If hotplug is handled by
> a different driver or by the platform firmware, devices may still
> be removed and re-enumerated twice.)
> 

> Thanks,
> 
> Lukas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
