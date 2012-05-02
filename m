Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 May 2012 22:10:27 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 06/19] PCI: prepare for serializing hotplug operations
 triggered by pciehp driver
Message-ID: <20120502051027.GD23579@kroah.com>
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com>
 <1335539820-11232-7-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335539820-11232-7-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2012 at 11:16:47PM +0800, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> Split pciehp_wq into two workqueues to avoid possible deadlock issues
> when using PCI hotplug lock to serialize hotplug operations triggered
> by pciehp driver.

Why two workqueues?  What is deadlocking?  And why name one "power" and
one "event"?  What do they now do differently?  How are you serializing
events across the workqueues as they can be doing the same thing at the
same time to the same hardware now, right?

What am I missing?

Ick, I said I wasn't going to read anymore, I'm really stopping now.
Sorry, it's like watching a train-wreck, you just can't turn away...

greg k-h
