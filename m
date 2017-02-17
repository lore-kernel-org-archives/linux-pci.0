Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:34508 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933512AbdBQS4F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2017 13:56:05 -0500
Received: by mail-ua0-f169.google.com with SMTP id 35so35680686uak.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Feb 2017 10:56:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170217174009.GA21480@otc-nc-03>
References: <20170217061247.5591-1-yinghai@kernel.org> <20170217174009.GA21480@otc-nc-03>
From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 17 Feb 2017 10:56:04 -0800
Message-ID: <CAE9FiQWjsnxosBqWGe2UEjfNzYEuiT2wTU-8Ppi=C+jJ_V0TJQ@mail.gmail.com>
Subject: Re: [PATCH] PCI,pciehp: Don't handle PDC for cards with attention button
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 17, 2017 at 9:40 AM, Raj, Ashok <ashok.raj@intel.com> wrote:
> Hi Yinghai
>
> Which version of linux did you apply this?

current linus tree + pci/next

>
> I'm not sure if you can ignore PDC when ATTN isn't present. Surprise hot-add on
> systems with Power Control would depend on PDC.

in pcie_enable_notification() we don't enable PDCE when ATTN is not there.

        cmd = PCI_EXP_SLTCTL_DLLSCE;
        if (ATTN_BUTTN(ctrl))
                cmd |= PCI_EXP_SLTCTL_ABPE;
        else
                cmd |= PCI_EXP_SLTCTL_PDCE;
        if (!pciehp_poll_mode)
                cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;

        mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
                PCI_EXP_SLTCTL_PFDE |
                PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
                PCI_EXP_SLTCTL_DLLSCE);

        pcie_write_cmd_nowait(ctrl, cmd, mask);

So we should handle PDC at all.

Thanks

Yinghai
