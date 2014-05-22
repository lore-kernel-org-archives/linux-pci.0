Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:36592 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbaEVIUk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 May 2014 04:20:40 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 22 May 2014 18:20:38 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id A3E702CE8071
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2014 18:20:35 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s4M8KK7i3080596
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2014 18:20:20 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s4M8KYnB000942
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2014 18:20:35 +1000
Date: Thu, 22 May 2014 16:20:33 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, talal@mellanox.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	amirv@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>
Subject: Re: [PATCH v10 2/4] PCI: Change pbus_size_mem() return values to be
 more conventional
Message-ID: <20140522082033.GA13988@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140520034558.11972.74795.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140520034558.11972.74795.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 19, 2014 at 09:45:58PM -0600, Bjorn Helgaas wrote:
>pbus_size_mem() previously returned 0 for failure and 1 for success.
>Change it to return -ENOSPC for failure and 0 for success.
>
>No functional change.
>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>---
> drivers/pci/setup-bus.c |   35 +++++++++++++++++++++--------------
> 1 file changed, 21 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>index 589f2261ab0e..caa07fe6a23a 100644
>--- a/drivers/pci/setup-bus.c
>+++ b/drivers/pci/setup-bus.c
>@@ -915,6 +915,10 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
>  *
>  * Calculate the size of the bus and minimal alignment which
>  * guarantees that all child resources fit in this size.
>+ *
>+ * Returns -ENOSPC 0 if there's no available bus resource of the desired type.
                    ^^^
One small question, the 0 here means?


-- 
Richard Yang
Help you, Help me

