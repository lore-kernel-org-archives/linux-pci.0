Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14083 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbaG2Qno (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jul 2014 12:43:44 -0400
Message-ID: <1406652178.1011.191.camel@ul30vt.home>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
From: Alex Williamson <alex.williamson@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jordan_Hargrave@Dell.com, jon.mason@intel.com,
	Jon Mason <jdmason@kudzu.us>
Date: Tue, 29 Jul 2014 10:42:58 -0600
In-Reply-To: <alpine.LRH.2.03.1407291022380.5109@AMR>
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>
	 <1406650687.1011.180.camel@ul30vt.home>
	 <alpine.LRH.2.03.1407291022380.5109@AMR>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-07-29 at 10:30 -0600, Keith Busch wrote:
> On Tue, 29 Jul 2014, Alex Williamson wrote:
> > On Tue, 2014-07-29 at 16:17 +0800, Yijing Wang wrote:
> >> Currently we don't update device's mps value when doing
> >> pci device hot-add. The hot-added device's mps will be set
> >> to default value (128B). But the upstream port device's mps
> >> may be larger than 128B which was set by firmware during
> >> system bootup. In this case the new added device may not
> >> work normally.
> >
> > Apologies if we rehash some previously discussed topics while I try to
> > cover for Bjorn while he's out.  By "normally", do you mean "optimally"?
> > The device should be functional with a lower mps setting, right?
> 
> You'd think so, but some platforms don't work. A pci-e trace showed
> TLPs exceeding MPS when parent device at 256B and the end device left
> at 128B. Even if that's a platform bug, I think we still want it to work.

But if it's a platform bug for a non-compliant device, should it be
handled as a quirk rather than standard configuration?  Thanks,

Alex


