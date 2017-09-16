Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:59218 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750909AbdIPHSj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Sep 2017 03:18:39 -0400
Subject: Re: [PATCH bisected regression in 4.14] PCI: fix race while enabling
 upstream bridges concurrently
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <150547971091.977464.16294045866179907260.stgit@buzz>
 <CABe79T48Q3E6DA=19JC0s1SVyw8oi4iBWCaFfQdwNEjSoLbDqA@mail.gmail.com>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <036a1ee1-c857-1dff-cd15-5d1b684e20a7@yandex-team.ru>
Date: Sat, 16 Sep 2017 10:18:36 +0300
MIME-Version: 1.0
In-Reply-To: <CABe79T48Q3E6DA=19JC0s1SVyw8oi4iBWCaFfQdwNEjSoLbDqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 15.09.2017 16:43, Srinath Mannam wrote:
> Hi Konstantin,
> 
> On Fri, Sep 15, 2017 at 6:18 PM, Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>> In pci_enable_bridge() pci_enable_device() is called before calling
>> pci_set_master(), thus check pci_is_enabled() becomes true in the
>> middle of this sequence. As a result in pci_enable_device_flags()
>> concurrent enable of device on same bridge could think that this
>> bridge is completely enabled, but actually it's not yet.
>>
>> For me this race broke ethernet devices after booting kernel via
>> kexec, normal reboot was fine.
>>
>> This patch removes racy fast-path: pci_enable_bridge() will take
>> pci_bridge_mutex and do nothing if bridge is already enabled.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Fixes: 40f11adc7cd9 ("PCI: Avoid race while enabling upstream bridges")
>> ---
>>   drivers/pci/pci.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b0002daa50f3..ffbe11dbdd61 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1394,7 +1394,7 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>>                  return 0;               /* already enabled */
>>
>>          bridge = pci_upstream_bridge(dev);
>> -       if (bridge && !pci_is_enabled(bridge))
>> +       if (bridge)

> This patch causes deadlock because of nexted mutex lock.

Oh, yes.

I suppose not ascending to upstream bridge for bridges from pci_enable_device_flags should fix this.

Something like this:


--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1393,9 +1393,11 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
         if (atomic_inc_return(&dev->enable_cnt) > 1)
                 return 0;               /* already enabled */

-       bridge = pci_upstream_bridge(dev);
-       if (bridge)
-               pci_enable_bridge(bridge);
+       if (!pci_is_bridge(dev)) {
+               bridge = pci_upstream_bridge(dev);
+               if (bridge)
+                       pci_enable_bridge(bridge);
+       }

         /* only skip sriov related */
         for (i = 0; i <= PCI_ROM_RESOURCE; i++)

> As per original code, Bridge enable function is called equal to number
> of child bridges it has.
> In the case endpoint is connected to RC through two bridges.
> bridge 2 is enabled(both device and bus master) first.
> While bridge1 enable, it calls device enable which calls device_enable_flags.
> set device enable flag
> check it has bridge (here yes because it has bridge2)
> calls bridge enable for bridge2. which is already enabled.
> 
> So in my patch we introduced mutex to stop the race condition.
> By taking this mutex, we see dead lock in the second call for bridge
> enable (ex: bridge2)
> Here we stopped second time calling of bridge enable using "if (bridge
> && !pci_is_enabled(bridge))"
> In this case, there will not be such scenario where device enable and
> bus master is missed in bridge enable function.
> Because pci_is_enabled check in "if (bridge &&
> !pci_is_enabled(bridge))" will check for its bridge not itself.
> Stopping its bridge is not a problem because it is already enabled, as
> I explained above.
> 
> Please explain your case where bus master could missed for bridge. It
> helps me to understand more about how various bridges enabled.

Pure race: seocnd deivice could call do_pci_enable_device() while
first still enabling bridge and haven't set bus master for it:


CPU1                                          CPU2

pci_enable_device_flags(dev1)                 pci_enable_device_flags(dev2)

pci_is_enabled(bridge)

atomic_read(&bridge->enable_cnt) -> 0

pci_upstream_bridge(bridge)

mutex_lock(&pci_bridge_mutex);

pci_enable_device(bridge)

atomic_inc_return(&bridge->enable_cnt) 0 -> 1

                                               pci_is_enabled(bridge)

                                               atomic_read(&bridge->enable_cnt) -> 1

                                               do_pci_enable_device(dev2) -> fail,

pci_set_master(bridge);

mutex_unlock(&pci_bridge_mutex);

do_pci_enable_device(dev1)


> 
>>                  pci_enable_bridge(bridge);
>>
>>          /* only skip sriov related */
>>
> Regards,
> Srinath.
> 
