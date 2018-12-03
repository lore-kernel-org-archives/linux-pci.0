Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C536BC04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 14:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F22E208A3
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 14:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHNNb4Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F22E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbeLCOD1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbeLCOD1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 09:03:27 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3DCC206B7;
        Mon,  3 Dec 2018 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543845739;
        bh=P1ohtgQpLTpNi74GevAjQoePB1bpNk8qUomveSg7Eog=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YHNNb4VfIJ8zra5Q5teETWSD7pgpcp1bK7UPQPpNgVSmrjq1ic7DRccq/epPYu3gH
         ohY62YFxXMOACq/wtfuRWj1wfOc8pjLV90Jvbjv2UXk0hj0AQxMIkpzC+ZrEy349Ex
         caly0iuJA/vb3691eUb1JqOz4tRKaR9rwO2oOWpk=
Subject: Re: [PATCH v1 2/2] PCI/ACPI: alloc ACPI to be built without PCI
 support
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>
References: <20181201204137.1786-1-okaya@kernel.org>
 <20181201204137.1786-2-okaya@kernel.org> <20181203081942.GA2516@gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <d15a7ea7-6bb3-9f83-5251-0bdde92fcb36@kernel.org>
Date:   Mon, 3 Dec 2018 09:02:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181203081942.GA2516@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/3/2018 3:19 AM, Ingo Molnar wrote:
> 
> * Sinan Kaya <okaya@kernel.org> wrote:
> 
>> We are compiling PCI code today for systems with ACPI and no PCI
>> device present. Remove the useless code and reduce the tight
>> dependency.
>>
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>   arch/x86/include/asm/pci_x86.h | 5 +++++
>>   drivers/acpi/Kconfig           | 1 -
>>   drivers/acpi/Makefile          | 2 +-
>>   drivers/acpi/internal.h        | 5 +++++
>>   drivers/pci/Makefile           | 2 +-
>>   include/acpi/acpi_drivers.h    | 5 +++++
>>   include/linux/acpi.h           | 6 ++++++
>>   include/linux/pci.h            | 4 ++++
>>   8 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
>> index 959d618dbb17..940cf12e7d05 100644
>> --- a/arch/x86/include/asm/pci_x86.h
>> +++ b/arch/x86/include/asm/pci_x86.h
>> @@ -121,7 +121,12 @@ extern void __init dmi_check_pciprobe(void);
>>   extern void __init dmi_check_skip_isa_align(void);
>>   
>>   /* some common used subsys_initcalls */
>> +#ifdef CONFIG_PCI
>>   extern int __init pci_acpi_init(void);
>> +#else
>> +static inline int  __init pci_acpi_init(void)
>> +{ return -EINVAL; }
>> +#endif
> 
> No objections to removing the dependency, but that's nowhere near
> standard kernel style. ;-)
> 

Great,

> (There are similar problems elsewhere in the patch as well, please fix
> all of them.)

I sure can fix them but I copied the stub style from existing other stub
functions in the same file and did run checkpatch before submitting.

If you can point me to the specific ones you would like to see or give an
idea what it needs to look like, I can change it.

I saw three different styles as follows:

static inline int  __init pci_acpi_init(void) {}

static inline int  __init pci_acpi_init(void)
{}

static inline int  __init pci_acpi_init(void)
{
}


> 
> Thanks,
> 
> 	Ingo
> 

