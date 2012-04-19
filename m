Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:47507 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2DSHH3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Apr 2012 03:07:29 -0400
Received: from huawei.com (szxga05-in [172.24.2.49])
 by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M2P000MQT0J17@szxga05-in.huawei.com> for
 linux-pci@vger.kernel.org; Thu, 19 Apr 2012 15:05:07 +0800 (CST)
Received: from szxrg02-dlp.huawei.com ([172.24.2.119])
 by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M2P00D08SYXKN@szxga05-in.huawei.com> for
 linux-pci@vger.kernel.org; Thu, 19 Apr 2012 15:05:07 +0800 (CST)
Date: Thu, 19 Apr 2012 15:04:49 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH V4 6/6] PCI, ACPI,
 x86: update MMCFG information when hot-plugging PCI host bridges
In-reply-to: <20120419154921.64583b35.izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Message-id: <4F8FB911.1090002@huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com>
 <1334103063-2283-7-git-send-email-jiang.liu@huawei.com>
 <20120418154725.92833e4d.izumi.taku@jp.fujitsu.com>
 <4F8E7227.1050707@huawei.com>
 <20120419154921.64583b35.izumi.taku@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Taku,
	You are right. acpi_pci_root.mmconf_added is used to track
whether MMCFG info is added by pci_mmconfig_insert(), and
arch_acpi_pci_root_remove() will only delete MMCFG info added by
pci_mmconfig_insert().
	gerry

On 2012-4-19 14:49, Taku Izumi wrote:
>
> Hi Jiang,
>     Thanks, and I have another question.
>
>      What does "acpi_pci_root.mmconf_added" indicate ?
>      In case of non-hotpluggable hostbridges, that is, when MMCONF
>      is described using MCFG table, acpi_pci_root.mmconf_added is always 0.
>      Is "acpi_pci_root.mmconf_added" only for hotpluggable hostbridges ?
>


