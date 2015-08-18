Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150817230041.GO26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
	<1438039809-24957-4-git-send-email-yinghai@kernel.org>
	<20150817230041.GO26431@google.com>
Date: Tue, 18 Aug 2015 12:01:44 -0700
Message-ID: <CAE9FiQWhfhQdStJHZbscnoaZU5H_RKCWx7-td6eBAiQgCiSYVw@mail.gmail.com>
Subject: Re: [PATCH v3 03/51] PCI: Use correct align for optional only
 resources during sorting
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 17, 2015 at 4:00 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 27, 2015 at 04:29:21PM -0700, Yinghai Lu wrote:
>> During sorting before assign, we only put resource with non-zero align
>> in the sorted list, so for optional resources that must size is 0 and only
>> have addon parts, we need to have correct align.
>>
>> While treating SRIOV as optional resources, we always read alignment for
>> SRIOV bars, so they are ok.
>> Hotplug bridge resources are using STARTALIGN so it is ok when size is 0
>> if we have correct start for them.
>>
>> Later we want to treat the ROM BAR as optional resource, and it has
>> have SIZEALIGN, we need to find a way to get align for them.
>
> Are you saying we have a ROM resource where the ROM BAR is of non-zero
> size, but the resource structure says it's zero size?

Try to treat the ROM resource as optional, so will set the size in the
resource to 0.
aka required part size to 0. We can not get alignment from size anymore.
When we try to sort the resources before assign, we will skip resources with
bogus alignment.


>
>> We can use addon resource align instead in that case, and it will
>> be ok for SRIOV path and hotplug bridge resource path.
>>
>> Sorted list will contain must resource align/size to 0/0 to hold spot for
>> optional resources.
>>
>> We need to pass realloc_head from sizing stage to sorting stage, and
>> get entry from realloc list and calculate align from the entry.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
>
> Apparently this fixes a problem?  What is the problem?  What is the
> symptom of the problem?

resource allocation fail, so try to fix it by treat ROM BAR to be optional.



>
>> Reported-by: TJ <linux@iam.tj>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>>  drivers/pci/setup-bus.c | 50 ++++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 43 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 247d8fe..27cb0f0 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -145,9 +145,43 @@ static resource_size_t get_res_add_align(struct list_head *head,
>>       return dev_res->min_align;
>>  }
>>
>> +static resource_size_t __pci_resource_alignment(
>
> I don't like creating new function names by adding "__" to the
> beginning of an existing function name.  It doesn't give enough of a
> clue about what how the functions are different.  I don't really
> understand what's going on here, but this might be a clue that this
> could be refactored differently.

The function try to use alignment from optional part if alignment from
required part is 0.

>
>> +                             struct pci_dev *dev,
>> +                             struct resource *r,
>> +                             struct list_head *realloc_head)
>> +{
>> +     resource_size_t r_align = pci_resource_alignment(dev, r);
>> +     resource_size_t orig_start, orig_end;
>> +     struct pci_dev_resource *dev_res;
>> +
>> +     if (r_align || !realloc_head)
>> +             return r_align;
>> +
>> +     dev_res = res_to_dev_res(realloc_head, r);
>> +     if (!dev_res || !dev_res->add_size)
>> +             return r_align;
>> +
>> +     orig_start = r->start;
>> +     orig_end = r->end;
>> +     r->end += dev_res->add_size;
>> +     if ((r->flags & IORESOURCE_STARTALIGN)) {
>> +             resource_size_t r_size = resource_size(r);
>> +             resource_size_t add_align = dev_res->min_align;
>> +
>> +             r->start = add_align;
>> +             r->end = add_align + r_size - 1;
>
> I think this would be slightly shorter and more obvious as:
>
>   resource_size_t r_size = resource_size(r);
>
>   r->start = dev_res->min_align;
>   r->end = r->start + r_size - 1;

ok, will update that.
