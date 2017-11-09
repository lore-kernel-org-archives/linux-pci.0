Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51142 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754633AbdKIN1c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2017 08:27:32 -0500
Date: Thu, 9 Nov 2017 14:27:29 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: subrahmanya_lingappa <l.subrahmanya@mobiveil.co.in>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Peter W Newton <peter.newton@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>
Subject: Re: [PATCH 1/2 v2] PCI: Mobiveil: export irq_set_msi_desc symbol
In-Reply-To: <697da40c-7cdd-3d05-5846-37eae31bb729@mobiveil.co.in>
Message-ID: <alpine.DEB.2.20.1711091427050.1839@nanos>
References: <CAFZiPx1x9irvXCm7W9t_VjGnw2VLPhptO8WfuRXPd1jpcBU2Sw@mail.gmail.com> <697da40c-7cdd-3d05-5846-37eae31bb729@mobiveil.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 9 Nov 2017, subrahmanya_lingappa wrote:

> From e38b741006856f3a3623109dd5ddf5f99326ce61 Mon Sep 17 00:00:00 2001
> From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Date: Thu, 9 Nov 2017 04:25:21 -0500
> Subject: [PATCH 1/2 v2] PCI: Mobiveil: export irq_set_msi_desc symbol
> 
> This patch exports irq_set_msi_desc symbol which is used by
> few PCIe root port drivers.

And which one of those is modular?

Thanks,

	tglx
