Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Tanmay Inamdar' <tinamdar@apm.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Grant Likely' <grant.likely@linaro.org>,
	'Catalin Marinas' <catalin.marinas@arm.com>,
	'Rob Landley' <rob@landley.net>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	'patches' <patches@apm.com>, 'Jon Masters' <jcm@redhat.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>
References: <1387785725-24262-1-git-send-email-tinamdar@apm.com>
 <1387785725-24262-2-git-send-email-tinamdar@apm.com>
 <007401cf0a81$51429250$f3c7b6f0$%han@samsung.com>
 <CACoXjcmqUixctokJ9COLWAsaDTUyVKk9vTAbW1hUhUdcgaj-kg@mail.gmail.com>
In-reply-to: <CACoXjcmqUixctokJ9COLWAsaDTUyVKk9vTAbW1hUhUdcgaj-kg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] pci: APM X-Gene PCIe controller driver
Date: Tue, 07 Jan 2014 12:31:46 +0900
Message-id: <001101cf0b58$fe73e730$fb5bb590$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 07, 2014 11:45 AM, Tanmay Inamdar wrote:
> On Sun, Jan 5, 2014 at 5:47 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Monday, December 23, 2013 5:02 PM, Tanmay Inamdar wrote:
> >>
> >> This patch adds the AppliedMicro X-gene SOC PCIe controller driver.
> >> APM X-Gene PCIe controller supports maximum upto 8 lanes and
> >> GEN3 speed. X-Gene has maximum 5 PCIe ports supported.
> >
> > (+cc Jason Gunthorpe, Arnd Bergmann)
> >
> > Hi Tanmay Inamdar,
> >
> > I added some minor comments. :-)
> >
> >>
> >> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> >> ---
> >>  drivers/pci/host/Kconfig      |    5 +
> >>  drivers/pci/host/Makefile     |    1 +
> >>  drivers/pci/host/pcie-xgene.c | 1017 +++++++++++++++++++++++++++++++++++++++++
> >
> > Would you change the file name to 'pci-xgene.c'?
> > Now, all PCI host drivers are using the prefix 'pci-', not 'pcie-'.
> 
> I guess designware is an exception. There is
> "drivers/pci/host/pcie-designware.c"

(+cc Thierry Reding, Pratyush Anand, Mohit KUMAR)

Now, the current naming rule is "PCI-" prefix as below.

  - Samsung Exynos: "pci"-exynos.c
  - Freescale i.MX6: "pci"-imx6.c
  - Marvell: pci-mvebu.c
  - Nvidia Tegra: pci-tegra.c
  - Renesas R-Car: pci-rcar-gen2.c

According to the Thierry Reding's comment,
"I think we should keep these sorted alphabetically. Also Tegra and
Marvell are PCIe controllers but they still use the pci- prefix instead
of pcie-. Perhaps it'd be good to keep consistency here? I initially
chose pci- because from a software point of view it doesn't matter all
that much whether it's PCI or PCIe and because the drivers are part of
the PCI subsystem. However if Exynos now uses the pcie- prefix it makes
it look like Tegra and Marvell are plain old PCI."
(https://groups.google.com/forum/#!msg/linux.kernel/qtimJoNSc3w/_1aayHaG54YJ)

However, "pcie-designware.c" is common layer driver for other
SoC PCI host drivers that use Synopsys Designware PCI IP.
Thus, currently it is shared by other SoC PCI host drivers
such as pci-exynos.c, and pci-imx6.c. Also, ST PCI driver will
use pcie-designware.c as common layer.

Originally, "pci"-designware.c was used. However, Pratyush Anand
suggested "pci"-designware.c can be renamed to "pcie"-designware.c,
because Synopsys PCI IP and Synopsys PCI Express IP are different.
So, currently "pcie"-designware.c is used.

So, if there is no special reason, "pci-" prefix can be used.
Thank you.

Best regards,
Jingoo Han

