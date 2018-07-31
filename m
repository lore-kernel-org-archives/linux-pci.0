Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731848AbeGaShM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jul 2018 14:37:12 -0400
Date: Tue, 31 Jul 2018 11:56:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/3] PCI: mobiveil: Misc fixes
Message-ID: <20180731165600.GL45322@bhelgaas-glaptop.roam.corp.google.com>
References: <20180730134316.11719-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730134316.11719-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 30, 2018 at 02:43:13PM +0100, Lorenzo Pieralisi wrote:
> Subrahmanya,
> 
> I put together this series so that the Mobiveil controller driver
> can compile (successfully). Please review and ack as soon as possible
> since the current situation is a bit embarassing to be honest, we
> should be sending these patches as fixes this week so that they
> can make it for v4.18, currently the driver is in the kernel for
> nothing.

There doesn't seem to be much interest in the Mobiveil driver (the
last patch I see was on May 10), and as you say, it's not even in the
Makefile, so it has gotten zero testing or even building.

Should we just drop the driver and see if anybody wants to try again
next cycle?  I'm a little hesitant about flipping the switch to enable
a brand-new driver this late in the cycle.

Bjorn
