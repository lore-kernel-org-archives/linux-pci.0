Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <57E40665.8080005@gmail.com>
Date: Fri, 23 Sep 2016 00:27:17 +0800
From: "zhichang.yuan" <zhichang.yuan02@gmail.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <3538381.vOsx75UXVU@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F881744@lhreml507-mbx>
 <9178320.n4yHmfyPA3@wuerfel>
In-Reply-To: <9178320.n4yHmfyPA3@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "minyard@acm.org" <minyard@acm.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 John Garry <john.garry@huawei.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuanzhichang <yuanzhichang@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>,
 "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
 "kantyzc@163.com" <kantyzc@163.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


On 09/22/2016 08:14 PM, Arnd Bergmann wrote:
> On Thursday, September 22, 2016 11:55:45 AM CEST Gabriele Paoloni wrote:
>>>> I think extending of_empty_ranges_quirk() may be a reasonable
>>> solution.
>>>> What do you think Arnd?
>>> I don't really like that idea, that quirk is meant to work around
>>> broken DTs, but we can just make the DT valid and implement the
>>> code properly.
>> Ok  I understand your point where it is not right to use of_empty_ranges_quirk()
>> As a quirk is used to work around broken HW or broken FW (as in this case)
>> rather than to fix code
>>
>> What about the following? I think adding the check you suggested next to
>> of_empty_ranges_quirk() is adding the case we need in the right point (thus
>> avoiding any duplication)
>>   
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -457,6 +457,15 @@ static struct of_bus *of_match_bus(struct device_node *np)
>>          return NULL;
>>   }
>>   
>> +static inline int of_isa_indirect_io(struct device_node *np)
>> +{
>> +       /*
>> +        * check if the current node is an isa bus and if indirectio operation
>> +        * are registered
>> +        */
>> +       return (of_bus_isa_match(np) && arm64_extio_ops);
>> +}
>> +
>>   static int of_empty_ranges_quirk(struct device_node *np)
>>   {
>>          if (IS_ENABLED(CONFIG_PPC)) {
>> @@ -503,7 +512,7 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>>           * This code is only enabled on powerpc. --gcl
>>           */
>>          ranges = of_get_property(parent, rprop, &rlen);
>> -       if (ranges == NULL && !of_empty_ranges_quirk(parent)) {
>> +       if (ranges == NULL && !of_empty_ranges_quirk(parent) && !of_isa_indirect_io(parent)) {
>>                  pr_debug("OF: no ranges; cannot translate\n");
>>                  return 1;
>>          }
> I don't see what effect that would have. What do you want to
> achieve with this?
>
> I think all we need from this function is to return '1' if
> we hit an ISA I/O window, and that should happen for the two
> interesting cases, either no 'ranges' at all, or no translation
> for the range in question, so that __of_translate_address can
> return OF_BAD_ADDR, and we can enter the special case
> handling in the caller, that handles it like
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 02b2903fe9d2..a18d96843fae 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -685,17 +685,24 @@ static int __of_address_to_resource(struct device_node *dev,
>   	if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
>   		return -EINVAL;
>   	taddr = of_translate_address(dev, addrp);
> -	if (taddr == OF_BAD_ADDR)
> -		return -EINVAL;
>   	memset(r, 0, sizeof(struct resource));
> +
>   	if (flags & IORESOURCE_IO) {
>   		unsigned long port;
> -		port = pci_address_to_pio(taddr);
> +
> +		if (taddr == OF_BAD_ADDR)
> +			port = arch_of_address_to_pio(dev, addrp)
> +		else
> +			port = pci_address_to_pio(taddr);
> +
>   		if (port == (unsigned long)-1)
>   			return -EINVAL;
>   		r->start = port;
>   		r->end = port + size - 1;
>   	} else {
> +		if (taddr == OF_BAD_ADDR)
> +			return -EINVAL;
> +
>   		r->start = taddr;
>   		r->end = taddr + size - 1;
>   	}
>
For this patch sketch, I have a question.
Do we call pci_address_to_pio in arch_of_address_to_pio to get the 
corresponding logical IO port
for LPC??

If we don't, it seems the LPC specific IO address will conflict with PCI 
host bridges' logical IO.
Supposed our LPC populated the IO range from 0x100 to 0x3FF( this is 
normal for ISA similar
devices), after arch_of_address_to_pio(), the r->start will be set as 
0x100, r->end will be set as
0x3FF.  And if there is one PCI host bridge who request a IO window size 
over 0x400 at the same
time, the  corresponding r->start and r->end will be set as 0x0, 0x3FF 
after of_address_to_resource
for this host bridge.  Then the IO conflict happens.

cheers,
Zhichang

>
> 	Arnd


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
