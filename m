Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46949 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730AbaHFEdQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 00:33:16 -0400
Date: Wed, 6 Aug 2014 10:02:04 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: "kishon@ti.com" <kishon@ti.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>,
	Tim Harvey <tharvey@gateworks.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>
Subject: Re: designware: missing *config* reg space
Message-ID: <20140806043204.GA2755@pratyush-vbox>
References: <CAOMZO5CmDa4=AcHZpWcaLanDZQ3fXNfQbcN_0Oc04MWPw9bY1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAOMZO5CmDa4=AcHZpWcaLanDZQ3fXNfQbcN_0Oc04MWPw9bY1Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wed, Aug 06, 2014 at 02:26:10AM +0800, Fabio Estevam wrote:
> Hi,
> 
> I am running linux-next 20140805 on a imx6q-sabresd board and noticed
> the following error:
> 
> root@freescale /$ dmesg | grep pci
> [    0.168095] imx6q-pcie 1ffc000.pcie: missing *config* reg space
> [    0.501019] imx6q-pcie 1ffc000.pcie: phy link never came up
> [    0.501579] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> 
> This 'missing *config* reg space' was introduced by:

dev_err printing the above message should be dev_dbg until all the
platform specifies its configuration space definition through *reg*
instead of *ranges*.

> commit 4dd964df36d0e548e1806ec2ec275b62d4dc46e8
> Author: Kishon Vijay Abraham I <kishon@ti.com>
> Date:   Thu Jul 17 14:30:40 2014 +0530
> 
>     PCI: designware: Look for configuration space in 'reg', not 'ranges'
> 
>     The configuration address space has so far been specified in *ranges*,
>     however it should be specified in *reg* making it a platform MEM resource.
>     Hence used 'platform_get_resource_*' API to get configuration address space
>     in the designware driver.
> 
>     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Mohit Kumar <mohit.kumar@st.com>
>     Acked-by: Jingoo Han <jg1.han@samsung.com>
>     Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>     Cc: Marek Vasut <marex@denx.de>
>     Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Wouldn't this break dt compatibility?

In spite of the above missing *config* message, your system should
work fine. This patch should not affect any older platform.They will
assign their cfg space through restype == 0.

~Pratyush

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
