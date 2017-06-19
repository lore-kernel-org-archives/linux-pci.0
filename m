Return-Path: <SRS0=HzMw=5Y=ginzinger.com=Stefan.Schoefegger@kernel.org>
Return-Path: <SRS0=HzMw=5Y=ginzinger.com=Stefan.Schoefegger@kernel.org>
From: =?iso-8859-1?Q?Sch=F6fegger_Stefan?= <Stefan.Schoefegger@ginzinger.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, "Arnd
 Bergmann" <arnd@arndb.de>, open list <linux-kernel@vger.kernel.org>, "Kishon
 Vijay Abraham I" <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "moderated list:PCI DRIVER FOR IMX6"
	<linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 1/1] PCI: imx6: Add pcie compliance test option
Date: Mon, 19 Jun 2017 06:43:58 +0000
Message-ID: <1552752.riIkOpKaxW@en-pc05>
References: <1472121518-9340-1-git-send-email-stefan.schoefegger@ginzinger.com>
 <1923573.HjpiSnITgW@en-pc05>
 <CAOMZO5C03MwGkQSrJr-AeG98q84iyWnKj2GSvveJ6xKL+Y-9EQ@mail.gmail.com>
In-Reply-To: <CAOMZO5C03MwGkQSrJr-AeG98q84iyWnKj2GSvveJ6xKL+Y-9EQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, June 14, 2017 4:11:29 PM CEST Fabio Estevam wrote:
> On Wed, Jun 14, 2017 at 2:52 AM, Sch=F6fegger Stefan
>=20
> <Stefan.Schoefegger@ginzinger.com> wrote:
> > device). The bitrate and de-emphasis must be switched. The driver (with=
out
> > this patches) does not allow to switch to gen2 because it falls back to
> > gen1. It is impossible to generate the gen2 test pattern.
>=20
> If you pass 'fsl,max-link-speed =3D <2>;' in your device tree, then it
> will allow gen2.
>=20
> From Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt:
>=20
> "- fsl,max-link-speed: Specify PCI gen for link capability. Must be '2' f=
or
>   gen2, otherwise will default to gen1. Note that the IMX6 LVDS clock
> outputs do not meet gen2 jitter requirements and thus for gen2 capability=
 a
> gen2 compliant clock generator should be used and configured."
>=20
> Wouldn't this solve the problem?

No, it only sets the maximum allowed link speed but it is forced to gen1=20
before.

During compliance test there is no real link established and there is no li=
nk=20
speed negotiation, the phy is in a special compliance test state.

Stefan
