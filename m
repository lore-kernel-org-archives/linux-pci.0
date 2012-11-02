Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5093202E.4050700@cn.fujitsu.com>
Date: Fri, 02 Nov 2012 09:21:50 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Toshi Kani <toshi.kani@hp.com>
CC: yinghai@kernel.org, bhelgaas@google.com, lenb@kernel.org,
	jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Improve container_notify_cb() to support container
 hot-remove.
References: <1351668471-31436-1-git-send-email-tangchen@cn.fujitsu.com>  <1351668471-31436-4-git-send-email-tangchen@cn.fujitsu.com> <1351788194.19172.98.camel@misato.fc.hp.com>
In-Reply-To: <1351788194.19172.98.camel@misato.fc.hp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/02/2012 12:43 AM, Toshi Kani wrote:
>
> Hi Tang,
>
> Rafael pointed out in my CPU hot-remove patch that
> acpi_bus_hot_remove_device() was not exported for modules.  Looks like
> you have the same problem here.  FYI, I just sent the following patch
> that exports acpi_bus_hot_remove_device() and acpi_os_hotplug_execute().
>
> https://lkml.org/lkml/2012/11/1/225
>
Hi Toshi,

I see. Thanks for the info. :)

Thanks.

