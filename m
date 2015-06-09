Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38753 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbbFIQXu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2015 12:23:50 -0400
Received: by igblz2 with SMTP id lz2so15460897igb.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2015 09:23:49 -0700 (PDT)
Date: Tue, 9 Jun 2015 11:23:46 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 02/18] NTB: Add NTB hardware abstraction layer
Message-ID: <20150609162346.GC23119@google.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
 <21347a93355f40d945cf9f565f95e790d9b3bda5.1433838377.git.Allen.Hubbe@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <21347a93355f40d945cf9f565f95e790d9b3bda5.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These refer to English text usage (doc, comments, Kconfig help), not C code:

  s/ntb/NTB/ (except where it refers directly to the driver)
  s/pci/PCI/
  s/PCI-E/PCIe/
  s/api/API/
  s/intel/Intel/

On Tue, Jun 09, 2015 at 05:44:29AM -0400, Allen Hubbe wrote:
> Abstract the ntb device behind a programming interface, so that it can
> support different hardware.  Change the intel hardware driver to fit the
> abstraction.
> 
> Expose the ntb hardware api to client drivers instead of tying it to
> ntb_transport.  Make ntb_transport a client of the ntb hardware api.
