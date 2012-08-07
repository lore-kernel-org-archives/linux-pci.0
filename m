Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56837 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab2HGFeS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Aug 2012 01:34:18 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1SycQq-0004Xp-6G
	for linux-pci@vger.kernel.org; Tue, 07 Aug 2012 07:34:16 +0200
Received: from 99-119-199-15.lightspeed.sntcca.sbcglobal.net ([99.119.199.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 07 Aug 2012 07:34:16 +0200
Received: from paolopiace by 99-119-199-15.lightspeed.sntcca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 07 Aug 2012 07:34:16 +0200
To: linux-pci@vger.kernel.org
From: Paolo <paolopiace@gmail.com>
Subject: Re: accessing =?utf-8?b?cGNpX2Rldg==?=
Date: Tue, 7 Aug 2012 05:34:04 +0000 (UTC)
Message-ID: <loom.20120807T073259-557@post.gmane.org>
References: <loom.20120807T001740-895@post.gmane.org> <20120806224658.GA8579@kroah.com> <loom.20120807T010348-354@post.gmane.org> <CAErSpo5-U1AJr1+HbkGxXKKa8MQ0WOzSpVNy7ooj2rtPoXyHnQ@mail.gmail.com> <loom.20120807T020525-624@post.gmane.org> <CAErSpo7FAjvnsaoao3m65K+b3i_u_pHtttREzZN7RqjJcZ0cDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas <at> google.com> writes:
> 
> pci_get_device().  In arch/mn10300/unit-asb2305/pci-irq.c,
> pcibios_fixup_irqs() does something similar to what you're asking for.

Thanks so much!!




