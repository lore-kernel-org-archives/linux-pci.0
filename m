Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <556D45A3.9070708@linux.intel.com>
Date: Tue, 02 Jun 2015 13:56:51 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Hanjun Guo <hanjun.guo@linaro.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
CC: Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch v3 6/7] x86/PCI/ACPI: Use common interface to support
 PCI host bridge
References: <1431593803-5213-1-git-send-email-jiang.liu@linux.intel.com> <1431593803-5213-7-git-send-email-jiang.liu@linux.intel.com> <555F355E.7060706@linaro.org>
In-Reply-To: <555F355E.7060706@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/22 21:55, Hanjun Guo wrote:
> On 2015年05月14日 16:56, Jiang Liu wrote:
>> Use common interface to simplify ACPI PCI host bridge implementation.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>>   arch/x86/pci/acpi.c |  292
>> +++++++++++++++------------------------------------
>>   1 file changed, 85 insertions(+), 207 deletions(-)
>>
> [...]
>> -static void release_pci_root_info(struct pci_host_bridge *bridge)
>> +static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
>>   {
>> -    struct resource *res;
>> -    struct resource_entry *entry;
>> -    struct pci_root_info *info = bridge->release_data;
>> -
>> -    resource_list_for_each_entry(entry, &bridge->windows) {
>> -        res = entry->res;
>> -        if (res->parent &&
>> -            (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
>> -            release_resource(res);
>> -    }
>> -
>> -    teardown_mcfg_map(info);
>> -    kfree(info);
>> +    teardown_mcfg_map(ci);
>> +    kfree(ci);
> 
> Implicit pointer cast? I think add a comment here that %p of ci
> is same as %p of info would be helpful for review and easy understood.

Good point, will change as:
	kfree(container_of(ci, struct pci_root_info, common));
Thanks!
Gerry

> 
> other than that,
> 
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Thanks
> Hanjun
