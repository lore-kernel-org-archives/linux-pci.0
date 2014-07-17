Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:43553 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbaGQAew (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 20:34:52 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so1775916iec.40
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 17:34:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6c999c0fee0b406db597e74837980081@BLUPR03MB136.namprd03.prod.outlook.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
	<20140626031247.GN2224@dragon>
	<CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
	<20140626054937.GB7859@dragon>
	<CAJ+vNU0DNCT5pcvnptNBo-tPTVOH1HnrCwy7uCZt33dfyq8U-g@mail.gmail.com>
	<6c999c0fee0b406db597e74837980081@BLUPR03MB136.namprd03.prod.outlook.com>
Date: Wed, 16 Jul 2014 17:28:35 -0700
Message-ID: <CAJ+vNU2_AOYm8=L-w4QKDT-sWq-pennOyPE0eN-sYzUgzAMCSw@mail.gmail.com>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
From: Tim Harvey <tharvey@gateworks.com>
To: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
Cc: Shawn Guo <Shawn.Guo@freescale.com>,
	Fabio Estevam <festevam@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Marek Va?ut" <marex@denx.de>,
	=?UTF-8?Q?David_M=C3=BCller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 27, 2014 at 3:06 AM, Hong-Xing.Zhu@freescale.com
<Hong-Xing.Zhu@freescale.com> wrote:
> [Richard] I did the tests refer to this use-case, enable imx6 pcie on both u-boot and kernel,
> and I encounter the system hang too.
>
> Here are the latest updates and some clues from my side:
> - About 200us delay is required after the ltssm_en is set to be '1' at my side.
> Otherwise, system would be hang when driver access the pcie_phy_debug_r1 to check
> the link is up or not.
>
> - After that, system hang when rc trying to access the cfg space of ep device,
> Although the pcie link had been setup and I don't have know the root cause yet.
>
> - The kernel can boot up successfully, when I mask the cfg read/write call-back in pcie-designware.c
> Driver for debug purpose.
>
> Note:
> The sequence of the pcie initialization should be adjusted refer to the newly
>  discovered bug(pcie link maybe rarely random down after the system warm-reset).
> * Ref_ssp_en(bit16 of gpr1 register) should be set after the pcie others clks are enable.
> Enable pcie related clks --> delay for about ~10us waiting for the clks stable-->set ref_ssp_en(bit16 of gpr1 register).
>
> Debug is still on-going.
>

Any update on this? Are you or others at Freescale actively working on this?

Regards,

Tim
