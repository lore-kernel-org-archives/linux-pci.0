Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61988 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab2DLNMW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2012 09:12:22 -0400
Received: by iagz16 with SMTP id z16so2787396iag.19
        for <linux-pci@vger.kernel.org>; Thu, 12 Apr 2012 06:12:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F866184.4000403@jp.fujitsu.com>
References: <4F79584B.2010301@jp.fujitsu.com> <CAErSpo4Yy9d93gNzDadFxSN+41NkEKBz4yai9KzB1aaCP3pwWw@mail.gmail.com>
 <4F7AA3A2.1080900@jp.fujitsu.com> <4F7C003B.4040208@jp.fujitsu.com> <4F866184.4000403@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 12 Apr 2012 07:12:01 -0600
Message-ID: <CAErSpo6Xb6rbZ757VHuQnWWsXbnygTM9JQFzvOnOiM895D+R-g@mail.gmail.com>
Subject: Re: [RFC] pciehp: Add archdata setting
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 11, 2012 at 11:00 PM, Hiroo Matsumoto
<matsumoto.hiroo@jp.fujitsu.com> wrote:
> Hi, Kaneshige
>
>
> You are right!
> Setting dma_ops in pcibios_enable_device is a nice way.
> In PCI driver, pci_enable_device_xxx that calls pcibios_enable_device is
> called before checking archdata.dma_ops.
>
> I added code of checking and setting dma_ops to pcibios_enable_device in
> arch/powerpc/kernel/pci-common.c.
> It works good.

When I researched this, I thought the best route was to use the
bus_register_notifier() path, as amd_iommu_init_notifier() does.

We're filling in a struct device field, not a PCI field, and
bus_register_notifier() seems like a more generic path than relying on
pcibios_enable_device().

Bjorn
