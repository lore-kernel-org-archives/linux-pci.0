Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35875 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbbHRU6G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 16:58:06 -0400
MIME-Version: 1.0
In-Reply-To: <20150817235236.GQ26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
	<1438039809-24957-8-git-send-email-yinghai@kernel.org>
	<20150817235236.GQ26431@google.com>
Date: Tue, 18 Aug 2015 13:58:05 -0700
Message-ID: <CAE9FiQW9fMVmT8Bd6BFHS=7xc34PUwWGKdU_gYen_Zjy6KS6yw@mail.gmail.com>
Subject: Re: [PATCH v3 07/51] PCI: Reorder resources list for must/optional resources
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

On Mon, Aug 17, 2015 at 4:52 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 27, 2015 at 04:29:25PM -0700, Yinghai Lu wrote:
>> After we update size and alignment for must+optional resource, we
>> reorder them with new alignment, but this is only for STARTALIGN.
>>
>> For SIZEALIGN type resource, after add back add_size, the alignment
>> get changed, so need to do the sorting like STARTALIGN type resources.
>>
>> Also we need to reorder the sorting back after we restore
>> resource to must only when must+optional fail to allocate for all.
>>
>> So move out the reordering code from the loop to separated function,
>> and call it two times accordingly.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>>  drivers/pci/setup-bus.c | 62 +++++++++++++++++++++++++++++--------------------
>>  1 file changed, 37 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 7346bbf..6f2d508 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -287,6 +287,31 @@ static inline void reset_resource(struct resource *res)
>>       res->flags = 0;
>>  }
>>
>> +static void __sort_resources(struct list_head *head)
>
> Why did you add "__" before the function name?

ok, will remove that.
