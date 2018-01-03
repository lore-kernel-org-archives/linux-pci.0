Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 24/26] video: fbdev: riva: deprecate
 pci_get_bus_and_slot()
Date: Wed, 03 Jan 2018 12:18:44 +0100
Message-id: <5036032.4uFqTqHFln@amdc3058>
In-reply-to: <04f4cf20-9b57-3eff-79b6-abfda1258174@codeaurora.org>
MIME-version: 1.0
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <CGME20180102133737epcas1p2cb1a62d59d9a83564db1f265c1643bf4@epcas1p2.samsung.com>
 <04f4cf20-9b57-3eff-79b6-abfda1258174@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "open list:NVIDIA \(rivafb and nvidiafb\)
 FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
 Antonino Daplas <adaplas@gmail.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, open list <linux-kernel@vger.kernel.org>,
 "open list:FRAMEBUFFER
 LAYER" <dri-devel@lists.freedesktop.org>, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 02, 2018 08:37:32 AM Sinan Kaya wrote:
> On 12/19/2017 12:38 AM, Sinan Kaya wrote:
> > pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> > where a PCI device is present. This restricts the device drivers to be
> > reused for other domain numbers.
> > 
> > Getting ready to remove pci_get_bus_and_slot() function in favor of
> > pci_get_domain_bus_and_slot().
> > 
> > struct riva_par has a pointer to struct pci_dev. Use the pci_dev member
> > to extract the domain information.
> > 
> > Change the function signature for CalcStateExt and RivaGetConfig to pass
> > in struct pci_dev in addition to RIVA_HW_INST so that code inside the
> > riva_hw.c can also calculate domain number and pass it to
> > pci_get_domain_bus_and_slot().
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Any feedback here, most of the remaining patches have the ACK except these?

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
