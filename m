Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753569AbeD0WJe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 18:09:34 -0400
Date: Fri, 27 Apr 2018 17:09:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marc.zyngier@arm.com,
        mingkai.hu@nxp.com, peter.newton@nxp.com, minghuan.lian@nxp.com,
        rajesh.raina@nxp.com, rajan.kapoor@nxp.com, prabhjot.singh@nxp.com
Subject: Re: [PATCH v8 3/3] Implement MSI support for Mobiveil PCIe Host
 Bridge IP device driver
Message-ID: <20180427220932.GA73638@bhelgaas-glaptop.roam.corp.google.com>
References: <1524634505-9598-1-git-send-email-l.subrahmanya@mobiveil.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524634505-9598-1-git-send-email-l.subrahmanya@mobiveil.co.in>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


I should have noticed this before, sorry:

s/Implement MSI support for Mobiveil PCIe Host/
  PCI: mobiveil: Add MSI support/

This makes "git log --oneline drivers/pci/host/pcie-mobiveil.c" look
sensible.

Also, please add a commit log in addition to the subject.  It's OK if the
commit log repeats the subject.

On Wed, Apr 25, 2018 at 01:35:05AM -0400, Subrahmanya Lingappa wrote:
> Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-pci@vger.kernel.org
