Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150817235416.GS26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
	<1438039809-24957-14-git-send-email-yinghai@kernel.org>
	<20150817235416.GS26431@google.com>
Date: Tue, 18 Aug 2015 14:58:06 -0700
Message-ID: <CAE9FiQVDRFvzadNz6HkEgShuJdfWWvF_tu-fT982WVp9ZEkxeA@mail.gmail.com>
Subject: Re: [PATCH v3 13/51] PCI: Separate realloc list checking after allocation
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 17, 2015 at 4:54 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 27, 2015 at 04:29:31PM -0700, Yinghai Lu wrote:
>> We check the realloc list, as list must be empty after allocation.
>>
>> Separate the realloc list checking to another function.
>>
>> Add checking that is missed in acpiphp driver.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: linux-acpi@vger.kernel.org
>> ---
>>  drivers/pci/hotplug/acpiphp_glue.c |  1 +
>>  drivers/pci/pci.h                  |  1 +
>>  drivers/pci/setup-bus.c            | 11 ++++++++---
>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>> index ff53856..134caee 100644
>> --- a/drivers/pci/hotplug/acpiphp_glue.c
>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
>> @@ -507,6 +507,7 @@ static void enable_slot(struct acpiphp_slot *slot)
>>               }
>>       }
>>       __pci_bus_assign_resources(bus, &add_list, NULL);
>> +     __pci_bus_check_realloc(&add_list);
>>
>>       acpiphp_sanitize_bus(bus);
>>       pcie_bus_configure_settings(bus);
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 4ff0ff1..2b83977 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -235,6 +235,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus,
>>  void __pci_bus_assign_resources(const struct pci_bus *bus,
>>                               struct list_head *realloc_head,
>>                               struct list_head *fail_head);
>> +void __pci_bus_check_realloc(struct list_head *realloc_head);
>>  bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
>>
>>  void pci_reassigndev_resource_alignment(struct pci_dev *dev);
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 06664db..f30225c 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -350,6 +350,11 @@ out:
>>       }
>>  }
>>
>> +void __pci_bus_check_realloc(struct list_head *realloc_head)
>> +{
>> +     BUG_ON(!list_empty(realloc_head));
>
> I don't think this really improves readability.  At least before, we could
> see what we were looking for and we knew it might BUG().

ok, will only missing BUG_ON into acpiphp_glue.c.
