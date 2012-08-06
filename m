Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34713 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726Ab2HFXQn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Aug 2012 19:16:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1SyWXS-0001pN-Gh
	for linux-pci@vger.kernel.org; Tue, 07 Aug 2012 01:16:42 +0200
Received: from 99-119-199-15.lightspeed.sntcca.sbcglobal.net ([99.119.199.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 07 Aug 2012 01:16:42 +0200
Received: from paolopiace by 99-119-199-15.lightspeed.sntcca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 07 Aug 2012 01:16:42 +0200
To: linux-pci@vger.kernel.org
From: Paolo <paolopiace@gmail.com>
Subject: Re: accessing =?utf-8?b?cGNpX2Rldg==?=
Date: Mon, 6 Aug 2012 23:16:32 +0000 (UTC)
Message-ID: <loom.20120807T010348-354@post.gmane.org>
References: <loom.20120807T001740-895@post.gmane.org> <20120806224658.GA8579@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Greg KH <gregkh <at> linuxfoundation.org> writes:
> 
> Yes, but why would you?
> 
> What problem are you trying to solve?
>

Thanks for responding!

Basically, I want to check the config registers before and after the driver
registration in order to make sure that the driver is not contaminating them.

And, yes, it's the very first time I'm dealing with kernel & drivers.

