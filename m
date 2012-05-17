Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37655 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966338Ab2EQPnO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2012 11:43:14 -0400
Received: by dady13 with SMTP id y13so2572548dad.19
        for <linux-pci@vger.kernel.org>; Thu, 17 May 2012 08:43:14 -0700 (PDT)
Message-ID: <4FB51C89.5080905@gmail.com>
Date: Thu, 17 May 2012 23:43:05 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: Vinod Koul <vinod.koul@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH v1 0/8] enhance dmaengine core to support DMA device hotplug
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>On Mon, Apr 23, 2012 at 6:51 AM, Jiang Liu <liuj97@xxxxxxxxx> wrote:
>> From: Jiang Liu <liuj97@xxxxxxxxx>
>>
>> This patchset tries to enhance the dmaengine and its clients to support
>> hot-removal of DMA devices at runtime, especially for IOAT devices.
>>
>> When hot-removing IOH (PCI host bridge) on Intel Nehalem/Westmere platform,
>> we need to remove all IOAT devices embedded in the IOH. For future Intel
>> processor with IIO (Embedded IOH), we need to remove IOAT devices even
>> when hot-removing a physical processor. But current dmaengine implementation
>> doesn't support hot-removal of IOAT devices at runtime.
>
>Removal of the host bridge means several devices disappear at once.
>Is it safe to assume that this action is coordinated by userspace?
>I.e. is the kernel given a chance to shut everything down and remove
>drivers, or is this a "surprise" unplug?

Hi Dan,
	Sorry for late reply! I just noticed this mail by browsing the linux-pci
mail list web archive just now.
	Yes, it will be coordinated by user/kernel hotplug manager. We don't 
plan to support surprisingly removal yet. It seems a little craze to support
that.
	Thanks!
	Gerry
