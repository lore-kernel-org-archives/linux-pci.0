Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:55908 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbeFYMwI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 08:52:08 -0400
Date: Mon, 25 Jun 2018 15:52:04 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: shpchp: Fix probing logic inversion
Message-ID: <20180625125204.GH2558@lahna.fi.intel.com>
References: <20180621164715.28160-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180621164715.28160-1-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2018 at 05:47:15PM +0100, Marc Zyngier wrote:
> Until recently, shpc_probe() would bail out pretty early in the
> absence of the SHPC capability. A logic change in the way the
> driver now checks that capability makes it go and probe the
> firmware anyway, with ugly consequences if the system is not
> ACPI based (my arm64 ThunderX is DT driven, and explodes in
> a spectacular way after getting a NULL root bridge from the
> non-existent ACPI tables...).

Could you share log from the failure? I would like to understand a bit
better where it crashes and why.

> Take this opportunity to move the call to shpchp_is_native()
> back into shpc_probe(), making it clear that a non-ACPI system
> is not expected to use this driver.

It is fine to use SHPC in non-ACPI systems. However, in ACPI systems we
should negotiate whether it is the OS or the firmware who handles it.
