Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:50589 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757783AbbJIQVr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 12:21:47 -0400
Message-ID: <1444407689.17726.12.camel@oracle.com>
Subject: Re: [PATCH v7 13/60] PCI: Add has_mem64 for struct host_bridge
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2015 10:21:29 -0600
In-Reply-To: <1444340359-8011-14-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-14-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
> Add has_mem64 for struct host_bridge, on root bus that does not support
> mmio64 above 4g, will not set that.
> 
> We will use that info next two following patches:
> 1. Don't treat non-pref mmio64 as pref mmio, so will not put
>    it under bridge's pref range when rescan the devices
> 2. will keep pref mmio64 and pref mmio32 under bridge pref bar.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>


Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com> 


