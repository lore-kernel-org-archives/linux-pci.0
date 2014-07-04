Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:59825 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbaGDXf7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jul 2014 19:35:59 -0400
Received: by mail-ob0-f171.google.com with SMTP id nu7so2364535obb.16
        for <linux-pci@vger.kernel.org>; Fri, 04 Jul 2014 16:35:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACna6ry7+oNLwGVkdJiDkLq_QCZ5+gKk8Dxr=tbs-kBYqCp9Yg@mail.gmail.com>
References: <CACna6ry7+oNLwGVkdJiDkLq_QCZ5+gKk8Dxr=tbs-kBYqCp9Yg@mail.gmail.com>
Date: Sat, 5 Jul 2014 01:35:59 +0200
Message-ID: <CACna6rxfutrgdnv2=UZgg5=awQy4KMqFYzwesGtq9gyxh3Jw_g@mail.gmail.com>
Subject: Re: Checking PCIe generation in driver code
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3 July 2014 22:06, Rafał Miłecki <zajec5@gmail.com> wrote:
> I'm dealing with Broadcom devices and it appears I need to know if the
> current PCIe device is Gen 1 or Gen 2. This is because they have
> slightly different registers:
> #define PCI_BAR0_WIN2 0xac
> #define PCIE2_BAR0_WIN2 0x70
>
> Is there a way to know that? I keep starring at struct pci_dev, but
> can't see "generation" field. Tried Googling, but couldn't find
> anything.

I've noticed that my 14e4:4360 card (PCIe Gen2) has:
LNKCAP: 0x0046DC12 (hint: PCI_EXP_LNKCAP_SLS_5_0GB)

Some older card 14e4:4359 (PCIe 1) has:
LNKCAP: 0x00176811 (hint: PCI_EXP_LNKCAP_SLS_2_5GB)

Wikipedia says 500 MB/s was added in PCIe 2.0.

Could I check for this bit to determine if I'm dealing PCIe 2.0 card?

-- 
Rafał
