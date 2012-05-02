Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 May 2012 22:06:25 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 04/19] PCI: serialize hotplug operations triggered by
 PCI hotplug sysfs interfaces
Message-ID: <20120502050625.GB23579@kroah.com>
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com>
 <1335539820-11232-5-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335539820-11232-5-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2012 at 11:16:45PM +0800, Jiang Liu wrote:
> +	/* Avoid deadlock with pci_hp_deregister() */
> +	while (!pci_hotplug_try_enter()) {
> +		/* Check whether the slot has been deregistered. */
> +		if (list_empty(&slot->slot_list)) {
> +			retval = -ENODEV;
> +			goto exit_put;
> +		}
> +		msleep(1);
> +	}

Oh my.

Wow.

{sigh}

ick.

My eyes hurt.

And your cpu load just went crazy.

You can now handle all of the nasty emails from sysadmins asking why
their systems look like their load is high for no good reason.

Not to mention all of the other issues here.

My statement about not inventing new lock types has now been proven
true.

The fact that this would even be a chunk of code that was proposed to be
merged makes me weep.

You owe me a bottle of whatever you are drinking if you expect me to
continue to review these patch submissions.

I'm stopping here in the series, please rework this whole thing in a
major way.

greg k-h
