Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 2 May 2012 14:48:15 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 04/19] PCI: serialize hotplug operations triggered by
 PCI hotplug sysfs interfaces
Message-ID: <20120502214815.GC27281@kroah.com>
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com>
 <1335539820-11232-5-git-send-email-jiang.liu@huawei.com>
 <20120502050625.GB23579@kroah.com>
 <4FA0E02F.5040901@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FA0E02F.5040901@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 02, 2012 at 03:20:15PM +0800, Jiang Liu wrote:
> On 2012-5-2 13:06, Greg KH wrote:
> >On Fri, Apr 27, 2012 at 11:16:45PM +0800, Jiang Liu wrote:
> >>+	/* Avoid deadlock with pci_hp_deregister() */
> >>+	while (!pci_hotplug_try_enter()) {
> >>+		/* Check whether the slot has been deregistered. */
> >>+		if (list_empty(&slot->slot_list)) {
> >>+			retval = -ENODEV;
> >>+			goto exit_put;
> >>+		}
> >>+		msleep(1);
> >>+	}
> >
> >Oh my.
> >
> >Wow.
> >
> >{sigh}
> >
> >ick.
> >
> >My eyes hurt.
> >
> >And your cpu load just went crazy.
> >
> >You can now handle all of the nasty emails from sysadmins asking why
> >their systems look like their load is high for no good reason.
> My bad, should use schedule_timeout_interruptible() instead of
> msleep(1) here to avoid busy waiting.

Um, no, that's not my main point here at all.

My main point is this type of loop is the wrong thing to do in the first
place.

Please redo this whole thing, as explained in my first email in this
thread.

greg k-h
