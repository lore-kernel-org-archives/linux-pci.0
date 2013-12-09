Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:41373 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042Ab3LIUPj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Dec 2013 15:15:39 -0500
Date: Mon, 9 Dec 2013 13:15:37 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Prevent bus conflicts while checking for bridge
 apertures
Message-ID: <20131209201537.GJ5429@obsidianresearch.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131206001947.27659.14981.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131209193112.GA20199@obsidianresearch.com>
 <CAErSpo5ab6buYa9GvpYECeeCwhYATt6dVePD6Cov-75kQndf4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5ab6buYa9GvpYECeeCwhYATt6dVePD6Cov-75kQndf4g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 09, 2013 at 01:00:36PM -0700, Bjorn Helgaas wrote:

> I don't think it's 100% spec compliant because the spec allows
> PCI_COMMAND_IO to be set if the bridge has an enabled I/O BAR but does
> not support an I/O aperture.  I admit I have never seen such a device,
> and I doubt one exists :)

Yes, fair enough!

Jason
