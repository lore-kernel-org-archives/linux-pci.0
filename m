Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:41445 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755119AbeFYKho (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2018 06:37:44 -0400
Date: Mon, 25 Jun 2018 12:37:42 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hari Vyas <hari.vyas@broadcom.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        ray.jui@broadcom.com
Subject: Re: [PATCH] PCI: Data corruption happening due to race condition
Message-ID: <20180625103742.GA20292@wunner.de>
References: <1529921446-20452-1-git-send-email-hari.vyas@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529921446-20452-1-git-send-email-hari.vyas@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2018 at 03:40:46PM +0530, Hari Vyas wrote:
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
> and proc,sys entries are not cleared.

Where exactly was is_added incorrectly observed as 0?  Normally
addition and removal of devices are serialized using
pci_lock_rescan_remove(), maybe this is missing somewhere?

Thanks,

Lukas
