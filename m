Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:54581 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108Ab2KQC1X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Nov 2012 21:27:23 -0500
From: Jon Mason <jon.mason@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Subject: [PATCH v6 0/2] PCI-Express Non-Transparent Bridge Support 
Date: Fri, 16 Nov 2012 19:27:11 -0700
Message-Id: <1353119233-32752-1-git-send-email-jon.mason@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I am submitting version 6 of the PCI-Express Non-Transparent Bridge
patches for inclusion in 3.8 via Greg KH's char-misc-next tree.  All
outstanding issues have been addressed.

Version 6 corrects Greg KH's issues, most notably the improper usage of
the Linux device model.
http://thread.gmane.org/gmane.linux.kernel.pci/18599

Thanks,
Jon

