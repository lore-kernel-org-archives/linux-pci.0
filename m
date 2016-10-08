Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:38415 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbcJHHxh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Oct 2016 03:53:37 -0400
Date: Sat, 8 Oct 2016 09:53:34 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesper Nilsson <jespern@axis.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@axis.com
Subject: Re: [PATCH 5/8] PCI: artpec6: Remove unnecessary
 artpec6_pcie_link_up()
Message-ID: <20161008075334.GU30704@axis.com>
References: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161007163308.24751.61973.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161007163308.24751.61973.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 07, 2016 at 11:33:08AM -0500, Bjorn Helgaas wrote:
> Remove artpec6_pcie_link_up(); the generic dw_pcie_link_up() does the same
> thing, so we don't need a device-specific version.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
