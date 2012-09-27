Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUUjPza9Hq8jJR0nLN__26zQooQAr=paB6dRjQtTM=ngw@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<20120918152553.8c8390d8.izumi.taku@jp.fujitsu.com>
	<CAErSpo7hYHkFAgFy=q6ASV_15r-y_Cp=92nUdRAnBSGLi9ZMrA@mail.gmail.com>
	<CAErSpo5bTDWCoVbzP-zz_ZcbSL-QJg+eFwoJHQxvaeQAY5OG2A@mail.gmail.com>
	<CAE9FiQUUjPza9Hq8jJR0nLN__26zQooQAr=paB6dRjQtTM=ngw@mail.gmail.com>
Date: Thu, 27 Sep 2012 10:59:43 -0700
Message-ID: <CAE9FiQXNdWO9pmr_vsMqaHCzm-TesMdBjTxHUUXTCY9m0G4KcQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 27, 2012 at 10:23 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Sep 27, 2012 at 9:48 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Fri, Sep 21, 2012 at 2:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> If we get rid of the struct pci_bus * dependency, then we can easily
>>> add the _PRT before doing PCI enumeration behind the bridge, and we
>>> can remove the _PRT after removing the PCI devices.  I think this is
>>> one small step toward getting rid of the add/start and stop/remove
>>> split.
>>
>> I'm going to work on doing this if nobody else is interested.
>
> I'm not sure if that is needed.

After patches that is using pci_host_bridge_bus_type and pci_bus_type
notification, we can remove
acpi_pci_root_start.

please check patches in my for-pci-next branch: it include jiang's 7
patches about notifier, and my kill pci_root_buses and etc.

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-next

-Yinghai
