Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36726 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbeILOIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2018 10:08:50 -0400
MIME-Version: 1.0
References: <20180912064523.9599-1-drake@endlessm.com>
In-Reply-To: <20180912064523.9599-1-drake@endlessm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Sep 2018 11:05:02 +0200
Message-ID: <CAJZ5v0j6VcFbO_R3fGLi2Ec1DmWsVA-0mzDG3LrA-3D5CrsPbw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Reprogram bridge prefetch registers on resume
To: Daniel Drake <drake@endlessm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        nouveau@lists.freedesktop.org, Linux PM <linux-pm@vger.kernel.org>,
        Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com,
        andy.shevchenko@linux.intel.com,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        jonathan.derrick@intel.com, Thomas Martitz <kugel@rockbox.org>,
        David Miller <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        netdev <netdev@vger.kernel.org>, nic_swsd@realtek.com,
        rchang@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 12, 2018 at 8:45 AM Daniel Drake <drake@endlessm.com> wrote:
>
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
> Linux already saves and restores PCI config space during suspend/resume,
> but this register was being skipped because upon resume, it already
> has value 0 (the correct, pre-suspend value).
>
> Intel appear to have previously acknowledged this behaviour and the
> requirement to rewrite this register.
> https://bugzilla.kernel.org/show_bug.cgi?id=116851#c23
>
> Based on that, rewrite the prefetch register values even when that
> appears unnecessary.
>
> We have confirmed this solution on all the affected models we have
> in-hands (X542UQ, UX533FD, X530UN, V272UN).
>
> Additionally, this solves an issue where r8169 MSI-X interrupts were
> broken after S3 suspend/resume on Asus X441UAR. This issue was recently
> worked around in commit 7bb05b85bc2d ("r8169: don't use MSI-X on
> RTL8106e"). It also fixes the same issue on RTL6186evl/8111evl on an
> Aimfor-tech laptop that we had not yet patched. I suspect it will also
> fix the issue that was worked around in commit 7c53a722459c ("r8169:
> don't use MSI-X on RTL8168g").
>
> Thomas Martitz reports that this change also solves an issue where
> the AMD Radeon Polaris 10 GPU on the HP Zbook 14u G5 is unresponsive
> after S3 suspend/resume.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201069
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
>
> Notes:
>     Replaces patch:
>        PCI: add prefetch quirk to work around Asus/Nvidia suspend issues
>
>     Some of the more verbose info was moved to bugzilla:
>     https://bugzilla.kernel.org/show_bug.cgi?id=201069
>
>     This patch is aimed at v4.19 (and maybe v4.18-stable); we may follow
>     up with more intrusive improvements for v4.20+.
>
>     v2: reimplement the register restore within the existing
>         pci_restore_config_space() code.
>
>  drivers/pci/pci.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 29ff9619b5fa..e1704100e72d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1289,13 +1289,15 @@ int pci_save_state(struct pci_dev *dev)
>  EXPORT_SYMBOL(pci_save_state);
>
>  static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
> -                                    u32 saved_val, int retry)
> +                                    u32 saved_val, int retry, bool force)
>  {
>         u32 val;
>
> -       pci_read_config_dword(pdev, offset, &val);
> -       if (val == saved_val)
> -               return;
> +       if (!force) {
> +               pci_read_config_dword(pdev, offset, &val);
> +               if (val == saved_val)
> +                       return;
> +       }
>
>         for (;;) {
>                 pci_dbg(pdev, "restoring config space at offset %#x (was %#x, writing %#x)\n",
> @@ -1313,25 +1315,34 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
>  }
>
>  static void pci_restore_config_space_range(struct pci_dev *pdev,
> -                                          int start, int end, int retry)
> +                                          int start, int end, int retry,
> +                                          bool force)
>  {
>         int index;
>
>         for (index = end; index >= start; index--)
>                 pci_restore_config_dword(pdev, 4 * index,
>                                          pdev->saved_config_space[index],
> -                                        retry);
> +                                        retry, force);
>  }
>
>  static void pci_restore_config_space(struct pci_dev *pdev)
>  {
>         if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
> -               pci_restore_config_space_range(pdev, 10, 15, 0);
> +               pci_restore_config_space_range(pdev, 10, 15, 0, false);
>                 /* Restore BARs before the command register. */
> -               pci_restore_config_space_range(pdev, 4, 9, 10);
> -               pci_restore_config_space_range(pdev, 0, 3, 0);
> +               pci_restore_config_space_range(pdev, 4, 9, 10, false);
> +               pci_restore_config_space_range(pdev, 0, 3, 0, false);
> +       } else if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +               pci_restore_config_space_range(pdev, 12, 15, 0, false);
> +               /* Force rewriting of prefetch registers to avoid
> +                * S3 resume issues on Intel PCI bridges that occur when
> +                * these registers are not explicitly written.
> +                */
> +               pci_restore_config_space_range(pdev, 9, 11, 0, true);
> +               pci_restore_config_space_range(pdev, 0, 8, 0, false);
>         } else {
> -               pci_restore_config_space_range(pdev, 0, 15, 0);
> +               pci_restore_config_space_range(pdev, 0, 15, 0, false);
>         }
>  }
>
> --

Passing the extra bool around is somewhat clumsy, but I haven't found
a cleaner way to do it, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
