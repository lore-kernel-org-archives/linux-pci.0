Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Jul 2017 14:45:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V3 1/2] PCI: Add Extended Tags quirk for Broadcom HT2100
 Root Port
Message-ID: <20170712194543.GF14614@bhelgaas-glaptop.roam.corp.google.com>
References: <1499786735-25782-1-git-send-email-okaya@codeaurora.org>
 <20170711195853.GA14614@bhelgaas-glaptop.roam.corp.google.com>
 <ae4dca5b-30cf-3a14-1707-380a3660badf@codeaurora.org>
 <20170711203957.GB14614@bhelgaas-glaptop.roam.corp.google.com>
 <25b6bbf6-20b5-dfc8-c92a-268c07fa1f98@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <25b6bbf6-20b5-dfc8-c92a-268c07fa1f98@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, wim.ten.have@oracle.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 12, 2017 at 09:07:14AM -0400, Sinan Kaya wrote:
> Hi Bjorn,
> 
> On 7/11/2017 4:39 PM, Bjorn Helgaas wrote:
> > My proposal handles endpoints, too.  The pci_walk_bus() in the quirk
> > handles all devices we've already enumerated, and all devices we'll
> > enumerate in the future are handled in pci_configure_device().
> 
> Code clears the endpoint's extended tag capability only if a quirky host
> bridge is found. 
> 
> The question here was 
> 
> "what if you have an endpoint, it may declare extended tags capability
> and has a bug even though the host bridge is just fine"
> 
> Code will enable extended tags on both the host bridge and endpoint
> if it is supported.
> 
> The host bridge will start generating 256 tags towards the endpoint
> but endpoint is unable to catch up with it. 
> 
> Same thing is possible with two endpoints that try to do peer-to-peer
> communication. The first endpoint may generate 256 requests, second
> endpoint may not handle it.
> 
> Again, this is a hypothetical condition with no known endpoints. I
> suggest we deal with this when time comes.

Jike's question (at least, the one I saw via email) was this:

Jike> Maybe checking the version of this endpoint at first? Do you expect a
Jike> v1 endpoint
Jike> to be working under v2+ ports?

This has nothing to do with whether a device is v1 or v2.  All PCIe devices
are expected to handle 8-bit tags as completers.  If we find defective
endpoints, we'll have to add quirks for them just like you did for the
HT2100 root port.  There's nothing we can do until we find them.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
