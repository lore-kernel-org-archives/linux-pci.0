Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17202 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757839AbbJIQWH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 12:22:07 -0400
Message-ID: <1444407704.17726.13.camel@oracle.com>
Subject: Re: [PATCH v7 14/60] PCI: Only treat non-pref mmio64 as pref if
 host bridge has mmio64
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2015 10:21:44 -0600
In-Reply-To: <1444340359-8011-15-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-15-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
> If host bridge does not have mmio64 above 4G, We don't need to
> treat device non-pref mmio64 as as pref mmio64.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com> 



