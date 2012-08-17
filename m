Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60187 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871Ab2HQRow (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 13:44:52 -0400
Received: by lbbgj3 with SMTP id gj3so2263363lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 10:44:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <502E8115.90507@gmail.com>
References: <502E8115.90507@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 Aug 2012 11:44:31 -0600
Message-ID: <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
Subject: Re: PCI Section mismatch error in linux-next.
To: David Daney <ddaney.cavm@gmail.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_fixup_irqs()
> around after init) causes:
>
> WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference from the
> function pci_fixup_irqs() to the function .init.text:pcibios_update_irq()
>
> The MIPS implementation of pcibios_update_irq() is __init, so there is
> conflict with the removal of __init from pci_fixup_irqs() and
> pdev_fixup_irq().
>
> Can you guys either remove the patch from linux-next, or improve it to also
> fix up any architecture implementations of pdev_update_irq()?

Crap, there are lots of arches with this issue.  I'll fix it up.
Thanks for pointing it out!

Bjorn
