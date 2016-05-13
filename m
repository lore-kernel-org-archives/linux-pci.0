Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20914 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbcEMMZl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 May 2016 08:25:41 -0400
From: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Joerg Roedel <jroedel@suse.de>,
	"Bjorn Helgaas" <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: Build breakage for pci-next since v4.6-rc5
Date: Fri, 13 May 2016 12:25:36 +0000
Message-ID: <36D38C1F74839847A52A484C31F3E51A62221FEF@irsmsx105.ger.corp.intel.com>
References: <20160513115642.GA22906@wunner.de>
In-Reply-To: <20160513115642.GA22906@wunner.de>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0019_01D1AD23.509D9420"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

------=_NextPart_000_0019_01D1AD23.509D9420
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Lukas, thanks for the heads up.

The actual commit that needs rebasing is:
    commit f0af9593372abfde34460aa1250e670cc535a7d8
    Author: Bjorn Helgaas <bhelgaas@google.com>
    Date:   Wed Feb 24 13:43:45 2016 -0600
    PCI: Add pci_add_dma_alias() to abstract implementation

It changes all direct usages of PCI_DEV_FLAGS_DMA_ALIAS_DEVFN to a
pci_add_dma_alias  function call.

Bjorn, you want me to post the rebased version?

Regards,
Jacek

-----Original Message-----
From: Lukas Wunner [mailto:lukas@wunner.de]=20
Sent: Friday, May 13, 2016 1:57 PM
To: Joerg Roedel <jroedel@suse.de>; Lawrynowicz, Jacek
<jacek.lawrynowicz@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; Alex Williamson
<alex.williamson@redhat.com>; linux-pci@vger.kernel.org
Subject: Build breakage for pci-next since v4.6-rc5

Hi Jacek, Hi J=F6rg,

in case this isn't on your radar yet, Bjorn Helgaas' next branch
currently no longer builds when merged with Linus' master branch
because this commit introduced with v4.6-rc5:

    commit e3156048346c28c695f5cf9db67a8cf88c90f947
    Author: Joerg Roedel <jroedel@suse.de>
    Date:   Fri Apr 8 15:12:24 2016 +0200
    iommu/amd: Fix checking of pci dma aliases

adds an occurrence of PCI_DEV_FLAGS_DMA_ALIAS_DEVFN but this
commit on Bjorn's next branch:

    commit 338c3149a221527e202ee26b1e35f76c965bb6c0
    Author: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
    Date:   Thu Mar 3 15:38:02 2016 +0100
    PCI: Add support for multiple DMA aliases

removed all other occurrences of this macro. A rebase of the
latter commit is required to fix the build breakage. I was
made aware of this yesterday by Intel's 0-DAY kernel test
infrastructure (see below).

Thanks,

Lukas

----- Forwarded message from kbuild test robot <fengguang.wu@intel.com> =
-----

Date: Thu, 12 May 2016 21:38:46 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: kbuild-all@01.org, Lukas Wunner <lukas@wunner.de>
Subject: [l1k:thunderbolt_runpm_v2 1/14] =
drivers/iommu/amd_iommu.c:266:22:
	error: 'PCI_DEV_FLAGS_DMA_ALIAS_DEVFN' undeclared
User-Agent: Mutt/1.5.23 (2014-03-12)

tree:   https://github.com/l1k/linux thunderbolt_runpm_v2
head:   308f7c892de104a57f50dda4761c10c094f5e80d
commit: 376a0f25bf07bdd90c58985f210c95a59d21fe1b [1/14] Merge =
remote-tracking
branches 'helgaas/next', 'helgaas/for-linus' and 'helgaas/pci/pm' into =
HEAD
config: x86_64-rhel (attached as .config)
compiler: gcc-4.9 (Debian 4.9.3-14) 4.9.3
reproduce:
        git checkout 376a0f25bf07bdd90c58985f210c95a59d21fe1b
        # save the attached .config to linux build tree
        make ARCH=3Dx86_64=20

