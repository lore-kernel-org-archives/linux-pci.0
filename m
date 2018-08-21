Return-Path: <SRS0=uSZ2=LE=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=uSZ2=LE=intel.com=keith.busch@kernel.org>
Date: Tue, 21 Aug 2018 09:29:21 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, poza@codeaurora.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
	Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
Message-ID: <20180821152920.GA18612@localhost.localdomain>
References: <908ff33ded8f31830f95a8889d8540f1@codeaurora.org>
 <5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
 <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
 <a149d9657ca83b41c724b0ddd319c6fb@codeaurora.org>
 <512e0e11c3ba462c1d033f8b0e768fa27489731c.camel@kernel.crashing.org>
 <ad23b16cf7ff1f3b51961fda59533892@codeaurora.org>
 <2742bdba5ae8ccc420234b6e6b0224919367ed4c.camel@kernel.crashing.org>
 <20180821143751.GA18477@localhost.localdomain>
 <621f599b-8a87-5bde-5a9f-ecb5bdbcf716@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <621f599b-8a87-5bde-5a9f-ecb5bdbcf716@kernel.org>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 21, 2018 at 11:07:31AM -0400, Sinan Kaya wrote:
> On 8/21/2018 10:37 AM, Keith Busch wrote:
> > The actions associated with error recovery will trigger link state changes
> > for a lot of existing hardware. PCIEHP currently does the same removal
> > sequence for both link state change (DLLSC) and presence detect change
> > (PDC) events.
> > 
> > It sounds like you want pciehp to do nothing on the DLLSC events that it
> > currently handles, and instead do the board removal only on PDC.  If that
> > is the case, is the desire to not remove devices downstream a permanently
> > disabled link, or does that responsibility fall onto some other component?
> > 
> 
> Looking at PDC is not enough. Hotplug driver handles both physical
> removal as well as the link going down due to signal integrity issues today.
> 
> If the link went down because of a pending FATAL error, AER/DPC recovers
> the link automatically. There is no need for hotplug to be involved in
> fatal error work.
> 
> Hotplug driver needs to handle both physical removal as well as intermittent
> link down issues though.

Back to your patch you linked to earlier, your proposal is to have
pciehp wait for DEVSTS.FED before deciding if it needs to handle the
DLLSC event. That might be a start, but it isn't enough since that
status isn't set if the downstream device reported ERR_FATAL. I think
you'd need to check the secondary status register for a Received System
Error.
