Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Aug 2015 19:03:05 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 22/51] PCI: Add alt_size allocation support
Message-ID: <20150818000305.GU26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
 <1438039809-24957-23-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438039809-24957-23-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 04:29:40PM -0700, Yinghai Lu wrote:
> On system with several pcie switches, BIOS allocate very tight resources
> to the bridge bar, and it is not aligned to min_align as kernel allocation
> code.

I can't parse this.

> For example:
> 	02:03.0---0c:00.0---0d:04.0---18:00.0
> 18:00.0 need 0x10000000, and 0x00010000.
> BIOS only allocate 0x10100000 to 0d:04.0 and above bridges.

Do you mean the BIOS only allocated 0x10010000?

> Later after using /sys/bus/pci/devices/0000:0c:00.0/remove to remove 0c:00.0,
> rescan with /sys/bus/pci/rescan can not allocate 0x18000000 to 0c:00.0.
> 
> another example:
> 00:1c.0-[02-21]----00.0-[03-21]--+-01.0-[04-12]----00.0-[05-12]----19.0-[06-12]----00.0
>                                  +-05.0-[13]--
>                                  +-07.0-[14-20]----00.0-[15-20]--+-08.0-[16]--+-00.0
>                                  |                               |            \-00.1
>                                  |                               +-14.0-[17]----00.0
>                                  |                               \-19.0-[18-20]----00.0
>                                  \-09.0-[21]--
> 06:00.0 need 0x4000000 and 0x800000.
> BIOS only allocate 0x4800000 to 05:19.0 and 04:00.0.
> when 05:19.0 get removed via /sys/bus/pci/devices/0000:05:19.0/remove,
> rescan with /sys/bus/pci/rescan will fail.
>  pci 0000:05:19.0: BAR 14: no space for [mem size 0x06000000]
>  pci 0000:05:19.0: BAR 14: failed to assign [mem size 0x06000000]
>  pci 0000:06:00.0: BAR 2: no space for [mem size 0x04000000 64bit]
>  pci 0000:06:00.0: BAR 2: failed to assign [mem size 0x04000000 64bit]
>  pci 0000:06:00.0: BAR 0: no space for [mem size 0x00800000]
>  pci 0000:06:00.0: BAR 0: failed to assign [mem size 0x00800000]
> current code try to use align 0x2000000 and size 0x6000000, but parent
> bridge only have 0x4800000.

I *think* you're saying:
  - BIOS assigned space for device X
  - We remove X via sysfs
  - We rescan via sysfs and discover X
  - We try to assign space for X
  - We fail because we don't use the same algorithm as BIOS did

If there is an optimal way to assign space for an arbitrary number of
BARs, we could just adopt it.  I don't know what that is, and I don't
know whether an optimal algorithm exists even in principle.

If there is no single optimal algorithm, there will always be cases where
we fail because we use a different algorithm than the firmware did.

> Introduce alt_align/alt_size and store them in realloc list in addition
> to addon info, and will try it after min_align/min_size allocation fails.

What does "alt" mean?

> The alt_align is max_align, and alt_size is aligned size with bridge
> minimum window alignment.
