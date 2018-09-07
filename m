Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:57727 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbeIGTql (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Sep 2018 15:46:41 -0400
Date: Fri, 7 Sep 2018 17:05:15 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Daniel Drake <drake@endlessm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, linux-pm@vger.kernel.org,
        kherbst@redhat.com, andriy.shevchenko@linux.intel.com,
        rafael.j.wysocki@intel.com, keith.busch@intel.com,
        mika.westerberg@linux.intel.com, jonathan.derrick@intel.com,
        kugel@rockbox.org, davem@davemloft.net, hkallweit1@gmail.com,
        netdev@vger.kernel.org, nic_swsd@realtek.com
Subject: Re: [PATCH] PCI: Reprogram bridge prefetch registers on resume
Message-ID: <20180907150515.GA28739@al>
References: <20180907053614.6540-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907053614.6540-1-drake@endlessm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 07, 2018 at 01:36:14PM +0800, Daniel Drake wrote:
<..>
> Thomas Martitz reports that this workaround also solves an issue where
> the AMD Radeon Polaris 10 GPU on the HP Zbook 14u G5 is unresponsive
> after S3 suspend/resume.

Where was this claimed? It is not stated in the linked bug:
(https://bugs.freedesktop.org/show_bug.cgi?id=105760

> On resume, reprogram the PCI bridge prefetch registers, including the
> magic register mentioned above.
> 
> This matches Win10 behaviour, which also rewrites these registers
> during S3 resume (checked with qemu tracing).

Windows 10 unconditionally rewrites these registers (BAR, I/O Base +
Limit, Memory Base + Limit, etc. from top to bottom), see annotations:
https://www.spinics.net/lists/linux-pci/msg75856.html

Linux has a generic "restore" operation that works backwards from the
end of the PCI config space to the beginning, see
pci_restore_config_space. Do you have a dmesg where you see the
"restoring config space at offset" messages?

Would it be reasonable to unconditionally write these registers in
pci_restore_config_dword, like Windows does?

Kind regards,
Peter
