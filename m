Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59753 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751680AbdFSUtS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jun 2017 16:49:18 -0400
Date: Mon, 19 Jun 2017 16:57:51 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Correct comment: VMD domains start at 0x10000,
 not 0x1000
Message-ID: <20170619205751.GA22260@localhost.localdomain>
References: <20170619203601.2396.80335.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170619203601.2396.80335.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 19, 2017 at 03:36:01PM -0500, Bjorn Helgaas wrote:
> VMD domains are allocated starting at 0x10000, not 0x1000 as the comment
> said.  Correct the comment and add a reference to the ACPI spec for _SEG.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Indeed, thanks for the fix.

Reviewed-by: Keith Busch <keith.busch@intel.com>
