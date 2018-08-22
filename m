Return-Path: <SRS0=3zTz=LF=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=3zTz=LF=h08.hostsharing.net=foo00@kernel.org>
Date: Wed, 22 Aug 2018 11:13:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Keith Busch <keith.busch@intel.com>, poza@codeaurora.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
	Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
Message-ID: <20180822091333.rre2okhnrot44dyq@wunner.de>
References: <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
 <20180820155325.GA16148@localhost.localdomain>
 <cf6de256280be7a2948db6dd2b5bfae92e70e12f.camel@kernel.crashing.org>
 <6aa71d74-e4dc-c627-1496-981278388bce@kernel.org>
 <20180820213544.GA16805@localhost.localdomain>
 <0193e0c5a52d8f2e93958f0683f3acc81cef2bc9.camel@kernel.crashing.org>
 <fd538f20-0754-f127-ceb9-693fec90b4af@kernel.org>
 <44195c0d7159ce4cd01b660002b2f5af5d53678b.camel@kernel.crashing.org>
 <184814fb-0caf-b260-4415-8f96fbdf4831@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <184814fb-0caf-b260-4415-8f96fbdf4831@kernel.org>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2018 at 06:13:03PM -0400, Sinan Kaya wrote:
> presence detect is optional

Hm, how so?  Do you have a spec reference for that?

Thanks,

Lukas
