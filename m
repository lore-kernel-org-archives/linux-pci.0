Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37661 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbbIAJBk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 1 Sep 2015 05:01:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1ZWhRh-0008KH-1l
	for linux-pci@vger.kernel.org; Tue, 01 Sep 2015 11:01:37 +0200
Received: from 195.219.98.189 ([195.219.98.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2015 11:01:37 +0200
Received: from peio by 195.219.98.189 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2015 11:01:37 +0200
To: linux-pci@vger.kernel.org
From: Peio <peio@azkarate.eu>
Subject: Re: PCI rescan : can't assign mem
Date: Tue, 1 Sep 2015 09:01:30 +0000 (UTC)
Message-ID: <loom.20150901T110001-176@post.gmane.org>
References: <loom.20150831T091131-859@post.gmane.org> <CAE9FiQWNA1BEGom757xtbc0zFjFqZ9uqKwj2kM7EFDDKXEL6fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yinghai Lu <yinghai <at> kernel.org> writes:


> how about current upsteam kernel?

> > Is possible to fix it?
> 
> Please whole post boot log with "debug ignore_loglevel".
> 
> Need _CRS from BIOS provide enough MMIO range for 00:1c.0
> 
> Yinghai
> 

I prefer the stable kernel used by ubuntu 14.04.
My BIOS don't have MMIO range configuration options.
Log with "debug ignore_loglevel" sentto Yinghai (too long for post here).


