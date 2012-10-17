Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <507E60C2.6010104@cn.fujitsu.com>
Date: Wed, 17 Oct 2012 15:39:46 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: jiang.liu@huawei.com, bhelgaas@google.com, lenb@kernel.org,
	izumi.taku@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Update acpi_root_bridge_list in container hotplug
 path.
References: <1350444308-27102-1-git-send-email-tangchen@cn.fujitsu.com> <CAE9FiQVFc9VVfWZpEfjPeGvo5pby3BQNzDei3VTXdoR048_SPg@mail.gmail.com>
In-Reply-To: <CAE9FiQVFc9VVfWZpEfjPeGvo5pby3BQNzDei3VTXdoR048_SPg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/17/2012 01:18 PM, Yinghai Lu wrote:
>
> no, we don't need that.
>
> after closely looking, it seems we can dump acpi_root_bridge.
>
> please check if attached patch could work with container path.

Hi Yinghai,

Your patch seems working well.

BTW, I actually found that the two lists, acpi_root_bridge and
acpi_pci_roots in drivers/acpi/pci_root.c were similar, except
your acpi_root_bridge included PNP0A08.

In the beginning, I thought you would use it in some other situations,
and now it is clear that it can be removed.
Thanks. :)

And also, I have another 2 questions, maybe you can help me.
1) Do we need to put PNP0A08 into acpi_pci_roots ?
2) In container_notify_cb(), when it got a ACPI_NOTIFY_EJECT_REQUEST
    event, it doesn't do the hot-remove things.
    I use your sci emulator patch to test it. I did the following thing:
	echo echo "\_SB_.LSB1" > /sys/kernel/debug/acpi/sci_notify
    where \_SB_.LSB1 is a container, it just did nothing.
    Do we need to support this operation ?

Thanks. :)

>
> Thanks
>
> Yinghai

