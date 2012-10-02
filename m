Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53356 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195Ab2JBGZY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Oct 2012 02:25:24 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1TIvum-0007ti-AZ
	for linux-pci@vger.kernel.org; Tue, 02 Oct 2012 08:25:08 +0200
Received: from 99-119-199-15.lightspeed.sntcca.sbcglobal.net ([99.119.199.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 08:25:08 +0200
Received: from paolopiace by 99-119-199-15.lightspeed.sntcca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 08:25:08 +0200
To: linux-pci@vger.kernel.org
From: Paolo <paolopiace@hotmail.com>
Subject: Re: =?utf-8?b?cGNpX3JlcXVlc3RfcmVnaW9ucygp?=
Date: Tue, 2 Oct 2012 06:16:53 +0000 (UTC)
Message-ID: <loom.20121002T080608-96@post.gmane.org>
References: <loom.20121002T002058-318@post.gmane.org> <CAErSpo7q4tYwCHnMjovyDVXdCpGrWkqmO5u=1yAAhh7XBL_ASA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas <at> google.com> writes:
> 
> In 2.6.32, the function pci_request_regions() is in the file
> drivers/pci/pci.c.  It's still there in the current kernel (v3.6).
> 
> The stuff below looks like a directory hierarchy, not information
> about the *contents* of the files.
>

Don't know what to say. There is NO string "pci_request_regions" in any of those
files. They are just Makefile and Kconfig.
Yet, I'm working on a driver that calls that function and works just fine.
How/where does it find that pci_request_regions()?

Here is the output of the ls command, purged of the dot directories.

paolo@paolo-DT0:/usr/src/linux-headers-2.6.32-43$ ls -laR drivers/pci/

drivers/pci/:
drwxr-xr-x  2 root root 4096 2012-09-20 14:55 hotplug
-rw-r--r--  1 root root 1977 2009-12-02 19:51 Kconfig
-rw-r--r--  1 root root 1600 2009-12-02 19:51 Makefile
drwxr-xr-x  3 root root 4096 2012-09-20 14:55 pcie

drivers/pci/hotplug:
-rw-r--r-- 1 root root 4907 2009-12-02 19:51 Kconfig
-rw-r--r-- 1 root root 1855 2009-12-02 19:51 Makefile

drivers/pci/pcie:
drwxr-xr-x 2 root root 4096 2012-09-20 14:55 aer
-rw-r--r-- 1 root root 1241 2009-12-02 19:51 Kconfig
-rw-r--r-- 1 root root  286 2009-12-02 19:51 Makefile

drivers/pci/pcie/aer:
-rw-r--r-- 1 root root  634 2009-12-02 19:51 Kconfig
-rw-r--r-- 1 root root  585 2009-12-02 19:51 Kconfig.debug
-rw-r--r-- 1 root root  294 2009-12-02 19:51 Makefile


