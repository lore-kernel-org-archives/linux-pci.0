Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sat, 30 Jun 2018 14:19:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V2] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
Message-ID: <20180630191959.GB9547@bhelgaas-glaptop.roam.corp.google.com>
References: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
 <20180630004912.GI40928@bhelgaas-glaptop.roam.corp.google.com>
 <568634cf-54d0-c67d-b0f8-766b67def610@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <568634cf-54d0-c67d-b0f8-766b67def610@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 open list <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 30, 2018 at 10:45:21AM -0400, Sinan Kaya wrote:
> On 6/29/2018 8:49 PM, Bjorn Helgaas wrote:
> > On Tue, Jun 19, 2018 at 10:14:46PM -0400, Sinan Kaya wrote:
> >> A PCIe endpoint carries the process address space identifier (PASID) in
> >> the TLP prefix as part of the memory read/write transaction. The address
> >> information in the TLP is relevant only for a given PASID context.
> >>
> >> An IOMMU takes PASID value and the address information from the
> >> TLP to look up the physical address in the system.
> >>
> >> If a bridge drops the TLP prefix, the translation agent can resolve the
> >> address to an incorrect location and cause data corruption. Prevent
> >> this condition by requiring End-to-End TLP prefix to be supported on the
> >> entire data path between the endpoint and the root port.
> > 
> > PASID is an End-End TLP Prefix (PCIe r4.0, sec 6.20).  Sec 2.2.10.2 says
> > 
> >   It is an error to receive a TLP with an End-End TLP Prefix by a
> >   Receiver that does not support End-End TLP Prefixes. A TLP in
> >   violation of this rule is handled as a Malformed TLP. This is a
> >   reported error associated with the Receiving Port (see Section 6.2).
> > 
> > So I agree that we shouldn't enable PASID in an endpoint unless all
> > the switch ports leading to it support End-End prefixes.  But I don't
> > see how a bridge can drop a prefix and cause data corruption -- if it
> > doesn't support End-End prefixes, shouldn't the bridge raise a
> > Malformed TLP error instead of forwarding the TLP?
> 
> It should under normal circumstances. 
> 
> I remember reading that most PCIe switches don't support TLP prefixes.
> I don't know if it is because of buggy behavior or if it is just plain
> unsupported while dropping the request as Malformed TLP.
> 
> I was trying to be proactive and not enable PASID if the entire path
> is incapable.

Absolutely, that makes perfect sense.  Much better to fail to enable
PASID rather than enabling it and seeing Malformed TLP errors or data
corruption later.

I was trying to figure out if you can actually force data corruption
this way.  If you can, I'd say that sounds like a buggy switch that we
might want to be aware of.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
