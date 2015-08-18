Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37509 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbbHRVTT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 17:19:19 -0400
MIME-Version: 1.0
In-Reply-To: <20150817225041.GN26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
	<1438039809-24957-2-git-send-email-yinghai@kernel.org>
	<20150817225041.GN26431@google.com>
Date: Tue, 18 Aug 2015 14:19:18 -0700
Message-ID: <CAE9FiQVz1zLTSKX6=LfRxRTTU0VmOzY4DDbn18_ABFsmaTAcHg@mail.gmail.com>
Subject: Re: [PATCH v3 01/51] PCI: Cleanup res_to_dev_res() printout for addon resources
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
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 17, 2015 at 3:50 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 27, 2015 at 04:29:19PM -0700, Yinghai Lu wrote:
>> Now get_res_add_size and get_res_add_align all have same printout
>> from res_to_dev_res(), and it is confusing.
>>
>> Move out debug messages printout from res_to_dev_res(),
>> and later we will reuse res_to_dev_res() in other functions.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>>  drivers/pci/setup-bus.c | 34 ++++++++++++++++++++--------------
>>  1 file changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 508cc56..f0fa705 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -104,19 +104,9 @@ static struct pci_dev_resource *res_to_dev_res(struct list_head *head,
>>  {
>>       struct pci_dev_resource *dev_res;
>>
>> -     list_for_each_entry(dev_res, head, list) {
>> -             if (dev_res->res == res) {
>> -                     int idx = res - &dev_res->dev->resource[0];
>> -
>> -                     dev_printk(KERN_DEBUG, &dev_res->dev->dev,
>> -                              "res[%d]=%pR res_to_dev_res add_size %llx min_align %llx\n",
>> -                              idx, dev_res->res,
>> -                              (unsigned long long)dev_res->add_size,
>> -                              (unsigned long long)dev_res->min_align);
>> -...

>> +
>> +     dev_printk(KERN_DEBUG, &dev_res->dev->dev,
>> +                "BAR %d: %pR get_res_add_align min_align %llx\n",
>> +                (int)(res - &dev_res->dev->resource[0]),
>> +                res, (unsigned long long)dev_res->min_align);
>
> Please use %#llx so we have a "0x" prefix like other hex numbers.
>

ok.
Later i'd like to just kill those debug printout if all get settled
after this patchset.
