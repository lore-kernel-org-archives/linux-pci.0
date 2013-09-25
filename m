Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Sep 2013 17:28:28 -0600
Message-ID: <CAErSpo7UX6dt0CPZp3kEQrXXbMeArpu1iFfp=-FX46LVgq0iMw@mail.gmail.com>
Subject: PCI host merge strategy and maintainers
To: Frank Li <lznuaa@gmail.com>, Shawn Guo <shawn.guo@linaro.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Kevin Hilman <khilman@linaro.org>,
	Stephen Warren <swarren@nvidia.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are patches for exynos, imx6, mvebu, and tegra on the PCI list,
and I want to sort out how people expect them to be merged.

My current assumption is the following:

  drivers/pci/host/pcie-designware.c  via PCI tree since I applied
recent changes
  drivers/pci/host/pci-exynos.c  via PCI tree since I applied recent changes
  drivers/pci/host/pci-imx6.c  via Shawn Guo per [1]
  drivers/pci/host/pci-mvebu.c  ?? unclear; Jason Cooper has merged
some, I've merged some
  drivers/pci/host/pci-tegra.c  via PCI tree per Stephen Warren [2]

Please correct anything that's wrong above, and please give me some
guidance on mvebu.  I'm happy to go either way; I just need to know
whether to pay attention to them :)

In addition, since I don't have time, expertise, or hardware to really
review changes to these drivers, I'd like to have them acked by people
who do.  My current assumption is that these are the right people:

  designware: Jingoo Han <jg1.han@samsung.com>
  exynos: Jingoo Han <jg1.han@samsung.com>
  imx6: Shawn Guo <shawn.guo@linaro.org>
  mvebu: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn
<andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>
  tegra: Thierry Reding <thierry.reding@gmail.com>

Again, please correct anything that's wrong.  My plan is that I won't
apply patches to these drivers unless they're acked by the folks
above.

Bjorn


[1] http://lkml.kernel.org/r/20130916091059.GM31147@S2101-09.ap.freescale.net
[2] http://lkml.kernel.org/r/521CCF9B.9000004@wwwdotorg.org
