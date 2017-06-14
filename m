Return-Path: <SRS0=T03V=5T=gmail.com=festevam@kernel.org>
Return-Path: <SRS0=T03V=5T=gmail.com=festevam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1923573.HjpiSnITgW@en-pc05>
References: <1472121518-9340-1-git-send-email-stefan.schoefegger@ginzinger.com>
 <2668097.SlerkO2uVy@en-pc05> <20170613135847.GA7128@bhelgaas-glaptop.roam.corp.google.com>
 <1923573.HjpiSnITgW@en-pc05>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 14 Jun 2017 16:11:29 -0300
Message-ID: <CAOMZO5C03MwGkQSrJr-AeG98q84iyWnKj2GSvveJ6xKL+Y-9EQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: imx6: Add pcie compliance test option
To: =?UTF-8?Q?Sch=C3=B6fegger_Stefan?= <Stefan.Schoefegger@ginzinger.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>, open list <linux-kernel@vger.kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"moderated list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 14, 2017 at 2:52 AM, Sch=C3=B6fegger Stefan
<Stefan.Schoefegger@ginzinger.com> wrote:

> device). The bitrate and de-emphasis must be switched. The driver (withou=
t
> this patches) does not allow to switch to gen2 because it falls back to g=
en1.
> It is impossible to generate the gen2 test pattern.

If you pass 'fsl,max-link-speed =3D <2>;' in your device tree, then it
will allow gen2.

>From Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt:

"- fsl,max-link-speed: Specify PCI gen for link capability. Must be '2' for
  gen2, otherwise will default to gen1. Note that the IMX6 LVDS clock outpu=
ts
  do not meet gen2 jitter requirements and thus for gen2 capability a gen2
  compliant clock generator should be used and configured."

Wouldn't this solve the problem?
