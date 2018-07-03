Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 03 Jul 2018 08:04:20 -0400
From: okaya@codeaurora.org
To: poza@codeaurora.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <324f8cf2fe6f7bdc43ca8a646eea908d@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <324f8cf2fe6f7bdc43ca8a646eea908d@codeaurora.org>
Message-ID: <c129b813df87a2a471e8b9101447f535@codeaurora.org>
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
 linux-pci-owner@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-03 06:52, poza@codeaurora.org wrote:
> On 2018-07-03 14:04, Lukas Wunner wrote:
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
>> 
> 
> I tend to agree with you Lukas.
> 
> on this line I already have follow up patches
> although I am waiting for Bjorn to review some patch-series before 
> that.
> [PATCH v2 0/6] Fix issues and cleanup for ERR_FATAL and ERR_NONFATAL
> 
> It doesn't look to me a an entirely a race condition since its guarded
> by pci_lock_rescan_remove())
> I observed that both hotplug and aer/dpc comes out of it in a quiet 
> sane state.
> 

To add more detail on when this issue happens.

This problem is more visible on root ports with MSI-x capability or with 
multiple MSI interrupt numbers.

AFAIK, QDT root ports are single shared MSI interrupt only. Therefore, 
you won't see this issue.

As you can see in the code, rescan lock is held for the entire fatal 
error handling path.

> My thinking is: Disabling hotplug interrupts during ERR_FATAL,
> is something little away from natural course of link_down event
> handling, which is handled by pciehp more maturely.
> so it would be just easy not to take any action e.g. removal and
> re-enumeration of devices from ERR_FATAL handling point of view.
> 

I think it is more unnatural to fragment code flow and allow two drivers 
to do the same thing in parallel or create inter-driver dependency.

I got the idea from pci_reset_slot() function which is already masking 
hotplug interrupts when called by external entries during secondary bus 
reset. We just didn't handle the same for fatal error cases.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
