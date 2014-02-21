Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:9883
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752417AbaBUVEz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 16:04:55 -0500
Message-ID: <5307BF6F.8040303@amd.com>
Date: Fri, 21 Feb 2014 15:04:47 -0600
From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<x86@kernel.org>, <dougthompson@xmission.com>,
	<bhelgaas@google.com>, <JBeulich@suse.com>,
	<dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<Arindam.Nath@amd.com>
Subject: Re: [PATCH] amd64_edac: Add support for newer F16h models
References: <1392913726-16961-1-git-send-email-Aravind.Gopalakrishnan@amd.com> <20140221142749.GC11531@pd.tnic>
In-Reply-To: <20140221142749.GC11531@pd.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/21/2014 8:27 AM, Borislav Petkov wrote:
> On Thu, Feb 20, 2014 at 10:28:46AM -0600, Aravind Gopalakrishnan wrote:
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 97fbecd..e91ad27 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -528,6 +528,8 @@
>>   #define PCI_DEVICE_ID_AMD_15H_NB_F5	0x1605
>>   #define PCI_DEVICE_ID_AMD_16H_NB_F3	0x1533
>>   #define PCI_DEVICE_ID_AMD_16H_NB_F4	0x1534
>> +#define PCI_DEVICE_ID_AMD_16H_M30H_NB_F3 0x1583
>> +#define PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 0x1584
> Just put those in arch/x86/include/asm/amd_nb.h as amd64_edac.c includes
> it already and you can avoid the pci_ids.h addition. Unless there are
> plans to use F{3,4} in other places too...
>

F{3,4} are used by hwmon/k10temp.c and hwmon/fam15h_power.c and they 
will need definitions to be places here in pci_ids.h
But I'm not sure if the hwmon drivers need to carry support for this 
model yet (will verify that)

If not, I'll remove them and resend.

Thanks,
-Aravind.

