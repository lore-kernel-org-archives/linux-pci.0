Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12517 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760783AbcBYPm3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Feb 2016 10:42:29 -0500
From: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v4 3/6] PCI: Add support for multiple DMA aliases
Date: Thu, 25 Feb 2016 15:41:51 +0000
Message-ID: <36D38C1F74839847A52A484C31F3E51A62180790@irsmsx105.ger.corp.intel.com>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160224194406.7585.17447.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160225143841.GA8726@localhost>
In-Reply-To: <20160225143841.GA8726@localhost>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0044_01D16FEB.6CF92500"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

------=_NextPart_000_0044_01D16FEB.6CF92500
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Thursday, February 25, 2016 3:39 PM
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lawrynowicz, Jacek <jacek.lawrynowicz@intel.com>; linux-
> pci@vger.kernel.org; Alex Williamson <alex.williamson@redhat.com>; Joerg
> Roedel <jroedel@suse.de>; David Woodhouse <dwmw2@infradead.org>;
> iommu@lists.linux-foundation.org
> Subject: Re: [PATCH v4 3/6] PCI: Add support for multiple DMA aliases
> 
> On Wed, Feb 24, 2016 at 01:44:06PM -0600, Bjorn Helgaas wrote:
> > From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
> >
> > <Insert changelog here>
> 
> (Sorry, I should have copied this changelog in the patch; I copied
> this manually from your v3 posting):
> 
> > This patch solves IOMMU support issues with PCIe non-transparent bridges
> > that use Requester ID look-up tables (LUT), e.g. PEX8733. Before exiting
> > the bridge, packet's RID is rewritten according to LUT programmed by
> > a driver. Modified packets are then passed to a destination bus and
> > processed upstream. The problem is that such packets seem to come from
> > non-existent nodes that are hidden behind NTB and are not discoverable
> > by a destination node, so IOMMU discards them. Adding DMA alias for a
> > given LUT entry allows IOMMU to create a proper mapping that enables
> > inter-node communication.
> 
> A specific example here would help me understand.  Here's how I
> understand this (correct me if I'm wrong): We're talking about a DMA
> packet being forwarded upstream from an NTB.  The NTB uses the LUT to
> rewrite the RID in the DMA packet.  The new RID from the LUT is
> unknown to the IOMMU, so it discards the DMA packet.

Yes, this is exactly the problem.

> > The current DMA alias implementation supports only single alias, so it's
> > not possible to connect more than two nodes when IOMMU is enabled. This
> > implementation enables all possible aliases on a given bus (256) that
> > are stored in a bitset. Alias devfn is directly translated to a bit
> > number. The bitset is not allocated for devices that have no need for
> > DMA aliases.
> 
> I think "two nodes" is referring to two PCIe devices on the other side
> of the NTB.  You want DMA packets from those devices to have different
> RIDs so the IOMMU can distinguish them.

Right.

> The LUT entries basically create aliases of the NTB (one alias for
> each device beyond the NTB).  Your quirk uses pci_add_dma_alias(), and
> the aliases are all on the same bus as the NTB itself.
> 
> The quirk adds PCI_DEVFN(0x10, 0x0), PCI_DEVFN(0x11, 0x0), and
> PCI_DEVFN(0x12, 0x0).  Shouldn't there be some connection between this
> and the LUT programming?  I assume the LUT is programmed to correspond
> to those aliases.  Does this mean you're limited to three devices
> beyond the NTB?

Yes, there is an indirect connection between LUT table and devfns used in the
quirk.
Dev part is an offset in the LUT table and function is taken from the device
behind the NTB.
So the driver can only change the dev part by using different LUT offsets.
We don't plan to modify this quirk. The number of PCIe devices beyond single
x200 card NTB will not change.
Two are used by x200 CPU (host bridge & root port) and one is used by x200 DMA
engine.
I'm not sure introducing some dependencies to make sure the offsets are set
correctly is really worth it.

So regarding the improvements in the patch description, you want me to update
and repost it?

BTW I posted x200 DMA driver (the client for this change) on DMA list:
https://lkml.org/lkml/2016/2/9/287
I'm working on integrating review comments and hope to get it included in 4.6.

Regards,
Jacek 

> > ---
> >  drivers/iommu/iommu.c |   17 ++++++++++-------
> >  drivers/pci/pci.c     |   11 +++++++++--
> >  drivers/pci/probe.c   |    1 +
> >  drivers/pci/search.c  |   14 +++++++++-----
> >  include/linux/pci.h   |    4 +---
> >  5 files changed, 30 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 0e3b009..a214e19 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -659,9 +659,15 @@ static struct iommu_group
> *get_pci_function_alias_group(struct pci_dev *pdev,
> >  	return NULL;
> >  }
> >
> > +static bool dma_alias_is_enabled(struct pci_dev *dev, u8 devfn)
> > +{
> > +	return dev->dma_alias_mask &&
> > +	       test_bit(devfn, dev->dma_alias_mask);
> > +}
> > +
> >  /*
> > - * Look for aliases to or from the given device for exisiting groups.  The
> > - * dma_alias_devfn only supports aliases on the same bus, therefore the
> search
> > + * Look for aliases to or from the given device for existing groups. DMA
> > + * aliases are only supported on the same bus, therefore the search
> 
> I'm trying to reconcile this statement that "DMA aliases are only
> supported on the same bus" (which was there even before this patch)
> with the fact that pci_for_each_dma_alias() does not have that
> limitation.
> 
> >   * space is quite small (especially since we're really only looking at pcie
> >   * device, and therefore only expect multiple slots on the root complex or
> >   * downstream switch ports).  It's conceivable though that a pair of
> > @@ -686,11 +692,8 @@ static struct iommu_group *get_pci_alias_group(struct
> pci_dev *pdev,
> >  			continue;
> >
> >  		/* We alias them or they alias us */
> > -		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN)
> &&
> > -		     pdev->dma_alias_devfn == tmp->devfn) ||
> > -		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > -		     tmp->dma_alias_devfn == pdev->devfn)) {
> > -
> > +		if (dma_alias_is_enabled(pdev, tmp->devfn) ||
> > +		    dma_alias_is_enabled(tmp, pdev->devfn)) {
> >  			group = get_pci_alias_group(tmp, devfns);
> 
> We basically have this:
> 
>   for_each_pci_dev(tmp) {
>     if (<pdev and tmp are DMA aliases>)
>       group = get_pci_alias_group();
>       ...
>   }
> 
> The DMA alias stuff relies on PCI internals, so it doesn't doesn't
> seem quite right to use things like PCI_DEV_FLAGS_DMA_ALIAS_DEVFN and
> dma_alias_devfn here in the IOMMU code.
> 
> I'm trying to figure out why we don't do something like the following
> instead:
> 
>   callback(struct pci_dev *pdev, u16 alias, void *opaque)
>   {
>     struct iommu_group *group;
> 
>     group = get_pci_alias_group();
>     if (group)
>       return group;
> 
>     return 0;
>   }
> 
>   pci_for_each_dma_alias(pdev, callback, ...);
> 
> Is the existing code some sort of optimization, e.g., checking
> PCI_DEV_FLAGS_DMA_ALIAS_DEVFN is cheaper than using
> pci_for_each_dma_alias()?
> 
> It seems like this won't work for some very unlikely but theoretically
> possible topologies, e.g.,
> 
>   PCIe Root Complex/IOMMU
>     PCIe switch A
>       PCIe to conventional PCI bridge
>         PCI to PCIe Root Complex
> 	  PCIe NTB
> 
> Here, I think the IOMMU will only see RIDs from PCIe switch A, but the
> current code only looks at DMA aliases that are on the same bus as the
> PCIe NTB.  Wouldn't using pci_for_each_dma_alias() handle this
> correctly?
> 
> >  			if (group) {
> >  				pci_dev_put(tmp);

------=_NextPart_000_0044_01D16FEB.6CF92500
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
VMv3yxHO8jex40LgMIIFijCCBHKgAwIBAgITMwAAHtrUMHJqXk2MNwAAAAAe2jANBgkqhkiG9w0B
AQUFADB5MQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRow
GAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMg
SXNzdWluZyBDQSA0QjAeFw0xNTEwMTIxMzEwNDlaFw0xODA5MjYxMzEwNDlaMEkxGzAZBgNVBAMT
Ekxhd3J5bm93aWN6LCBKYWNlazEqMCgGCSqGSIb3DQEJARYbamFjZWsubGF3cnlub3dpY3pAaW50
ZWwuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1tjwqdbx6/OJGZH6bcoU0kUw
Rfszjz7Ws3+m5aZzzysxb1a4/KemhppgfL8kAjJ4Ha35ixtjn2ZO+uAQ7IgJs512oyUkUZydLypc
4kobk1ZQiAeX1J/r0gwPQsbBBJu0rJ4uP9wMn6P1YQRHbjJ443cDPlYKjEzoFxnTlWwpQ4Zc3C8Y
DCLuZk6NPduNJ0++LIVOKi9s35cht7W8CxoVOjV9s9sZlEeN5oCGLVB9ORpt3GPh+8ap/WXTB6FW
Z8Zn/eH0FqPH/UOfbNlb6sJz9RnZ0RcIa+KJpj2QA38JfmSuGc+u+7Ds7/I+0GL3BIzOv9eGBA8h
DAAV8IwXGhwmQQIDAQABo4ICOTCCAjUwCwYDVR0PBAQDAgeAMDwGCSsGAQQBgjcVBwQvMC0GJSsG
AQQBgjcVCIbDjHWEmeVRg/2BKIWOn1OCkcAJZ4HevTmV8EMCAWQCAQgwHQYDVR0OBBYEFM3NoUwk
hZ72HaT2GREobB3IUpkTMB8GA1UdIwQYMBaAFNpBI5xaj3GvV4M+INPjZdsMywvbMGUGA1UdHwRe
MFwwWqBYoFaGVGh0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvQ1JML0ludGVsJTIwRXh0
ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRCLmNybDCBnwYIKwYBBQUHAQEEgZIwgY8w
IgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3NwLmludGVsLmNvbS8waQYIKwYBBQUHMAKGXWh0dHA6Ly93
d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNhdGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBC
YXNpYyUyMElzc3VpbmclMjBDQSUyMDRCLmNydDAfBgNVHSUEGDAWBggrBgEFBQcDBAYKKwYBBAGC
NwoDDDApBgkrBgEEAYI3FQoEHDAaMAoGCCsGAQUFBwMEMAwGCisGAQQBgjcKAwwwUwYDVR0RBEww
SqArBgorBgEEAYI3FAIDoB0MG2phY2VrLmxhd3J5bm93aWN6QGludGVsLmNvbYEbamFjZWsubGF3
cnlub3dpY3pAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQCXms3sgvqozD+mirP5B9PANgCE
RVBbEkYt8TzJE0B1lcLfXavkPldx1vC2vpblXofPfVyRbaUbobbIqohYCiblPvqso5raQmr8GeR1
RiWmiqiye2sA2nvQh1m7Skc6h7XBI3knNDzhG87zmvweY0Fgmbvdi7PGfMxjT4eiLjvzhWCthkmJ
NYoJ7Whtn60/vHl1OO6b7JeTqfNDc1NxV/g4dlMyFsr+XtyMGFzI0ch6eIzlpqeFDzKLI/5i8tzc
cZikcJThuwA/SfHHWEHs33gEHxa4F1x6ngyN8OdZgwdBc6nk6wgx6vLeDnN67fCNhQAadMeHjdP+
QqAEvc7XavdRMIIGfTCCBWWgAwIBAgIKGZmpegAAAAAy3TANBgkqhkiG9w0BAQUFADB5MQswCQYD
VQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYDVQQKExFJbnRl
bCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSA0
QTAeFw0xMzEwMjEwODU4NThaFw0xNjEwMDUwODU4NThaMEkxGzAZBgNVBAMTEkxhd3J5bm93aWN6
LCBKYWNlazEqMCgGCSqGSIb3DQEJARYbamFjZWsubGF3cnlub3dpY3pAaW50ZWwuY29tMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAplKHW1GF9qUj6MGOr6H3a+meHkH/FZW7bNFAFGic
hxCpbgkwPVjFPo5gqoTk1/vZazgMlr6BrETZHAT78vC2OfpHEOgRcBvE3aJw8AMk9q8Scsx43UWY
iK9Ys1i7idBWNH45OfCyHu7Z0pHCFywyQgFUK4FM10MlFNBXzET+rmgqU9RBIRFWkMOi0G4gmL7c
lLApKKFjjfhTx75W2WK3vsNK4Uw+omqR/Kli7IeXExsKOXjv8kuzifYZNAUHMiAGUZURbp5hv7IY
wG7SI9CDwDrtpFbu9k8RRRLNJnt8n+cueMPmNMeMv6PVy/8hmKn0tW+wIIO6hPbe8MbCqLcQJwID
AQABo4IDNTCCAzEwCwYDVR0PBAQDAgQwMD0GCSsGAQQBgjcVBwQwMC4GJisGAQQBgjcVCIbDjHWE
meVRg/2BKIWOn1OCkcAJZ4S52UGHhP9OAgFkAgENMEQGCSqGSIb3DQEJDwQ3MDUwDgYIKoZIhvcN
AwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG9w0DBzAdBgNVHQ4EFgQUa/PH
evLj3Q34U/tCjZKn2DnMMIwwHwYDVR0jBBgwFoAUHmkqtNwo/kcYTiELP7ysES/wmPUwgckGA1Ud
HwSBwTCBvjCBu6CBuKCBtYZUaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50
ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEEuY3Jshl1odHRwOi8vY2Vy
dGlmaWNhdGVzLmludGVsLmNvbS9yZXBvc2l0b3J5L0NSTC9JbnRlbCUyMEV4dGVybmFsJTIwQmFz
aWMlMjBJc3N1aW5nJTIwQ0ElMjA0QS5jcmwwge8GCCsGAQUFBwEBBIHiMIHfMGkGCCsGAQUFBzAC
hl1odHRwOi8vd3d3LmludGVsLmNvbS9yZXBvc2l0b3J5L2NlcnRpZmljYXRlcy9JbnRlbCUyMEV4
dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjA0QS5jcnQwcgYIKwYBBQUHMAKGZmh0dHA6
Ly9jZXJ0aWZpY2F0ZXMuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNhdGVzL0ludGVsJTIw
RXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRBLmNydDAfBgNVHSUEGDAWBggrBgEF
BQcDBAYKKwYBBAGCNwoDBDApBgkrBgEEAYI3FQoEHDAaMAoGCCsGAQUFBwMEMAwGCisGAQQBgjcK
AwQwUwYDVR0RBEwwSqArBgorBgEEAYI3FAIDoB0MG2phY2VrLmxhd3J5bm93aWN6QGludGVsLmNv
bYEbamFjZWsubGF3cnlub3dpY3pAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQCZxulYBdgq
w81+yDpeBMgPwjP6kyC2V0UHwaRygJD6LJEq5KNaJBQl1leJ8esPXOyFCSHyhkAE89FrFvNRhvJs
1B2vpT7sPMy0S8LHwJ/y+vokKXE+b69KwtOIhvzFuZ2SjloRtrN9gIL3lJSy/8hNDnh5Gmzq/KgY
Fv2hOoi1vQYta94hBCgLAjMdbZPuPhdHZxq7QRK871Ghg1tD0Rj1fxEp4aX+UVlcJruVTVdWCjaC
nv0dmSxtIG0tDh8bb8ZfPDbijqz8ul26z+7wHJCDB6dT6zwDCXnWIoD8nzLlaCyRvWUtiTC3wXpy
mh1fAkT91KBs8uiS6O8FccYZoylvMYID5zCCA+MCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNV
BAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24x
KzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEICEzMAAB7a1DByal5N
jDcAAAAAHtowCQYFKw4DAhoFAKCCAiswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMTYwMjI1MTU0MTUwWjAjBgkqhkiG9w0BCQQxFgQUWGQ6qa0kqHJnDfFC0DUrzlJ0
jkAwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgZgGCSsGAQQBgjcQBDGBijCB
hzB5MQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYD
VQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNz
dWluZyBDQSA0QQIKGZmpegAAAAAy3TCBmgYLKoZIhvcNAQkQAgsxgYqggYcweTELMAkGA1UEBhMC
VVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29y
cG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEECChmZ
qXoAAAAAMt0wDQYJKoZIhvcNAQEBBQAEggEAej1Y6Ovyu/eFAt9f64gs+thSDR0TiKm1X/+K6n6F
NbJ9tdCZ2j8ZXellbK0Z8nR+Kuz/tGvm4LkGPKDTBIx7nAgJ0TdR2/IS1a0r19D/a8qS5vYpn8MS
bJoD/Lgfjq8sytdog+apdH2WTrkqkA2VSEPTia4BJX07cpSgtv/TvFT9ykfn/P7NhpSpbZymlOSE
PO6F/P1EXxKjYJC4BaHdE2JZy1/9IUKbK9OR0jvR2zJB9t7+pqxyZG9JDjdcmpmWEWQy61DhteYP
EfbrV8P3Dn6F8JtKkT0PIaRs1nHVTovQq1G5VbrhE31H3T4V//1tSl3g8mGO6wOlUZoMD3B63AAA
AAAAAA==

------=_NextPart_000_0044_01D16FEB.6CF92500--
