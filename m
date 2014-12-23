Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:50522 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbaLWUbV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Dec 2014 15:31:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Pratyush Anand <panand@redhat.com>
Cc: mohit.kumar@st.com, jg1.han@samsung.com, l.stach@pengutronix.de,
	shawn.guo@freescale.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
	Sean Cross <xobs@kosagi.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: Re: [PATCH] PCIe: Designware: Do not allow config space through ranges
Date: Tue, 23 Dec 2014 21:31:01 +0100
Message-ID: <3330424.GRa0M3NfZG@wuerfel>
In-Reply-To: <5498D97A.8030105@redhat.com>
References: <7dcdee69eb7db8336829e6085d736a3ac7e68ad4.1419229126.git.panand@redhat.com> <5459567.EisgEvQXh9@wuerfel> <5498D97A.8030105@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 23 December 2014 08:24:50 Pratyush Anand wrote:
> On Monday 22 December 2014 02:00 PM, Arnd Bergmann wrote:
> > On Monday 22 December 2014 12:09:04 Pratyush Anand wrote:

> >> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> >> index df781cdf13c1..0b22b42e1ff9 100644
> >> --- a/drivers/pci/host/pcie-designware.c
> >> +++ b/drivers/pci/host/pcie-designware.c
> >> @@ -409,19 +409,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >>                      pp->mem_mod_base = of_read_number(parser.range -
> >>                                                        parser.np + na, ns);
> >>              }
> >> -            if (restype == 0) {
> >> -                    of_pci_range_to_resource(&range, np, &pp->cfg);
> >> -                    pp->cfg0_size = resource_size(&pp->cfg)/2;
> >> -                    pp->cfg1_size = resource_size(&pp->cfg)/2;
> >> -                    pp->cfg0_base = pp->cfg.start;
> >> -                    pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
> >> -
> >> -                    /* Find the untranslated configuration space address */
> >> -                    pp->cfg0_mod_base = of_read_number(parser.range -
> >> -                                                       parser.np + na, ns);
> >> -                    pp->cfg1_mod_base = pp->cfg0_mod_base +
> >> -                                        pp->cfg0_size;
> >> -            }
> >>      }
> >
> > Since we've allowed this for so long, it may be better to leave this
> > in for compatibility with old dts files. It would however be good to
> > print a warning message. We could also limit it to those machines that
> > are known to have been used with this property in the past.
> 
> I think, only imx6 is using "config from ranges", for which I made the 
> change in this patch. Modification need to be tested and acked by IMX6 
> maintainers.
> I do not see any other driver using it. However, I have kept all 
> designware user in CC here.

The change to look at the 'reg' property for config space was introduced
in 4dd964df36d ("PCI: designware: Look for configuration space in 'reg',
not 'ranges'"), and at the time, we had Exynos5440 and i.MX as users,
which is only a small subset of what we have now. If we are sure that
on both architectures we don't need to support backwards compatibility
for the existing dtbs, then we can do it, but that would be hard to
prove, unless we know for sure that the platforms are already broken
for any user that has old dtb files.

	Arnd
