Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:28717 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757049AbbJIQkG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 12:40:06 -0400
Message-ID: <1444407581.17726.7.camel@oracle.com>
Subject: Re: [PATCH v7 06/60] sparc/PCI: Keep resource idx order with bridge
 register number
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2015 10:19:41 -0600
In-Reply-To: <1444340359-8011-7-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-7-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
> On one system found strang "no compatible bridge window" warning
> 
> PCI: Claiming 0000:00:01.0: Resource 14: 0002000100000000..000200010fffffff [10220c]
> PCI: Claiming 0000:01:00.0: Resource 1: 0002000100000000..000200010000ffff [100214]
> pci 0000:01:00.0: can't claim BAR 1 [mem 0x2000100000000-0x200010000ffff 64bit]: no compatible bridge window
> 
> and we already had pref_compat support that add extra pref bit for device
> resource.
> 
> It turns out that pci_resource_compatible()/pci_up_path_over_pref_mem64()
> just check resource with bridge pref mmio register idx 15, and we have put
> resource to use mmio register idx 14 during of_scan_pci_bridge()
> as the bridge does not mmio resource.
> 
> We already fix pci_up_path_over_pref_mem64() to check all bus resources.
> 
> And at the same time, this patch will make resource to consistent sequence
> like other arch or directly from pci_read_bridge_bases(),
> even non-pref mmio is missing, or out of ordering in firmware reporting.
> 
> So hold i = 1 for non pref mmio, and i =2 for pref mmio.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com> 



