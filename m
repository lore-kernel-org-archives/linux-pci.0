Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices whose
 dependency has not met
To: Arnd Bergmann <arnd@arndb.de>, "zhichang.yuan" <yuanzhichang@hisilicon.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
 <1489372963-9000-6-git-send-email-yuanzhichang@hisilicon.com>
 <4600523.rWNiWKrYZC@aspire.rjw.lan> <58C9F6C6.4090700@hisilicon.com>
 <CAK8P3a2QZ_j9RQ0U=4MoAAcRcZyu0L5AiYM22QZkiRxh7Ca-iA@mail.gmail.com>
From: "zhichang.yuan" <zhichang.yuan02@gmail.com>
Message-ID: <592befcb-8b52-3a3a-323f-55566f61c7df@gmail.com>
Date: Thu, 16 Mar 2017 22:56:52 +0800
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2QZ_j9RQ0U=4MoAAcRcZyu0L5AiYM22QZkiRxh7Ca-iA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Rafael Wysocki <rafael@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, linuxarm@huawei.com,
 Frank Rowand <frowand.list@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Wei Xu <xuwei5@hisilicon.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 devicetree@vger.kernel.org, Corey Minyard <minyard@acm.org>,
 liviu.dudau@arm.com, John Garry <john.garry@huawei.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 kantyzc@163.com, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Zou Rongrong <zourongrong@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Arnd,



On 03/16/2017 06:13 PM, Arnd Bergmann wrote:
> On Thu, Mar 16, 2017 at 3:21 AM, zhichang.yuan
> <yuanzhichang@hisilicon.com> wrote:
>> Hi, Rafael,
>>
>> Thanks for your review!
>>
>> On 2017/3/14 5:24, Rafael J. Wysocki wrote:
>>> On Monday, March 13, 2017 10:42:41 AM zhichang.yuan wrote:
>>>> In commit 40e7fcb1929(ACPI: Add _DEP support to fix battery issue on Asus
>>>> T100TA), the '_DEP' was supported to solve the dependency of Asus battery. But
>>>> this patch is specific to Asus battery device.
>>>> In the real world, there are other devices which need the dependency to play the
>>>> role on the enumeration order. For example, all the Hip06 LPC
>>>> periperals(IPMI-BT, uart, etc) must be scanned after the LPC host driver
>>>> finished the probing. So, it makes sense to add a checking whether the ACPI
>>>> device meet all the dependencies during its enumeration slot, if not, the
>>>> enumeration will be delayed till all dependency master finish their work.
>>>>
>>>> This patch adds the dependency checking in ACPI enumeration, also the
>>>> corresponding handling to retrigger the Hip06 LPC peripherals' scanning.
>>>
>>> AFAICS, _DEP is generally abused in the wild and cannot be made generic.  Sorry.
>>>
>>
>> From the ACPI specification, _DEP is for operation region accesses.
>> You are right...
>>
>> How about we add a ACPI handler for our LPC bus?? Just like amba.
>> In this way, we also can solve the issue about LPC enumeration order.
> 
> As far as I can tell, PCI and LPC have exactly the same requirement here,
> so whatever you end up doing for one should be used for the other as well.
> 

Thanks for your remind!

To some extend, our LPC is similar to PCI. We also need to setup the host
resources before scanning the children. For PCI, there is an ACPI handler of
pci_root_handler. Although our LPC is not so complicated and powerful as PCI(for
example, LPC can't probe downside devices), I think, we can still make LPC host
ready to work in its own ACPI handler callback....

Cheers,
Zhichang


>       Arnd
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
