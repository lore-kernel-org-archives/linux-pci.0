Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:65099 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab3LLBRU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 20:17:20 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXO00KT168V2000@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 12 Dec 2013 10:17:19 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Jagan Teki' <jagannadh.teki@gmail.com>
Cc: 'Marek Vasut' <marex@denx.de>, 'Mohit Kumar' <mohit.kumar@st.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Richard Zhu' <Hong-Xing.Zhu@freescale.com>,
	'spear-devel' <spear-devel@list.st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <6b4282b9e793ec89ba0c20f3362d41f6133a8132.1386752447.git.mohit.kumar@st.com>
 <201312111103.28568.marex@denx.de>
 <CAD6G_RSBhHoXMdw=pK_riXN6ozUtK32uUeAJH5uuox_PQxmi7g@mail.gmail.com>
In-reply-to: <CAD6G_RSBhHoXMdw=pK_riXN6ozUtK32uUeAJH5uuox_PQxmi7g@mail.gmail.com>
Subject: Re: [PATCH 08/12] pcie: designware: Fix IO transfers
Date: Thu, 12 Dec 2013 10:17:19 +0900
Message-id: <002401cef6d7$e6d89c00$b489d400$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 11, 2013 8:30 PM, Jagan Teki wrote:
> On Wed, Dec 11, 2013 at 3:33 PM, Marek Vasut <marex@denx.de> wrote:
> > On Wednesday, December 11, 2013 at 10:38:33 AM, Mohit Kumar wrote:
> >> From: Pratyush Anand <pratyush.anand@st.com>
> >>
> >> pp->io_base which is the input of the outbound IO address translation
> >> unit should be the cpu address, it was programmed wrongly to realio
> >> address.
> >>
> >> We should pass global_io_offset rather than sys->io_offset to
> >> pci_ioremap_io, so we map the new window into the first available spot
> >> in the Linux view of the I/O space.
> >>
> >> We must also pass cpu address instead  of realio address to
> >> pci_ioremap_io.
> >>
> >> This patch fixes above issue. It has been tested with Lecroy PTC in AIC
> >> mode and Pericom PI7C9X2G303EL PCIe switch, which does not work
> >> otherwise.
> >>
> >> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> >> Tested-by: Mohit Kumar <mohit.kumar@st.com>
> >> Tested-by: Tim Harvey <tharvey@gateworks.com>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Marek Vasut <marex@denx.de>
> >> Cc: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> >> Cc: linux-pci@vger.kernel.org
> >> Cc: spear-devel@list.st.com
> >
> > Acked-by: Marek Vasut <marex@denx.de>
> >
> > Best regards,
> > Marek Vasut
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Acked-by: Jagannadha Sutradharudu Teki <jagannadh.teki@gmail.com>

As I said, please use 'Reviewed-by' instead of 'Acked-by'.

Best regards,
Jingoo Han

