Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58330 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678Ab2HaTaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 31 Aug 2012 15:30:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1T7Wuq-0008S2-1Q
	for linux-pci@vger.kernel.org; Fri, 31 Aug 2012 21:30:04 +0200
Received: from 99-119-199-15.lightspeed.sntcca.sbcglobal.net ([99.119.199.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 31 Aug 2012 21:30:04 +0200
Received: from paolopiace by 99-119-199-15.lightspeed.sntcca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 31 Aug 2012 21:30:04 +0200
To: linux-pci@vger.kernel.org
From: Paolo <paolopiace@gmail.com>
Subject: BAR0/1 & enumeration
Date: Fri, 31 Aug 2012 19:29:50 +0000 (UTC)
Message-ID: <loom.20120831T212633-656@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As newbie to the pcie world, I'm seeking help for understanding this:

How does the bios during enumeration finds whether BAR0/1 is set for pointing to
the config-space of its function or to memory space for memory transactions?

Thanks!

