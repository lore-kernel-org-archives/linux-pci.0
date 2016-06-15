Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:20573 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbcFOTDO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2016 15:03:14 -0400
From: "Tang, CQ" <cq.tang@intel.com>
To: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Subject: Handling MSI-X Vector Shortages
Date: Wed, 15 Jun 2016 19:03:09 +0000
Message-ID: <1D440B9B88E22A4ABEF89F9F1F81BC29490C2138@FMSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
              I am writing a driver to deal with MSI-X vector shortage. PCI local bus specification 6.8.3.2 clearly says that, software controlled aliasing can be used to solve the problem, where multiple MSI-X table entries are configured with the same vector.
              pci_enable_msix() call from driver only configure the entries specified in the argument with different vectors. Does Linux provide help function to copy MSI-X table entries? I search the pci/msi source code and don't find an exported function to do that.   
       If there are such function, please tell the function name. if not, can we add such help function?
       Or is driver allowed to access the MSI-X table entries directly, etc, read from one entry (configured by PCI subsystem), and write to another unused entry?

              Thank you very much for the help.

--CQ Tang

