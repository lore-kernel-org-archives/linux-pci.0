Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <509698C3.5070700@gmail.com>
Date: Mon, 05 Nov 2012 00:33:07 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Tang Chen <tangchen@cn.fujitsu.com>, bhelgaas@google.com,
	lenb@kernel.org, jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ACPI: container hot remove support.
References: <1351668471-31436-1-git-send-email-tangchen@cn.fujitsu.com> <509106E2.70008@jp.fujitsu.com> <CAE9FiQVrMj2KunOMDvftnu=MG=t=UpKTA4-t_YTYdgVL-rg_7Q@mail.gmail.com>
In-Reply-To: <CAE9FiQVrMj2KunOMDvftnu=MG=t=UpKTA4-t_YTYdgVL-rg_7Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/01/2012 12:48 AM, Yinghai Lu wrote:
> On Wed, Oct 31, 2012 at 4:09 AM, Yasuaki Ishimatsu
> <isimatu.yasuaki@jp.fujitsu.com> wrote:
>>> patch 2. Introduce a new function container_device_remove() to handle
>>>           ACPI_NOTIFY_EJECT_REQUEST event for container.
>>
>> If container device contains memory device, the function is
>> very danger. As you know, we are developing a memory hotplug.
>> If memory has kernel memory, memory hot remove operations fails.
>> But container_device_remove() cannot realize it. So even if
>> the memory hot remove operation fails, container_device_remove()
>> keeps hot remove operation. Finally, the function sends _EJ0
>> to firmware. In this case, if the memory is accessed, kernel
>> panic occurs.
>> The example is as follows:
>>
>>  https://lkml.org/lkml/2012/9/26/318
> 
> so what is the overall status memory hot-remove?
> how are following memory get processed ?
> 1. memory for kernel text, module
> 2. page table
> 3. vmemmap
> 4. memory for kmalloc, for dma
Hi Yinghai,
	I have given a talk about the CPU/memory/PCI host bridge hotplug
current status and next step plan on China Linux Kernel Developer Conference,
please refer to
https://github.com/downloads/jiangliu/linux/ACPI%20Based%20System%20Device%20Dynamic%20Reconfiguration.pdf
	Thanks!
	Gerry

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

