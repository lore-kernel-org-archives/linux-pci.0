Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:48351 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbaGEQL5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jul 2014 12:11:57 -0400
Received: by mail-qa0-f44.google.com with SMTP id hw13so2180740qab.3
        for <linux-pci@vger.kernel.org>; Sat, 05 Jul 2014 09:11:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACna6rxfutrgdnv2=UZgg5=awQy4KMqFYzwesGtq9gyxh3Jw_g@mail.gmail.com>
References: <CACna6ry7+oNLwGVkdJiDkLq_QCZ5+gKk8Dxr=tbs-kBYqCp9Yg@mail.gmail.com>
 <CACna6rxfutrgdnv2=UZgg5=awQy4KMqFYzwesGtq9gyxh3Jw_g@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 5 Jul 2014 10:11:36 -0600
Message-ID: <CAErSpo4kFuCn98eJFbCo5W7bpPTA-visb0u-nPq-ptUCiB6XgA@mail.gmail.com>
Subject: Re: Checking PCIe generation in driver code
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 4, 2014 at 5:35 PM, Rafał Miłecki <zajec5@gmail.com> wrote:
> On 3 July 2014 22:06, Rafał Miłecki <zajec5@gmail.com> wrote:
>> I'm dealing with Broadcom devices and it appears I need to know if the
>> current PCIe device is Gen 1 or Gen 2. This is because they have
>> slightly different registers:
>> #define PCI_BAR0_WIN2 0xac
>> #define PCIE2_BAR0_WIN2 0x70
>>
>> Is there a way to know that? I keep starring at struct pci_dev, but
>> can't see "generation" field. Tried Googling, but couldn't find
>> anything.
>
> I've noticed that my 14e4:4360 card (PCIe Gen2) has:
> LNKCAP: 0x0046DC12 (hint: PCI_EXP_LNKCAP_SLS_5_0GB)
>
> Some older card 14e4:4359 (PCIe 1) has:
> LNKCAP: 0x00176811 (hint: PCI_EXP_LNKCAP_SLS_2_5GB)
>
> Wikipedia says 500 MB/s was added in PCIe 2.0.
>
> Could I check for this bit to determine if I'm dealing PCIe 2.0 card?

No, I think you should use the device ID to differentiate between the
register layouts.

Bjorn
