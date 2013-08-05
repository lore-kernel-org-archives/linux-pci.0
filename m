Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:50787 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab3HEPjF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 11:39:05 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so5722119obc.7
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2013 08:39:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPWoNkLQUbFG2vZ7wqoqqVNj4uxKz3Fa_vsSH=1_TDD=XC1f2A@mail.gmail.com>
References: <CAPWoNkJ3NKM-_g93LdRpjvdNFtLt-Pjpg4d4oEKC9CvkpzZ-Wg@mail.gmail.com>
 <CAPWoNkLQUbFG2vZ7wqoqqVNj4uxKz3Fa_vsSH=1_TDD=XC1f2A@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 5 Aug 2013 09:38:45 -0600
Message-ID: <CAErSpo5ZZgdpkK+QdQUEnNCEXcG_T+QBWTVoQnMTghxkX7n2HA@mail.gmail.com>
Subject: Re: PCIE device errors after linux kernel upgrade
To: Leon Ravich <lravich@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linuxppc-dev]

On Mon, Aug 5, 2013 at 5:17 AM, Leon Ravich <lravich@gmail.com> wrote:
> Hi all ,
> I am trying to upgrade ours embedded device (freescale powerPC P2020 cpu)
> linux kernel  , till now we used 2.6.32 I am trying to upgrade to 3.8.13 .
> I took the source from freescale git:
> git://git.freescale.com/ppc/sdk/linux.git
>
> on our embedded device we have an FPGA connected through PCIE .
>
> on each boot we loading the rbf design to the FPGA and the rescan pci bus to let
> kernel detect it .
>
> during the rescan I getting error messages:
>  genirq: Setting trigger mode 0 for irq 27 failed
> (mpc8xxx_irq_set_type+0x0/0xec)
> [   22.060898] genirq: Setting trigger mode 0 for irq 28 failed
> (mpc8xxx_irq_set_type+0x0/0xec)
> [   22.069461] genirq: Setting trigger mode 0 for irq 31 failed
> (mpc8xxx_irq_set_type+0x0/0xec)
> [   22.078010] genirq: Setting trigger mode 0 for irq 32 failed
> (mpc8xxx_irq_set_type+0x0/0xec)
> [   22.086576] genirq: Setting trigger mode 0 for irq 33 failed
> (mpc8xxx_irq_set_type+0x0/0xec)
> [   22.095143] genirq: Setting trigger mode 0 for irq 37 failed
> (mpc8xxx_irq_set_type+0x0/0xec)
> [   22.103715] genirq: Setting trigger mode 0 for irq 38 failed
> (mpc8xxx_irq_set_type+0x0/0xec)
> [   22.112282] genirq: Setting trigger mode 0 for irq 39 failed
> (mpc8xxx_irq_set_type+0x0/0xec)

Hmm, I don't know much about IRQ issues.

> [   37.945785] pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't
> match header type 01)

There's a recent patch related to this:
http://lkml.kernel.org/r/1374823418-1550-1-git-send-email-Chunhe.Lan@freescale.com

> [   37.953640] PCIE error(s) detected
> [   37.953858] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [   37.953988] pci 0000:00:00.0: BAR 8: assigned [mem 0xc0000000-0xdfffffff]
> [   37.953994] pci 0000:00:00.0: BAR 7: can't assign io (size 0x10000)
> [   37.954000] pci 0000:01:00.0: BAR 0: assigned [mem 0xc0000000-0xc00fffff]
> [   37.954013] pci 0000:01:00.0: BAR 1: assigned [mem 0xc0100000-0xc017ffff]
> [   37.954025] pci 0000:01:00.0: BAR 2: assigned [mem 0xc0180000-0xc01fffff]
> [   37.954036] pci 0000:00:00.0: PCI bridge to [bus 01]
> [   37.954041] pci 0000:00:00.0:   bridge window [mem 0xc0000000-0xdfffffff]
> [   38.007354] PCIE ERR_DR register: 0x80020000
> [   38.011613] PCIE ERR_CAP_STAT register: 0x00000041
> [   38.016392] PCIE ERR_CAP_R0 register: 0x00000800
> [   38.020997] PCIE ERR_CAP_R1 register: 0x00000000
> [   38.025602] PCIE ERR_CAP_R2 register: 0x00000000
> [   38.030207] PCIE ERR_CAP_R3 register: 0x00000000
>
>
> and after a few minutes I linux reboot it self,
>
>
> where can I start debugging it??

I'd start by applying the header quirk patch above, then comparing the
complete console log (boot with "ignore_loglevel") from 2.6.32 and
3.8.13.

Bjorn
