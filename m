Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20930 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbaFXWZz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Jun 2014 18:25:55 -0400
Date: Tue, 24 Jun 2014 16:25:53 -0600 (MDT)
From: Keith Busch <keith.busch@intel.com>
To: "Elliott, Robert (Server Storage)" <Elliott@hp.com>
cc: "Busch, Keith" <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Nagalakshmi Nandigama <Nagalakshmi.Nandigama@lsi.com>,
	Sreekanth Reddy <Sreekanth.Reddy@lsi.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [RFC PATCH] Let device drivers disable msi on shutdown
In-Reply-To: <94D0CD8314A33A4D9D801C0FE68B402958B4AD28@G9W0745.americas.hpqcorp.net>
Message-ID: <alpine.LRH.2.03.1406241603580.4699@AMR>
References: <1403628537-16367-1-git-send-email-keith.busch@intel.com> <94D0CD8314A33A4D9D801C0FE68B402958B4AD28@G9W0745.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 24 Jun 2014, Elliott, Robert (Server Storage) wrote:
> 1. That will cover the .shutdown function used by mptfc.c, mptspi.c,
> and mptscsih.c, but mptsas.c uses mptsas_shutdown rather than
> mptscsih_shutdown.  It doesn't call pci_disable_msi either.

Missed that; thanks.

> 2. mptscsih_suspend is another caller of mptscsih_shutdown
> (although the latter does nothing right now).  This is done
> before calling mpt_suspend, which writes to some chip registers
> to disable interrupts before calling pci_disable_msi.  Adding a
> pci_disable_msi call before those writes might not be safe.

Clearly more paths into this function than I investigated.

> 3. That mptscsih_suspend call chain will result in calling
> pci_disable_msi twice, which might trigger this in
> pci_disable_msi -> pci_msi_shutdown:
>        BUG_ON(list_empty(&dev->msi_list));

Ah, but pci_disable_msi will not even invoke pci_msi_shutdown:

         if (!pci_msi_enable || !dev || !dev->msi_enabled)
 	                return;

The same check is done in pci_msi_shutdown. If that check wasn't there,
every driver would hit that BUG_ON since most every other pci driver
disables their interrupts in their shutdown path before returning, and
then pci-driver calls it again! MPT appears to be the exception.
