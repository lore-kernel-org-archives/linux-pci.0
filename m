Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 22/26] video: fbdev: intelfb: deprecate
 pci_get_bus_and_slot()
Date: Wed, 03 Jan 2018 12:18:15 +0100
Message-id: <1712261.2Mai7cXr8p@amdc3058>
In-reply-to: <7099e2af-4704-4611-94c0-830483de4578@codeaurora.org>
MIME-version: 1.0
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <CGME20180102133833epcas1p4003614ea6c95c4568e8433acbb30f52d@epcas1p4.samsung.com>
 <7099e2af-4704-4611-94c0-830483de4578@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "open list:INTEL FRAMEBUFFER DRIVER
 \(excluding 810 and 815\)" <linux-fbdev@vger.kernel.org>,
 linux-pci@vger.kernel.org, timur@codeaurora.org,
 Maik Broemme <mbroemme@libmpq.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 02, 2018 08:38:24 AM Sinan Kaya wrote:
> On 12/19/2017 12:37 AM, Sinan Kaya wrote:
> > pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> > where a PCI device is present. This restricts the device drivers to be
> > reused for other domain numbers.
> > 
> > Getting ready to remove pci_get_bus_and_slot() function in favor of
> > pci_get_domain_bus_and_slot().
> > 
> > Find the domain number from pdev.
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Any feedback here ? most of the remaining patches have the ACK except these.

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
