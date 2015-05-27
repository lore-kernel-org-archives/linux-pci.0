Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150516152823.GK31666@google.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	<20150516152537.GJ31666@google.com>
	<20150516152823.GK31666@google.com>
Date: Wed, 27 May 2015 16:27:19 -0700
Message-ID: <CAE9FiQVeAJHv_T-O6g4zSTz19DP1LdyMo28tJX5zg4fmDuGxAw@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI/sparc: Fix booting with T5-8
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 16, 2015 at 8:28 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> BTW, if it makes sense to add pci_bus_addr_t first, without the other
> sparc64/prefetchability changes, that's fine with me.  But I think there
> were some doc and maybe Kconfig updates related to that, so please fold
> those in and repost it.

Good to me, will repost that.

Thanks

Yinghai
