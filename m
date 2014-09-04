Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 4 Sep 2014 15:23:50 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Quentin Lambert <lambert.quentin@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Scott Murray <scott@spiteful.org>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fixing checkpatch errors and warnings for PCI hotplug
Message-ID: <20140904212350.GE17125@google.com>
References: <20140804185923.GA4185@greed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140804185923.GA4185@greed>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 04, 2014 at 08:59:23PM +0200, Quentin Lambert wrote:
> Patch 1 and 2 fix checkpatch coding style warnings.
> 
> Patch 3 fixes chechpatch errors due to assignement
> in if conditions.
> 
> 
> Quentin Lambert (3):
>   PCI hotplug: fix a missing space coding style issue
>   PCI hotplug: fix a simple if coding style issue
>   PCI hotplug: remove assignement from if conditions

I don't mind doing changes like these, but when we do, I want to do the
whole drivers/pci directory at once to minimize the churn.  I don't know
how you did these, but it looks like there are more instances than are
fixed by these patches, e.g.,

    drivers/pci/hotplug/cpcihp_generic.c:	if(!bridge) {
    drivers/pci/pci.c:      if ((i = pci_save_pcie_state(dev)) != 0)
