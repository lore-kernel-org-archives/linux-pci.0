Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbeC3Wu1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 18:50:27 -0400
Date: Fri, 30 Mar 2018 17:50:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Feng Kan <fkan@apm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Toan Le <toanle@apm.com>
Subject: Re: [PATCH V3] PM / core: fix deferred probe breaking suspend resume
 order
Message-ID: <20180330225024.GH9322@bhelgaas-glaptop.roam.corp.google.com>
References: <1520274579-30492-1-git-send-email-fkan@apm.com>
 <CAL85gmAAVoCCXoLH+c0ROSBy4mS3z86tnbX+7Avh5oGT=fHcfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL85gmAAVoCCXoLH+c0ROSBy4mS3z86tnbX+7Avh5oGT=fHcfA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:41:33AM -0700, Feng Kan wrote:
> On Mon, Mar 5, 2018 at 10:29 AM, Feng Kan <fkan@apm.com> wrote:
> > When bridge and its endpoint is enumerated the devices are added to the
> > dpm list. Afterward, the bridge defers probe when IOMMU is not ready.
> > This causes the bridge to be moved to the end of the dpm list when
> > deferred probe kicks in. The order of the dpm list for bridge and
> > endpoint is reversed.
> >
> > Add reordering code to move the bridge and its children and consumers to
> > the end of the pm list so the order for suspend and resume is not altered.
> > The code also move device and its children and consumers to the tail of
> > device_kset list if it is registered.
> >
> > Signed-off-by: Feng Kan <fkan@apm.com>
> > Signed-off-by: Toan Le <toanle@apm.com>
> > ...
> >
> Hi, just wanted to check if there is anything else I need to change on
> this. Thanks.

I'm assuming Rafael will handle this.
