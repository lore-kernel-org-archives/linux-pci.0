Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120208050119.GE8930@ram-ThinkPad-T61>
References: <1328424908-6385-1-git-send-email-yinghai@kernel.org>
	<1328424908-6385-5-git-send-email-yinghai@kernel.org>
	<20120208043517.GD8930@ram-ThinkPad-T61>
	<CAE9FiQUdRLmc-_hHWtaz=8QZiu4Ma6ZY7zavByJnwMDTBQLtzg@mail.gmail.com>
	<20120208050119.GE8930@ram-ThinkPad-T61>
Date: Tue, 7 Feb 2012 22:11:22 -0800
Message-ID: <CAE9FiQUYg8V8RSeh+xiWYxEfSxwEhp9KRXAjVkyhT94Enkqc3Q@mail.gmail.com>
Subject: Re: [PATCH 4/9] PCI: Fix cardbus bridge resources as optional size handling
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 7, 2012 at 9:01 PM, Ram Pai <linuxram@us.ibm.com> wrote:
>
> ..snip..
>>        * If we have prefetchable memory support, allocate
>>        * two regions.  Otherwise, allocate one region of
>>        * twice the size.
>>        */
>>       if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0) {
>>               b_res[2].start = pci_cardbus_mem_size;
>>               b_res[2].end = b_res[2].start + pci_cardbus_mem_size - 1;
>>               b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH |
>>                                 IORESOURCE_STARTALIGN;
>>               if (realloc_head) {
>>                       b_res[2].end -= pci_cardbus_mem_size;
>>                       add_to_list(realloc_head, bridge, b_res+2,
>>                                pci_cardbus_mem_size, pci_cardbus_mem_size);
>>               }
>>
>>               /* reduce that to half */
>>               b_res_3_size = pci_cardbus_mem_size;
>>       }
>
> ACK. Ok. got it. This looks correct.

Good, So we have

Acked-by: Ram Pai <linuxram@us.ibm.com>
Tested-by: Dominik Brodowski <linux@dominikbrodowski.net>

Hope Jesse will not miss to add them

Thanks

Yinghai
