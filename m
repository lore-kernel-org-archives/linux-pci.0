Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33546 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbbIGGc7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Sep 2015 02:32:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1ZYpz2-0001up-Gf
	for linux-pci@vger.kernel.org; Mon, 07 Sep 2015 08:32:53 +0200
Received: from 195.219.98.189 ([195.219.98.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2015 08:32:52 +0200
Received: from peio by 195.219.98.189 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2015 08:32:52 +0200
To: linux-pci@vger.kernel.org
From: Peio <peio@azkarate.eu>
Subject: Re: PCI rescan : can't assign mem [SOLVED]
Date: Mon, 7 Sep 2015 06:32:45 +0000 (UTC)
Message-ID: <loom.20150907T082622-930@post.gmane.org>
References: <loom.20150831T091131-859@post.gmane.org> <CAE9FiQWNA1BEGom757xtbc0zFjFqZ9uqKwj2kM7EFDDKXEL6fw@mail.gmail.com> <loom.20150901T110001-176@post.gmane.org> <CAE9FiQUxU2FCxFKQ=6ZdnJL8fU-YxAOjQmMSAP_YBG1gEG+ntA@mail.gmail.com> <loom.20150902T084450-322@post.gmane.org> <CAE9FiQWgrymUN07D5rFr0XVrF1Ays606JaWQCfH47Av0cv8q0g@mail.gmail.com> <loom.20150903T080202-734@post.gmane.org> <loom.20150903T113710-656@post.gmane.org> <CAErSpo6KYCM99H5J0JvYymNmbn-O1NfVwo4Lp7B=2cXCFQwnOw@mail.gmail.com> <loom.20150904T072156-908@post.gmane.org> <CAErSpo7M8Ahaps00An2qXQWdMpq38batxxXrVSwDBqvHjsm8rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas <at> google.com> writes:

> 
> On Fri, Sep 4, 2015 at 12:32 AM, Peio <peio <at> azkarate.eu> wrote:
> > Bjorn Helgaas <bhelgaas <at> google.com> writes:
> >-
> 
> 
> If the workaround works for you, that's great and you should keep
> using it.  I just don't want to propagate the idea that "pci=nocrs" is
> the general solution for anything.   Ideally, a user should not have
> to use kernel parameters except for debugging or to work around
> hardware or firmware problems.
> 
> Bjorn
> 

At the moment I'll use the workaround, but a better solution will be, update 
the BIOS to a version assigning more memory resources to pcie.
Thank you for your warning Bjorn.

Peio



