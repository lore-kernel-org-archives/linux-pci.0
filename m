Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 13 Jul 2017 18:38:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4] PCI: handle CRS returned by device after FLR
Message-ID: <20170713233859.GA5944@bhelgaas-glaptop.roam.corp.google.com>
References: <1499375234-23928-1-git-send-email-okaya@codeaurora.org>
 <20170713121758.GL4486@bhelgaas-glaptop.roam.corp.google.com>
 <0bcc0b00-1ad3-6866-32ab-15da8ea1821e@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <0bcc0b00-1ad3-6866-32ab-15da8ea1821e@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo.Pieralisi@arm.com, vikrams@codeaurora.org,
 linux-pci@vger.kernel.org, timur@codeaurora.org, linux-kernel@vger.kernel.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 13, 2017 at 11:44:12AM -0400, Sinan Kaya wrote:
> On 7/13/2017 8:17 AM, Bjorn Helgaas wrote:
> >> he spec is calling to wait up to 1 seconds if the device is sending CRS.
> >> The NVMe device seems to be requiring more. Relax this up to 60 seconds.
> > Can you add a pointer to the "1 second" requirement in the spec here?
> > We use 60 seconds in pci_scan_device() and acpiphp_add_context().  Is
> > there a basis in the spec for the 60 second timeout?
> 
> This does not specify a hard limit above on how long SW need to wait. 

I wouldn't expect a *maximum* time we can wait.  I'm looking for the
minimum times the spec requires.

If you're claiming "the spec is calling to wait up to 1 second", I
just want to know where in the spec it says that.  That helps in the
future when we need to maintain code like this.

> If I remember it right from CRS commit messages, 60 seconds was coming from
> some PCIe switch taking too long to boot.

If you have a pointer to this, please include it.  The earliest thing
I can find is when Linux was imported into git (1da177e4c3f4
("Linux-2.6.12-rc2")), which includes a 60 second timeout:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c?id=1da177e4c3f4#n686


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
