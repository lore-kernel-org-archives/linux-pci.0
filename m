Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20160914221654.GG16581@localhost>
References: <CAJZ5v0gRm++9zcAtXc1jYKsrg=tw2K3Wd=kQRS=RbRxXRDj8yA@mail.gmail.com>
 <20160913121942.80356-1-mika.westerberg@linux.intel.com> <20160914221654.GG16581@localhost>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Sep 2016 00:47:21 +0200
Message-ID: <CAJZ5v0jqk_5wr1qDhiX9+V3o3f1J74hBm8Pf=6gt4kmvX0_5EQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Add pci_find_resource()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Aaron Durbin <adurbin@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 15, 2016 at 12:16 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Sep 13, 2016 at 03:19:41PM +0300, Mika Westerberg wrote:
>> Add a new helper function pci_find_resource() that can be used to find out
>> whether a given resource (for example from a child device) is contained
>> within given PCI device's standard resources.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I think the ACPI part of this series is more interesting than the PCI
> part, so I propose that Rafael merge the series if he likes it.

I do, thanks!

>
>> ---
>>  drivers/pci/pci.c   | 27 +++++++++++++++++++++++++++
>>  include/linux/pci.h |  4 ++++
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index aab9d5115a5f..491f879f34cb 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -480,6 +480,33 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>>  EXPORT_SYMBOL(pci_find_parent_resource);
>>
>>  /**
>> + * pci_find_resource - Return matching PCI device resource
>> + * @dev: PCI device to query
>> + * @res: Resource to look for
>> + *
>> + * Goes over standard PCI resources (BARs) and checks if the given resource
>> + * is partially or fully contained in any of them. In that case the
>> + * matching resource is returned, %NULL otherwise.
>> + */
>> +struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
>> +{
>> +     int i;
>> +
>> +     if (!res)
>> +             return NULL;
>
> I agree that this test for !res is unnecessary.

Right.

I'm assuming the patch will be updated to drop this check.

Thanks,
Rafael
