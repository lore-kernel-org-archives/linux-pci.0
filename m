Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40966 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab2DKECk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 00:02:40 -0400
Received: by lbbgm6 with SMTP id gm6so399921lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Apr 2012 21:02:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com>
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Apr 2012 22:02:18 -0600
Message-ID: <CAErSpo7zWEXBhC7+gaq+BCussyKOYORaBG-PBe4ERruCAA-cfQ@mail.gmail.com>
Subject: Re: [PATCH V4 0/6] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
To: Jiang Liu <liuj97@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 10, 2012 at 6:10 PM, Jiang Liu <liuj97@gmail.com> wrote:
> This patchset enhance pci_root driver to update MMCFG information when
> hot-plugging PCI root bridges. It applies to Yinghai's tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug
>
> The second patch is based on Taku Izumi work with some enhancements to
> correctly handle PCI host bridges without _CBA method.

I'm sorry I won't have time to really review these for a couple weeks.

It always seemed wrong to me that we parse MCFG and set things up
before we even look at PNP0A03/PNP0A08 devices.  It would make more
sense to me to have something in acpi_pci_root_add() to set up
MMCONFIG using _CBA if available, and falling back to parsing MCFG if
it's not.

Bjorn
