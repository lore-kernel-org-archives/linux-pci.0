Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:51021 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeGCJNa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2018 05:13:30 -0400
Date: Tue, 3 Jul 2018 11:13:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hari Vyas <hari.vyas@broadcom.com>
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com
Subject: Re: [PATCH v3] PCI: Data corruption happening due to race condition
Message-ID: <20180703091329.GA7561@wunner.de>
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
> 
> Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
