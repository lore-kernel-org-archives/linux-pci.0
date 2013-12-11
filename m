Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:52062 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab3LKL3p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 06:29:45 -0500
Received: by mail-ob0-f169.google.com with SMTP id wm4so6857887obc.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2013 03:29:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201312111103.28568.marex@denx.de>
References: <cover.1386752447.git.mohit.kumar@st.com>
	<6b4282b9e793ec89ba0c20f3362d41f6133a8132.1386752447.git.mohit.kumar@st.com>
	<201312111103.28568.marex@denx.de>
Date: Wed, 11 Dec 2013 16:59:44 +0530
Message-ID: <CAD6G_RSBhHoXMdw=pK_riXN6ozUtK32uUeAJH5uuox_PQxmi7g@mail.gmail.com>
Subject: Re: [PATCH 08/12] pcie: designware: Fix IO transfers
From: Jagan Teki <jagannadh.teki@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: Mohit Kumar <mohit.kumar@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Pratyush Anand <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	spear-devel <spear-devel@list.st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 11, 2013 at 3:33 PM, Marek Vasut <marex@denx.de> wrote:
> On Wednesday, December 11, 2013 at 10:38:33 AM, Mohit Kumar wrote:
>> From: Pratyush Anand <pratyush.anand@st.com>
>>
>> pp->io_base which is the input of the outbound IO address translation
>> unit should be the cpu address, it was programmed wrongly to realio
>> address.
>>
>> We should pass global_io_offset rather than sys->io_offset to
>> pci_ioremap_io, so we map the new window into the first available spot
>> in the Linux view of the I/O space.
>>
>> We must also pass cpu address instead  of realio address to
>> pci_ioremap_io.
>>
>> This patch fixes above issue. It has been tested with Lecroy PTC in AIC
>> mode and Pericom PI7C9X2G303EL PCIe switch, which does not work
>> otherwise.
>>
>> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
>> Tested-by: Mohit Kumar <mohit.kumar@st.com>
>> Tested-by: Tim Harvey <tharvey@gateworks.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Richard Zhu <Hong-Xing.Zhu@freescale.com>
>> Cc: linux-pci@vger.kernel.org
>> Cc: spear-devel@list.st.com
>
> Acked-by: Marek Vasut <marex@denx.de>
>
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

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