Note: the l1k/thunderbolt_runpm_v2 HEAD =
308f7c892de104a57f50dda4761c10c094f5e80d
builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/iommu/amd_iommu.c: In function 'get_alias':
>> drivers/iommu/amd_iommu.c:266:22: error: =
'PCI_DEV_FLAGS_DMA_ALIAS_DEVFN'
undeclared (first use in this function)
      pdev->dev_flags |=3D PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
                         ^
   drivers/iommu/amd_iommu.c:266:22: note: each undeclared identifier is
reported only once for each function it appears in
>> drivers/iommu/amd_iommu.c:267:7: error: 'struct pci_dev' has no =
member named
'dma_alias_devfn'
      pdev->dma_alias_devfn =3D ivrs_alias & 0xff;
          ^

vim +/PCI_DEV_FLAGS_DMA_ALIAS_DEVFN +266 drivers/iommu/amd_iommu.c

e3156048 Joerg Roedel 2016-04-08  260  	/*
e3156048 Joerg Roedel 2016-04-08  261  	 * If we don't have a PCI DMA =
alias and
the IVRS alias is on the same
e3156048 Joerg Roedel 2016-04-08  262  	 * bus, then the IVRS table may =
know
about a quirk that we don't.
e3156048 Joerg Roedel 2016-04-08  263  	 */
e3156048 Joerg Roedel 2016-04-08  264  	if (pci_alias =3D=3D devid &&
e3156048 Joerg Roedel 2016-04-08  265  	    PCI_BUS_NUM(ivrs_alias) =
=3D=3D
pdev->bus->number) {
e3156048 Joerg Roedel 2016-04-08 @266  		pdev->dev_flags |=3D
PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
e3156048 Joerg Roedel 2016-04-08 @267  		pdev->dma_alias_devfn =3D
ivrs_alias & 0xff;
e3156048 Joerg Roedel 2016-04-08  268  		pr_info("AMD-Vi: Added PCI DMA
alias %02x.%d for %s\n",
e3156048 Joerg Roedel 2016-04-08  269  			PCI_SLOT(ivrs_alias),
PCI_FUNC(ivrs_alias),
e3156048 Joerg Roedel 2016-04-08  270  			dev_name(dev));

:::::: The code at line 266 was first introduced by commit
:::::: e3156048346c28c695f5cf9db67a8cf88c90f947 iommu/amd: Fix checking =
of pci
dma aliases

:::::: TO: Joerg Roedel <jroedel@suse.de>
:::::: CC: Joerg Roedel <jroedel@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology =
Center
https://lists.01.org/pipermail/kbuild-all                   Intel =
Corporation



----- End forwarded message -----

------=_NextPart_000_0019_01D1AD23.509D9420
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
9w0BCQUxDxcNMTYwNTEzMTIyNTM1WjAjBgkqhkiG9w0BCQQxFgQUNQ1FDYIPCe/Ex7Tagh3KoJbT
LuQwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgZgGCSsGAQQBgjcQBDGBijCB
hzB5MQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYD
VQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNz
dWluZyBDQSA0QQIKGZmpegAAAAAy3TCBmgYLKoZIhvcNAQkQAgsxgYqggYcweTELMAkGA1UEBhMC
VVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29y
cG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEECChmZ
qXoAAAAAMt0wDQYJKoZIhvcNAQEBBQAEggEAGfcaTbNp7NOUyuAJf5/4rDuw6QyFU/pf1Q4Nv1jf
R1OeNNVTsUn7xL8Frte52QXz/D64oUo/ISLhW53Z91eQMFohirCbOsRkqUTcfF3TVRPnYypDdHFc
gxHsWq9zM9QQt3qqkDhttMFUjmoEICKj4zXSpVHNwPJBDSA/uK1pL2gBkPI0nMM4rnPabBr5vD7u
sLoTQnHvBd7J5mWzBnHVOqN842/fAlWn3NrQo7m46R97LfrAw0pbXe5K9EkNt0h7hdcCOgkDNAlx
htU5Oy5YGChIeBwRMOecRryrQlyE/ZKkFo8M+XtMxM1sInd57YmYzfNV3YR9W05M7Mm+rexhowAA
AAAAAA==

------=_NextPart_000_0019_01D1AD23.509D9420--
