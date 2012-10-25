Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <50888D77.2090006@huawei.com>
Date: Thu, 25 Oct 2012 08:53:11 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Toshi Kani <toshi.kani@hp.com>,
	Tang Chen <tangchen@cn.fujitsu.com>, <yinghai@kernel.org>,
	<lenb@kernel.org>, <izumi.taku@jp.fujitsu.com>,
	<isimatu.yasuaki@jp.fujitsu.com>, <mihailm@parallels.com>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Improve container_notify_cb() to support container
 hot-remove.
References: <1351058750-4275-1-git-send-email-tangchen@cn.fujitsu.com> <1351058750-4275-3-git-send-email-tangchen@cn.fujitsu.com> <1351098875.19172.21.camel@misato.fc.hp.com> <CAErSpo7KRTY+M1gSO7s_PGRPkXABK6x9CQsaMXbZ__C11mmTWQ@mail.gmail.com>
In-Reply-To: <CAErSpo7KRTY+M1gSO7s_PGRPkXABK6x9CQsaMXbZ__C11mmTWQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012-10-25 2:02, Bjorn Helgaas wrote:
> On Wed, Oct 24, 2012 at 11:14 AM, Toshi Kani <toshi.kani@hp.com> wrote:
>> On Wed, 2012-10-24 at 14:05 +0800, Tang Chen wrote:
> 
>>> +             result = container_device_remove(device);
>>> +             if (result) {
>>> +                     printk(KERN_WARNING "Failed to remove container\n");
>>
>> Please use pr_warn().
> 
> I think you should use dev_warn() and similar when possible.  In a
> year or two, the text "Failed to remove container" all by itself in a
> dmesg log is not going to mean anything to anybody except you, and it
> doesn't give any clue where to start looking for issues.
> 
> I also have a larger question.  I'm not sure if
> drivers/acpi/container.c does anything important in the first place.
> The code in it looks an awful lot like the code in
> drivers/acpi/processor_driver.c, drivers/acpi/acpi_memhotplug.c, and
> drivers/pci/hotplug/acpiphp_glue.c.
> 
> To me, it looks like container.c (as well as the other places I
> mentioned) is an attempt to compensate for the lack of hotplug support
> in the ACPI core.  If the ACPI core had generic hotplug support, e.g.,
> if it handled BUS_CHECK, DEVICE_CHECK, and EJECT_REQUEST notifications
> and turned those into the appropriate calls to driver .add()/.start()
> and .remove() methods, would we need container.c at all?
Hi Bjorn,
	It's true that container driver is just for hotplug. We are working
on a hotplug framework which will consolidate all hotplug logic into one
driver.
	--Gerry

> 
> Bjorn
> 
> .
> 


