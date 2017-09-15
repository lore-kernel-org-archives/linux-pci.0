Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0061.outbound.protection.outlook.com ([104.47.36.61]:57264
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751782AbdIOTUD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Sep 2017 15:20:03 -0400
From: "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "Snyder, Wilson" <Wilson.Snyder@cavium.com>,
        "Daney, David" <David.Daney@cavium.com>,
        "jcm@redhat.com" <jcm@redhat.com>
Subject: Re: [PATCH v3] PCI: quirks: update Cavium ThunderX ACS quirk
 implementation
Date: Fri, 15 Sep 2017 19:20:01 +0000
Message-ID: <DM5PR07MB300243C20B826A9211B0B4B48A6C0@DM5PR07MB3002.namprd07.prod.outlook.com>
References: <1505217316-15702-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>,<1505480233-22694-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
In-Reply-To: <1505480233-22694-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi guys,

Sorry for wasting your time by getting back to this.

Please correct me if I'm wrong,...

So far it might fall into same discussion as happened here:
https://lkml.org/lkml/2017/8/1/559

And to provided ACS mask I've already got a comment before for initial patc=
h that it is not correct because it violates the spec.

> +#define CAVIUM_CN8XXX_ACS_FLAGS (PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | =
\
> +                                PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT)

So from that point the proper mask is expected to be as following:

> (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV)

which should be enough to provide proper device isolation.

and based on that it appears to got self-nack here.

Are there any other comments on this ?
Going to prepare and test v4 of patch.

Sorry again for inconvenience.

WBR,
Vadim
________________________________________
From: Lomovtsev, Vadim
Sent: Friday, September 15, 2017 3:57:13 PM
To: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-kernel@vger.kerne=
l.org; alex.williamson@redhat.com
Cc: Snyder, Wilson; Daney, David; jcm@redhat.com; Lomovtsev, Vadim
Subject: [PATCH v3] PCI: quirks: update Cavium ThunderX ACS quirk implement=
ation

This commit makes Cavium PCI ACS quirk applicable only to Cavium
ThunderX (CN81/83/88XX) PCIE Root Ports which has limited PCI capabilities
in terms of no ACS support advertisement. However, the RTL internally
implements similar protection as if ACS had completion redirection,
blocking and validation features enabled.

Following settings are enforced by hardware on 8xxx although it does not ha=
ve ACS:

$PCCBR_XXX_ACS_CAP_CTL (as if it present)
---------------------------------------------------------------------------=
------------------------------
 Bit     Field Field   Reset      Typical    Field
 Pos     Name  Type    Value      Value      Description
---------------------------------------------------------------------------=
------------------------------
 <31:23> --    RAZ     --         --         Reserved.
 <22>    DTE   R/W     0          --         ACS direct translated P2P enab=
le. Value ignored by hardware.
 <21>    ECE   RO      0          0          ACS P2P egress control enable.=
 Always clear.
 <20>    UFE   R/W     0          --         ACS upstream forwarding enable=
. Value ignored by hardware.
 <19>    CRE   R/W     0          --         ACS completion redirect enable=
. Value ignored by hardware.
 <18>    RRE   R/W     0          --         ACS P2P request redirect enabl=
e. Value ignored by hardware.
 <17>    TBE   R/W     0          --         ACS transaction blocking enabl=
e. Value ignored by hardware.
 <16>    SVE   R/W     0          --         ACS source validation enable. =
Value ignored by hardware.
 <15:8>  ECVS  RO      0x0        0x0        Egress control vector size. Al=
ways zero.
 <7>     --    RAZ     --         --         Reserved.
 <6>     DT    RO      1          1          ACS direct translated P2P. Alw=
ays set.
 <5>     EC    RO      0          0          ACS P2P egress control. Always=
 clear.
 <4>     UF    RO      1          1          ACS upstream forwarding. Alway=
s set.
 <3>     CR    RO      1          1          ACS completion redirect. Alway=
s set.
 <2>     RR    RO      1          1          ACS P2P request redirect. Alwa=
ys set.
 <1>     TB    RO      1          1          ACS transaction blocking. Alwa=
ys set.
 <0>     SV    RO      1          1          ACS source validation. Always =
set.
---------------------------------------------------------------------------=
------------------------------

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
---
 drivers/pci/quirks.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a4d3361..f1786a5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4211,20 +4211,28 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev=
, u16 acs_flags)
 #endif
 }

-static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
+/*
+ * The CN8XXX on-chip devices' PCCBR's do not advertise
+ * ACS, although the RTL internally implements similar protections as to
+ * if ACS had completion redirection, blocking and validation features
+ * enabled.
+ */
+#define CAVIUM_CN8XXX_ACS_FLAGS (PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | \
+                                PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT)
+
+static __inline__  bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
 {
-       /*
-        * Cavium devices matching this quirk do not perform peer-to-peer
-        * with other functions, allowing masking out these bits as if they
-        * were unimplemented in the ACS capability.
-        */
-       acs_flags &=3D ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
-                      PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
+       return (pci_is_pcie(dev) &&
+               (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) &&
+               ((dev->device & 0xf800) =3D=3D 0xa000));
+}

-       if (!((dev->device >=3D 0xa000) && (dev->device <=3D 0xa0ff)))
+static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
+{
+       if (!pci_quirk_cavium_acs_match(dev))
                return -ENOTTY;

-       return acs_flags ? 0 : 1;
+       return acs_flags & ~(CAVIUM_CN8XXX_ACS_FLAGS) ? 0 : 1;
 }

 static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
--
2.9.5
