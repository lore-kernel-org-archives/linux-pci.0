Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60913 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754662AbbIDFcU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Sep 2015 01:32:20 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1ZXjbl-0008KY-57
	for linux-pci@vger.kernel.org; Fri, 04 Sep 2015 07:32:17 +0200
Received: from 195.219.98.189 ([195.219.98.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2015 07:32:17 +0200
Received: from peio by 195.219.98.189 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2015 07:32:17 +0200
To: linux-pci@vger.kernel.org
From: Peio <peio@azkarate.eu>
Subject: Re: PCI rescan : can't assign mem [SOLVED]
Date: Fri, 4 Sep 2015 05:32:11 +0000 (UTC)
Message-ID: <loom.20150904T072156-908@post.gmane.org>
References: <loom.20150831T091131-859@post.gmane.org> <CAE9FiQWNA1BEGom757xtbc0zFjFqZ9uqKwj2kM7EFDDKXEL6fw@mail.gmail.com> <loom.20150901T110001-176@post.gmane.org> <CAE9FiQUxU2FCxFKQ=6ZdnJL8fU-YxAOjQmMSAP_YBG1gEG+ntA@mail.gmail.com> <loom.20150902T084450-322@post.gmane.org> <CAE9FiQWgrymUN07D5rFr0XVrF1Ays606JaWQCfH47Av0cv8q0g@mail.gmail.com> <loom.20150903T080202-734@post.gmane.org> <loom.20150903T113710-656@post.gmane.org> <CAErSpo6KYCM99H5J0JvYymNmbn-O1NfVwo4Lp7B=2cXCFQwnOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas <at> google.com> writes:

> This is a workaround, not a solution.  It is not safe to use
> "pci=nocrs" in general because it can break things related to resource
> assignment, including hot-add of new devices.
> 
> I haven't looked at the problem in detail, but if the BIOS gives us a
> _CRS with host bridge windows that are too small to accommodate all
> your devices, there's really nothing the kernel can do about it.  You
> just have to regard it as a limitation of that platform.
> 
> Bjorn
> 
I'm sure itsn't a platform limitation, a BIOS issue assigning resources 
instead.

Anyway, It's a closed system, without hot-add or not own devices.

I suspect this workaround is fine to me. 



