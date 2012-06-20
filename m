Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:12743 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322Ab2FTIeR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 04:34:17 -0400
Message-ID: <4FE18A9B.9040501@huawei.com>
Date: Wed, 20 Jun 2012 16:32:27 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH v8 06/12] PCI/ACPI: provide MCFG address for PCI host
 bridges
References: <1340111732-6276-1-git-send-email-jiang.liu@huawei.com> <1340111732-6276-7-git-send-email-jiang.liu@huawei.com> <CAE9FiQWAPb7S9kBrebnf6nn2KmCL2ohUbukycJPGQLB=11+_pA@mail.gmail.com>
In-Reply-To: <CAE9FiQWAPb7S9kBrebnf6nn2KmCL2ohUbukycJPGQLB=11+_pA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,
> thought you were agreeing to go through choice 2 without caching MCFG anymore.
> 
> Can you just drop that caching MCFG and only handle _CBA here?
> 
> Thanks
> 
> Yinghai

	Yes, I'm going to adopt solution two as you suggested. 
On the other hand, the MMCFG caching is kept due to following
considerations:
1) To emit a warning message if MMCFG entries in MCFG table only
partially covers buses under a PCI host bridge. Taku reported that
he has a system which exhibits such a behavior.
2) To cross-check that MMCFG addresses returned by MCFG table and 
_CBA method are consistent if both are available (though that 
violates the PCI FW/ACPI specifications).
3) In future, we may try to remove MMCFG entry constructed from
MCFG table when hot-removing a PCI host bridge. We have some systems
which assign a distinguish segment ID for each host bridge. In such
a case, it may be reasonable to remove the MMCFG entry when removing
a host bridge.
4) The MCFG cache should be small under normal cases.

	If you feel it's unnecessary to keep the cache, I will remove
it and send out a updated version soon.
	Thanks!
	Gerry

