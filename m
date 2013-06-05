Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1369489718-25869-7-git-send-email-jiang.liu@huawei.com>
References: <1369489718-25869-1-git-send-email-jiang.liu@huawei.com> <1369489718-25869-7-git-send-email-jiang.liu@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 5 Jun 2013 14:14:38 -0600
Message-ID: <CAErSpo4AFxSqUfxbw60B8XVk3XxtYfRcLyWDy=yPb0fURV=BQg@mail.gmail.com>
Subject: Re: [PATCH v3, part1 06/10] PCI: make PCI host bridge/bus creating
 and destroying logic symmetric
To: Jiang Liu <liuj97@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 25, 2013 at 7:48 AM, Jiang Liu <liuj97@gmail.com> wrote:
> This patch makes PCI host bridge/bus creating and destroying logic
> symmetric by using device_initialize()/device_add()/device_del()/put_device()
> pairs as discussed in thread at:
> http://comments.gmane.org/gmane.linux.kernel.pci/22073
>
> It also fixes a bug in error recovery path in pci_create_root_bus()
> which may kfree() an in-use host bridge object.

Can you split out the bug fix into a separate patch, in case it's
something we want to backport by itself?  I'd do it myself, but I
didn't understand at a glance what the problem was.

Bjorn
