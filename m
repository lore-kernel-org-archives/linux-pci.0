Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33348 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935097AbcHaRC5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2016 13:02:57 -0400
MIME-Version: 1.0
In-Reply-To: <20160831155009.3216.93787.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160831155009.3216.93787.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From: Myron Stowe <myron.stowe@gmail.com>
Date: Wed, 31 Aug 2016 10:46:12 -0600
Message-ID: <CAL-B5D1Jb9QGimAar-wojBp--A3TriVtAe_MeZ7vYAOsPyrqsQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Mark Haswell Power Control Unit as having
 non-compliant BARs
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Andi Kleen <ak@linux.intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 31, 2016 at 9:50 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> The Haswell Power Control Unit has a non-PCI register (CONFIG_TDP_NOMINAL)
> where BAR 0 is supposed to be.  This is erratum HSE43 in the spec update
> referenced below:
>
>   The PCIe* Base Specification indicates that Configuration Space Headers
>   have a base address register at offset 0x10.  Due to this erratum, the
>   Power Control Unit's CONFIG_TDP_NOMINAL CSR (Bus 1; Device 30; Function
>   3; Offset 0x10) is located where a base register is expected.
>
> Mark the PCU as having non-compliant BARs so we don't try to probe any of
> them.  There are no other BARs on this device.
>
> Rename the quirk so it's not Broadwell-specific.

While it's not a big enough battle to fight it sure is irritating to
see vendors make the same mistakes over and over again.  Wondering if
this an error on the respective vendor's BIOS team's part or is this
is just being inherited over and over again from Intel's Premier BIOS
team reference code?

>
> Link: http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-spec-update.html
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=153881
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/pci/fixup.c |   20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 837ea36..6d52b94 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -553,15 +553,21 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_zone);
>
>  /*
> - * Broadwell EP Home Agent BARs erroneously return non-zero values when read.
> + * Device [8086:2fc0]
> + * Erratum HSE43
> + * CONFIG_TDP_NOMINAL CSR Implemented at Incorrect Offset
> + * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-spec-update.html
>   *
> - * See http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
> - * entry BDF2.
> + * Devices [8086:6f60,6fa0,6fc0]
> + * Erratum BDF2
> + * PCI BARs in the Home Agent Will Return Non-Zero Values During Enumeration
> + * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
>   */
> -static void pci_bdwep_bar(struct pci_dev *dev)
> +static void pci_invalid_bar(struct pci_dev *dev)
>  {
>         dev->non_compliant_bars = 1;
>  }
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_bdwep_bar);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_bdwep_bar);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_bdwep_bar);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, pci_invalid_bar);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
>

Acked-by: Myron Stowe <myron.stowe@redhat.com>
