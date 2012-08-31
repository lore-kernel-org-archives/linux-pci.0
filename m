Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44626 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab2HaT5G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 31 Aug 2012 15:57:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1T7XKz-0000YK-4D
	for linux-pci@vger.kernel.org; Fri, 31 Aug 2012 21:57:05 +0200
Received: from 99-119-199-15.lightspeed.sntcca.sbcglobal.net ([99.119.199.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 31 Aug 2012 21:57:05 +0200
Received: from paolopiace by 99-119-199-15.lightspeed.sntcca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 31 Aug 2012 21:57:05 +0200
To: linux-pci@vger.kernel.org
From: Paolo <paolopiace@gmail.com>
Subject: Re: BAR0/1 & enumeration
Date: Fri, 31 Aug 2012 19:56:51 +0000 (UTC)
Message-ID: <loom.20120831T214839-854@post.gmane.org>
References: <loom.20120831T212633-656@post.gmane.org> <20120831194626.GB21160@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Not really.

I'm working on a NTB. NTBs are Type-0 headers, like any PCIe end point.
BAR0/1 on NTB can be set as base address for the config-space of its function OR
as based address of the memory space for memory transactions.

Hence my initial question. Looking fwd to some hint.

