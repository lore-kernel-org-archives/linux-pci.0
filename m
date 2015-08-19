Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:36569 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbHSGcK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2015 02:32:10 -0400
MIME-Version: 1.0
In-Reply-To: <20150818041113.GW26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
	<1438039809-24957-28-git-send-email-yinghai@kernel.org>
	<20150818041113.GW26431@google.com>
Date: Tue, 18 Aug 2015 23:32:09 -0700
Message-ID: <CAE9FiQXm6Xnf2Yf-h6D8o9o963zGyFG7vtrAsm5Qkfo=eOU7NQ@mail.gmail.com>
Subject: Re: [PATCH v3 27/51] PCI: Move ISA ioport align out of calculate_iosize
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 17, 2015 at 9:11 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 27, 2015 at 04:29:45PM -0700, Yinghai Lu wrote:
>> So we could unify calculate_iosize and calculate_memsize later.
>
> Please make this a complete sentence, not just a continuation of the
> summary line.
>
>> when one bridge have several children devices, and every devices
>> have several io port resources and resource size < 0x400.
>
> This isn't a sentence either, so I'm not sure what this is supposed to
> mean.

will change to:

Subject: [PATCH] PCI: Move ISA io port align out of calculate_iosize()

We can move ISA io port align out of calculate_iosize(),
so we could unify calculate_iosize and calculate_memsize later.

That extra aligning or offset is to work around ISA devices:
When one bridge have several children devices, and every device
has several io port resources and resource size < 0x400.
We need to check size, and add extra size to make sure bit8/9
to be zero.
