Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:46688 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab3LKMEf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 07:04:35 -0500
Received: by mail-ob0-f173.google.com with SMTP id gq1so6783421obb.4
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2013 04:04:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189F95F6311@EAPEX1MAIL1.st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
	<7bce26f60d847a136f748b5eeac15dc79a7d662e.1386752447.git.mohit.kumar@st.com>
	<CAD6G_RTrETj9p+YNPjRMEFsO7Ggf3LfnuaPOSwO2brUcusNUJw@mail.gmail.com>
	<2CC2A0A4A178534D93D5159BF3BCB66189F95F6311@EAPEX1MAIL1.st.com>
Date: Wed, 11 Dec 2013 17:34:34 +0530
Message-ID: <CAD6G_RQ5AyHePbx8Xm-XVHp4TkwXL_hAmwCZWQ-wv7EBJcOHwA@mail.gmail.com>
Subject: Re: [PATCH 06/12] pcie: designware: Move register definition to the
 header file
From: Jagan Teki <jagannadh.teki@gmail.com>
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	spear-devel <spear-devel@list.st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 11, 2013 at 5:25 PM, Mohit KUMAR DCG <Mohit.KUMAR@st.com> wrote:
> Hello Jagan,
>
>> -----Original Message-----
>> From: Jagan Teki [mailto:jagannadh.teki@gmail.com]
>> Sent: Wednesday, December 11, 2013 5:09 PM
>> To: Mohit KUMAR DCG
>> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> Pratyush ANAND; Jingoo Han; spear-devel
>> Subject: Re: [PATCH 06/12] pcie: designware: Move register definition to the
>> header file
>>
>> On Wed, Dec 11, 2013 at 3:08 PM, Mohit Kumar <mohit.kumar@st.com>
>> wrote:
>> > From: Pratyush Anand <pratyush.anand@st.com>
>> >
>> > Move synopsis specific register definition from source file to header
>> > file, so that they can be re-used by other files if needed.
>> >
>> > Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
>> > Cc: Mohit Kumar <mohit.kumar@st.com>
>> > Cc: Jingoo Han <jg1.han@samsung.com>
>> > Cc: spear-devel@list.st.com
>> > Cc: linux-pci@vger.kernel.org
>> > ---
>> >  drivers/pci/host/pcie-designware.c |   42 ------------------------------------
>> >  drivers/pci/host/pcie-designware.h |   42
>> ++++++++++++++++++++++++++++++++++++
>> >  2 files changed, 42 insertions(+), 42 deletions(-)
>> >
>> > diff --git a/drivers/pci/host/pcie-designware.c
>> > b/drivers/pci/host/pcie-designware.c
>> > index 212b8b6..73aa13c 100644
>> > --- a/drivers/pci/host/pcie-designware.c
>> > +++ b/drivers/pci/host/pcie-designware.c
>> > @@ -23,48 +23,6 @@
>> >
>> >  #include "pcie-designware.h"
>> >
>> > -/* Synopsis specific PCIE configuration registers */
>> > -#define PCIE_PORT_LINK_CONTROL         0x710
>> > -#define PORT_LINK_MODE_MASK            (0x3f << 16)
>> > -#define PORT_LINK_MODE_1_LANES         (0x1 << 16)
>> > -#define PORT_LINK_MODE_2_LANES         (0x3 << 16)
>> > -#define PORT_LINK_MODE_4_LANES         (0x7 << 16)
>> > -
>> > -#define PCIE_LINK_WIDTH_SPEED_CONTROL  0x80C
>> > -#define PORT_LOGIC_SPEED_CHANGE                (0x1 << 17)
>> > -#define PORT_LOGIC_LINK_WIDTH_MASK     (0x1ff << 8)
>> > -#define PORT_LOGIC_LINK_WIDTH_1_LANES  (0x1 << 8) -#define
>> > PORT_LOGIC_LINK_WIDTH_2_LANES  (0x2 << 8) -#define
>> > PORT_LOGIC_LINK_WIDTH_4_LANES  (0x4 << 8)
>> > -
>> > -#define PCIE_MSI_ADDR_LO               0x820
>> > -#define PCIE_MSI_ADDR_HI               0x824
>> > -#define PCIE_MSI_INTR0_ENABLE          0x828
>> > -#define PCIE_MSI_INTR0_MASK            0x82C
>> > -#define PCIE_MSI_INTR0_STATUS          0x830
>> > -
>> > -#define PCIE_ATU_VIEWPORT              0x900
>> > -#define PCIE_ATU_REGION_INBOUND                (0x1 << 31)
>> > -#define PCIE_ATU_REGION_OUTBOUND       (0x0 << 31)
>> > -#define PCIE_ATU_REGION_INDEX1         (0x1 << 0)
>> > -#define PCIE_ATU_REGION_INDEX0         (0x0 << 0)
>> > -#define PCIE_ATU_CR1                   0x904
>> > -#define PCIE_ATU_TYPE_MEM              (0x0 << 0)
>> > -#define PCIE_ATU_TYPE_IO               (0x2 << 0)
>> > -#define PCIE_ATU_TYPE_CFG0             (0x4 << 0)
>> > -#define PCIE_ATU_TYPE_CFG1             (0x5 << 0)
>> > -#define PCIE_ATU_CR2                   0x908
>> > -#define PCIE_ATU_ENABLE                        (0x1 << 31)
>> > -#define PCIE_ATU_BAR_MODE_ENABLE       (0x1 << 30)
>> > -#define PCIE_ATU_LOWER_BASE            0x90C
>> > -#define PCIE_ATU_UPPER_BASE            0x910
>> > -#define PCIE_ATU_LIMIT                 0x914
>> > -#define PCIE_ATU_LOWER_TARGET          0x918
>> > -#define PCIE_ATU_BUS(x)                        (((x) & 0xff) << 24)
>> > -#define PCIE_ATU_DEV(x)                        (((x) & 0x1f) << 19)
>> > -#define PCIE_ATU_FUNC(x)               (((x) & 0x7) << 16)
>> > -#define PCIE_ATU_UPPER_TARGET          0x91C
>> > -
>> >  static struct hw_pci dw_pci;
>> >
>> >  static unsigned long global_io_offset; diff --git
>> > a/drivers/pci/host/pcie-designware.h
>> > b/drivers/pci/host/pcie-designware.h
>> > index c15379b..da1ed35 100644
>> > --- a/drivers/pci/host/pcie-designware.h
>> > +++ b/drivers/pci/host/pcie-designware.h
>> > @@ -74,4 +74,46 @@ int dw_pcie_link_up(struct pcie_port *pp);  void
>> > dw_pcie_setup_rc(struct pcie_port *pp);  int dw_pcie_host_init(struct
>> > pcie_port *pp);
>> >
>> > +/* Synopsis specific PCIE configuration registers */
>> > +#define PCIE_PORT_LINK_CONTROL         0x710
>> > +#define PORT_LINK_MODE_MASK            (0x3f << 16)
>> > +#define PORT_LINK_MODE_1_LANES         (0x1 << 16)
>> > +#define PORT_LINK_MODE_2_LANES         (0x3 << 16)
>> > +#define PORT_LINK_MODE_4_LANES         (0x7 << 16)
>> > +
>> > +#define PCIE_LINK_WIDTH_SPEED_CONTROL  0x80C
>> > +#define PORT_LOGIC_SPEED_CHANGE                (0x1 << 17)
>> > +#define PORT_LOGIC_LINK_WIDTH_MASK     (0x1ff << 8)
>> > +#define PORT_LOGIC_LINK_WIDTH_1_LANES  (0x1 << 8) #define
>> > +PORT_LOGIC_LINK_WIDTH_2_LANES  (0x2 << 8) #define
>> > +PORT_LOGIC_LINK_WIDTH_4_LANES  (0x4 << 8)
>> > +
>> > +#define PCIE_MSI_ADDR_LO               0x820
>> > +#define PCIE_MSI_ADDR_HI               0x824
>> > +#define PCIE_MSI_INTR0_ENABLE          0x828
>> > +#define PCIE_MSI_INTR0_MASK            0x82C
>> > +#define PCIE_MSI_INTR0_STATUS          0x830
>> > +
>> > +#define PCIE_ATU_VIEWPORT              0x900
>> > +#define PCIE_ATU_REGION_INBOUND                (0x1 << 31)
>> > +#define PCIE_ATU_REGION_OUTBOUND       (0x0 << 31)
>> > +#define PCIE_ATU_REGION_INDEX1         (0x1 << 0)
>> > +#define PCIE_ATU_REGION_INDEX0         (0x0 << 0)
>> > +#define PCIE_ATU_CR1                   0x904
>> > +#define PCIE_ATU_TYPE_MEM              (0x0 << 0)
>> > +#define PCIE_ATU_TYPE_IO               (0x2 << 0)
>> > +#define PCIE_ATU_TYPE_CFG0             (0x4 << 0)
>> > +#define PCIE_ATU_TYPE_CFG1             (0x5 << 0)
>> > +#define PCIE_ATU_CR2                   0x908
>> > +#define PCIE_ATU_ENABLE                        (0x1 << 31)
>> > +#define PCIE_ATU_BAR_MODE_ENABLE       (0x1 << 30)
>> > +#define PCIE_ATU_LOWER_BASE            0x90C
>> > +#define PCIE_ATU_UPPER_BASE            0x910
>> > +#define PCIE_ATU_LIMIT                 0x914
>> > +#define PCIE_ATU_LOWER_TARGET          0x918
>> > +#define PCIE_ATU_BUS(x)                        (((x) & 0xff) << 24)
>> > +#define PCIE_ATU_DEV(x)                        (((x) & 0x1f) << 19)
>> > +#define PCIE_ATU_FUNC(x)               (((x) & 0x7) << 16)
>> > +#define PCIE_ATU_UPPER_TARGET          0x91C
>> > +
>> >  #endif /* _PCIE_DESIGNWARE_H */
>>
>> Seems like none were using these headers except pcie-designware.c - if ie
>> the case better to place it same place as before.
>
> - We have include these and used few like ' PCIE_LINK_WIDTH_SPEED_CONTROL '  for SPEAr13xx platform,
> so move these to the separate header  file.
>

Acked-by: Jagannadha Sutradharudu Teki <jagannadh.teki@gmail.com>

-- 
Thanks,
Jagan.
--------
Jagannadha Sutradharudu Teki,
E: jagannadh.teki@gmail.com, P: +91-9676773388
Engineer - System Software Hacker
U-boot - SPI Custodian and Zynq APSOC
Ln: http://www.linkedin.com/in/jaganteki
