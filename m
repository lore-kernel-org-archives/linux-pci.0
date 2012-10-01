Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51161 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136Ab2JAW3T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Oct 2012 18:29:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1TIoUI-0004CU-7J
	for linux-pci@vger.kernel.org; Tue, 02 Oct 2012 00:29:18 +0200
Received: from 99-119-199-15.lightspeed.sntcca.sbcglobal.net ([99.119.199.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 00:29:18 +0200
Received: from paolopiace by 99-119-199-15.lightspeed.sntcca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 00:29:18 +0200
To: linux-pci@vger.kernel.org
From: Paolo <paolopiace@gmail.com>
Subject: =?utf-8?b?cGNpX3JlcXVlc3RfcmVnaW9ucygp?=
Date: Mon, 1 Oct 2012 22:28:31 +0000 (UTC)
Message-ID: <loom.20121002T002058-318@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I cannot locate pci_request_regions()

Where can I find it?

I am working with kernel 2.6.32.

Supposedly, it should be in drivers/pci/pci.c but there is nothing like that.

There, I see:
.
├── hotplug
│   ├── Kconfig
│   └── Makefile
├── Kconfig
├── Makefile
└── pcie
    ├── aer
    │   ├── Kconfig
    │   ├── Kconfig.debug
    │   └── Makefile
    ├── Kconfig
    └── Makefile

