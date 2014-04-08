Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:56875 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757529AbaDHS1h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 14:27:37 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so1423209igb.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Apr 2014 11:27:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5344251D.7040805@pobox.com>
References: <5344251D.7040805@pobox.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Apr 2014 12:27:16 -0600
Message-ID: <CAErSpo6KuYLaoEsxR4jJQ98P23kNEMzMcu_-RyM3nWd6YRxgag@mail.gmail.com>
Subject: Re: driver skip pci_set_master, fix it? No.
To: Mark Lord <mlord@pobox.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ben, linux-pci]

On Tue, Apr 8, 2014 at 10:34 AM, Mark Lord <mlord@pobox.com> wrote:
> I am working a couple of drivers for chips that perform extensive bus-mastering ops.
> These including full SRIOV support, and allow assigning virtual functions to virtual machines, etc.
>
> One thing the driver (still in development) does for safety,
> is defer the call to pci_set_master() until *after* it has mapped
> the MMIO space of the chips, so it can reset/flush the DMA engines
> before giving them permission to scribble over host RAM.
>
> But a recent patch to the kernel has removed this from the driver's control.
> The core PCI now does pci_set_master() immediately on pci_enable_device().

I assume you're talking about the one added by cf3e1feba7f9 ("PCI:
Workaround missing pci_set_master in pci drivers"), but as far as I
can tell, it only calls pci_set_master() for *bridge* devices.  What
am I missing?  Is pci_set_master() being called for your endpoint?
What path is that?

Bjorn
