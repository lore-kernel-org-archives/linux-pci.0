Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <50666D08.6050509@huawei.com>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
	<1348733519-24684-5-git-send-email-yinghai@kernel.org>
	<CAErSpo4WYEFg9HBRm8z=sSUTYLv5eLNfH07RQaQGh2+ZScp8sw@mail.gmail.com>
	<CAE9FiQW2mvXGVKF7Wn0Td+_Wafu1sPMYr-sn2zffAfBycKi=Hg@mail.gmail.com>
	<CAErSpo4Or84GO-DjKcu=G7hqUo8BF8Lu7czHwfmZDecvVS-tMQ@mail.gmail.com>
	<50666D08.6050509@huawei.com>
Date: Fri, 28 Sep 2012 21:19:38 -0700
Message-ID: <CAE9FiQUj6+DWUL1ZHqWG07VjV26aWRaJnyWEX6pOgWhuxwfcDQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI, ACPI: assign unassigned resource for hot add
 root bus
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 28, 2012 at 8:37 PM, Jiang Liu <jiang.liu@huawei.com> wrote:
> On 2012-9-29 11:31, Bjorn Helgaas wrote:
>> I agree, and I'm not asking you to fix that.  I'm just trying to
>> understand what's going on and write some comments and changelogs that
>> will help make this maintainable in the future.
>>
>> Also note the question at the top -- your changelog calls out IOAPICs,
>> but I'm still not sure what this patch has to do with IOAPICs.
> Hi Bjorn，
>         Another weay is to add an ACPI driver for IOAPIC, so we can control
> the order between IOAPIC and PCI host bridge.

use acpi_driver instead of acpi_pci_driver ?
