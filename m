Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <503F96EB.2010304@gmail.com>
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
	<CAErSpo5eqyuK_yKshHbDyK5LBBG9cCn1MpmHbqpvVYe6x7AxFg@mail.gmail.com>
	<CAE9FiQV4M8cAZ71Pxvm8gAXzVuEz_4Yb3akpk7w9JwBH052_rQ@mail.gmail.com>
	<503F96EB.2010304@gmail.com>
Date: Thu, 30 Aug 2012 10:29:54 -0700
Message-ID: <CAE9FiQVdz1ApW-05BjzHK-kfZ-hrVbSamcemLbo_65qinV-R_w@mail.gmail.com>
Subject: Re: [PATCH 0/7][RESEND] acpi, pci: hostbridge hotplug support
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 30, 2012 at 9:38 AM, Jiang Liu <liuj97@gmail.com> wrote:
> On 08/30/2012 11:48 PM, Yinghai Lu wrote:
>         For system does support physical processor hotplug, I think
> BIOS should expose those special PCI buses, otherwise we may run into
> trouble after removing a physical processor.
No, not do the physical removing.

I just want to remove those not needed pci root bus.

lspci output get filled of all the those useless cpu pci devices.

>         BTW, do we really want to support logical PCI host bridge hotplug
> or only support physical host bridge hotplug? Here logical hotplug means
> adding a PCI bus into or removing a PCI bus from the running kernel.

get logical done at first, and then via acpi we could do real physical removal.

Thanks

Yinghai
