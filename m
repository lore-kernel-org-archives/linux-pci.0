Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH 1/9] PCI: Simplify disconnected marking
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>, Oza Pawandeep <poza@codeaurora.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <cover.1534686484.git.lukas@wunner.de>
 <10f51ea0e0a29b33a5f87e7eb98fe4cdf8cb681f.1534686485.git.lukas@wunner.de>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <d7d7537f-12ea-b9a4-aa6f-9a7d55db1b25@kernel.org>
Date: Sun, 19 Aug 2018 17:56:19 -0400
MIME-Version: 1.0
In-Reply-To: <10f51ea0e0a29b33a5f87e7eb98fe4cdf8cb681f.1534686485.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 8/19/2018 10:29 AM, Lukas Wunner wrote:
>   		pci_dev_get(dev);
> -		if (!presence) {
> -			pci_dev_set_disconnected(dev, NULL);
> -			if (pci_has_subordinate(dev))
> -				pci_walk_bus(dev->subordinate,
> -					     pci_dev_set_disconnected, NULL);
> -		}

Thanks, I never liked this.
