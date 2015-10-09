Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:50029 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933562AbbJIQVN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 12:21:13 -0400
Message-ID: <1444407651.17726.10.camel@oracle.com>
Subject: Re: [PATCH v7 11/60] PCI: Check pref compatible bit for mem64
 resource of PCIe device
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2015 10:20:51 -0600
In-Reply-To: <1444340359-8011-12-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-12-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
> We still get "no compatible bridge window" warning on sparc T5-8
> after we add support for 64bit resource parsing for root bus.
> 
>  PCI: scan_bus[/pci@300/pci@1/pci@0/pci@6] bus no 8
>  PCI: Claiming 0000:00:01.0: Resource 15: 0000800100000000..00008004afffffff [220c]
>  PCI: Claiming 0000:01:00.0: Resource 15: 0000800100000000..00008004afffffff [220c]
>  PCI: Claiming 0000:02:04.0: Resource 15: 0000800100000000..000080012fffffff [220c]
>  PCI: Claiming 0000:03:00.0: Resource 15: 0000800100000000..000080012fffffff [220c]
>  PCI: Claiming 0000:04:06.0: Resource 14: 0000800100000000..000080010fffffff [220c]
>  PCI: Claiming 0000:05:00.0: Resource 0: 0000800100000000..0000800100001fff [204]
>  pci 0000:05:00.0: can't claim BAR 0 [mem 0x800100000000-0x800100001fff]: no compatible bridge window
> 
> All the bridges 64-bit resource have pref bit, but the device resource does not
> have pref set, then we can not find parent for the device resource,
> as we can not put non-pref mem under pref mem.
> 
> According to pcie spec errta
> https://www.pcisig.com/specifications/pciexpress/base2/PCIe_Base_r2.1_Errata_08Jun10.pdf
> page 13, in some case it is ok to mark some as pref.
> 
> Mark if the entire path from the host to the adapter is over PCI Express.
> Then set pref compatible bit for claim/sizing/assign for 64bit mem resource
> on that pcie device.
> 
> -v2: set pref for mmio 64 when whole path is PCI Express, according to David Miller.
> -v3: don't set pref directly, change to UNDER_PREF, and set PREF before
>      sizing and assign resource, and cleart PREF afterwards. requested by BenH.
> -v4: use on_all_pcie_path device flag instead.
> 
> Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
> Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
> Reported-by: David Ahern <david.ahern@oracle.com>
> Tested-by: David Ahern <david.ahern@oracle.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
> Tested-by: TJ <linux@iam.tj>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com> 




