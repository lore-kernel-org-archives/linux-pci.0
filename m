Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:32856 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbHSGhj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2015 02:37:39 -0400
MIME-Version: 1.0
In-Reply-To: <20150818041300.GX26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
	<1438039809-24957-29-git-send-email-yinghai@kernel.org>
	<20150818041300.GX26431@google.com>
Date: Tue, 18 Aug 2015 23:37:38 -0700
Message-ID: <CAE9FiQVXxuGR_QMwB-irnCR04NSRAw0AWSOszvsHAnnsc_iDEw@mail.gmail.com>
Subject: Re: [PATCH v3 28/51] PCI: Unifiy calculate_size for io port and mmio
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

On Mon, Aug 17, 2015 at 9:13 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 27, 2015 at 04:29:46PM -0700, Yinghai Lu wrote:
>> We should check size+size1 with min_size for io port.
>> For example, when hotplug bridge has two children bridges,
>> every child bridge will need 0x1000, so size1 will be 0x2000
>> and size is 0. The min_size for the hotplug bridge is 0x100.
>
> A min_size of 0x100?  Is that a typo?

yes, it is 0x100.

#define DEFAULT_HOTPLUG_IO_SIZE         (256)
/* pci=hpmemsize=nnM,hpiosize=nn can override this */
unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;

and we have

                if (bus->self->is_hotplug_bridge) {
                        min_io_size  = pci_hotplug_io_size;

>
>> with old version calculate_iosize, we get 0x3000 for final
>> size because we are using size to compare with min_size. That is
>> not right, we should use 0x2000 instead.
>
> If this fixes a bug, please make one patch that *only* fixes the bug,
> and a separate one that unifies but doesn't change the behavior.

ok, will separate it into two.
