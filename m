Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:55329 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbeFYLP0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2018 07:15:26 -0400
Date: Mon, 25 Jun 2018 13:15:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hari Vyas <hari.vyas@broadcom.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH] PCI: Data corruption happening due to race condition
Message-ID: <20180625111525.GA30242@wunner.de>
References: <1529921446-20452-1-git-send-email-hari.vyas@broadcom.com>
 <20180625103742.GA20292@wunner.de>
 <3fa3c29e023abf67fa74d6e94a27645f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3fa3c29e023abf67fa74d6e94a27645f@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2018 at 04:27:37PM +0530, Hari Vyas wrote:
> 	This issue is happening  with multiple times device removal and
> rescan from sysfs. Card is not removed physically.
> 	Is_added bit is set after device attach which probe nvme driver.
> NVMe driver starts one workqueue and that one is calling pci_set_master()
> to set is_busmaster bit.
> 	With multiple times device removal and rescan from sysfs,  race
> condition is observed and is_added bit is over-written to 0 from workqueue
> started by NVMe driver.

Could you add a dump_stack() to pci_bus_add_device() and pci_stop_dev()
where the is_added bit is modified, reproduce the issue and attach the
resulting dmesg output to a newly opened bug on bugzilla.kernel.org?

Thanks,

Lukas
