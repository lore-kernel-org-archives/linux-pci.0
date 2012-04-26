Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46409 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758387Ab2DZQVx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 12:21:53 -0400
Received: by pbbro12 with SMTP id ro12so2987147pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 09:21:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
References: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
Date: Thu, 26 Apr 2012 09:21:52 -0700
Message-ID: <CAE9FiQWrOkwUTRENNsg1Q5aS6MmL3d3qTaO8UtRmBsbh8uXTBA@mail.gmail.com>
Subject: Re: [PATCH 0/6][RFC] pci, x86: change the way to add MMCFG region on x86
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: liuj97@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Keping Chen <chenkeping@huawei.com>, ddutile@redhat.com,
	greg.pearson@hp.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 26, 2012 at 3:37 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
>  This patchset is based on the following Jiang Liu's patchset:
>   http://marc.info/?l=linux-pci&m=133410334617298&w=2
>
>  This changes the way to add MMCFG region on x86.
>  MMCFG region information provided by ACPI MCFG table
>  or _CBA method will be added at acpi_pci_root_add()
>  of pci_root driver.
>
>  patch1-4 is exactly same as Liu's.
>
>  *[PATCH 1/6] PCI, x86: split out pci_mmcfg_check_reserved() for code reuse
>  *[PATCH 2/6] PCI, x86: split out pci_mmconfig_alloc() for code reuse
>  *[PATCH 3/6] PCI, x86: use RCU list to protect mmconfig list
>  *[PATCH 4/6] PCI, x86: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
>  *[PATCH 5/6] PCI, x86: introduce pci_mmcongi_add() / pci_mmconfig_delete()
>  *[PATCH 6/6] PCI, x86: change the way to add MMCFG region on x86

what happened ?

Jiang's V4 should be good enough.  I have used them in my local tree
for a while.

Please consider to post addon patches for that patchset if you have
other corner case that is not handled.

Thanks

Yinghai Lu
