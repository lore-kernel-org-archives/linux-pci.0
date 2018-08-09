Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 9 Aug 2018 14:35:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 3/3] PCI: Intel DC P3700 NVMe delay after FLR quirk
Message-ID: <20180809193553.GD113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180724160440.2729.75178.stgit@gimli.home>
 <20180724161446.2729.78211.stgit@gimli.home>
 <20180724101849.36f635eb@t450s.home>
MIME-Version: 1.0
In-Reply-To: <20180724101849.36f635eb@t450s.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 24, 2018 at 10:18:48AM -0600, Alex Williamson wrote:
> On Tue, 24 Jul 2018 10:14:46 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > Add a device specific reset for Intel DC P3700 NVMe device which
> > exhibits a timeout failure in drivers waiting for the ready status to
> > update after NVMe enable if the driver interacts with the device too
> > quickly after FLR.  As this has been observed in device assignment
> > scenarios, resolve this with a device specific reset quirk to add an
> > additional, heuristically determined, delay after the FLR completes.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/quirks.c |   22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> 
> I forgot to link the bz in this one, if this somehow becomes the final
> version, please add:
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=159265

Corrected link to: https://bugzilla.redhat.com/show_bug.cgi?id=1592654

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
