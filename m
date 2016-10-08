Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:48213 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751314AbcJHHlP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Oct 2016 03:41:15 -0400
Date: Sat, 8 Oct 2016 09:41:12 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesper Nilsson <jespern@axis.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@axis.com
Subject: Re: [PATCH 2/8] PCI: artpec6: Add register accessors
Message-ID: <20161008074112.GR30704@axis.com>
References: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161007163244.24751.48694.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161007163244.24751.48694.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 07, 2016 at 11:32:45AM -0500, Bjorn Helgaas wrote:
> Add device-specific register accessors for consistency across host
> drivers.  No functional change intended.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
