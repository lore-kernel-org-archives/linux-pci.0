Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI/portdrv: do not disable device on remove()
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org
References: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
From: Ryan Finnie <ryan@finnie.org>
Message-ID: <28781ad3-2105-8127-e385-6d42e3e75ae3@finnie.org>
Date: Tue, 22 May 2018 12:55:53 -0700
MIME-Version: 1.0
In-Reply-To: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Frederick Lawler <fred@fredlawl.com>, linux-arm-msm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Keith Busch <keith.busch@intel.com>, Dongdong Liu <liudongdong3@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 05/22/2018 10:58 AM, Sinan Kaya wrote:
> 'Commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
> shutdown")' has been added to kernel to shutdown pending PCIe port
> service interrupts during reboot so that a newly started kexec kernel
> wouldn't observe pending interrupts.
> 
> pcie_port_device_remove() is disabling the root port and switches by
> calling pci_disable_device() after all PCIe service drivers are shutdown.
> 
> pci_disable_device() has a much wider impact then port service itself and
> it prevents all inbound transactions to reach to the system and impacts
> the entire PCI traffic behind the bridge.
> 
> Issue is that pcie_port_device_remove() doesn't maintain any coordination
> with the rest of the PCI device drivers in the system before clearing the
> bus master bit.
> 
> This has been found to cause crashes on HP DL360 Gen9 machines during
> reboot. Besides, kexec is already clearing the bus master bit in
> pci_device_shutdown() after all PCI drivers are removed.

FAOD, this problem has been observed on both DL360 Gen9 and DL380 Gen9,
in both EFI and legacy modes.  I suspect all Gen9 models with the P89
firmware base.

> Just remove the extra clear here.

Thank you!  Fix tested on:

- DL360 Gen9
- DL380 Gen9
- DL380 Gen10 (confirmed no regression)
- DL380 G7 (confirmed no regression)

> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
> Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
> Cc: stable@vger.kernel.org
> Reported-by: Ryan Finnie <ryan@finnie.org>

Tested-by: Ryan Finnie <ryan@finnie.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
