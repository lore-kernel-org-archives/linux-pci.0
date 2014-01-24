Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:35421 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914AbaAXIYh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jan 2014 03:24:37 -0500
Date: Fri, 24 Jan 2014 13:54:12 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	'Viresh Kumar' <viresh.linux@gmail.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	'Thierry Reding' <thierry.reding@gmail.com>
Subject: Re: [PATCH V2 7/8] pcie: SPEAr13xx: Add designware pcie support
Message-ID: <20140124082412.GG2369@pratyush-vbox>
References: <cover.1390471111.git.mohit.kumar@st.com>
 <59f1ee2335f1f49913d5ed77213880f868987e96.1390471111.git.mohit.kumar@st.com>
 <000201cf18dc$282cf360$7886da20$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <000201cf18dc$282cf360$7886da20$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jingoo Han

On Fri, Jan 24, 2014 at 04:13:26PM +0800, Jingoo Han wrote:
> 
> 
> > -----Orig,
inal Message-----
> > From: Mohit Kumar [mailto:mohit.kumar@st.com]
> > Sent: Thursday, January 23, 2014 7:33 PM
> > Cc: Pratyush Anand; Mohit Kumar; Jingoo Han; Viresh Kumar; spear-devel@list.st.com; linux-
> > pci@vger.kernel.org
> > Subject: [PATCH V2 7/8] pcie: SPEAr13xx: Add designware pcie support
> > 
> > From: Pratyush Anand <pratyush.anand@st.com>
> > 
> > SPEAr1310 and SPEAr1340 SOC uses designware PCIe controller. Add
> > SPEAr13xx PCIe driver based on designware controller driver.
> > 
> > SPEAr1310 has 3 PCIe ports and SPEAr1340 has 1, which are multiplexed
> > with ahci/sata pins. By default evaluation board of both controller
> > works for ahci mode.
> > To use these patches on SPEAr1340/1310 evaluation board, do the
> > necessary modifications on board and enable (okay) pcie from respective
> > evb dtsi file.
> > 
> > Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> > Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> > Cc: Mohit Kumar <mohit.kumar@st.com>
> > Cc: Jingoo Han <jg1.han@samsung.com>
> > Cc: Viresh Kumar <viresh.linux@gmail.com>
> > Cc: spear-devel@list.st.com
> > Cc: linux-pci@vger.kernel.org
> > ---
> >  arch/arm/boot/dts/spear13xx.dtsi     |   53 +++++-
> >  arch/arm/configs/spear13xx_defconfig |    2 +
> >  arch/arm/mach-spear/Kconfig          |    1 +
> >  drivers/mfd/spear13xx-cfg.c          |  205 ++++++++++++++++++
> >  drivers/pci/host/Kconfig             |    5 +
> >  drivers/pci/host/Makefile            |    1 +
> >  drivers/pci/host/pcie-spear13xx.c    |  394 ++++++++++++++++++++++++++++++++++
> 
> (+cc Thierry Reding)
> 
> How about changing the file name to 'pci-spear13xx.c'?
> Now, all PCI host drivers are using the prefix 'pci-', not 'pcie-'.
> 
> According to the Thierry Reding's comment,
> "I think we should keep these sorted alphabetically. Also Tegra and
> Marvell are PCIe controllers but they still use the pci- prefix instead
> of pcie-. Perhaps it'd be good to keep consistency here? I initially
> chose pci- because from a software point of view it doesn't matter all
> that much whether it's PCI or PCIe and because the drivers are part of
> the PCI subsystem. However if Exynos now uses the pcie- prefix it makes
> it look like Tegra and Marvell are plain old PCI."
> (https://groups.google.com/forum/#!msg/linux.kernel/qtimJoNSc3w/_1aayHaG54YJ)
> 
> If there is a special reason, please let us know.

Only reason is: SPEAr13xx has also a PCI controller compliant with PCI
2.3 specification. However, there is no plan for developing Linux
driver for it, as of now.

Regards
Pratyush
> 
> Other things look good. :-)
> Thank you.
> 
> Best regards,
> Jingoo Han
> 
> >  7 files changed, 659 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/pci/host/pcie-spear13xx.c
> 
> 
