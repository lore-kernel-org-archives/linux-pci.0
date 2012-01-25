Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:62255 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab2AYVd5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2012 16:33:57 -0500
Received: by werb13 with SMTP id b13so4160735wer.19
        for <linux-pci@vger.kernel.org>; Wed, 25 Jan 2012 13:33:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120125130836.22450527@jbarnes-desktop>
References: <20120109224349.24913.23010.stgit@bhelgaas.mtv.corp.google.com> <20120125130836.22450527@jbarnes-desktop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Jan 2012 14:33:36 -0700
Message-ID: <CAErSpo4227cGPKCsYRYgREQyxdE-qZHpfJ+iqmt0TS6vctB-DQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/PCI: build amd_bus.o only when CONFIG_AMD_NB=y
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 25, 2012 at 2:08 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> On Mon, 09 Jan 2012 15:43:49 -0700
> Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> We only need amd_bus.o for AMD systems with PCI.  arch/x86/pci/Makefile
>> already depends on CONFIG_PCI=y, so this patch just adds the dependency
>> on CONFIG_AMD_NB.
>>
>> CC: Yinghai Lu <yinghai@kernel.org>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  arch/x86/pci/Makefile |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
>> index 6b8759f..d24d3da 100644
>> --- a/arch/x86/pci/Makefile
>> +++ b/arch/x86/pci/Makefile
>> @@ -18,8 +18,9 @@ obj-$(CONFIG_X86_NUMAQ)             += numaq_32.o
>>  obj-$(CONFIG_X86_MRST)               += mrst.o
>>
>>  obj-y                                += common.o early.o
>> -obj-y                                += amd_bus.o bus_numa.o
>> +obj-y                                += bus_numa.o
>>
>> +obj-$(CONFIG_AMD_NB)         += amd_bus.o
>>  obj-$(CONFIG_PCI_CNB20LE_QUIRK)      += broadcom_bus.o
>>
>>  ifeq ($(CONFIG_PCI_DEBUG),y)
>
> Arg sorry guys I've been totally swamped since sending in the pull
> req.  I'll do a review & merge pass on the outstanding stuff tomorrow.

Linus picked up this particular fix already (5cf9a4e69c1ff), so don't
worry about this one.

Bjorn
