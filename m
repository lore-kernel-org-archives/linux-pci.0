Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:32802 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756762Ab3DWReK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2013 13:34:10 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so673146iar.2
        for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2013 10:34:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51763847.8090808@cn.fujitsu.com>
References: <516FB647.5030203@cn.fujitsu.com>
	<CAErSpo65ARR_fZwsGCZDJqbPWktHYUkufgPt-2mWwur=nPR1Qg@mail.gmail.com>
	<51763847.8090808@cn.fujitsu.com>
Date: Tue, 23 Apr 2013 10:34:09 -0700
Message-ID: <CAE9FiQV3e7tiUwg5qtw0=1ncRykJ5Pkog2C9cYG3VkfkKAgZnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: Convert alloc_pci_dev(void) to
 pci_alloc_dev(bus) instead
From: Yinghai Lu <yinghai@kernel.org>
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	tangchen <tangchen@cn.fujitsu.com>,
	Lin Feng <linfeng@cn.fujitsu.com>,
	li guang <lig.fnst@cn.fujitsu.com>,
	Mike Qiu <qiudayu@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 23, 2013 at 12:29 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
> From b01e61759f894b651ed3bb39c9fc18e0b66d7cb3 Mon Sep 17 00:00:00 2001
> From: GuZheng <guz.fnst@cn.fujitsu.com>
> Date: Tue, 23 Apr 2013 14:01:39 +0800
> Subject: [PATCH v2 2/2] PCI: Convert alloc_pci_dev(void) to pci_alloc_dev(bus)
>  instead
>
> Use the new pci_alloc_dev(bus) to replace the existing using of alloc_pci_dev(void).
> And new functions pci_bus_get/put() are introdued to hide pci_bus' reference management.
>
> v2:
>   Follow Yinghai's suggestions to reduce pci_bus' ref when destroying pci device.
>   Add new functions pci_bus_get/put() to hide pci_bus' reference management.

You did not tell us if the remove test scripts works after put the line back.

If it does not work, what is the point of this patch?

Yinghai
