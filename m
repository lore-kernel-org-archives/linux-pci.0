Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46935 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab2EBXnd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 May 2012 19:43:33 -0400
Received: by lbbgm6 with SMTP id gm6so868520lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 02 May 2012 16:43:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
References: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 2 May 2012 17:43:11 -0600
Message-ID: <CAErSpo66t5K_9jHB_e0pk+sxBXBd4px--fc=8AXkMiDou5rrEg@mail.gmail.com>
Subject: Re: [PATCH 0/6][RFC] pci, x86: change the way to add MMCFG region on x86
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: liuj97@gmail.com, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, ddutile@redhat.com,
	greg.pearson@hp.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 26, 2012 at 4:37 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
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

I can't keep track of what's going on here, with you and Gerry posting
the same patches.  You can post additional patches that apply on top
of Gerry's, or work with Gerry to get your changes incorporated in his
patches.  But it's too hard to sort out the combination with different
versions of the same thing coming from both of you.

Bjorn
