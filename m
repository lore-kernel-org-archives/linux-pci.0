Return-Path: <SRS0=jmEW=7E=gmail.com=zuban32s@kernel.org>
Return-Path: <SRS0=jmEW=7E=gmail.com=zuban32s@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170802223547.GP20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1500387145-4216-1-git-send-email-zuban32s@gmail.com> <20170802223547.GP20308@bhelgaas-glaptop.roam.corp.google.com>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Thu, 3 Aug 2017 01:48:51 +0300
Message-ID: <CAKSfGUA_1ccDBaChXaWwOKthq-okkAmYADpWxQXQ67DG6SjgYA@mail.gmail.com>
Subject: Re: [PATCH] pci: shpchp: set the bridge busmaster if MSI are enabled
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Marcel Apfelbaum <marcel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

2017-08-03 1:35 GMT+03:00 Bjorn Helgaas <helgaas@kernel.org>:
> On Tue, Jul 18, 2017 at 05:12:25PM +0300, Aleksandr Bezzubikov wrote:
>> An MSI-based SHPC built in PCI bridges can configure hotplugged devices
>> only if they notify the bridge with MSI.
>
> I think you're referring to the events listed in SHPC r1.0, sec 4.7.3,
> table 4-24, right?  Attention Button Press, Isolated Power Fault, Card
> Presence Change, MRS Sensor Change, etc?
>
> So IIUC, this is really about the bridge itself generating MSIs about
> slot-related events, not the hot-added devices generating MSIs.
>

You're right, it's definitely about the bridge's built-in SHPC
that generates MSIs.

> I agree this patch makes sense, I'm just trying to clarify the
> changelog.
>
>> But they can't trigger interrupt without the bridge being busmaster,
>> that's why it should be enabled.
>>
>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>> ---
>>  drivers/pci/hotplug/shpchp_hpc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
>> index de0ea47..e5824c7 100644
>> --- a/drivers/pci/hotplug/shpchp_hpc.c
>> +++ b/drivers/pci/hotplug/shpchp_hpc.c
>> @@ -1062,6 +1062,8 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
>>               if (rc) {
>>                       ctrl_info(ctrl, "Can't get msi for the hotplug controller\n");
>>                       ctrl_info(ctrl, "Use INTx for the hotplug controller\n");
>> +             } else {
>> +                     pci_set_master(pdev);
>>               }
>>
>>               rc = request_irq(ctrl->pci_dev->irq, shpc_isr, IRQF_SHARED,
>> --
>> 2.7.4
>>



-- 
Aleksandr Bezzubikov
