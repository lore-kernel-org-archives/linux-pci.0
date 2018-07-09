Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:46325 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754455AbeGINiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jul 2018 09:38:20 -0400
Received: by mail-yw0-f171.google.com with SMTP id e23-v6so6027349ywe.13
        for <linux-pci@vger.kernel.org>; Mon, 09 Jul 2018 06:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1807051515260.21817@math.ut.ee>
In-Reply-To: <alpine.LRH.2.21.1807051515260.21817@math.ut.ee>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Jul 2018 08:38:07 -0500
Message-ID: <CAErSpo6Fp8XpTQi7gcSQEuvpuJMYCMn5Y0cXRNvmO_opSR08HQ@mail.gmail.com>
Subject: Re: HH DL585 warm boot fail (old)
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 6, 2018 at 2:13 PM Meelis Roos <mroos@linux.ee> wrote:
>
> I have a first gen HP Proliant DL585 ("G1" but the name was not used
> back then) that boots up fine from poweron but usually fails bootup from
> warm reboot, somewhere in PCI detection (will try to photographs the
> screen some time).
>
> I just stumbled upon an old OpenSolaris thead about the same DL585 and
> same symptoms:
> http://opensolaris-discuss.opensolaris.narkive.com/T0UTXYGZ/solaris-10-06-06-x86-hp-dl585-boot-hang-aftrer-reboot-help
>
> Their conclusion was the wfollowing and they seem to have found a fix
> (although I have not tested any version of Solaris on this DL585
> myself):
>
> "The hang is caused when, during PCI enumeration, a PCI-PCI bridge is
> partially disabled when the PCI command register bits which enable IO
> and memory windows are cleared."
>
> Is this information useful in some way for debugging it?
>
> What else besides screenshot of the can be useful in debugging?

Would you mind opening a report at https://bugzilla.kernel.org?  I'm
not sure if anybody will be able to do anything about this, but it's
always possible.

A complete dmesg log and "sudo lspci -vv" output from a successful
boot would be a good start.  And if you have a screenshot of the
failure, that would help, too.  You can use the "ignore_loglevel"
kernel parameter to make sure we see everything on the console.  Does
this machine have an iLO?  If so, it may have logs that could be
useful if this is related to some sort of bus error.

Bjorn
