Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbeIHCbz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Sep 2018 22:31:55 -0400
Date: Fri, 7 Sep 2018 16:48:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Drake <drake@endlessm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, linux-pm@vger.kernel.org,
        peter@lekensteyn.nl, kherbst@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael.j.wysocki@intel.com,
        keith.busch@intel.com, mika.westerberg@linux.intel.com,
        jonathan.derrick@intel.com, kugel@rockbox.org, davem@davemloft.net,
        hkallweit1@gmail.com, netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Reprogram bridge prefetch registers on resume
Message-ID: <20180907214856.GC250890@bhelgaas-glaptop.roam.corp.google.com>
References: <20180907053614.6540-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907053614.6540-1-drake@endlessm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc LKML]

On Fri, Sep 07, 2018 at 01:36:14PM +0800, Daniel Drake wrote:
> On 38+ Intel-based Asus products, the nvidia GPU becomes unusable
> after S3 suspend/resume. The affected products include multiple
> generations of nvidia GPUs and Intel SoCs. After resume, nouveau logs
> many errors such as:
> 
>     fifo: fault 00 [READ] at 0000005555555000 engine 00 [GR] client 04 [HUB/FE] reason 4a [] on channel -1 [007fa91000 unknown]
>     DRM: failed to idle channel 0 [DRM]
> 
> Similarly, the nvidia proprietary driver also fails after resume
> (black screen, 100% CPU usage in Xorg process). We shipped a sample
> to Nvidia for diagnosis, and their response indicated that it's a
> problem with the parent PCI bridge (on the Intel SoC), not the GPU.
> 
> Runtime suspend/resume works fine, only S3 suspend is affected.
> 
> We found a workaround: on resume, rewrite the Intel PCI bridge
> 'Prefetchable Base Upper 32 Bits' register (PCI_PREF_BASE_UPPER32). In
> the cases that I checked, this register has value 0 and we just have to
> rewrite that value.
> 
> It's very strange that rewriting the exact same register value
> makes a difference, but it definitely makes the issue go away.
> It's not just acting as some kind of memory barrier, because rewriting
> other bridge registers does not work around the issue. There's something
> magic in this particular register. We have confirmed this on all
> the affected models we have in-hands (X542UQ, UX533FD, X530UN, V272UN).
> 
> Additionally, this workaround solves an issue where r8169 MSI-X
> interrupts were broken after S3 suspend/resume on Asus X441UAR. This
> issue was recently worked around in commit 7bb05b85bc2d ("r8169:
> don't use MSI-X on RTL8106e"). It also fixes the same issue on
> RTL6186evl/8111evl on an Aimfor-tech laptop that we had not yet
> patched. I suspect it will also fix the issue that was worked around in
> commit 7c53a722459c ("r8169: don't use MSI-X on RTL8168g").

This is crazy.  I would think *lots* of devices, like anything that
uses prefetchable memory, would be affected by this.

> Thomas Martitz reports that this workaround also solves an issue where
> the AMD Radeon Polaris 10 GPU on the HP Zbook 14u G5 is unresponsive
> after S3 suspend/resume.
> 
> From our testing, the affected Intel PCI bridges are:
> Intel Skylake PCIe Controller (x16) [8086:1901] (rev 05)
> Intel Skylake PCIe Controller (x16) [8086:1901] (rev 07)
> Intel Device [8086:31d8] (rev f3)
> Intel Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1 [8086:5ad6] (rev fb)
> Intel Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port A #1 [8086:5ad8] (rev fb)
> Intel Sunrise Point-LP PCI Express Root Port [8086:9d10] (rev f1)
> Intel Sunrise Point-LP PCI Express Root Port #5 [8086:9d14] (rev f1)
> Intel Device [8086:9dbc] (rev f0)
> 
> On resume, reprogram the PCI bridge prefetch registers, including the
> magic register mentioned above.
> 
> This matches Win10 behaviour, which also rewrites these registers
> during S3 resume (checked with qemu tracing).
> 
> Link: https://marc.info/?i=CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com

Can you use

  https://lkml.kernel.org/r/CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com

instead, so we don't depend on marc.info?  lkml.kernel.org doesn't have
linux-pci archives, but it might someday, and it does redirect to other
archives already.

> Link: https://bugs.freedesktop.org/show_bug.cgi?id=105760

I would really like to have a bugzilla.kernel.org issue with the
excellent debugging you and Peter did attached.  Then we don't also
have to depend on github.com, etc., sticking around.

The list of platforms below could also be attached there, since you
went to a lot of trouble to collect it, but it's probably more than is
necessary for the changelog.

> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
> 
> Notes:
>     Replaces patch:
>        PCI: add prefetch quirk to work around Asus/Nvidia suspend issues
>     
>     Below is the list of Asus products with Intel/Nvidia that we
>     believe are affected by the GPU resume issue.
>     
>     I revised my counting method from my last patch to eliminate duplicate
>     platforms that had multiple SKUs with the same DMI/GPU/bridge, that's why
>     the product count reduced from 43 to 38.
>     
>     sys_vendor: ASUSTeK COMPUTER INC.
>     board_name: FX502VD
>     product_name: FX502VD
>     01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1c8d] (rev ff) (prog-if ff)
>     	!!! Unknown header type 7f
>     00:01.0 PCI bridge [0604]: Intel Corporation Device [8086:1901] (rev 05) (prog-if 00 [Normal decode])
> ...
