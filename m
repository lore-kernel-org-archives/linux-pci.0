Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58532 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbcFPQU5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jun 2016 12:20:57 -0400
Date: Thu, 16 Jun 2016 11:20:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Doug Ledford <dledford@redhat.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: hfi1 use of PCI internals
Message-ID: <20160616162052.GA2144@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I noticed drivers/infiniband/hw/hfi1 got moved from staging to
drivers/ for v4.7.  It does a bunch of grubbing around in PCIe ASPM
configuration, e.g., see drivers/infiniband/hw/hfi1/aspm.h.

I know there have been lots of ASPM issues, both hardware problems and
Linux kernel problems, but it is *supposed* to be manageable by the
core, without special driver support.  What's the justification for
having to do this in the hfi1 driver?

Bjorn
