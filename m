Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35420 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbIQOzv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 10:55:51 -0400
Received: by wicge5 with SMTP id ge5so122533764wic.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2015 07:55:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1442440671-5361-1-git-send-email-yinghai@kernel.org>
References: <1442440671-5361-1-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 17 Sep 2015 09:55:30 -0500
Message-ID: <CAErSpo5THoC1mC7OnKOvX04Bq27xvZmKmoY7v_QczCQTEG91gg@mail.gmail.com>
Subject: Re: [PATCH v5 00/53] PCI: Resource allocation cleanup for v4.4
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 16, 2015 at 4:56 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Hi,
>
> After 5b28541552ef (PCI: Restrict 64-bit prefetchable bridge windows
> to 64-bit resources), we have several reports on resource allocation
> failure, and we try to fix the problem with resource clip, and get
> more problems.
>
> One is realloc fail with two graphics cards above 4G.
> One is from sparc that have problem with clip as we don't parse
> mem64 for it.

I assume the following patches are related to the sparc64/mem64 thing.
Could they be split out and posted separately?  We should be able to
fix that issue even without all the other patches.

>   sparc/PCI: Add mem64 resource parsing for root bus
>   sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
>   powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
>   OF/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
