Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49590 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613AbbIUTmR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 21 Sep 2015 15:42:17 -0400
Date: Mon, 21 Sep 2015 22:42:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7] pci: quirk to skip msi disable on shutdown
Message-ID: <20150921223622-mutt-send-email-mst@redhat.com>
References: <1441553385-3810-1-git-send-email-mst@redhat.com>
 <20150921182147.GC27964@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150921182147.GC27964@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 21, 2015 at 01:21:47PM -0500, Bjorn Helgaas wrote:
> On Sun, Sep 06, 2015 at 06:32:35PM +0300, Michael S. Tsirkin wrote:
> > On some hypervisors, virtio devices tend to generate spurious interrupts
> > when switching between MSI and non-MSI mode.  Normally, either MSI or
> > non-MSI is used and all is well, but during shutdown, linux disables MSI
> > which then causes an "irq %d: nobody cared" message, with irq being
> > subsequently disabled.
> 
> My understanding is:
> 
>   Linux disables MSI/MSI-X during device shutdown.  If the device
>   signals an interrupt after that, it may use INTx.
> 
> This INTx interrupt is not necessarily spurious.  Using INTx to signal an
> interrupt that occurs when MSI is disabled seems like reasonable behavior
> for any PCI device.
> And it doesn't seem related to switching between MSI and non-MSI mode.
> Yes, the INTx happens *after* disabling MSI, but it is not at all
> *because* we disabled MSI.  So I wouldn't say "they generate spurious
> interrupts when switching between MSI and non-MSI."
> 
> Why doesn't virtio-pci just register an INTx handler in addition to an MSI
> handler?
> 
> Bjorn

The handler causes an expensive exit to the hypervisor,
and the INTx lines are shared with other devices.

Seems silly to slow them down just so we can do something
that triggers the device bug.  The bus master is disabled by that time,
if linux can just desist from touching MSI enable device won't
send either INTx (because MSI is on) or MSI
(because bus master is on) and all will be well.

-- 
MST
