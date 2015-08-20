Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:56389 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbbHTSkp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2015 14:40:45 -0400
Date: Thu, 20 Aug 2015 11:40:42 -0700 (PDT)
Message-Id: <20150820.114042.1327127338658980319.davem@davemloft.net>
To: bhelgaas@google.com
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org, mroos@linux.ee,
	sparclinux@vger.kernel.org, eric.snowberg@oracle.com,
	benh@kernel.crashing.org
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAErSpo5SApFYWOs8Q2ZH2vpnEW6jY0XWAgeiyhMk4aCNtON46w@mail.gmail.com>
References: <20150820054800.GB10267@google.com>
	<20150820.104728.699050706854625548.davem@davemloft.net>
	<CAErSpo5SApFYWOs8Q2ZH2vpnEW6jY0XWAgeiyhMk4aCNtON46w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Aug 2015 11:23:43 -0700

> On Thu, Aug 20, 2015 at 10:47 AM, David Miller <davem@davemloft.net> wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>> Date: Thu, 20 Aug 2015 00:48:00 -0500
>>
>>> [+cc Dave, Eric, Ben, sparclinux]
>>
>> I think the comment is terrible.
> 
> I'll update the comment if you suggest some text.  Do you object
> mainly to the mention of the specific systems?

"PCI root complex can not be assumed to be instantiated in the PCI bus
 hierarchy."
 
