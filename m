Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21296 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757140Ab2DFCoD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Apr 2012 22:44:03 -0400
From: "Hao, Xudong" <xudong.hao@intel.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Expose ltr/obff interface by sysfs
Date: Fri, 6 Apr 2012 02:43:59 +0000
Message-ID: <403610A45A2B5242BD291EDAE8B37D300FD0A434@SHSMSX102.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, 

I'm working on virtualization Xen/KVM. I saw there are ltr/obff enabling/disabling function in pci.c, but no called till now. I want to know if anybody(driver developer) are working for using it? Can driver change the LTR latency value dynamically?

/*
LTR(Latency tolerance reporting) allows devices to send messages to the root complex indicating their latency tolerance for snooped & unsnooped memory transactions.
OBFF (optimized buffer flush/fill), where supported, can help improve energy efficiency by giving devices information about when interrupts and other activity will have a reduced power impact.
*/

One way to control ltr/obff is used by driver, however, I'm considering that in virtualization, how guest OS driver control them. I have an idea that expose an inode interface by sysfs, like "reset" inode implemented in pci-sysfs.c, so that system user/administrator can enable/disable ltr/obff or set latency value on userspace, but not limited on driver. Comments?

< pls CC me when reply this mail, thanks >

Best Regards,
Xudong Hao

