Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36802 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab3LJR2W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2013 12:28:22 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so9216877iej.28
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2013 09:28:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1386647973.32037.57.camel@pasglop>
References: <1386244373-35796-1-git-send-email-wangyijing@huawei.com>
 <20131210000154.GE4699@google.com> <1386647973.32037.57.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Dec 2013 10:28:01 -0700
Message-ID: <CAErSpo67ZB_GUrKpLbkfZs4qLe3S0eYy=oLTKg9=MSxZL2h+yw@mail.gmail.com>
Subject: Re: [PATCH 1/9] PCI: Use dev_is_pci() to check whether it is pci device
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	linux-parisc@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 9, 2013 at 8:59 PM, Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> On Mon, 2013-12-09 at 17:01 -0700, Bjorn Helgaas wrote:
>> [+cc arch lists]
>>
>> On Thu, Dec 05, 2013 at 07:52:53PM +0800, Yijing Wang wrote:
>> > Use dev_is_pci() instead of directly compare
>> > pci_bus_type to check whether it is pci device.
>> >
>> > Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>
>> I applied all these to my pci/yijing-dev_is_pci branch for v3.14, thanks!
>>
>> Browse them here: http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/yijing-dev_is_pci
>
> Ah ok. I also have the powerpc one in powerpc -next, no biggie though

I'll drop the powerpc one.
