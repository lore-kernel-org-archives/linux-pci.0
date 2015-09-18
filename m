Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54249 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753932AbbIRObu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 10:31:50 -0400
Date: Fri, 18 Sep 2015 10:31:49 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PCI / PM: Update runtime PM documentation for PCI devices
In-Reply-To: <2256432.RWZW2V6rYx@vostro.rjw.lan>
Message-ID: <Pine.LNX.4.44L0.1509181028130.1681-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 18 Sep 2015, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Section 3.2 "Device Runtime Power Management" of pci.txt has become
> outdated, so update it to correctly reflect the current code flow.
> 
> Also update the comment in local_pci_probe() to document the fact
> that pm_runtime_put_noidle() is not the only runtime PM helper
> function that can be used to decrement the device's runtime PM
> usage counter in .probe().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/power/pci.txt |   51 ++++++++++++++++++++++++++++++++------------
>  drivers/pci/pci-driver.c    |    7 +++---
>  2 files changed, 42 insertions(+), 16 deletions(-)
> 
> Index: linux-pm/Documentation/power/pci.txt
> ===================================================================
> --- linux-pm.orig/Documentation/power/pci.txt
> +++ linux-pm/Documentation/power/pci.txt
> @@ -979,20 +979,45 @@ every time right after the runtime_resum

...

> +It is important to remember that the driver's runtime_suspend() callback
> +may be executed right after the usage counter has been decremented, because
> +user space may already have cuased the pm_runtime_allow() helper function

s/cuased/caused/.  Otherwise,

Acked-by: Alan Stern <stern@rowland.harvard.edu>

