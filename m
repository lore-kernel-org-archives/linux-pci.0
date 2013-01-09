Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 05/14] lib: Add I/O map cache implementation
Date: Wed, 9 Jan 2013 21:19:56 +0000
Cc: linux-tegra@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Russell King <linux@arm.linux.org.uk>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de> <1357764194-12677-6-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1357764194-12677-6-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201301092119.57067.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 09 January 2013, Thierry Reding wrote:
> The I/O map cache is used to map large regions of physical memory in
> smaller chunks to avoid running out of vmalloc()/ioremap() space.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Can you explain why this is necessary and which problem it solves?
The implementation looks reasonable, but it's not clear to me if
we really need this new interface.

In what cases does it actually save ioremap space?

	Arnd
