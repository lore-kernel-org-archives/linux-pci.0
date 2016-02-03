Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52770 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754270AbcBCBaH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2016 20:30:07 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: Clean up warnings
Date: Wed, 03 Feb 2016 02:31:01 +0100
Message-ID: <2038203.Uh6oc2KHrK@vostro.rjw.lan>
In-Reply-To: <20160202191658.7887.28475.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202191658.7887.28475.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, February 02, 2016 01:20:28 PM Bjorn Helgaas wrote:
> I'm on a quest to clean up compiler warnings in drivers/pci.  I'd like to
> be able to treat warnings as errors, at least for the 0day build robot.
> 
> ---
> 
> Bjorn Helgaas (3):
>       PCI: Check device_attach() return value always
>       PCI/PME: Remove redundant port lookup
>       PCI/PME: Restructure pcie_pme_suspend() to prevent compiler warning
> 
> 
>  drivers/pci/bus.c      |    7 ++++++-
>  drivers/pci/pcie/pme.c |   11 ++++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)

ACK for all of the above, where applicable. :-)

Thanks,
Rafael

