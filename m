Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:45516 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbaJ0TcI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Oct 2014 15:32:08 -0400
Received: by mail-qa0-f53.google.com with SMTP id n8so1950317qaq.40
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2014 12:32:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <544E99FD.5040306@web.de>
References: <544D37F7.2060800@web.de> <1414399977.2421.1.camel@pengutronix.de> <544E99FD.5040306@web.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 27 Oct 2014 13:31:47 -0600
Message-ID: <CAErSpo5Wsmjqm1rMi_46j_Y-6h+9eNv7Rc1OH0Wm7S1VmMNWWA@mail.gmail.com>
Subject: Re: Setting cpu affinity for MSI-X on i.mx6 possible?
To: Heiner Kallweit <heiner.kallweit@web.de>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 27, 2014 at 1:16 PM, Heiner Kallweit <heiner.kallweit@web.de> wrote:
> Thanks, Lucas.
>
> It's interesting however that the igb driver claims it's using MSI-X.
> Maybe the DW PCIE drivers offers MSI-X on the bus and just internally falls back to MSI?
>
> Rgds, Heiner
>
> [    4.165850] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.2.15-k
> [    4.172930] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    4.178638] igb 0000:01:00.0: enabling device (0140 -> 0142)
> [    4.235789] igb 0000:01:00.0: added PHC on eth0
> [    4.235793] igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
> [    4.235799] igb 0000:01:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:01:c0:14:b1:58
> [    4.235804] igb 0000:01:00.0: eth0: PBA No: FFFFFF-0FF
> [    4.235810] igb 0000:01:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)

What does "lspci -vvs01:00.0" say?  It *looks* like igb pays attention
to whether enabling MSI-X worked, but that path in the driver is not
completely trivial, and I got tired of tracing the code to verify it.

Bjorn
