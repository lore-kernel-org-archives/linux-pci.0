Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 11 Dec 2017 10:42:33 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2] PCI: keystone: fix interrupt-controller-node lookup
Message-ID: <20171211104233.GB3225@red-moon>
References: <20171117133831.1300-1-johan@kernel.org>
 <20171211102955.GK5672@localhost>
MIME-Version: 1.0
In-Reply-To: <20171211102955.GK5672@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable <stable@vger.kernel.org>, Murali Karicheri <m-karicheri2@ti.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 11, 2017 at 11:29:55AM +0100, Johan Hovold wrote:
> On Fri, Nov 17, 2017 at 02:38:31PM +0100, Johan Hovold wrote:
> > Fix child-node lookup during initialisation which was using the wrong
> > OF-helper and ended up searching the whole device tree depth-first
> > starting at the parent rather than just matching on its children.
> > 
> > To make things worse, the parent pci node could end up being prematurely
> > freed as of_find_node_by_name() drops a reference to its first argument.
> > Any matching child interrupt-controller node was also leaked.
> > 
> > Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
> > Cc: stable <stable@vger.kernel.org>     # 3.18
> > Acked-by: Murali Karicheri <m-karicheri2@ti.com>
> > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> > 
> > v2
> >  - amend commit message and mention explicitly that of_find_node_by_name()
> >    drops a reference to the start node
> >  - add Murali's and Lorenzo's acks
> 
> This one hasn't shown up in linux-next, so sending a reminder to make
> sure it doesn't fall between the cracks.

Hi Johan,

yes it is in the list of fixes to be sent upstream - I was about to
ask Bjorn to apply it.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
