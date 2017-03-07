Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754576AbdCGEHX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Mar 2017 23:07:23 -0500
Date: Mon, 6 Mar 2017 18:24:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] pciehp: Fix race condition handling surprise link-down
Message-ID: <20170307002417.GA21358@bhelgaas-glaptop.roam.corp.google.com>
References: <1481317564-18045-1-git-send-email-ashok.raj@intel.com>
 <20170203025901.GA15080@bhelgaas-glaptop.roam.corp.google.com>
 <20170203060053.GA240323@otc-nc-03>
 <20170203165104.GC15080@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170203165104.GC15080@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 03, 2017 at 10:51:04AM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 02, 2017 at 10:00:53PM -0800, Raj, Ashok wrote:
> > ...
> > Just to summarize, we only queue the POWEROFF due to surprise link down
> > and another POWERON due to link becoming back up. The transient link-down 
> > events are coveniently ignored.
> 
> I'm leery about ignoring events, though it happens to be convenient in
> this case.  I think we're ignoring them because we're running work
> items simultaneously with other items, and I think that concurrency is
> unnecessary complexity.
> 
> I think it would be safer to queue every event and process every event
> serially.

Hi Ashok,

Just a ping to make sure we're not deadlocked.  I'm waiting for you,
so I hope you're not also waiting for me :)  I'm not trying to rush you;
I just don't want to drop this by mistake.

Bjorn
