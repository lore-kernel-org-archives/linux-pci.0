Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from samserver.samelson.uni-hildesheim.de ([147.172.172.66]:16600
        "EHLO messagesink.samelson.uni-hildesheim.de" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753300AbdHWG21 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 02:28:27 -0400
From: Sascha El-Sharkawy <elscha@sse.uni-hildesheim.de>
To: "bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Klaus Schmid <schmid@sse.uni-hildesheim.de>
Date: Wed, 23 Aug 2017 08:22:38 +0200
Subject: [PATCH] PCI SUBSYSTEM allows inconsistent configuration, current
 Kernel version
Message-ID: <171b5343-c8c2-47bb-b29d-ef21bac15637@messagesink.samelson.uni-hildesheim.de>
Content-Type: multipart/mixed;
        boundary="_002_171b5343c8c247bbb29def21bac15637messagesinksamelsonunih_"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--_002_171b5343c8c247bbb29def21bac15637messagesinksamelsonunih_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,


We detected that the selection of "PCI resource re-allocation detection" (C=
ONFIG_PCI_REALLOC_ENABLE_AUTO) is ignored in some situations. This can happ=
en as the related functionality (drivers/pci/setup-bus.c, lines 1702 - 1738=
) depends on CONFIG_PCI_REALLOC_ENABLE_AUTO and CONFIG_PCI_IOV, while in Kc=
onfig (drivers/pci/Kconfig, lines 42 - 53) this functionality is only contr=
olled by CONFIG_PCI_REALLOC_ENABLE_AUTO.

The dependency on CONFIG_PCI_IOV is only mentioned in the comment of CONFIG=
_PCI_REALLOC_ENABLE_AUTO, but not checked by Kconfig. As CONFIG_PCI_IOV is =
selected by many other configuration options, we expect the failure to happ=
en in very few configurations only, which makes it even harder to detect an=
d fix. However, there exist configurations that will still be faulty.
The suggested fix ensures that the re-allocation is always working as speci=
fied through an automated selection of CONFIG_PCI_IOV if CONFIG_PCI_REALLOC=
_ENABLE_AUTO is selected.

Best regards,
Sascha

-- -----------------------------------------------------------------------
Sascha El-Sharkawy, MSc=20
University of Hildesheim=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0Tel.: +49 (0) 5121 / 883-40336=A0=20
Institute of Computer Science=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0F=
ax:  +49 (0) 5121 / 883-40337
Universitaetsplatz 1   =A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 elscha@sse.uni-hildesheim.de
D-31141 Hildesheim, Germany=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 http:=
//www.sse.uni-hildesheim.de



--_002_171b5343c8c247bbb29def21bac15637messagesinksamelsonunih_
Content-Type: application/x-gzip; name="PCI_REALLOC_ENABLE_AUTO.patch.gz"
Content-Description: PCI_REALLOC_ENABLE_AUTO.patch.gz
Content-Disposition: attachment;
	filename="PCI_REALLOC_ENABLE_AUTO.patch.gz"; size=519;
	creation-date="Fri, 18 Aug 2017 12:35:27 GMT";
	modification-date="Fri, 18 Aug 2017 12:18:12 GMT"
Content-Transfer-Encoding: base64

H4sICATbllkAA1BDSV9SRUFMTE9DX0VOQUJMRV9BVVRPLnBhdGNoAI2SX2vbMBTFn+tPcejTiuOk
+bOGMQpNujDCQjKSdaNPQZauY4EmGUtuGtiH37XTDgfSUb3Ivrr33N89ElSpn6j0vULq3jfpbKZ3
+IMx4jhOeEXoI9OGIHNhd6Q6GEJbT2XQzvoP8VUHIygydPxPrqJI6SxDkux0gOidk0/PRSNtFT1D
DgdiPM663ZvxRzX+JNG/vr4ZjSJGOa8WMegbind3SEaDTn+IuN4G4MALwvf7+fbLbPrwNWpH1rPJ
YrG6386Wk+litp08/FhFuEidM7icWZGyDZyGkryrSkn8kQhjnBT18OxCIFl/XXKRooKs8uA4l0Tx
hWePZGjazFc/OSMnU/AGbMQBj8ipJOgMB1dhL2xAyI/dpOOD4F7k65Q2Q6NwymGJuDFXpARqqFUX
jywrhYUwe3HwqDyBrbotqSm8dTZK8G+58vSQ75PlHBtcasWUoQssXWCsXHtkJEJVw3sIWJe4oq1V
WUPev84NXxWFK0OTbLx7BfzMj4rVRGBIX3fAXhvT1hFVcL95QMlMh9bEp1fia38266RuNZ2sPXLx
RAwV2lIpUW3EsVwhPTReT+erTZcv6n3jz4+Eb2M1Su9C+y8Pmgv+lXMGO6RclYYOPL+YZX32Fy8f
mb6+AwAA

--_002_171b5343c8c247bbb29def21bac15637messagesinksamelsonunih_--
