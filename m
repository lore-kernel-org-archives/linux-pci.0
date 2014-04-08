Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:37792 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaDHIWu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 04:22:50 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Tue, 8 Apr 2014 13:52:48 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id D3B563940058
	for <linux-pci@vger.kernel.org>; Tue,  8 Apr 2014 13:52:46 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s388MqEe1048942
	for <linux-pci@vger.kernel.org>; Tue, 8 Apr 2014 13:52:52 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s388Miq8016510
	for <linux-pci@vger.kernel.org>; Tue, 8 Apr 2014 13:52:46 +0530
Date: Tue, 8 Apr 2014 16:22:40 +0800
From: Guo Chao <yan@linux.vnet.ibm.com>
To: Or Gerlitz <ogerlitz@mellanox.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>, talal@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
Message-ID: <20140408082240.GB3198@yanx>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
 <1394222924-28886-1-git-send-email-yinghai@kernel.org>
 <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
 <20140408025738.GA3198@yanx>
 <5343A2D8.20803@mellanox.com>
 <20140408074135.GA12126@richard>
 <5343AB8B.5070409@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5343AB8B.5070409@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 08, 2014 at 10:55:55AM +0300, Or Gerlitz wrote:
> On 08/04/2014 10:41, Wei Yang wrote:
> >>>So just to make sure we're on the same page -- fixing the bug is
> >>>carried out through netdev, e.g this 3.14-rc8
> >>>upstream commit 97a5221 "net/mlx4_core: pass
> >>>pci_device_id.driver_data to __mlx4_init_one during reset"
> >>>and now this one more fix which is under discussion
> >>>http://marc.info/?l=linux-pci&m=139675010015646&w=2, right?
> >No, this onehttp://marc.info/?l=linux-pci&m=139675010015646&w=2  is another
> >bug in mlx4 driver, missing a proper pci_dev_data in mlx4_init_one.
> >
> >The bug discussing in this thread is the driver "forget" to release the
> >"owner" during kexec. So this device couldn't be usded after kexec.
> >
> Can you guys please open a kernel.org bugzilla ticket, or better...
> work on a patch?
> 

It's already fixed in upstream.

commit 367d56f7b4d5ce61e883c64f81786c7a3ae88eea
Author: Gavin Shan <shangw@linux.vnet.ibm.com>
Date:   Tue Mar 4 15:35:20 2014 +0800

    net/mlx4: Support shutdown() interface


Thanks,
Guo Chao

