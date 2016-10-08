Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:48209 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751314AbcJHHks (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Oct 2016 03:40:48 -0400
Date: Sat, 8 Oct 2016 09:40:45 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesper Nilsson <jespern@axis.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@axis.com
Subject: Re: [PATCH 1/8] PCI: artpec6: Name private struct pointer "artpec6"
 consistently
Message-ID: <20161008074045.GQ30704@axis.com>
References: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 07, 2016 at 11:32:33AM -0500, Bjorn Helgaas wrote:
> Use a device-specific name, "artpec6", for struct artpec6_pcie pointers
> to hint that this is device-specific information.  No functional change
> intended.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
