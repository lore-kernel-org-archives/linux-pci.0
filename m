Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy13-pub.unifiedlayer.com ([69.89.16.30]:50334 "HELO
	oproxy13-pub.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751594Ab3FYVNz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2013 17:13:55 -0400
Date: Tue, 25 Jun 2013 14:15:56 -0700
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, john.ronciak@intel.com,
	miles.j.penner@intel.com, bruce.w.allan@intel.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 6/6] x86/PCI: quirk Thunderbolt PCI-to-PCI bridges
Message-ID: <20130625141556.2f9de7b1@jbarnes-desktop>
In-Reply-To: <1372177330-28013-7-git-send-email-mika.westerberg@linux.intel.com>
References: <1372177330-28013-1-git-send-email-mika.westerberg@linux.intel.com>
	<1372177330-28013-7-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 25 Jun 2013 19:22:10 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> +	if (!(pci_probe & PCI_NOASSIGN_ROMS)) {
> +		pr_info("Thunderbolt host router detected disabling ROMs\n");
> +		pci_probe |= PCI_NOASSIGN_ROMS;
> +	}

I wonder if this should just be the default on x86?  Or do we allocate
ROM space to address some other platform where we need it and the BIOS
doesn't do it for the devices we care about?

-- 
Jesse Barnes, Intel Open Source Technology Center
