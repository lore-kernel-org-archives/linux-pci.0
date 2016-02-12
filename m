Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38325 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbcBLDUf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Feb 2016 22:20:35 -0500
Date: Thu, 11 Feb 2016 21:20:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org
Subject: Re: Q: Relation between lanes to devices and to BARs
Message-ID: <20160212032026.GA28057@localhost>
References: <CAJ2oMhL-oL68ZOLsFEn3uGE=O9sMjcwPDH6oznLhG15xnzSQtQ@mail.gmail.com>
 <1454300093.10542.3.camel@redhat.com>
 <CAJ2oMh+MjG8frrE3DjHBtwrsG1vGwMcDzQQ8f-n0q-YBS04DZg@mail.gmail.com>
 <20160201205400.GB4861@localhost>
 <CAJ2oMh+8pAP3AwF+jBt4rMJ2VhuehSCGHNw7-2VwSeRyV759BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJ2oMh+8pAP3AwF+jBt4rMJ2VhuehSCGHNw7-2VwSeRyV759BA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 11, 2016 at 05:22:15PM +0200, Ran Shalit wrote:
> If I may please ask one more on this issue.
> You have made it clear the terms lanes & device in relation to
> PCI/PCI-e device driver.
> What about port ? Is there any relation between port to lane/device or
> is there no relation between these terms.

In Linux, PCIe Ports (Root Ports, Switch Upstream Ports, or Switch
Downstream Ports) are treated as devices.  There is a struct pci_dev
for each Port.  A Switch contains at least two Ports (an Upstream Port
and one or more Downstream Ports), and there is a pci_dev for each of
them.

There is no connection between the number of lanes and the number of
pci_dev structs.  The Linux PCI core doesn't do anything with the
number of lanes.  My understanding is that the devices on either end
of a Link normally negotiate the link width (number of lanes) between
themselves automatically, without software intervention.

> For example, can it be 1 device with 2 lanes and 8 ports for example ?

"1 device with 8 ports" is a phrase that would make sense in the PCIe
spec, where you could be talking about a Switch with one Upstream Port
and seven Downstream Ports.

But in the Linux kernel, since we treat each PCI/PCIe *function* as an
independent device, this looks like 8 devices.  There will be 8
pci_dev structs, one for each port.

The "2 lanes" part is irrelevant.  The number of lanes makes no
difference as far as how many pci_dev structs we have.

Bjorn
