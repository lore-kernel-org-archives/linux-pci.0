Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42911 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967AbaCaIRx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 31 Mar 2014 04:17:53 -0400
Subject: Interrupt remapping quirk tainting the kernel
From: Jean Delvare <jdelvare@suse.de>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 Mar 2014 10:17:48 +0200
Message-ID: <1396253868.23070.94.camel@chaos.site>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Neil and all,

I have (once again) a question about this commit:

From: Neil Horman <nhorman@tuxdriver.com>
Date: Tue, 16 Apr 2013 20:38:32 +0000
Subject: iommu/vt-d: add quirk for broken interrupt remapping on 55XX chipsets
Git-commit: 03bbcb2e7e292838bb0244f5a7816d194c911d62

When interrupt remapping is disabled by this quirk, the kernel gets
tainted. What is the rationale for doing that?

The user can boot with intremap=off. That will also disable interrupt
remapping, as the quirk does, but not taint the kernel. If this is
considered OK then I fail to see why the quirk should behave differently
and taint the kernel.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

