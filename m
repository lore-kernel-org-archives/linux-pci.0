Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57677 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757318Ab2EGSkz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 14:40:55 -0400
Received: by pbbrp8 with SMTP id rp8so7014394pbb.19
        for <linux-pci@vger.kernel.org>; Mon, 07 May 2012 11:40:55 -0700 (PDT)
Date: Mon, 7 May 2012 11:40:50 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Jiang Liu <liuj97@gmail.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 10/19] PCI: serialize hotplug operaitons triggered by
 the shpchp driver
Message-ID: <20120507184050.GC725@kroah.com>
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com>
 <1335539820-11232-11-git-send-email-jiang.liu@huawei.com>
 <4FA4F3E5.5040600@fold.natur.cuni.cz>
 <4FA5EF97.8010306@gmail.com>
 <20120506152036.GA31551@kroah.com>
 <4FA7D882.3070903@gmail.com>
 <4FA7D839.9090109@fold.natur.cuni.cz>
 <4FA7D894.3040700@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FA7D894.3040700@fold.natur.cuni.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 07, 2012 at 04:13:40PM +0200, Martin Mokrejs wrote:
> Martin Mokrejs wrote:
> > Hi Greg and Jiang,
> >   I am confirming this issue still happens for me with my changed motherboard and express card slot
> > of my Dell Vostro 3550 laptop. :( I trigger this when unplugging a FireWire express card. Not always
> > but does happen. attached is a camera picture of the Oops.
> > 
> > 
> > wq_worker_sleeping
> > __schedule
> > schedule
> > do_exit
> > oops_end
> > no_context
> > __bad_area_nosemaphore
> > ? put_dec
> > bad_area_nosemaphore
> > do_page_fault
> > ? pointer.clone
> > ? vsnprintf
> > page_fault
> > ? sysfs_name_hash
> > sysfs_find_dirent
> > sysfs_hash_and_remove
> > sysfs_remove_bin_file
> > pci_remove_resource_files

Bjorn, the resource stuff changed recently, while pci hotplug didn't
change at all.  Are we trying to remove files that aren't really there
anymore?

Or could we be removing the same file twice?

thanks,

greg k-h
