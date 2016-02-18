Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46322 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425363AbcBRMJb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Feb 2016 07:09:31 -0500
Date: Thu, 18 Feb 2016 13:09:28 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-pci@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Borislav Petkov <bp@suse.de>,
	Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 0/4] PCI: aer_inject cleanups and verbosity
Message-ID: <20160218130928.67dbf63b@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As discussed earlier, here are a few cleanups and verbosity adjustments
to the aer_inject driver.

[PATCH 1/4] PCI: aer_inject: Fix error codes
[PATCH 2/4] PCI: aer_inject: Use dev_warn()
[PATCH 3/4] PCI: aer_inject: Log actual error causes
[PATCH 4/4] PCI: aer_inject: Log error injections

-- 
Jean Delvare
SUSE L3 Support
