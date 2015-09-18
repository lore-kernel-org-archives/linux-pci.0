Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 18 Sep 2015 09:59:56 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Tanmay Inamdar <tinamdar@apm.com>,
	<patches@apm.com>
Subject: Re: [PATCH 1/1] PCI/MSI: X-Gene: Remove msi_controller assignment
 in X-Gene PCIe driver
Message-ID: <20150918095956.2e27c93c@arm.com>
In-Reply-To: <1442449900-30842-1-git-send-email-dhdang@apm.com>
References: <1442449900-30842-1-git-send-email-dhdang@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 16 Sep 2015 17:31:40 -0700
Duc Dang <dhdang@apm.com> wrote:

> With commit 8d63bc7beaee ("PCI/MSI: pci-xgene-msi: Get rid of
> struct msi_controller"), it is no longer required to assign
> msi_controller for X-Gene PCIe host bridge to support MSI. This
> patch removes this unnecessary code and also helps avoid a warning
> message ("failed to enable MSI") during boot.
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Cc: Tanmay Inamdar <tinamdar@apm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
