Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FBCC10F0B
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 08:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB492084C
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 08:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDBIdA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:33:00 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:59451 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDBIdA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 04:33:00 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4593030000CDB;
        Tue,  2 Apr 2019 10:32:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 20D951D287; Tue,  2 Apr 2019 10:32:57 +0200 (CEST)
Date:   Tue, 2 Apr 2019 10:32:57 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Lockdep warning in pciehp (v5.0-based kernel)
Message-ID: <20190402083257.kyqmirq4ovzscxsv@wunner.de>
References: <20190402021933.GA2966@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402021933.GA2966@mit.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 01, 2019 at 10:19:33PM -0400, Theodore Ts'o wrote:
> Hi, I got the following lockdep warning while booting a Dell XPS13.
> Is this a known issue?

No, it's not a known issue.  I just double-checked the code.
It looks fine to me, so this appears to be a false positive.

Your machine has a JHL6540 Thunderbolt controller built-in (Alpine Ridge,
C-step) and you've attached a device with a DSL6540 Thunderbolt controller
(Alpine Ridge).  Whenever you chain Thunderbolt devices together you get
cascaded PCIe hotplug ports.  Each pciehp controller struct has a
reset_lock.

The lockdep splat happens when the upstream pciehp controller's IRQ thread
handles a hotplug event (upon discovering the attached device on boot).
It's holding the upstream controller's reset_lock while handling the event
to prevent the user from concurrently initiating a reset via sysfs.

Upon enumerating the downstream pciehp controller, its probe routine
acquire's that second controller's reset_lock for the same reason.

So these are different locks and in addition they're of type rw_semaphore
and both the IRQ thread and the probe routine only acquire the locks for
reading, hence wouldn't block each other even if it was the same lock.

Not really being familiar with the intricacies of lockdep, I'm wondering
if it's just not smart enough to recognize that these are different locks?
And why is it not recognizing that both functions only acquire the locks
for reading?  How can the code be annotated to avoid the false positive?

The only other explanation I can think of is that 5.0.0-00034-gcaae0ec7396f
is not a plain-vanilla 5.0 kernel and contains Google-specific additions
to the pciehp code which might cause the lockdep splat.

HTH,

Lukas

> [   13.836367] pciehp 0000:3b:04.0:pcie204: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
> 
> [   13.837149] ============================================
> [   13.837149] WARNING: possible recursive locking detected
> [   13.837150] 5.0.0-00034-gcaae0ec7396f #54 Not tainted
> [   13.837151] --------------------------------------------
> [   13.837152] irq/125-pciehp/165 is trying to acquire lock:
> [   13.837153] 000000000f8f89cc (&ctrl->reset_lock){.+.+}, at: pciehp_check_presence+0x1b/0x72
> [   13.837159] 
>                but task is already holding lock:
> [   13.837160] 000000001b052053 (&ctrl->reset_lock){.+.+}, at: pciehp_ist+0x10a/0x164
> [   13.837162] 
>                other info that might help us debug this:
> [   13.837162]  Possible unsafe locking scenario:
> 
> [   13.837163]        CPU0
> [   13.837163]        ----
> [   13.837164]   lock(&ctrl->reset_lock);
> [   13.837164]   lock(&ctrl->reset_lock);
> [   13.837165] 
>                 *** DEADLOCK ***
> 
> [   13.837165]  May be due to missing lock nesting notation
> 
> [   13.837166] 4 locks held by irq/125-pciehp/165:
> [   13.837167]  #0: 000000001b052053 (&ctrl->reset_lock){.+.+}, at: pciehp_ist+0x10a/0x164
> [   13.837169]  #1: 0000000087e07843 (pci_rescan_remove_lock){+.+.}, at: pciehp_configure_device+0x1e/0xfd
> [   13.837171]  #2: 00000000e9b570d4 (&dev->mutex){....}, at: __device_attach+0x28/0x12d
> [   13.837174]  #3: 000000004add66ea (&dev->mutex){....}, at: __device_attach+0x28/0x12d
> [   13.837176] 
>                stack backtrace:
> [   13.837178] CPU: 7 PID: 165 Comm: irq/125-pciehp Not tainted 5.0.0-00034-gcaae0ec7396f #54
> [   13.837178] Hardware name: Dell Inc. XPS 13 9380/0KTW76, BIOS 1.2.1 02/14/2019
> [   13.837179] Call Trace:
> [   13.837183]  dump_stack+0x67/0x8e
> [   13.837186]  __lock_acquire+0x9b2/0xddc
> [   13.837189]  ? pci_hp_add+0x18a/0x1ee
> [   13.837190]  ? pci_hp_add+0x18a/0x1ee
> [   13.837192]  ? find_held_lock+0x2b/0x6e
> [   13.837194]  lock_acquire+0x147/0x172
> [   13.837196]  ? pciehp_check_presence+0x1b/0x72
> [   13.837199]  down_read+0x44/0x87
> [   13.837201]  ? pciehp_check_presence+0x1b/0x72
> [   13.837203]  pciehp_check_presence+0x1b/0x72
> [   13.837205]  pciehp_probe+0x229/0x24d
> [   13.837207]  pcie_port_probe_service+0x38/0x4b
> [   13.837209]  really_probe+0x1a5/0x372
> [   13.837210]  ? driver_allows_async_probing+0x2c/0x2c
> [   13.837211]  driver_probe_device+0xcf/0xff
> [   13.837213]  ? driver_allows_async_probing+0x2c/0x2c
> [   13.837215]  bus_for_each_drv+0x84/0xa8
> [   13.837217]  __device_attach+0x9d/0x12d
> [   13.837219]  bus_probe_device+0x31/0x9e
> [   13.837221]  device_add+0x1c1/0x5bd
> [   13.837223]  ? __init_waitqueue_head+0x36/0x47
> [   13.837225]  pcie_port_device_register+0x3b9/0x41e
> [   13.837228]  ? irq_thread_check_affinity+0x7b/0x7b
> [   13.837230]  pcie_portdrv_probe+0x37/0xa4
> [   13.837232]  pci_device_probe+0xbe/0x130
> [   13.837234]  really_probe+0x1a5/0x372
> [   13.837236]  ? driver_allows_async_probing+0x2c/0x2c
> [   13.837237]  ? irq_thread+0x82/0x193
> [   13.837238]  driver_probe_device+0xcf/0xff
> [   13.837239]  ? driver_allows_async_probing+0x2c/0x2c
> [   13.837241]  bus_for_each_drv+0x84/0xa8
> [   13.837242]  __device_attach+0x9d/0x12d
> [   13.837245]  pci_bus_add_device+0x4a/0x83
> [   13.837247]  pci_bus_add_devices+0x2c/0x5d
> [   13.837248]  pci_bus_add_devices+0x53/0x5d
> [   13.837250]  pciehp_configure_device+0xef/0xfd
> [   13.837253]  pciehp_handle_presence_or_link_change+0x28d/0x37b
> [   13.837254]  pciehhp_ist+0x12c/0x164
> [   13.837256]  ? irq_finalize_oneshot+0x9e/0x9e
> [   13.837257]  irq_thread_fn+0x1e/0x41
> [   13.837259]  irq_thread+0x138/0x193
> [   13.837261]  ? wake_threads_waitq+0x27/0x27
> [   13.837263]  ? irq_thread_check_affinity+0x7b/0x7b
> [   13.837265]  kthread+0xf7/0xfc
> [   13.837266]  ? kthread_cancel_delayed_work_sync+0xf/0xf
> [   13.837269]  ret_from_fork+0x3a/0x50
> [   13.837321] ------------[ cut here ]------------
