Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57979 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbaIHMvx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Sep 2014 08:51:53 -0400
Received: by mail-pd0-f178.google.com with SMTP id p10so3719871pdj.23
        for <linux-pci@vger.kernel.org>; Mon, 08 Sep 2014 05:51:53 -0700 (PDT)
Message-ID: <540DA653.2000901@linaro.org>
Date: Mon, 08 Sep 2014 20:51:31 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jiang Liu <jiang.liu@linux.intel.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Lv Zheng <lv.zheng@intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Patch v4 04/16] ACPI: Rename processor_core.c as apic_id.c
References: <1409192561-19744-1-git-send-email-jiang.liu@linux.intel.com> <1409192561-19744-5-git-send-email-jiang.liu@linux.intel.com> <1957879.bE3ICM6HKO@vostro.rjw.lan>
In-Reply-To: <1957879.bE3ICM6HKO@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gerry, Rafael,

On 2014年09月08日 06:37, Rafael J. Wysocki wrote:
> On Thursday, August 28, 2014 10:22:29 AM Jiang Liu wrote:
>> Now all code in processor_core.c is APIC ID related, so rename it as
>> apic_id.c. Later IOAPIC ID related code will be added into apic_id.c.
> Actually, I'm not sure about this one.
>
> Renames like this make it difficult to backport things in general
> and kind of break "git blame", so do we have to do that?
>
> What's wrong with leaving the name as is and adding a comment
> about the contents being related to IOAPIC ID?

It will be thankful for not renaming the file into apic_id.c, because apic id is x86 specific,
and platform like ARM will also add some code to get cpu hardware id via GICC structure
in MADT table in that file, apic id is not a generic name for both x86 and ARM, I prefer to
keep it as it is :)

Thanks
Hanjun

