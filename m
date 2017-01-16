Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: iproc: fix kernel crash if dev->of_node not defined
To: Abylay Ospan <aospan@netup.ru>
References: <1484266817-6725-1-git-send-email-aospan@netup.ru>
 <6891f43f-25e7-1411-800e-97e6788f2f27@gmail.com>
 <e5301de6-9a6c-7deb-4ff7-ccd462c4381e@broadcom.com>
 <6cfba8af-1e9b-cb43-4898-61d6fb8f12ca@broadcom.com>
 <CAK3bHNVQ9Rbuwf1i54h7uLLdkUvyGibmfJpD6zRjt1gYiQD7Hw@mail.gmail.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <c5080024-d58c-7b7d-1602-36b2d4511bef@broadcom.com>
Date: Mon, 16 Jan 2017 14:47:18 -0800
MIME-Version: 1.0
In-Reply-To: <CAK3bHNVQ9Rbuwf1i54h7uLLdkUvyGibmfJpD6zRjt1gYiQD7Hw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, zajec5@gmail.com, linux-kernel@vger.kernel.org,
 Ray Jui <ray.jui@broadcom.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

+Rafal,

On 01/12/2017 08:55 PM, Abylay Ospan wrote:
> Hi Florian,
> 
>> Still, upstream Linux support for Northstar is Device Tree, and BCMA bus
>> should fill in of_nodes accordingly, if not, that's a bug that must be
>> fixed at the BCMA layer.
> 
> yes, this is a source of the problem. Devices allocated in
> 'bcma_bus_scan' but of_node doesn't assigned.
> Is some code missing in drivers/bcma/ which should assign of_node ?

bcma_of_fill_device() is responsible for assigning the core of_node
pointer based on the core discovered. It sounds like we may have to add
an entry under the "axi" bus node for the PCIe RC, very much like these
ones already exist:

              gmac0: ethernet@24000 {
                        reg = <0x24000 0x800>;
                };

                gmac1: ethernet@25000 {
                        reg = <0x25000 0x800>;
                };

                gmac2: ethernet@26000 {
                        reg = <0x26000 0x800>;
                };

                gmac3: ethernet@27000 {
                        reg = <0x27000 0x800>;
                };

Without that, you indeed do not have a proper linkage between the BCMA
discovered device and its of_node pointer.

Can you give it a spin?

> 
> I can suggest following "hacky" patch for this (works for me):
> 
> Author: Abylay Ospan <aospan@netup.ru>
> Date:   Fri Jan 13 07:24:13 2017 +0300
> 
>     bcma: force assign 'of_node' for devices on the bus
> 
>     prevent other code to fail if no 'of_node' defined
> 
>     Signed-off-by: Abylay Ospan <aospan@netup.ru>
> 
> diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
> index 2c1798e..4fe1c92 100644
> --- a/drivers/bcma/main.c
> +++ b/drivers/bcma/main.c
> @@ -301,6 +301,11 @@ void bcma_init_bus(struct bcma_bus *bus)
>  static void bcma_register_core(struct bcma_bus *bus, struct bcma_device *core)
>  {
>         int err;
> +       struct device * dev;
> +
> +       dev = bcma_bus_get_host_dev(bus);
> +       if (dev && !core->dev.of_node)
> +               core->dev.of_node = dev->of_node;
> 
> 
> if it's ok I will send this patch in separate email.
> 
>>
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Abylay Ospan <aospan@netup.ru>
>>>>> ---
>>>>>  drivers/pci/host/pcie-iproc.c | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>>>>> index 3ebc025..f2836a9 100644
>>>>> --- a/drivers/pci/host/pcie-iproc.c
>>>>> +++ b/drivers/pci/host/pcie-iproc.c
>>>>> @@ -952,6 +952,9 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
>>>>>     const int na = 3, ns = 2;
>>>>>     int rlen;
>>>>>
>>>>> +   if (!node)
>>>>> +           return -ENOENT;
>>>>> +
>>>>>     parser->node = node;
>>>>>     parser->pna = of_n_addr_cells(node);
>>>>>     parser->np = parser->pna + na + ns;
>>>>>
>>>>
>>>>
>>
>>
>> --
>> Florian
> 
> 
> 


-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
