Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53103 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753789Ab2DYROt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Apr 2012 13:14:49 -0400
Received: by lahj13 with SMTP id j13so276216lah.19
        for <linux-pci@vger.kernel.org>; Wed, 25 Apr 2012 10:14:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F805B32.1080401@gmail.com>
References: <20120406115948.3536e6c8.izumi.taku@jp.fujitsu.com>
 <4F7E8DDD.7020603@jp.fujitsu.com> <20120406201628.1621752c.izumi.taku@jp.fujitsu.com>
 <4F805B32.1080401@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Apr 2012 11:14:27 -0600
Message-ID: <CAErSpo4tibFpTSr+KaUJtFt=S5zGm=s5-p42_wW0yUcGu9JzWg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] PCI, ACPI, x86: MMCFG support for hotpluggable PCI
 hostbridges on x86, x86_64
To: Jiang Liu <liuj97@gmail.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 7, 2012 at 9:20 AM, Jiang Liu <liuj97@gmail.com> wrote:
> On 04/06/2012 07:16 PM, Taku Izumi wrote:
>>
>> This patch introduces the configuration for the base address of
>> the memory mapped configuration space (MMCFG) for hotpluggable PCI
>> hostbridges on x86 and x86_64.
>>
>> The MMCFG for hotpluggable host bridges must be described by using
>> ACPI _CBA method. This patch adds implementation for _CBA method
>> on ACPI pci_root driver and MMCFG manipulating functons for x86 and
>> x86_64.
>>
>> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
>> ---
>>  arch/x86/pci/mmconfig-shared.c |   61 ++++++++++++++++++++++++++++++++++-------
>>  drivers/acpi/pci_root.c        |   28 ++++++++++++++++++
>>  drivers/pci/pci.c              |   31 ++++++++++++++++++++
>>  include/acpi/acnames.h         |    1
>>  include/linux/pci.h            |    3 ++
>>  5 files changed, 113 insertions(+), 11 deletions(-)

Taku, I'm ignoring this patch for now because I assume that Jiang
Liu's series "[PATCH V4 0/6] PCI, x86: update MMCFG information when
hot-plugging PCI host bridges" includes the same functionality.

If my assumption is wrong, please let me know.

Bjorn
