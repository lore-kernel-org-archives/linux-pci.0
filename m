Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Message-ID: <cae46bea2b02153d8d6661182b0111d32e8396b9.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@kernel.org>, poza@codeaurora.org,
        Bjorn Helgaas
 <helgaas@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue, 21 Aug 2018 08:19:52 +1000
In-Reply-To: <20180820221351.GA16932@localhost.localdomain>
References: 
	<5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
	 <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
	 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
	 <20180820155325.GA16148@localhost.localdomain>
	 <cf6de256280be7a2948db6dd2b5bfae92e70e12f.camel@kernel.crashing.org>
	 <6aa71d74-e4dc-c627-1496-981278388bce@kernel.org>
	 <20180820213544.GA16805@localhost.localdomain>
	 <0193e0c5a52d8f2e93958f0683f3acc81cef2bc9.camel@kernel.crashing.org>
	 <fd538f20-0754-f127-ceb9-693fec90b4af@kernel.org>
	 <44195c0d7159ce4cd01b660002b2f5af5d53678b.camel@kernel.crashing.org>
	 <20180820221351.GA16932@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2018-08-20 at 16:13 -0600, Keith Busch wrote:
> 
> There might be some potential here.
> 
> There actualy is a Slot Status Presence Detect State (PDS), but it isn't
> latched. The link and presence change (PDC) are latched.
> 
> A potential problem may be a PDC event handling observes PDS set to the
> last known state if the remove + add happens fast enough, and then no
> action is taken in the current implementation.
> 
> The DPC capability learned from such issues, and they will latch the
> status until acknowledged so those sorts of races are not possible.
> 
> But anyway, maybe we can change pciehp to ignore PDS and always
> re-enumerate when PDC is observed, and that may very well simplify a lot
> of this.

That sounds reasonable to me.

Cheers,
Ben.
