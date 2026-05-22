Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2EA386C1E;
	Fri, 22 May 2026 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779431704; cv=none; b=mLjJUshSf9Ijl3yio0QzgO8BrOTOvjfamE0FMnfijp7HpUuwrYhPvSN9lxx7rcBj+wxODxd2bcKpZOu9Xck+QtdHcjYzAE2GshvMPds/AI/kcXoDh61j2MA27KcmF2Sl2TReb+VcnaXMUNm+B4el60wRkEOhWVubyp0hDgJkOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779431704; c=relaxed/simple;
	bh=vtbvf/DX7+rTCqJkup3mzJqXgILXP8YVnqb2/LuwrbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rd3ZLEoyDyYvi+BtmP5TEZNtlhBi5H1afkLLin/JPKv9mL35SOxEh3J4ao74d/nNW20f3BM4n0kOFbidQ7Ck+TY8izgH5npTqHpHWPP3TuyYn42GVyhv6cCjV6qKbcyUYSaullv6579nFZGaQNYH2GBicYUHAokk8ftrIawDgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=gIMzwN0r; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="gIMzwN0r"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64M6YpcS62123294, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1779431691;
	bh=wC9w2Z5C5Gc40585J/GtgTVsVGzTIt20Z6lbJKNvu3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gIMzwN0rCLvUTA0hXfAv2/j/kt3Z6hlkTj8fIkqwMsdYu+P8z0J2XArvAN3koNgLr
	 4eKzM0Y+fROvuzgOC0Q54RZEsOXFyBjzQRpvF9i0M4Vn8k7hahhV7xE2NG8k/a8REI
	 MkHW4/GZ5Is1Ds4bjfVoNGGcSAPUfHi7nwpor7FqrspIbN177zl1R9CeXnhdXGQgrk
	 bgb536/hiG1me8tuXANL8UXke79rVmcJkMxBwkvJcNxlhaJIS8v8hJuxCAPXyM0EcX
	 ZIvGeLLHNGg15xWVlOfpPNYziU0O0T15V9y6q/aayMPUsZWzT3t/Wl0JwsIV0Iyb0j
	 71UGPE5pc0SJg==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64M6YpcS62123294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 May 2026 14:34:51 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 May 2026 14:34:51 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Fri,
 22 May 2026 14:34:51 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC Patch] pci: add power management for rtl8116af
Thread-Topic: [RFC Patch] pci: add power management for rtl8116af
Thread-Index: AQHc6NNMU8mbcBNuNkiOuO8bKV6JxLYYIKSAgAE15EA=
Date: Fri, 22 May 2026 06:34:51 +0000
Message-ID: <1e4e4a70c9ac43849ec56a8f5cc21672@realsil.com.cn>
References: <20260521033827.502-1-javen_xu@realsil.com.cn>
 <20260521160929.GA164133@bhelgaas>
In-Reply-To: <20260521160929.GA164133@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>On Thu, May 21, 2026 at 11:38:27AM +0800, javen wrote:
>> From: Javen Xu <javen_xu@realsil.com.cn>
>>
>> RTL8116af is a multi function card. But due to the hardware design,
>> only function 0 and function 1(nic) are exposed to pci system. If the
>> system want to enter s0idle or cpu need to enter c10 when suspend,
>> function 2 to 7 must be set to d3 and enable aspm. Function 5 and 6
>> are reserved, so we skip them.
>
>If the other functions aren't visible, does Linux use them at all?
>Can you just put them in D3hot and leave them there indefinitely?

Linux does not use them at all. The purpose of this patch is to put them in=
 D3hot and enable their ASPM indefinitely, so the system can enter c10 and =
s0idle.

>
>Other than quirk_rtl8168_set_aspm_clkreq() function name, I can't tell fro=
m
>the code what this does with ASPM.  I'm a little dubious because (a) ASPM =
is
>supposed to be managed by the PCI core, not by individual drivers and (b) =
I
>can't tell whether this conflicts or races with anything in pci/pcie/aspm.=
c.
>
>Smells like a device that doesn't make much effort to conform to the PCI s=
pecs.
>
In function quirk_rtl8168_set_aspm_clkreq(), writing to 0x80 (0x70 + 0x10) =
is actually writing to PCIe Link Control Register. Setting BIT(0)|BIT(1)|BI=
T(8) here enables ASPM L0s/L1, and enable Clock Power Management.

