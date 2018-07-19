Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbeGSSM5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jul 2018 14:12:57 -0400
Date: Thu, 19 Jul 2018 12:28:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, bhelgaas@google.com,
        kys@microsoft.com, linux-pci@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] PCI: hv: support reporting serial number as slot
 information
Message-ID: <20180719172846.GL128988@bhelgaas-glaptop.roam.corp.google.com>
References: <20180612164037.10672-1-sthemmin@microsoft.com>
 <20180704160834.GB12996@red-moon>
 <20180711134908.GF188359@bhelgaas-glaptop.roam.corp.google.com>
 <20180713143819.14da12b1@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180713143819.14da12b1@xeon-e3>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 13, 2018 at 02:38:19PM -0700, Stephen Hemminger wrote:
> PS: it is  nuisance that when the PCI support was moved to
> drivers/pci/controllers it was not done in a way  that git correctly
> tracked the rename. Therefore all the commit history was broken :-(

Oooh, that's my fault, and I'm really sorry about that.  For future
reference, what *should* I have done?

Both the original patch [1] and 6e0832fa432e ("PCI: Collect all native
drivers under drivers/pci/controller/") *look* like they comprehend
renames, e.g.,

  diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
  similarity index 100%
  rename from drivers/pci/dwc/pci-exynos.c
  rename to drivers/pci/controller/dwc/pci-exynos.c

IIRC I just applied that patch from email with "stg import", but maybe
I should have used "git mv" instead?  I did try "git mv" just now, and
"git log" doesn't show history before the rename, while
"git log --follow" does.

Anyway, sorry about breaking history; I really hate that.

Bjorn

[1] https://lkml.kernel.org/r/1527729157-201428-1-git-send-email-shawn.lin@rock-chips.com
