Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:22384 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546Ab2C1Otb convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:2:1>);
	Wed, 28 Mar 2012 10:49:31 -0400
Message-Id: <4F73414F020000780007B822@nat28.tlf.novell.com>
Date: Wed, 28 Mar 2012 15:50:23 +0100
From: "Jan Beulich" <JBeulich@suse.com>
To: <nhorman@tuxdriver.com>, "Jesse Barnes" <jbarnes@virtuousgeek.org>
Cc: <linux-pci@vger.kernel.org>
Subject: error handling in msix_capability_init() broken?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In "PCI/sysfs: add per pci device msi[x] irq listing (v5)" error handling
in said function got broken afaict: "ret" gets set to zero (success), and
control gets transferred to the "error" label. In contrast,
msi_capability_init() properly cleans up in that case.

While doing proper cleanup here would certainly be possible here,
I wonder whether treating failure to set up these sysfs entries as an
error condition is appropriate here in the first place.

Additionally it appears to me that populate_msi_sysfs() has
incomplete error handling too - kset_unregister() isn't being
called, and pdev->msi_kset is left set to non-NULL.

Thanks, Jan

