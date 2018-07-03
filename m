Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 03 Jul 2018 18:41:33 +0530
From: poza@codeaurora.org
To: okaya@codeaurora.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
Message-ID: <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Keith Busch <keith.busch@intel.com>, Lukas Wunner <lukas@wunner.de>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-03 17:00, okaya@codeaurora.org wrote:
> On 2018-07-03 04:34, Lukas Wunner wrote:
>> On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
>>> If a bridge supports hotplug and observes a PCIe fatal error, the 
>>> following
>>> events happen:
>>> 
>>> 1. AER driver removes the devices from PCI tree on fatal error
>>> 2. AER driver brings down the link by issuing a secondary bus reset 
>>> waits
>>> for the link to come up.
>>> 3. Hotplug driver observes a link down interrupt
>>> 4. Hotplug driver tries to remove the devices waiting for the rescan 
>>> lock
>>> but devices are already removed by the AER driver and AER driver is 
>>> waiting
>>> for the link to come back up.
>>> 5. AER driver tries to re-enumerate devices after polling for the 
>>> link
>>> state to go up.
>>> 6. Hotplug driver obtains the lock and tries to remove the devices 
>>> again.
>>> 
>>> If a bridge is a hotplug capable bridge, mask hotplug interrupts 
>>> before the
>>> reset and unmask afterwards.
>> 
>> Would it work for you if you just amended the AER driver to skip
>> removal and re-enumeration of devices if the port is a hotplug bridge?
>> Just check for is_hotplug_bridge in struct pci_dev.
> 
> The reason why we want to remove devices before secondary bus reset is
> to quiesce pcie bus traffic before issuing a reset.
> 
> Skipping this step might cause transactions to be lost in the middle
> of the reset as there will be active traffic flowing and drivers will
> suddenly start reading ffs.
> 
> I don't think we can skip this step.
> 

what if we only have conditional enumeration ?  (leaving removing 
devices followed by SBR as is) ?

following code is doing little more extra work than our normal ERR_FATAL 
path.

pciehp_unconfigure_device doing little more than enumeration to 
quiescence the bus.

/*
		 * Ensure that no new Requests will be generated from
		 * the device.
		 */
		if (presence) {
			pci_read_config_word(dev, PCI_COMMAND, &command);
			command &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
			command |= PCI_COMMAND_INTX_DISABLE;
			pci_write_config_word(dev, PCI_COMMAND, command);
		}



> 
>> 
>> That would seem like a much simpler solution, given that it is known
>> that the link will flap on reset, causing the hotplug driver to remove
>> and re-enumerate devices.  That would also cover cases where hotplug 
>> is
>> handled by a different driver than pciehp, or by the platform 
>> firmware.
>> 
>> Thanks,
>> 
>> Lukas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
