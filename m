Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53630 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885Ab2DZQQq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 12:16:46 -0400
Received: by pbbro12 with SMTP id ro12so2981961pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 09:16:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120426193953.b789bdb6.izumi.taku@jp.fujitsu.com>
References: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
	<20120426193953.b789bdb6.izumi.taku@jp.fujitsu.com>
Date: Thu, 26 Apr 2012 09:16:46 -0700
Message-ID: <CAE9FiQUF69Eyry6exi7W+K7uT5gCWfoMKM51ZX1Or-+KBaptYA@mail.gmail.com>
Subject: Re: [PATCH 1/6] PCI, x86: split out pci_mmcfg_check_reserved() for
 code reuse
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

On Thu, Apr 26, 2012 at 3:39 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
> Split out pci_mmcfg_check_reserved() for code reuse, which will be used
> when supporting PCI host bridge hotplug.
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>

Is the patch from You or Jiang?

Please put

From: Jiang Liu <jiang.liu@huawei.com>

at beginning if it is from Jiang.

Thanks

Yinghai
