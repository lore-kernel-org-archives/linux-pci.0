Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 23 May 2017 13:30:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v4 0/2] Tango PCIe controller support
Message-ID: <20170523183050.GA2637@bhelgaas-glaptop.roam.corp.google.com>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <20170523171758.GC24431@bhelgaas-glaptop.roam.corp.google.com>
 <cb5d08d6-bbbe-486f-b721-2eeeb410ab5e@free.fr>
MIME-Version: 1.0
In-Reply-To: <cb5d08d6-bbbe-486f-b721-2eeeb410ab5e@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Liviu Dudau <liviu.dudau@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 David Laight <david.laight@aculab.com>, Thomas Gleixner <tglx@linutronix.de>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 23, 2017 at 08:07:53PM +0200, Mason wrote:
> On 23/05/2017 19:17, Bjorn Helgaas wrote:
> >
> > On Thu, Apr 20, 2017 at 04:24:39PM +0200, Marc Gonzalez wrote:
> >
> >> This patch was split in two, to ease review of two orthogonal
> >> parts (MSI controller and host bridge). NB: the patch is
> >> just split in two where host bridge support starts.
> > 
> > The split is backwards.  The first patch should add basic host bridge
> > support that is functional, though lacking MSI support.  The second should
> > add the MSI support.
> 
> OK, I'll invert the patches.
> 
> Note: the bridge does not support legacy interrupts.
> Without MSI support, EPs can't interrupt the host.
> Is that still considered functional?

Yes.  The driver can at least claim the host bridge and enumerate PCI
devices.  If you add the MSI support first, that code is completely
dead and can never be called until the second patch is merged.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
