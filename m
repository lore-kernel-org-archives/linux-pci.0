Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25336 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052Ab2IFAlh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Sep 2012 20:41:37 -0400
Date: Thu, 6 Sep 2012 08:41:34 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: PCI/e1000 BUG: unable to handle kernel paging request at 0ffff163
Message-ID: <20120906004134.GA12893@localhost>
References: <20120905065118.GA9603@localhost>
 <CAE9FiQVO6dj+rEP=phQD5VYEF-rak6UPYGMSV8ud0OyELo7Opg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVO6dj+rEP=phQD5VYEF-rak6UPYGMSV8ud0OyELo7Opg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2012 at 11:41:04AM -0700, Yinghai Lu wrote:
> On Tue, Sep 4, 2012 at 11:51 PM, Fengguang Wu <fengguang.wu@intel.com> wrote:
> > Yinghai,
> >
> > There are many kernel paging errors showing up in tree:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-for-each-res-addon-v2
> >
> > The below summary shows that
> >
> > 1) it's a reliably reproducible bug
> > 2) all paging fault happens at address 0ffff163 and in some e1000 functions
> >
> > I'll try to bisect if the root cause is not obvious to you.  (Cannot
> > do so for now because there are 3 bisections on the way and I cannot
> > afford more..)
> 
> thanks, will check that...
> 
> the 32bit kernel as kvm gust, and host is doing pci passthrough to
> export the VF to the KVM guest?

No I didn't do anything special for PCI passthrough. I just used KVM's
emulated e1000 device.

btw, I'll be able to start bisection after several hours.

Thanks,
Fengguang
