Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 03 Jul 2018 19:59:21 +0530
From: poza@codeaurora.org
To: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <20180703141255.GB18639@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <20180703141255.GB18639@wunner.de>
Message-ID: <237b7dd4036d8a6156b9e1cb605c84c9@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, okaya@codeaurora.org,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-03 19:42, Lukas Wunner wrote:
> On Tue, Jul 03, 2018 at 07:30:28AM -0400, okaya@codeaurora.org wrote:
>> On 2018-07-03 04:34, Lukas Wunner wrote:
>> >On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
>> >>If a bridge supports hotplug and observes a PCIe fatal error, the
>> >>following
>> >>events happen:
>> >>
>> >>1. AER driver removes the devices from PCI tree on fatal error
>> >>2. AER driver brings down the link by issuing a secondary bus reset
>> >>waits
>> >>for the link to come up.
>> >>3. Hotplug driver observes a link down interrupt
>> >>4. Hotplug driver tries to remove the devices waiting for the rescan
>> >>lock
>> >>but devices are already removed by the AER driver and AER driver is
>> >>waiting
>> >>for the link to come back up.
>> >>5. AER driver tries to re-enumerate devices after polling for the link
>> >>state to go up.
>> >>6. Hotplug driver obtains the lock and tries to remove the devices
>> >>again.
>> >>
>> >>If a bridge is a hotplug capable bridge, mask hotplug interrupts before
>> >>the
>> >>reset and unmask afterwards.
>> >
>> >Would it work for you if you just amended the AER driver to skip
>> >removal and re-enumeration of devices if the port is a hotplug bridge?
>> >Just check for is_hotplug_bridge in struct pci_dev.
>> 
>> The reason why we want to remove devices before secondary bus reset is 
>> to
>> quiesce pcie bus traffic before issuing a reset.
>> 
>> Skipping this step might cause transactions to be lost in the middle 
>> of the
>> reset as there will be active traffic flowing and drivers will 
>> suddenly
>> start reading ffs.
> 
> Interesting, I think that merits a code comment.
> 
> FWIW, macOS has a "PCI pause" callback to quiesce a device:
> https://opensource.apple.com/source/IOPCIFamily/IOPCIFamily-239.1.2/pause.rtf
> 
> They're using it to reconfigure a device's BAR and bus number
> at runtime (sic!), e.g. if mmio windows need to be moved around
> on Thunderbolt hotplug if there's insufficient space:
> 
> 	"During pause reconfiguration, the following may be changed:
> 	 - device BAR registers
> 	 - the devices bus number
> 	 - registry properties reflecting these values ("ranges",
> 	   "assigned-addresses", "reg")
> 	 - device MSI block values for address and value, but not the
> 	   number of MSIs allocated"
> 
> Conceptually, "PCI pause" is similar to putting the device in a suspend
> state.  I'm wondering if suspending the devices below the bridge would
> make more sense than removing them in the AER driver.
> 

the code is shared by not only AER but also DPC, where if DPC event 
happens the devices are removed.
also if the bridge is hotplug capable, then the devices beneath might 
have changed and resume might break.

> Lukas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
