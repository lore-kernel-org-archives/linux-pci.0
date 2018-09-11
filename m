Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40785 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeIKIc1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Sep 2018 04:32:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id c126-v6so15900850qkd.7
        for <linux-pci@vger.kernel.org>; Mon, 10 Sep 2018 20:35:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180907150515.GA28739@al>
References: <20180907053614.6540-1-drake@endlessm.com> <20180907150515.GA28739@al>
From: Daniel Drake <drake@endlessm.com>
Date: Tue, 11 Sep 2018 11:35:13 +0800
Message-ID: <CAD8Lp46eDaSF3fNQgYL=3vCXJ5VpV-JkYEu-YTtuh+w4rMU-5w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Reprogram bridge prefetch registers on resume
To: Peter Wu <peter@lekensteyn.nl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        nouveau@lists.freedesktop.org, Linux PM <linux-pm@vger.kernel.org>,
        kherbst@redhat.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Thomas Martitz <kugel@rockbox.org>, davem@davemloft.net,
        hkallweit1@gmail.com, netdev@vger.kernel.org, nic_swsd@realtek.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have created https://bugzilla.kernel.org/show_bug.cgi?id=201069 to
archive the research done so far.

On Fri, Sep 7, 2018 at 11:05 PM, Peter Wu <peter@lekensteyn.nl> wrote:
> Windows 10 unconditionally rewrites these registers (BAR, I/O Base +
> Limit, Memory Base + Limit, etc. from top to bottom), see annotations:
> https://www.spinics.net/lists/linux-pci/msg75856.html
>
> Linux has a generic "restore" operation that works backwards from the
> end of the PCI config space to the beginning, see
> pci_restore_config_space. Do you have a dmesg where you see the
> "restoring config space at offset" messages?

Interesting, I had not spotted this code. The logs for the affected
bridge on Asus X542UQ:

 0000:00:1c.0: restoring config space at offset 0x3c (was 0x100,
writing 0x1001ff)
 0000:00:1c.0: restoring config space at offset 0x24 (was 0x10001,
writing 0xe1f1d001)
 0000:00:1c.0: restoring config space at offset 0x20 (was 0x0, writing
0xef00ee00)
 0000:00:1c.0: restoring config space at offset 0xc (was 0x810000,
writing 0x810010)
 0000:00:1c.0: restoring config space at offset 0x4 (was 0x100007,
writing 0x100407)

So it didn't restore 0x28 (the magic register) and also register 0x2c
(prefetch limit upper 32 bits) because their values were already 0 on
resume.

https://bugzilla.kernel.org/show_bug.cgi?id=116851#c23 has an
assertion that Intel recognises this issue and calls for all those
registers to be restored on resume.

I propose for Linux 4.19 we apply a minimally intrusive change that
"forcibly" restores dword registers 0x24, 0x28 and 0x2c for PCI
bridges (regardless of their current value), while retaining the
existing restore order (high to low) over all registers and doing the
read-then-maybe-write thing for all of the other regs (per current
behaviour).


Then we also consider swiftly applying a followup patch implementing a
more thorough approach and we give it some time in linux-next before
releasing in Linux 4.20 which does something more thorough. I think
perhaps more discussion is needed there, or at least some more input
from Bjorn. Seems like we have 3 approaches to consider:

1. Peter Wu suggests following what windows does. Windows appears to
start with low registers and works its way upwards, which means it
writes BAR addresses, I/O base, etc, before writing prefetch
registers. It skips over read-only and write-to-clear registers and
also only writes some of the registers at the very end - like the
command register.

To be thorough here we would probably also have to study and copy what
Windows does for non-bridge devices (not sure how many device classes
we would want to study here?). Also it is a bit risky in that Bjorn
has pointed out that Linux's earlier approach with a high level of
similarity here (restore registers in ascending order, regardless of
their current value) caused a laptop to hang on resume.


2. Bjorn suggested tweaking the existing code to always write the
saved value even when the hardware has that same value. The
read-maybe-write logic was introduced to avoid a laptop hang, but at
that time we were restoring registers in ascending order, now we are
descending it might be worth giving this another try.


3. Do nothing else beyond the minimal change that I propose for v4.19?
Looking a bit more into git history this seems to be a sensitive and
problematic area, more changes might mean more trouble. For example
right now pci_restore_config_space() does:
        pci_restore_config_space_range(pdev, 10, 15, 0, 0);
        /* Restore BARs before the command register. */
        pci_restore_config_space_range(pdev, 4, 9, 10, 0);
        pci_restore_config_space_range(pdev, 0, 3, 0, 0);
but pci_restore_config_space_range() already goes in descending order,
so the above is already equivalent to the code in the "else" path that
follows:
        pci_restore_config_space_range(pdev, 0, 15, 0, 0);

and if you look at the history behind this "mixup" there's stuff that
goes back to 2012 like commit a6cb9ee7cabe ("PCI: Retry BARs
restoration for Type 0 headers only") which was fixing up another
problematic commit in this area, etc.

Daniel
