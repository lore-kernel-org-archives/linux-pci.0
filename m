Return-Path: <SRS0=uSZ2=LE=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=uSZ2=LE=intel.com=keith.busch@kernel.org>
Date: Tue, 21 Aug 2018 10:44:13 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, poza@codeaurora.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
	Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
Message-ID: <20180821164413.GB18612@localhost.localdomain>
References: <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
 <a149d9657ca83b41c724b0ddd319c6fb@codeaurora.org>
 <512e0e11c3ba462c1d033f8b0e768fa27489731c.camel@kernel.crashing.org>
 <ad23b16cf7ff1f3b51961fda59533892@codeaurora.org>
 <2742bdba5ae8ccc420234b6e6b0224919367ed4c.camel@kernel.crashing.org>
 <20180821143751.GA18477@localhost.localdomain>
 <621f599b-8a87-5bde-5a9f-ecb5bdbcf716@kernel.org>
 <20180821152920.GA18612@localhost.localdomain>
 <37dc87b0-d0b1-8eb0-3eb9-ebccec6e4d77@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37dc87b0-d0b1-8eb0-3eb9-ebccec6e4d77@kernel.org>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 21, 2018 at 11:50:54AM -0400, Sinan Kaya wrote:
> On 8/21/2018 11:29 AM, Keith Busch wrote:
> > > Hotplug driver needs to handle both physical removal as well as intermittent
> > > link down issues though.
> > Back to your patch you linked to earlier, your proposal is to have
> > pciehp wait for DEVSTS.FED before deciding if it needs to handle the
> > DLLSC event. That might be a start, but it isn't enough since that
> > status isn't set if the downstream device reported ERR_FATAL. I think
> > you'd need to check the secondary status register for a Received System
> > Error.
> 
> Hmm, good feedback.
> 
> I was trying not to mix AER/DPC with HP but obviously I failed.
> I can add a flag to struct pci_dev like aer_pending for AER.
> 
> 1. AER ISR sets aer_pending
> 2. AER ISR issues a secondary bus reset
> 3. Hotplug driver bails out on aer_pending
> 4. AER ISR performs the recovery
> 
> It is slightly more challenging on the DPC front as HW brings down
> the link automatically and hotplug driver can observe the link down
> event before the DPC ISR. I'll have to go check if DPC interrupt is
> pending.
> 
> Let me know if this works out.

That sounds like a step in a good direction.

I think it's also safe to say the spec requires a slot capable of swapping
devices report the PDC slot event, so that should be valid criteria for
knowing if a hotplug event occured. There are other issues that we may
need to fix.

Consider a hierarchy of switches where the root port starts a DPC
event and the kernel tries to recover. Meanwhile devices downstream
switches lower in the hierarchy have changed. Since recovery doesn't do
re-enumeration and the top level downstream port didn't detect a hotplug
event, the recovery will "initialize" the wrong device to potentially
undefined results.

I think we'd need pciehp involved when error recovery rewalks the
downstream buses so pciehp may check PDC on capable ports. Implementing
'error_resume' in pciehp to de-enumerate/re-enumerate accordingly might
work ... If that happened, pciehp could call pcie_do_fatal_recovery()
and all three services could be unified!