I completely agree with the principle that ASPM should be managed by the PC=
I(pcie/aspm.c). However, the reason why we have to do this via a quirk usin=
g Function 0 private CSI interface is that Functions 2 to 7 are hidden from=
 OS. And pci will not detect it. lspci is below:
03:00.0 Unassigned class[ff00]: Realtek Semiconductor Co., Ltd. Device 816e=
 (rev 31)
03:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
411 PCI Express Gigabit Ethernet Controller (rev 24)

Since PCI core never enumerates them, and no struct pci_dev is ever created=
 for them. I think pcie/aspm.c is completely unaware of their existence and=
 will not cause conflicts or races.
And my quirk only targets these unseen function via function 1 private csi =
interface, leaving function 0 and 1 untouched for pcie/aspm.c to manage nat=
ively.

This hardware might not strictly conform to standard PCI spec. If you have =
any better suggestions or if there is a more preferred way within PCI syste=
m to handle such unhidden multi-function deivces, I would be very grateful =
to hear your advice.

Thanks for your time and review.
BRs,
Javen

>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>> ---
>> Hi,
>> Just as the comments above, function 2 to 7 are hidden to pci system.
>> So we have to set d3 and aspm through our private register, which is
>> CSI. I have a discussion with netdev maintainer, and he thought this
>> might be a question to pci system.
>
>Pointer to that discussion?

Discussion link: https://lore.kernel.org/netdev/33d351be-8a91-4940-950a-7f0=
866d0cae9@gmail.com/

