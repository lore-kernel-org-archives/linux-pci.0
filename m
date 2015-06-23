Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0135.outbound.protection.outlook.com ([157.56.110.135]:29870
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932284AbbFWCIP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Jun 2015 22:08:15 -0400
Date: Tue, 23 Jun 2015 10:07:15 +0800
From: Huang Rui <ray.huang@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Dexuan Cui <dexuan.cui@intel.com>,
	Matthew Wilcox <matthew@wil.cx>,
	"x86@kernel.org" <x86@kernel.org>, Felipe Balbi <balbi@ti.com>,
	Yu Zhao <yu.zhao@intel.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	"Chang, Jason" <Jason.Chang@amd.com>
Subject: Re: [PATCH 1/6] PCI: Use PCI_CLASS_SERIAL_USB instead of bare number
Message-ID: <20150623020710.GA6956@hr-slim.amd.com>
References: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150619224223.14626.20847.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150619224223.14626.20847.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 20, 2015 at 06:42:23AM +0800, Bjorn Helgaas wrote:
> be6646bfbaec ("PCI: Prevent xHCI driver from claiming AMD Nolan USB3 DRD
> device") added a quirk to override the PCI class code of the AMD Nolan
> device.
> 
> Use PCI_CLASS_SERIAL_USB instead of a bare number to improve greppability.
> Also add a log message about what we're doing.
> 
> No functional change except the new message.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Huang Rui <ray.huang@amd.com>
> CC: Jason Chang <jason.chang@amd.com>
> CC: Felipe Balbi <balbi@ti.com>

Looks good for me.

Acked-by: Huang Rui <ray.huang@amd.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
