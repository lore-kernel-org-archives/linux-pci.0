Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <54BF9C46.8060302@linux.intel.com>
Date: Wed, 21 Jan 2015 20:32:06 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Thierry Reding <treding@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Travis <travis@sgi.com>, Tony Luck <tony.luck@intel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [RFC Patch 17/19] resources: Move struct resource_list_entry
 from ACPI into resource core
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com> <1420684386-5975-18-git-send-email-jiang.liu@linux.intel.com> <3428063.tN1BxOoXSN@vostro.rjw.lan> <54BF4911.7030906@linux.intel.com> <alpine.DEB.2.11.1501211043170.5526@nanos>
In-Reply-To: <alpine.DEB.2.11.1501211043170.5526@nanos>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/1/21 17:43, Thomas Gleixner wrote:
> On Wed, 21 Jan 2015, Jiang Liu wrote:
>> On 2015/1/21 9:10, Rafael J. Wysocki wrote:
>>>> +
>>>> +void resource_list_insert(struct list_head *head,
>>>> +			  struct resource_list_entry *entry, bool tail)
>>>
>>> I would call this resource_list_add() if anything.
>>>
>>> Also it may be better to have two helpers, one for "add" and one for "add_tail"
>>> (and perhaps define them as static inline?).
>> We can't use inline functions here because that needs pulling list.h
>> into ioport.h, then causing building issues to header inclusion order.
> 
> Create a new header file to avoid the circular dependencies then.
Great, create include/linux/resource_list.h for it so we could
inline those simple functions.
Regards,
Gerry

> 
> Thanks,
> 
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
