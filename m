Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:52312 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932356AbdJ3Q6h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 12:58:37 -0400
Received: by mail-yw0-f196.google.com with SMTP id w2so12170588ywa.9
        for <linux-pci@vger.kernel.org>; Mon, 30 Oct 2017 09:58:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509361385-21224-1-git-send-email-vidyas@nvidia.com>
References: <1509361385-21224-1-git-send-email-vidyas@nvidia.com>
From: Rajat Jain <rajatja@google.com>
Date: Mon, 30 Oct 2017 09:57:56 -0700
Message-ID: <CACK8Z6GvTYsPz-TXTKVSRbsYc=w=7OO130ftiJL_NXZOcbVNkg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add ASPM-L1 Substates support for Tegra
To: Vidya Sagar <vidyas@nvidia.com>
Cc: treding@nvidia.com, Bjorn Helgaas <bhelgaas@google.com>,
        Yinghai Lu <yinghai@kernel.org>,
        David Daney <david.daney@cavium.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 30, 2017 at 4:03 AM, Vidya Sagar <vidyas@nvidia.com> wrote:
> Tegra chips T210 and T186 support ASPM-L1 Substates (i.e. L1.1 and L1.2)
> This patch series
> - adds a generic API for root port controller drivers to
>   override the default value of LTR L1.2 Threhold which otherwise comes from
>   the same APIs weak implementation in aspm.c file

May be I'm imagining things, (and may be this is a question for
Bjorn), but is it possible to ever have a system that could have more
than 1 *type* of root port? If so, the current proposal only allows
for 1 value of LTR threshold (system wide) which may not be ideal.

> - applies fixups to reflect correct capability values for
>   T_cmrt (Common Mode Restore Time) and
>   T_pwr_on (Power On)
>   and adjusts counter values for 19.2 MHz of clk_m
> - applies fixup specific to T210 to avoid unnecessary wake ups from L1.2 state
>
> PCIe - ASPM L1 Sub States spec
> https://pcisig.com/sites/default/files/specification_documents/ECN_L1_PM_Substates_with_CLKREQ_31_May_2013_Rev10a.pdf
>
> Testing Done on T210 and T186
> - ASPM-L1:
>   Verified ASPM-L1 enablement by selecting PCIEASPM_POWERSAVE config
>   With the help of Tegra rootport's internal counter registers, confirmed
>   link entry in and out of ASPM-L1 state using USB3.0 add-on card, NVMe and NIC
>   cards
> - ASPM-L1 SubStates:
>   Verified ASPM-L1 Substates enablement by selecting PCIEASPM_POWER_SUPERSAVE config
>   Confirmed link's entry into L1SS using Westren Digital NVMe card (with Sandisk
>   Controller) using Tegra rootport's internal counter registers
>
> Vidya Sagar (4):
>   PCI/ASPM: Add API to supply LTR L1.2 threshold
>   PCI: tegra: Enable ASPM-L1 capability advertisement
>   PCI: tegra: Apply sw fixups to support ASPM-L1 Sub-States
>   PCI: tegra: fixups to avoid unnecessary wakeup from ASPM-L1.2
>
>  drivers/pci/host/pci-tegra.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/aspm.c      | 11 +++--
>  include/linux/pci-aspm.h     |  6 +++
>  3 files changed, 113 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>
