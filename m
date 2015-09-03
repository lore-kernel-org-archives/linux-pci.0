Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38404 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbbICJp4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Sep 2015 05:45:56 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1ZXR5d-0004Tg-H5
	for linux-pci@vger.kernel.org; Thu, 03 Sep 2015 11:45:54 +0200
Received: from 195.219.98.189 ([195.219.98.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2015 11:45:53 +0200
Received: from peio by 195.219.98.189 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2015 11:45:53 +0200
To: linux-pci@vger.kernel.org
From: Peio <peio@azkarate.eu>
Subject: Re: PCI rescan : can't assign mem [SOLVED]
Date: Thu, 3 Sep 2015 09:45:47 +0000 (UTC)
Message-ID: <loom.20150903T113710-656@post.gmane.org>
References: <loom.20150831T091131-859@post.gmane.org> <CAE9FiQWNA1BEGom757xtbc0zFjFqZ9uqKwj2kM7EFDDKXEL6fw@mail.gmail.com> <loom.20150901T110001-176@post.gmane.org> <CAE9FiQUxU2FCxFKQ=6ZdnJL8fU-YxAOjQmMSAP_YBG1gEG+ntA@mail.gmail.com> <loom.20150902T084450-322@post.gmane.org> <CAE9FiQWgrymUN07D5rFr0XVrF1Ays606JaWQCfH47Av0cv8q0g@mail.gmail.com> <loom.20150903T080202-734@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Peio <peio <at> azkarate.eu> writes:

> 
> Yinghai Lu <yinghai <at> kernel.org> writes:
> 
> > boot with pci=nocrs ?
> > 
> > Try to get BIOS update.
> > 
> > > If I change BIOS parameters I'll need a fresh install or the actual 
kernel
> > > reconigzes changes?.
> > should not.
> > 
> 
> I'll try pci=nocrs and BIOS update.
> Thank you Yinghai.
> 
> 
I solved the issue.

1.- Boot kernel with pci=nocrs parameter (linux assigns lot of memory ro pci 
root bus).

2.- Remove upstream bridge : 
sudo echo 1 > /sys/bus/pci/devices/0000:00:1c.0/remove

3.- Rescan PCI bus
sudo echo 1 > /sys/bus/pci/rescan


