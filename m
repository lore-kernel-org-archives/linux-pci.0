Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:48606 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbaEVRAK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 May 2014 13:00:10 -0400
Received: by mail-ig0-f172.google.com with SMTP id uy17so7880804igb.5
        for <linux-pci@vger.kernel.org>; Thu, 22 May 2014 10:00:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140522082033.GA13988@richard>
References: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140520034558.11972.74795.stgit@bhelgaas-glaptop.roam.corp.google.com> <20140522082033.GA13988@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 22 May 2014 10:59:48 -0600
Message-ID: <CAErSpo5rA20EqgZ=R9EvDaKsVU4B4RSg069=cFQyY5R_mUQTBQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] PCI: Change pbus_size_mem() return values to be
 more conventional
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Yinghai Lu <yinghai@kernel.org>, talal@mellanox.com,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Amir Vadai <amirv@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>,
	Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 22, 2014 at 2:20 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Mon, May 19, 2014 at 09:45:58PM -0600, Bjorn Helgaas wrote:
>>pbus_size_mem() previously returned 0 for failure and 1 for success.
>>Change it to return -ENOSPC for failure and 0 for success.
>>
>>No functional change.
>>
>>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>---
>> drivers/pci/setup-bus.c |   35 +++++++++++++++++++++--------------
>> 1 file changed, 21 insertions(+), 14 deletions(-)
>>
>>diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>index 589f2261ab0e..caa07fe6a23a 100644
>>--- a/drivers/pci/setup-bus.c
>>+++ b/drivers/pci/setup-bus.c
>>@@ -915,6 +915,10 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
>>  *
>>  * Calculate the size of the bus and minimal alignment which
>>  * guarantees that all child resources fit in this size.
>>+ *
>>+ * Returns -ENOSPC 0 if there's no available bus resource of the desired type.
>                     ^^^
> One small question, the 0 here means?

Just a typo.  Fixed, thanks!
