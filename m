Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65317 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198AbbCYHZs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Mar 2015 03:25:48 -0400
Message-ID: <551262F9.7080809@linux.intel.com>
Date: Wed, 25 Mar 2015 15:25:45 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Bugfix] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
References: <1427095334-7430-1-git-send-email-jiang.liu@linux.intel.com> <20150323164809.GS26935@google.com>
In-Reply-To: <20150323164809.GS26935@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2015/3/24 0:48, Bjorn Helgaas wrote:
> On Mon, Mar 23, 2015 at 03:22:14PM +0800, Jiang Liu wrote:
<snit>
>> ---
>>  arch/x86/pci/acpi.c     |    5 ++---
>>  drivers/acpi/resource.c |    3 +++
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>> index e4695985f9de..8c4b1201f340 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -337,7 +337,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
>>  	info->bridge = device;
>>  	ret = acpi_dev_get_resources(device, list,
>>  				     acpi_dev_filter_resource_type_cb,
>> -				     (void *)(IORESOURCE_IO | IORESOURCE_MEM));
>> +				     (void *)(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_WINDOW));
> 
> Tangent: I'm disappointed that ia64 didn't get reworked to track the x86
> code here.  Is that coming soon?
Hi Bjorn,
	Recall the memory now, IA64 may have mutiple 64K IO space, which
also support SPARSE attribute. Currently ACPI resource parsing interface
have no support of these two requirements yet. Will try to improve it.
Thanks!
Gerry
