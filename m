Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 23 Mar 2017 17:14:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Masters <jcm@jonmasters.org>
Subject: Re: [PATCH] PCI: ACPI: Fix ThunderX PEM initialization
Message-ID: <20170323221439.GA12069@bhelgaas-glaptop.roam.corp.google.com>
References: <251db823-591b-483b-9c55-13c911020fd1@jonmasters.org>
 <48b93116-cc0f-e59d-8aa3-704052ad6759@gmail.com>
 <c3392131-9243-24d3-30b4-4d7e84019d6f@jonmasters.org>
 <20170321134744.GA13150@bhelgaas-glaptop.roam.corp.google.com>
 <b50b6a7f-30be-4206-4f38-2539ea936228@semihalf.com>
 <aad5796a-1af8-53e0-c5f3-cb7755519cd5@caviumnetworks.com>
 <de830a73-6f01-62af-b454-dc1588a209eb@jonmasters.org>
 <20170322144820.GA16556@bhelgaas-glaptop.roam.corp.google.com>
 <51ba853c-f543-b21b-c25f-b56d77746f92@jonmasters.org>
 <20170322163359.GB24935@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20170322163359.GB24935@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David.Daney@cavium.com, Tomasz Nowicki <tn@semihalf.com>,
 linux-pci@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>,
 linux-kernel@vger.kernel.org, stemerkhanov@CAVIUMNETWORKS.onmicrosoft.com,
 David Daney <ddaney.cavm@gmail.com>,
 Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 22, 2017 at 11:34:00AM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 22, 2017 at 12:25:39PM -0400, Jon Masters wrote:
> > On 03/22/2017 10:48 AM, Bjorn Helgaas wrote:
> > > On Wed, Mar 22, 2017 at 10:28:27AM -0400, Jon Masters wrote:
> > >> On 03/21/2017 10:56 AM, David Daney wrote:
> > > 
> > >>> Yes.  After all this back and forth, Cavium has decided to deploy
> > >>> firmware with "CAVxxx" as _HID.
> > >>
> > >> Great. How about a stable backport for Greg K-H? I want to make sure
> > >> that everyone running "upstream" has a chance of booting.
> > > 
> > > The first patch, fee4d813850c ("PCI: Use Cavium assigned hardware ID for
> > > ThunderX host controller"), has a stable tag already.
> > 
> > Thanks - I saw that after I mailed.
> > 
> > > The second, 1dc94a38af89 ("PCI: Add legacy firmware support for Cavium
> > > ThunderX host controller"), does not, but I can easily add it if needed.
> > 
> > I think that would be ideal. There is firmware out in the wild that
> > has neither identifier in it (for example, a bunch of folks in the
> > office bought platforms recently that don't boot upstream kernels).
> > My guys are used to just taking an upstream kernel and using that,
> > for development, and I have no intention of having the broader RH
> > org do any different from what they would do with an x86 box ;)
> 
> I added the same stable tag (v4.10+) to the second patch.

I moved these from pci/host-thunder (targeted for v4.12) to for-linus so we
can get these in v4.11.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
