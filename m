Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34823 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbbIIOzL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2015 10:55:11 -0400
Received: by wicge5 with SMTP id ge5so158575330wic.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2015 07:55:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55EFD3CA.3050301@linux.intel.com>
References: <1433780448-18636-1-git-send-email-jiang.liu@linux.intel.com>
 <1433780448-18636-2-git-send-email-jiang.liu@linux.intel.com>
 <20150729203741.GC9640@google.com> <55EFD3CA.3050301@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 9 Sep 2015 09:54:50 -0500
Message-ID: <CAErSpo438W5kRtxb9dG8AyLNVaCSTqF_QQ-rdU6DR26Q1_gRvA@mail.gmail.com>
Subject: Re: [Patch v5 1/6] ACPI/PCI: Enhance ACPI core to support sparse IO space
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Len Brown <lenb@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
	Thierry Reding <treding@nvidia.com>,
	Jakub Sitnicki <jsitnicki@gmail.com>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"x86 @ kernel . org" <x86@kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 9, 2015 at 1:38 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> On 2015/7/30 4:37, Bjorn Helgaas wrote:
>> On Tue, Jun 09, 2015 at 12:20:43AM +0800, Jiang Liu wrote:
>>> Enhance ACPI resource parsing interfaces to support sparse IO space,
>>> which will be used to share common code between x86 and IA64 later.
>>>
>>> Tested-by: Tony Luck <tony.luck@intel.com>
>>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>>> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> ---
>>>  drivers/acpi/resource.c |    9 ++++++---
>>>  include/linux/ioport.h  |    1 +
>>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>>> index 8244f013f210..fdcc73dad2c1 100644
>>> --- a/drivers/acpi/resource.c
>>> +++ b/drivers/acpi/resource.c
>>> @@ -123,7 +123,7 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res)
>>>  EXPORT_SYMBOL_GPL(acpi_dev_resource_memory);
>>>
>>>  static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
>>> -                                  u8 io_decode)
>>> +                                  u8 io_decode, u8 translation_type)
>>>  {
>>>      res->flags = IORESOURCE_IO;
>>>
>>> @@ -135,6 +135,8 @@ static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
>>>
>>>      if (io_decode == ACPI_DECODE_16)
>>>              res->flags |= IORESOURCE_IO_16BIT_ADDR;
>>> +    if (translation_type == ACPI_SPARSE_TRANSLATION)
>>> +            res->flags |= IORESOURCE_IO_SPARSE;
>>>  }
>>>
>>>  static void acpi_dev_get_ioresource(struct resource *res, u64 start, u64 len,
>>> @@ -142,7 +144,7 @@ static void acpi_dev_get_ioresource(struct resource *res, u64 start, u64 len,
>>>  {
>>>      res->start = start;
>>>      res->end = start + len - 1;
>>> -    acpi_dev_ioresource_flags(res, len, io_decode);
>>> +    acpi_dev_ioresource_flags(res, len, io_decode, 0);
>>>  }
>>>
>>>  /**
>>> @@ -227,7 +229,8 @@ static bool acpi_decode_space(struct resource_win *win,
>>>              acpi_dev_memresource_flags(res, len, wp);
>>>              break;
>>>      case ACPI_IO_RANGE:
>>> -            acpi_dev_ioresource_flags(res, len, iodec);
>>> +            acpi_dev_ioresource_flags(res, len, iodec,
>>> +                                      addr->info.io.translation_type);
>>>              break;
>>>      case ACPI_BUS_NUMBER_RANGE:
>>>              res->flags = IORESOURCE_BUS;
>>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>>> index 388e3ae94f7a..24bea087e7af 100644
>>> --- a/include/linux/ioport.h
>>> +++ b/include/linux/ioport.h
>>> @@ -94,6 +94,7 @@ struct resource {
>>>  /* PnP I/O specific bits (IORESOURCE_BITS) */
>>>  #define IORESOURCE_IO_16BIT_ADDR    (1<<0)
>>>  #define IORESOURCE_IO_FIXED         (1<<1)
>>> +#define IORESOURCE_IO_SPARSE                (1<<2)
>>
>> I don't really like this bit.  We adding a new generic IORESOURCE_* bit
>> just for a special case, and it's only used in one place, for one arch,
>> during enumeration.
> Hi Bjorn,
>         Instead of defining a formal flag IORESOURCE_IO_SPARSE, we may
> reuse other field in struct resource to pass back the SPARSE flag,
> but that's a little dirty. For example, we may reuse res->name field
> to carry the SPARSE flag for the IA64 special case.
>         Is that OK?

No, I think that's even worse.  Adding IORESOURCE_IO_SPARSE looks
positively glorious now.

Bjorn
