Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <555BFA73.5060902@linux.intel.com>
Date: Wed, 20 May 2015 11:07:31 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [RFC 2/4] PCI, MSI: Optionally free legacy PCI IRQ when enabling
 MSI/MSI-X
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com> <1430968374-29286-3-git-send-email-jiang.liu@linux.intel.com> <20150519150838.GQ31666@google.com> <20150519171518-mutt-send-email-mst@redhat.com> <20150519172534-mutt-send-email-mst@redhat.com>
In-Reply-To: <20150519172534-mutt-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/19 23:26, Michael S. Tsirkin wrote:
> On Tue, May 19, 2015 at 05:16:54PM +0200, Michael S. Tsirkin wrote:
>> On Tue, May 19, 2015 at 10:08:38AM -0500, Bjorn Helgaas wrote:
>>> [+cc Michael]
>>>
>>> On Thu, May 07, 2015 at 11:12:52AM +0800, Jiang Liu wrote:
>>>> Once PCI MSI/MSI-X is enabled by the device driver, PCI device won't
>>>> make use of legacy PCI IRQ until PCI MSI/MSI-X is disabled again.
>>>> So optionally free legacy PCI IRQ when enabling MSI/MSI-X and reallocate
>>>> when disabling MSI/MSI-X.
>>>>
>>>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>>>> ---
>>>>  drivers/pci/msi.c |    6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>>>> index c3e7dfcf9ff5..47cf72c669f0 100644
>>>> --- a/drivers/pci/msi.c
>>>> +++ b/drivers/pci/msi.c
>>>> @@ -686,6 +686,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
>>>>  	msi_set_enable(dev, 1);
>>>>  	dev->msi_enabled = 1;
>>>>  
>>>> +	pcibios_free_irq(dev);
>>>
>>> >From the recent discussion about disabling MSI at shutdown, I seem to
>>> recall that turning off bus mastering also effectively disables MSI and
>>> causes at least some devices to revert to using INTx.
> 
> So to stress this point, turning off bus mastering also effectively
> disables MSI without making devices revert to using INTx.
> This is why clearing bus master is the right thing to do
> if you don't want any interrupts at all.

Thanks for explanation, Michael:)
