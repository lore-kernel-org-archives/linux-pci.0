Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbdHCQep (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 12:34:45 -0400
Date: Thu, 3 Aug 2017 11:34:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Bezzubikov <zuban32s@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Marcel Apfelbaum <marcel@redhat.com>
Subject: Re: [PATCH] pci: shpchp: set the bridge busmaster if MSI are enabled
Message-ID: <20170803163443.GT20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1500387145-4216-1-git-send-email-zuban32s@gmail.com>
 <20170802223547.GP20308@bhelgaas-glaptop.roam.corp.google.com>
 <CAKSfGUA_1ccDBaChXaWwOKthq-okkAmYADpWxQXQ67DG6SjgYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKSfGUA_1ccDBaChXaWwOKthq-okkAmYADpWxQXQ67DG6SjgYA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 03, 2017 at 01:48:51AM +0300, Alexander Bezzubikov wrote:
> 2017-08-03 1:35 GMT+03:00 Bjorn Helgaas <helgaas@kernel.org>:
> > On Tue, Jul 18, 2017 at 05:12:25PM +0300, Aleksandr Bezzubikov wrote:
> >> An MSI-based SHPC built in PCI bridges can configure hotplugged devices
> >> only if they notify the bridge with MSI.
> >
> > I think you're referring to the events listed in SHPC r1.0, sec 4.7.3,
> > table 4-24, right?  Attention Button Press, Isolated Power Fault, Card
> > Presence Change, MRS Sensor Change, etc?
> >
> > So IIUC, this is really about the bridge itself generating MSIs about
> > slot-related events, not the hot-added devices generating MSIs.
> >
> 
> You're right, it's definitely about the bridge's built-in SHPC
> that generates MSIs.

Great, thanks for confirming that.  I applied this to pci/hotplug for v4.14
with the following changelog:

  PCI: shpchp: Enable bridge bus mastering if MSI is enabled

  An SHPC may generate MSIs to notify software about slot or controller
  events (SHPC spec r1.0, sec 4.7).  A PCI device can only generate an MSI if
  it has bus mastering enabled.

  Enable bus mastering if the bridge contains an SHPC that uses MSI for event
  notifications.

  Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
  [bhelgaas: changelog]
  Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
  Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
  Acked-by: Michael S. Tsirkin <mst@redhat.com>
  Cc: stable@vger.kernel.org
