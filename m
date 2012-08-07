Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44407 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756863Ab2HGAN4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Aug 2012 20:13:56 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1SyXQp-0001WR-PD
	for linux-pci@vger.kernel.org; Tue, 07 Aug 2012 02:13:55 +0200
Received: from 99-119-199-15.lightspeed.sntcca.sbcglobal.net ([99.119.199.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 07 Aug 2012 02:13:55 +0200
Received: from paolopiace by 99-119-199-15.lightspeed.sntcca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 07 Aug 2012 02:13:55 +0200
To: linux-pci@vger.kernel.org
From: Paolo <paolopiace@gmail.com>
Subject: Re: accessing =?utf-8?b?cGNpX2Rldg==?=
Date: Tue, 7 Aug 2012 00:13:45 +0000 (UTC)
Message-ID: <loom.20120807T020525-624@post.gmane.org>
References: <loom.20120807T001740-895@post.gmane.org> <20120806224658.GA8579@kroah.com> <loom.20120807T010348-354@post.gmane.org> <CAErSpo5-U1AJr1+HbkGxXKKa8MQ0WOzSpVNy7ooj2rtPoXyHnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas <at> google.com> writes:
>
> The user command "lspci -x" is a good way to see raw config space.

Sure, Thanks. But I need & want to do everything with the functions
pci_read_config_...

They need the struct pci_dev whose pointer is returned by the BIOS (or Kernel?)
as parameter of the probe function in the struct pci_driver

There must be a way to get access to each and every pci_dev without resorting to
the probe function.

That's what I'm looking fwd to know.

Regards

