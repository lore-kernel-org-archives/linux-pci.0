Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57015 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190AbbCDC32 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 Mar 2015 21:29:28 -0500
Message-ID: <54F66E02.5090408@linux.intel.com>
Date: Wed, 04 Mar 2015 10:29:22 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Thomas Voegtle <tv@lio96.de>, Hudd <hedede.l@gmail.com>,
	Prakash Punnoor <prakash@punnoor.de>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Dave Airlie <airlied@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Len Brown <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Subject: Re: [Debug 2/2] x86/PCI/ACPI: Relax ACPI resource descriptor checks
 to work around BIOS bugs
References: <1425356741-26789-1-git-send-email-jiang.liu@linux.intel.com> <1425356741-26789-3-git-send-email-jiang.liu@linux.intel.com> <CAErSpo6MtTj+DM0dtm0QxUXGV=rC7a0Sygs03sU0617mWO-DpA@mail.gmail.com>
In-Reply-To: <CAErSpo6MtTj+DM0dtm0QxUXGV=rC7a0Sygs03sU0617mWO-DpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/3 23:18, Bjorn Helgaas wrote:
> On Mon, Mar 2, 2015 at 10:25 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
>> Some BIOSes report incorrect length for ACPI address space descriptors,
>> so relax the checks to avoid regressions.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> 
> It'd be nice to have a DSDT archived and referenced in this changelog
> for future reference.  This sounds similar to previous issues:
Hi all,
	Could anybody help to dump an ACPI table from those failure
systems so we could archive it?
Thanks!
Gerry

> 
> 3162b6f0c5e1 ("PNPACPI: truncate _CRS windows with _LEN > _MAX - _MIN + 1")
> d558b483d5a7 ("x86/PCI: truncate _CRS windows with _LEN > _MAX - _MIN + 1")
> f238b414a74a ("PNPACPI: compute Address Space length rather than using _LEN")
> 48728e077480 ("x86/PCI: compute Address Space length rather than using _LEN")
> 
> I assume your work fixes both these paths and avoids the issues we fixed above.
> 
>> ---
>>  drivers/acpi/resource.c |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index c723668e3e27..5589a6e2a023 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -42,8 +42,10 @@ static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
>>          * CHECKME: len might be required to check versus a minimum
>>          * length as well. 1 for io is fine, but for memory it does
>>          * not make any sense at all.
>> +        * Note: some BIOSes report incorrect length for ACPI address space
>> +        * descriptor, so remove check of 'reslen == len' to avoid regression.
>>          */
>> -       if (len && reslen && reslen == len && start <= end)
>> +       if (len && reslen && start <= end)
>>                 return true;
>>
>>         pr_debug("ACPI: invalid or unassigned resource %s [%016llx - %016llx] length [%016llx]\n",
>> --
>> 1.7.10.4
>>
