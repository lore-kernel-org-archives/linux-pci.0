Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33375 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbdHAP4d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2017 11:56:33 -0400
Subject: Re: [PATCH] pci: shpchp: set the bridge busmaster if MSI are enabled
To: Marcel Apfelbaum <marcel@redhat.com>,
        Aleksandr Bezzubikov <zuban32s@gmail.com>,
        linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Michael Tsirkin <mst@redhat.com>,
        stable@vger.kernel.org
References: <1500387145-4216-1-git-send-email-zuban32s@gmail.com>
 <b0c85887-38f1-337e-4cc4-d671a200ff7d@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <eb72f87e-3df3-cd30-b08a-72403587eaa7@gmail.com>
Date: Tue, 1 Aug 2017 18:56:29 +0300
MIME-Version: 1.0
In-Reply-To: <b0c85887-38f1-337e-4cc4-d671a200ff7d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 19/07/2017 16:36, Marcel Apfelbaum wrote:
> On 18/07/2017 17:12, Aleksandr Bezzubikov wrote:
>> An MSI-based SHPC built in PCI bridges can configure hotplugged devices
>> only if they notify the bridge with MSI.
>> But they can't trigger interrupt without the bridge being busmaster,
>> that's why it should be enabled.
> 
> Hi Aleksandr,
> 
> Hot-plugging an empty bridge does require making it bus-master,
> otherwise we end up with an unusable pci brigde.
> 
>>
>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>> ---
>>   drivers/pci/hotplug/shpchp_hpc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/shpchp_hpc.c 
>> b/drivers/pci/hotplug/shpchp_hpc.c
>> index de0ea47..e5824c7 100644
>> --- a/drivers/pci/hotplug/shpchp_hpc.c
>> +++ b/drivers/pci/hotplug/shpchp_hpc.c
>> @@ -1062,6 +1062,8 @@ int shpc_init(struct controller *ctrl, struct 
>> pci_dev *pdev)
>>           if (rc) {
>>               ctrl_info(ctrl, "Can't get msi for the hotplug 
>> controller\n");
>>               ctrl_info(ctrl, "Use INTx for the hotplug controller\n");
>> +        } else {
>> +            pci_set_master(pdev);
>>           }
>>           rc = request_irq(ctrl->pci_dev->irq, shpc_isr, IRQF_SHARED,
>>
> 
> 
> I am not really familiar with the shpc code,
> but the change looks OK to me.
> 
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> 

Hi,

Since is a fix:
Cc: stable@vger.kernel.org

Thanks,
Marcel

> Thanks,
> Marcel
