Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731940AbeGSSZc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jul 2018 14:25:32 -0400
Date: Thu, 19 Jul 2018 12:41:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hari Vyas <hari.vyas@broadcom.com>
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com
Subject: Re: [PATCH v3] PCI: Data corruption happening due to race condition
Message-ID: <20180719174118.GM128988@bhelgaas-glaptop.roam.corp.google.com>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <1530608741-30664-2-git-send-email-hari.vyas@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530608741-30664-2-git-send-email-hari.vyas@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 03, 2018 at 02:35:41PM +0530, Hari Vyas wrote:
> When a pci device is detected, a variable is_added is set to
> 1 in pci device structure and proc, sys entries are created.
> 
> When a pci device is removed, first is_added is checked for one
> and then device is detached with clearing of proc and sys
> entries and at end, is_added is set to 0.
> 
> is_added and is_busmaster are bit fields in pci_dev structure
> sharing same memory location.
> 
> A strange issue was observed with multiple times removal and
> rescan of a pcie nvme device using sysfs commands where is_added
> flag was observed as zero instead of one while removing device
> and proc,sys entries are not cleared.  This causes issue in
> later device addition with warning message "proc_dir_entry"
> already registered.
> 
> Debugging revealed a race condition between pcie core driver
> enabling is_added bit(pci_bus_add_device()) and nvme driver
> reset work-queue enabling is_busmaster bit (by pci_set_master()).
> As both fields are not handled in atomic manner and that clears
> is_added bit.
> 
> Fix moves device addition is_added bit to separate private flag
> variable and use different atomic functions to set and retrieve
> device addition state. As is_added shares different memory
> location so race condition is avoided.

If/when you post a v4 of this, can you include the bugzilla URL
right here, i.e.,

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200283
> Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>

That way we can connect the commit with the bugzilla, which contains
more information that may be useful in the future.

Bjorn
