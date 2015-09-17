Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34244 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbbIQPiH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 11:38:07 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo5THoC1mC7OnKOvX04Bq27xvZmKmoY7v_QczCQTEG91gg@mail.gmail.com>
References: <1442440671-5361-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5THoC1mC7OnKOvX04Bq27xvZmKmoY7v_QczCQTEG91gg@mail.gmail.com>
Date: Thu, 17 Sep 2015 08:38:06 -0700
Message-ID: <CAE9FiQXvJM+Gc8Q4=n4-xN0kDXazLjpn0u8Lpc8ctmVotFLEEg@mail.gmail.com>
Subject: Re: [PATCH v5 00/53] PCI: Resource allocation cleanup for v4.4
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 17, 2015 at 7:55 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> I assume the following patches are related to the sparc64/mem64 thing.
> Could they be split out and posted separately?  We should be able to
> fix that issue even without all the other patches.
>
>>   sparc/PCI: Add mem64 resource parsing for root bus
>>   sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
>>   powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
>>   OF/PCI: Add IORESOURCE_MEM_64 for 64-bit resource

Yes, you are right.
