Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:50278 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab3H2DPW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 23:15:22 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so4014695ieb.31
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 20:15:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <521E98AA.1090308@gmail.com>
References: <20130828192627.5895.26558.stgit@bhelgaas-glaptop> <521E98AA.1090308@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 28 Aug 2013 21:15:00 -0600
Message-ID: <CAErSpo6gAoYEsqbqnCh6ocyjcXLX-Sa0YQOQMGG1DRvO0JHhfw@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCIe Capability accessor fix and cleanups
To: Jiang Liu <liuj97@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yuval Mintz <yuvalmin@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 28, 2013 at 6:41 PM, Jiang Liu <liuj97@gmail.com> wrote:
> On 08/29/2013 03:26 AM, Bjorn Helgaas wrote:
>> The first patch fixes a Link Control issue reported by Yuval Mintz.
>> The rest simplify the code a bit.
>>
>> ---
>>
>> Bjorn Helgaas (4):
>>       PCI: Allow PCIe Capability link-related register access for switches
>>       PCI: Remove PCIe Capability version checks
>>       PCI: Support PCIe Capability Slot registers only for ports with slots
>>       PCI: Remove pcie_cap_has_devctl()
>>
>>
>>  drivers/pci/access.c |   26 +++++++++++---------------
>>  1 file changed, 11 insertions(+), 15 deletions(-)
>>
> Hi Bjorn,
>         Good changes! We avoid some unnecessary hardware accesses for
> unavailable registers.
>
> Reviewed-By: Jiang Liu <jiang.liu@huawei.com>

I applied these to pci/misc and put them in "next" for v3.12.
