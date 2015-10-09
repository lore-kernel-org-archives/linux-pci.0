Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Oct 2015 17:50:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: bhelgaas@google.com, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, nsekhar@ti.com,
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 0/2] DRA72/DRA74: Add 2 lane support
Message-ID: <20151009225056.GD16112@localhost>
References: <1443445058-643-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443445058-643-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Arnd, Rob]

On Mon, Sep 28, 2015 at 06:27:36PM +0530, Kishon Vijay Abraham I wrote:
> Add driver modifications in pci-dra7xx to get x2 mode working in
> DRA72 and DRA74. Certain modifications is needed in PHY driver also
> which I'll send as a separate series.
> 
> Kishon Vijay Abraham I (2):
>   pci: host: pci-dra7xx: use "num-lanes" property to find phy count
>   pci: host: pci-dra7xx: Enable x2 mode support

Applied to pci/host-dra7xx for v4.4, thanks!

I adjusted the subject line capitalization & format to match the history.

Arnd, Rob, any comments on the DT updates or the "num-lanes" vs number of
strings in "phy-names" changes?

Bjorn
