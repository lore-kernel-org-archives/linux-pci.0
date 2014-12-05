Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp2.tech.numericable.fr ([82.216.111.38]:55260 "EHLO
	smtp2.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaLEQlj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Dec 2014 11:41:39 -0500
Message-ID: <5481E034.3030204@laposte.net>
Date: Fri, 05 Dec 2014 17:41:24 +0100
From: Barto <mister.freeman@laposte.net>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>,
	Chuansheng Liu <chuansheng.liu@intel.com>
CC: bhelgaas@google.com, rjw@rjwysocki.net, aaron.lu@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Add disabling pm async quirk for JMicron chips
References: <1417763857-11993-1-git-send-email-chuansheng.liu@intel.com> <20141205144544.GH4080@htj.dyndns.org>
In-Reply-To: <20141205144544.GH4080@htj.dyndns.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> Why is this being done through pci quirks?  e6b7e41cdd8 implements the
> same quirk in the respective drivers.  What's the difference here?
>
> Thanks.
>

the difference is that the commit e6b7e41cdd8 "ata: Disabling the async
PM for JMicron chip 363/361" doesn't work with my JMicron 363/368,

because in this commit "the if statement conditions" are not suitable to
my JMicron 363/368 card ( mismatch PCI_ID ), I tried this patch and it
doesn't work, check the if statement you will understand why :

https://github.com/rjarzmik/linux/commit/e6b7e41cdd8cae0591e04d9519b65470110e2d44

my JMicron 363/368 is both an IDE/SATA controler pcie card,

Chuansheng has found the solution by adding a line in
drivers/pci/quirks.c file in order to be sure that ALL variants of
JMicron 3xx/3xx chips will be targeted :

+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID,
+		pci_async_suspend_fixup);







Le 05/12/2014 15:45, Tejun Heo a écrit :
> On Fri, Dec 05, 2014 at 03:17:37PM +0800, Chuansheng Liu wrote:
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, quirk_jmicron_ata);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, quirk_jmicron_ata);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB362, quirk_jmicron_ata);
>> @@ -1519,6 +1534,8 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB3
>>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, quirk_jmicron_ata);
>>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, quirk_jmicron_ata);
>>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB369, quirk_jmicron_ata);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID,
>> +		pci_async_suspend_fixup);
> 
> Why is this being done through pci quirks?  e6b7e41cdd8 implements the
> same quirk in the respective drivers.  What's the difference here?
> 
> Thanks.
> 
