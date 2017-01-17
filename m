Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbdAQO4f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jan 2017 09:56:35 -0500
Date: Tue, 17 Jan 2017 08:56:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kilian.singer@quantumtechnology.info
Cc: linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170117145628.GD22776@bhelgaas-glaptop.roam.corp.google.com>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 27, 2016 at 05:57:37PM -0600, Bjorn Helgaas wrote:
> Hi Killian,
> 
> Thanks for the report (https://bugzilla.kernel.org/show_bug.cgi?id=190861)
> and all the debugging you've done.  Below is a revert of the troublesome
> commit.  Can you test it and verify that it also fixes the problem?
> 
> I assume Mika is looking at this and will have a better solution soon.
> But if not, I'll queue this up for v4.10.

Can somebody please summarize the current state of this issue?  I
assume somebody has already posted a better patch that should replace
this naive revert, but I haven't been following the whole thread.

> commit e648b1ca2b94d207289fedc2538d33c57cdbc4de
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Dec 27 17:27:30 2016 -0600
> 
>     Revert "PCI: Add runtime PM support for PCIe ports"
>     
>     Revert 006d44e49a25 ("PCI: Add runtime PM support for PCIe ports").
>     
>     Killian reported that on a Lenovo W54l with i7-4810MQ, Intel HD Graphics
>     4600, and NVIDIA Quadro® K1100M, locking the screen kills all keyboard and
>     mouse interaction.  Reverting 006d44e49a25 fixes the problem.
>     
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=190861
>     Reported-by: kilian.singer@quantumtechnology.info
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: stable@vger.kernel.org	# v4.8+
>     CC: Mika Westerberg <mika.westerberg@linux.intel.com>
