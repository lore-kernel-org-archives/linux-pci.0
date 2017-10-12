Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "M.h. Lian" <minghuan.lian@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: RE: [PATCH 1/2] PCI: Disable MSI for Freescale PCIe RC mode
Date: Thu, 12 Oct 2017 03:01:19 +0000
Message-ID: <VI1PR04MB161585379E4D3D7CB4794F35E84B0@VI1PR04MB1615.eurprd04.prod.outlook.com>
References: <20170922072522.36306-1-Zhiqiang.Hou@nxp.com>
 <20170922072522.36306-2-Zhiqiang.Hou@nxp.com>
 <20171011193737.GP25517@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171011193737.GP25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for your review.
Yes. All the freescale's PCIe controllers do not support to generate MSI interrupt.
The PCIe controllers developed for the next generation SoC do not support it either.

Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Thursday, October 12, 2017 3:38 AM
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> pci@vger.kernel.org; bhelgaas@google.com; Roy Zang <roy.zang@nxp.com>;
> Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>
> Subject: Re: [PATCH 1/2] PCI: Disable MSI for Freescale PCIe RC mode
> 
> On Fri, Sep 22, 2017 at 03:25:21PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > The Freescale PCIe controller advertises the MSI/MSI-X capability in
> > both RC and Endpoint mode, but in RC mode it doesn't support MSI/MSI-X
> > by it self, it can only transfer MSI/MSI-X from downstream
> 
> s/it self,/itself;/
> 
> > devices. So add this quirk to prevent use of MSI/MSI-X in RC mode.
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> >  drivers/pci/quirks.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > a4d33619a7bb..c1063a420f0c 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4799,3 +4799,11 @@ static void quirk_no_ats(struct pci_dev *pdev)
> >  /* AMD Stoney platform GPU */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
> > #endif /* CONFIG_PCI_ATS */
> > +
> > +/* Freescale PCIe doesn't support MSI in RC mode */ static void
> > +quirk_fsl_no_msi(struct pci_dev *pdev) {
> > +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> > +		pdev->no_msi = 1;
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
> > +quirk_fsl_no_msi);
> 
> This disables MSI for all Freescale root ports, past, present, and future.  Is that
> really what you want?  This is a bug (the root port shouldn't advertise MSI if it
> doesn't support it), and presumably it might be fixed in some future device?
> 
> This needs an ack from Minghuan or Mingkai (based on MAINTAINERS).
> 
> Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
