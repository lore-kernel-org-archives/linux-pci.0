Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752206AbeC3Ugv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 16:36:51 -0400
Date: Fri, 30 Mar 2018 15:36:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tal Gilboa <talgi@mellanox.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Keller Jacob E <jacob.e.keller@intel.com>
Subject: Re: [PATCH next V4 0/8] Report PCI device link status
Message-ID: <20180330203648.GA9322@bhelgaas-glaptop.roam.corp.google.com>
References: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 30, 2018 at 10:14:38AM +0300, Tal Gilboa wrote:
> These patches introduce the ability to report PCI link width
> and speed for all PCI devices in kernel log.
> This would reduce code duplication between drivers and unify
> the approach for reporting PCI link status.
> Implemented and tested for Mellanox devices.

This is awesome.

I reworked a few things and converted the remaining users of
pcie_get_minimum_link().  I'll post the result as a V5 of this series and
you can see what you think.  Hopefully I didn't break too many things.

Bjorn