>
>> I wonder whether this patch can be accepted here. Any feedback would
>> be highly appreciated!
>
>Pay attention to previous history and match style and capitalization in su=
bject
>line, commit log, etc.  Match text width in the patch itself.
>
>> ---
>>  drivers/pci/quirks.c | 119
>> +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 119 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
>> caaed1a01dc0..e6538edcdff4 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/sizes.h>
>>  #include <linux/suspend.h>
>>  #include <linux/switchtec.h>
>> +#include <linux/iopoll.h>
>>  #include "pci.h"
>>
>>  static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta) @@
>> -6381,3 +6382,121 @@ static void pci_mask_replay_timer_timeout(struct
>> pci_dev *pdev)  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750,
>> pci_mask_replay_timer_timeout);
>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755,
>> pci_mask_replay_timer_timeout);  #endif
>> +
>> +#define RTL_TX_CONFIG                        0x40
>> +#define RTL_CSIDR                    0x64
>> +#define RTL_CSIAR                    0x68
>> +#define RTL_ERIDR                    0x70
>> +#define RTL_ERIAR                    0x74
>> +#define RTL_OCPDR                    0xb0
>> +
>> +#define CSIAR_FLAG                   0x80000000
>> +#define CSIAR_WRITE_CMD                      0x80000000
>> +#define CSIAR_BYTE_ENABLE            0x0000f000
>> +#define CSIAR_ADDR_MASK                      0x00000fff
>> +
>> +#define ERIAR_READ_CMD                       0x80000000
>> +#define ERIAR_MASK_1111                      0x0f000000
>> +#define ERIAR_EXGMAC                 0
>> +#define ERIAR_FLAG                   0x80000000
>> +
>> +static u32 quirk_rtl_csi_read(void __iomem *base, u8
>> +multi_fun_sel_bit, int addr) {
>> +     u32 cmd =3D (addr & CSIAR_ADDR_MASK) | (multi_fun_sel_bit << 16) |
>> +CSIAR_BYTE_ENABLE;
>
>Possible opportunity for FIELD_PREP().

Will do.
>
>> +     u32 val;
>> +
>> +     writel(cmd, base + RTL_CSIAR);
>> +     if (readl_poll_timeout(base + RTL_CSIAR, val, val & CSIAR_FLAG, 10=
,
>1000))
>> +             return ~0;
>> +     return readl(base + RTL_CSIDR);
>> +}
>> +
>> +static void quirk_rtl_csi_write(void __iomem *base, u8
>> +multi_fun_sel_bit, int addr, int value) {
>> +     u32 cmd =3D CSIAR_WRITE_CMD | (addr & CSIAR_ADDR_MASK) |
>> +               CSIAR_BYTE_ENABLE | (multi_fun_sel_bit << 16);
>
>Ditto.
>
>> +     u32 val;
>> +
>> +     writel(value, base + RTL_CSIDR);
>> +     writel(cmd, base + RTL_CSIAR);
>> +     readl_poll_timeout(base + RTL_CSIAR, val, !(val & CSIAR_FLAG),
>> +10, 1000); }
>> +
>> +static u16 quirk_r8168_mac_ocp_read(void __iomem *base, u32 reg) {
>> +     writel(reg << 15, base + RTL_OCPDR);
>> +     return (u16)readl(base + RTL_OCPDR); }
>> +
>> +static void quirk_rtl8168_clear_and_set_csi(void __iomem *base, u8
>multi_fun_sel_bit,
>> +                                         u32 addr, u32 clearmask, u32
>> +setmask) {
>> +     u32 val =3D quirk_rtl_csi_read(base, multi_fun_sel_bit, addr);
>> +
>> +     if (val !=3D ~0) {
>> +             val &=3D ~clearmask;
>> +             val |=3D setmask;
>> +             quirk_rtl_csi_write(base, multi_fun_sel_bit, addr, val);
>> +     }
>> +}
>> +
>> +static void quirk_rtl8168_other_fun_pci_setting(void __iomem *base, u32
>addr,
>> +                                             u32 clearmask, u32
>> +setmask) {
>> +     for (int i =3D 2; i < 8; i++) {
>> +             if (i =3D=3D 5 || i =3D=3D 6)
>> +                     continue;
>> +             quirk_rtl8168_clear_and_set_csi(base, i, addr, clearmask, =
setmask);
>> +     }
>> +}
>> +
>> +static void quirk_rtl8168_set_aspm_clkreq(struct pci_dev *pdev) {
>> +     void __iomem *base;
>> +     u16 pci_command;
>> +     int mmio_bar;
>> +     u32 txconfig, xid;
>> +
>> +     pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
>> +     if (!(pci_command & PCI_COMMAND_MEMORY))
>> +             return;
>> +
>> +     mmio_bar =3D pci_select_bars(pdev, IORESOURCE_MEM);
>> +     if (!mmio_bar)
>> +             return;
>> +
>> +     mmio_bar =3D ffs(mmio_bar) - 1;
>> +     base =3D pci_iomap(pdev, mmio_bar, 0);
>> +     if (!base)
>> +             return;
>> +
>> +     txconfig =3D readl(base + RTL_TX_CONFIG);
>> +     if (txconfig =3D=3D ~0U) {
>> +             pci_iounmap(pdev, base);
>> +             return;
>> +     }
>> +
>> +     xid =3D (txconfig >> 20) & 0xfcf;
>> +     if ((xid & 0x7cf) !=3D 0x54b && (xid & 0x7cf) !=3D 0x54a) {
>> +             pci_iounmap(pdev, base);
>> +             return;
>> +     }
>> +
>> +     if ((quirk_r8168_mac_ocp_read(base, 0xdc00) & 0x0078) !=3D 0x0030 =
||
>> +         (quirk_r8168_mac_ocp_read(base, 0xd006) & 0x00ff) !=3D 0x0000)=
 {
>> +             pci_iounmap(pdev, base);
>> +             return;
>> +     }
>> +
>> +     quirk_rtl8168_other_fun_pci_setting(base, 0x80,
>> +                                         BIT(0) | BIT(1) | BIT(8),
>> +                                         BIT(0) | BIT(1) | BIT(8));
>> +
>> +     quirk_rtl8168_other_fun_pci_setting(base, 0x44,
>> +                                         0,
>> +                                         BIT(0) | BIT(1));
>> +
>> +     pci_iounmap(pdev, base);
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8168,
>> +quirk_rtl8168_set_aspm_clkreq);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_REALTEK, 0x8168,
>> +quirk_rtl8168_set_aspm_clkreq);
>> --
>> 2.43.0
>>
