Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34401 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897AbbIUSVw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2015 14:21:52 -0400
Received: by igcpb10 with SMTP id pb10so84728938igc.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2015 11:21:51 -0700 (PDT)
Date: Mon, 21 Sep 2015 13:21:47 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7] pci: quirk to skip msi disable on shutdown
Message-ID: <20150921182147.GC27964@google.com>
References: <1441553385-3810-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441553385-3810-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 06, 2015 at 06:32:35PM +0300, Michael S. Tsirkin wrote:
> On some hypervisors, virtio devices tend to generate spurious interrupts
> when switching between MSI and non-MSI mode.  Normally, either MSI or
> non-MSI is used and all is well, but during shutdown, linux disables MSI
> which then causes an "irq %d: nobody cared" message, with irq being
> subsequently disabled.

My understanding is:

  Linux disables MSI/MSI-X during device shutdown.  If the device
  signals an interrupt after that, it may use INTx.

This INTx interrupt is not necessarily spurious.  Using INTx to signal an
interrupt that occurs when MSI is disabled seems like reasonable behavior
for any PCI device.

And it doesn't seem related to switching between MSI and non-MSI mode.
Yes, the INTx happens *after* disabling MSI, but it is not at all
*because* we disabled MSI.  So I wouldn't say "they generate spurious
interrupts when switching between MSI and non-MSI."

Why doesn't virtio-pci just register an INTx handler in addition to an MSI
handler?

Bjorn
