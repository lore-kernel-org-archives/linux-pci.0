Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 11/14] ARM: tegra: tamonten: Add PCIe support
Date: Wed, 9 Jan 2013 21:23:37 +0000
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
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de> <1357764194-12677-12-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1357764194-12677-12-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201301092123.37491.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 09 January 2013, Thierry Reding wrote:
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  arch/arm/boot/dts/tegra20-tamonten.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It's not clear how this one-line patch adds PCIe support to the
platform. Are you missing the actual change here?

	Arnd
