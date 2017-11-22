Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 22 Nov 2017 08:51:24 +0100
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 30/30] PCI: remove pci_get_bus_and_slot() function
Message-ID: <20171122075124.GA26583@kroah.com>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-31-git-send-email-okaya@codeaurora.org>
 <c0df99c9-9170-be3a-3789-6b25be30936f@codeaurora.org>
 <6a78596e-720a-80a2-9d96-dcc79a32f677@codeaurora.org>
 <25ec431a-2c1b-d352-f9ef-c663864664b6@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <25ec431a-2c1b-d352-f9ef-c663864664b6@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 22, 2017 at 12:08:45AM -0600, Timur Tabi wrote:
> On 11/21/17 11:55 PM, Sinan Kaya wrote:
> > For places where domain number information is available, I extracted domain number
> > and added into pci_get_domain_bus_and_slot() call such as xen or bn drivers.
> 
> My suggestion is that you restrict your first patch set to only these
> patches.
> 
> > The assumption at this point is for pci_get_bus_and_slot() usages to be caught
> > in code-review.
> 
> How about this:
> 
> static inline struct pci_dev * __deprecated pci_get_bus_and_slot(unsigned
> int bus,
> 						   unsigned int devfn)
> {
> 	return pci_get_domain_bus_and_slot(0, bus, devfn);
> }

Ick, no, why?  What is wrong with removing this function as is?  Don't
mark something as __depreciated if there are no in-kernel users, just
delete it and move on.

If you have out-of-tree drivers, then yes, they can make a wrapper for
this function like this if they really feel the need, or they can get
their code merged :)

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
