Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751078AbdFAQuo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jun 2017 12:50:44 -0400
Date: Thu, 1 Jun 2017 11:50:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: How to trace down if PCIe link went into L1 state
Message-ID: <20170601165025.GA12257@bhelgaas-glaptop.roam.corp.google.com>
References: <CAHKzcENL1px=zS8QspSX3WZ_z1PWjWBEcNBKTb00cfVushd9XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHKzcENL1px=zS8QspSX3WZ_z1PWjWBEcNBKTb00cfVushd9XQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pm]

On Wed, May 31, 2017 at 11:00:16PM +0200, Waldemar Rymarkiewicz wrote:
> Hi,
> 
> I am not really familiar with pci subsystem but I need to check if the
> pcie link went into L1 state after suspend.
> 
> I use a wifi card with M2 connector with pcie interface. I suspend the
> system and would like to verify if the link state went really into
> L1/L2 as I see quite a big current on the power lines when it's in a
> suspend.

If I understand correctly, no Linux code is executing while the system
is suspended, so I think you would need a hardware analyzer to verify
the link state directly.

Per sec 5.3.2 of the PCIe spec r3.1, the power management state of a
link is determined by the D-state of its downstream component, and the
config write to PMCSR to change the D-state is what starts the
transition of the downstream component to D1, D2, etc., and transition
of the link to L1, L2, etc.  So you may be able to instrument the
kernel to log those writes and infer that the link *should* be in
L1/L2.  Of course, you're suspending the system, so you're probably
going to suspend your console device, too.  I don't know what
techniques people use to debug things in this area, other than using a
serial console.

Maybe the wifi card is a wakeup device and that prevents it from
sleeping as deeply as you expect?

Bjorn
