Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB09C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 09:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C693B20693
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 09:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WK0PzBBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfDPJxD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:53:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13615 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfDPJxD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 05:53:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb5a5e20000>; Tue, 16 Apr 2019 02:52:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 02:52:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 02:52:53 -0700
Received: from [10.24.192.75] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 09:52:50 +0000
Subject: Re: [PATCH] PCI: disable nv_msi_ht_cap_quirk_leaf quirk on arm/arm64
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20180730094213.11973-1-kwizart@gmail.com>
 <20190415092537.14305-1-kwizart@gmail.com>
 <20190415134813.GA111421@google.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <ad3aad60-c743-be19-9041-e6ed7f149a35@nvidia.com>
Date:   Tue, 16 Apr 2019 15:22:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415134813.GA111421@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555408354; bh=M5ReHsq5SS2euTb48HazoI/Z7YSBdCE8EqWFLmJxgdg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=WK0PzBBzu49YmLyE+SXh8QEhutMQ3x1W2oSKYVgE4C6bmUr7rVylzFIX8Ay27BId2
         Tyv7JJkaWTKXqnzgJ8G2ktIW5sz0oqkBsnxOXOWFQao3lJaI8X+mNaFNhwBqfzjn0L
         o/0lwik93cN0/FFSUT1HWJrQC0hm3sZL29lFBko6OFJVOqVFXKi0fU9KjQYYSCuEyh
         lECh9qsjH+60ghQAugegINs0BYJYpDG8tYn8ng76ndbp6cI7skgnG6agAkxH+yTw6o
         rxdUb4PjQDqGXfmDnLEHDGghqPTH5woAp4WgzmfLIQop198CIhvIJML/I1KJTJIXsi
         1jMIj/lRKgOOw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 7:18 PM, Bjorn Helgaas wrote:
> On Mon, Apr 15, 2019 at 11:25:37AM +0200, Nicolas Chauvet wrote:
>> This patch disable the use of nv_msi_ht_cap_quirk_leaf quirk on arm and
>> arm64 NVIDIA devices such as Tegra
>>
>> This fixes the following output:
>> "pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host bridge"
>> as experienced on a Trimslice device with PCI host bridge enabled
>>
>> v3: exclude the quirk for arm and arm64 instead of only for x86
>>
>> v2: use __maybe_unused to avoid a warning on nv_msi_ht_cap_quirk_leaf
>>
>> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
>> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> ---
>>  drivers/pci/quirks.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index a59ad09ce911..1ac65f09d7ee 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2811,12 +2811,15 @@ static void nv_msi_ht_cap_quirk_all(struct pci_d=
ev *dev)
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_qui=
rk_all);
>>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_=
cap_quirk_all);
>> =20
>> -static void nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
>> +static void __maybe_unused nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev=
)
>>  {
>>  	return __nv_msi_ht_cap_quirk(dev, 0);
>>  }
>> +/* HyperTransport is not relevant on theses arches */
>> +#if !IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)
> I don't see any of the previous versions or discussion on the list, so
> I can't tell what led to this #ifdef, but I'd prefer to avoid #ifdefs
> like this because they're checking for arch at the wrong level.
>
> If you're seeing that warning message, apparently your system contains
> an Nvidia device that has an HT_CAPTYPE_MSI_MAPPING capability, so
> HyperTransport is at least in the picture, even on arm/arm64.
>
> The quirk assumes a host bridge at 00:00.0, which is really a
> device-specific assumption, or maybe something specific to
> HyperTransport.  It's certainly not required by the PCI specs, which
> don't require a host bridge to be visible as a PCI device at all.
>
> I'd be tempted to just change that pci_warn() to a pci_info() or maybe
> even remove it altogether.  It would be nice to have the complete
> "lspci -vv" and dmesg log archived for future reference, since this
> quirk has such a broad reach (matching PCI_ANY_ID) and it has a long
> and ugly history already.

Nvidia HW team confirmed that HyperTransport is supported in AMD CPU + Nvid=
ia NForce motherboard and not supported in Tegra.

We are seeing the warn log because Tegra host bridge enumerates from device=
 number 1, as shown in below lspci output taken from Tegra210. HT_CAPTYPE_M=
SI_MAPPING capability is present in Tegra even though it doesn't support an=
d ARCH check is not best approach here. So changing pci_warn() to pci_info(=
) should be fine.

# lspci -D
0000:00:01.0 Class 0604: Device 10de:0fae (rev a1)
0000:00:02.0 Class 0604: Device 10de:0faf (rev a1)
0000:01:00.0 Class 0200: Device 10ec:8168 (rev 0c)
0000:02:00.0 Class 0280: Device 14e4:43ec (rev 02)
# lspci -t
-[0000:00]-+-01.0-[01]----00.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \-02.0-[02]---=
-00.0

dmesg log:
tegra-pcie 1003000.pcie: 4x1, 1x1 configuration
tegra-pcie 1003000.pcie: probing port 0, using 4 lanes
tegra-pcie 1003000.pcie: probing port 1, using 1 lanes
tegra-pcie 1003000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io=C2=A0 0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x13000000-0x1fffffff]
pci_bus 0000:00: root bus resource [mem 0x20000000-0x3fffffff pref]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x4 may corrupt=
 adjacent RW1C bits
pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x4 may corrupt=
 adjacent RW1C bits
pci 0000:00:01.0: enabling Extended Tags
pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x88 may corrup=
t adjacent RW1C bits
pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x3e may corrup=
t adjacent RW1C bits
pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x52 may corrup=
t adjacent RW1C bits
pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x4c may corrup=
t adjacent RW1C bits
pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x4 may corrupt=
 adjacent RW1C bits
pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x4 may corrupt=
 adjacent RW1C bits
pci 0000:00:02.0: enabling Extended Tags
pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x88 may corrup=
t adjacent RW1C bits
pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x3e may corrup=
t adjacent RW1C bits
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:02.0: BAR 14: assigned [mem 0x13000000-0x135fffff]
pci 0000:00:01.0: BAR 14: assigned [mem 0x13600000-0x136fffff]
pci 0000:00:01.0: BAR 15: assigned [mem 0x20000000-0x200fffff 64bit pref]
pci 0000:00:01.0: BAR 13: assigned [io=C2=A0 0x1000-0x1fff]
pci 0000:01:00.0: BAR 4: assigned [mem 0x20000000-0x20003fff 64bit pref]
pci 0000:01:00.0: BAR 2: assigned [mem 0x13600000-0x13600fff 64bit]
pci 0000:01:00.0: BAR 0: assigned [io=C2=A0 0x1000-0x10ff]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:=C2=A0=C2=A0 bridge window [io=C2=A0 0x1000-0x1fff]
pci 0000:00:01.0:=C2=A0=C2=A0 bridge window [mem 0x13600000-0x136fffff]
pci 0000:00:01.0:=C2=A0=C2=A0 bridge window [mem 0x20000000-0x200fffff 64bi=
t pref]
pci 0000:02:00.0: BAR 2: assigned [mem 0x13000000-0x133fffff 64bit]
pci 0000:02:00.0: BAR 0: assigned [mem 0x13400000-0x13407fff 64bit]
pci 0000:00:02.0: PCI bridge to [bus 02]
pci 0000:00:02.0:=C2=A0=C2=A0 bridge window [mem 0x13000000-0x135fffff]
pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host bridge
pcieport 0000:00:01.0: enabling device (0000 -> 0003)
pci 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge
pcieport 0000:00:02.0: enabling device (0000 -> 0002)

# lspci -vv
00:01.0 Class 0604: Device 10de:0fae (rev a1)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ Sp=
ecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B=
- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Latency: 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 1=
0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D0=
1, subordinate=3D01, sec-latency=3D0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: 00001000-0000=
1fff [size=3D4K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: 13600000-1=
36fffff [size=3D1M]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridg=
e: 0000000020000000-00000000200fffff [size=3D1M]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Secondary status: 66MHz- FastB2B=
- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BridgeCtl: Parity- SERR+ NoISA- =
VGA- MAbort- >Reset- FastB2B-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [40] Subsystem: De=
vice 10de:0000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [48] Power Managem=
ent version 3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold+)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [50] MSI: Enable- =
Count=3D1/2 Maskable- 64bit+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Address: 0000000179eea000=C2=A0 Data: 0000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [60] HyperTranspor=
t: MSI Mapping Enable- Fixed-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Mapping Address Base: 00000000fee00000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [80] Express (v2) =
Root Port (Slot+), MSI 00
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCap: MaxPayload 128 bytes, PhantFunc 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtTag+ RBE=
+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RlxdOrd+ Ex=
tTag+ PhantFunc- AuxPwr- NoSnoop+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MaxPayload =
128 bytes, MaxReadReq 512 bytes
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- Tr=
ansPend-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s, Exit Late=
ncy L0s <512ns
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ClockPM- Su=
rprise- LLActRep+ BwNot+ ASPMOptComp-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtSynch- C=
lockPM- AutWidDis- BWInt+ AutBWInt-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLA=
ctive+ BWMgmt- ABWMgmt-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Su=
rprise-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Slot #0, Po=
werLimit 0.000W; Interlock- NoCompl-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPI=
rq- LinkChg-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Control: At=
tnInd Off, PwrInd On, Power- Interlock-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ I=
nterlock-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Changed: MR=
L- PresDet+ LinkState+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-=
 CRSVisible-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RootCap: CRSVisible-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR+, O=
BFF Not Supported ARIFwd-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Atomi=
cOpsCap: Routing- 32bit- 64bit- 128bitCAS-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
+, OBFF Disabled ARIFwd-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Atomi=
cOpsCtl: ReqEn- EgressBlck-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Trans=
mit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Compl=
iance De-emphasis: -6dB
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationCom=
plete-, EqualizationPhase1-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Equal=
izationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Advanced =
Error Reporting
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UESta:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCm=
plt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UEMsk:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCm=
plt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 CESta:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout- Non=
FatalErr-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 CEMsk:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout- Non=
FatalErr+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECR=
CChkCap+ ECRCChkEn-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MultHdrRecC=
ap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 HeaderLog: 00000000 00000000 00000000 00000000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RootCmd: CERptEn- NFERptEn- FERptEn-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 First=
Fatal- NonFatalMsg- FatalMsg- IntMsg 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [140 v1] L1 PM Sub=
states
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L=
1_PM_Substates+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 PortCommonModeRestoreTime=3D255us PortTPowerOnTime=3D10us
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 T_CommonMode=3D255us LTR1.2_Threshold=3D0ns
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D10us
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport

00:02.0 Class 0604: Device 10de:0faf (rev a1)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Control: I/O- Mem+ BusMaster+ Sp=
ecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B=
- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Latency: 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 1=
0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D0=
2, subordinate=3D02, sec-latency=3D0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: None
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: 13000000-1=
35fffff [size=3D6M]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridg=
e: None
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Secondary status: 66MHz- FastB2B=
- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BridgeCtl: Parity- SERR+ NoISA- =
VGA- MAbort- >Reset- FastB2B-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [40] Subsystem: De=
vice 10de:0000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [48] Power Managem=
ent version 3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold+)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [50] MSI: Enable- =
Count=3D1/2 Maskable- 64bit+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Address: 0000000179eea000=C2=A0 Data: 0000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [60] HyperTranspor=
t: MSI Mapping Enable- Fixed-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Mapping Address Base: 00000000fee00000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [80] Express (v2) =
Root Port (Slot+), MSI 00
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCap: MaxPayload 128 bytes, PhantFunc 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtTag+ RBE=
+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RlxdOrd+ Ex=
tTag+ PhantFunc- AuxPwr- NoSnoop+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MaxPayload =
128 bytes, MaxReadReq 512 bytes
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- Tr=
ansPend-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s, Exit Late=
ncy L0s <512ns
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ClockPM- Su=
rprise- LLActRep+ BwNot+ ASPMOptComp-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtSynch- C=
lockPM- AutWidDis- BWInt+ AutBWInt-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLA=
ctive+ BWMgmt- ABWMgmt-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Su=
rprise-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Slot #0, Po=
werLimit 0.000W; Interlock- NoCompl-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPI=
rq- LinkChg-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Control: At=
tnInd Off, PwrInd On, Power- Interlock-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ I=
nterlock-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Changed: MR=
L- PresDet+ LinkState+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-=
 CRSVisible-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RootCap: CRSVisible-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR+, O=
BFF Not Supported ARIFwd-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Atomi=
cOpsCap: Routing- 32bit- 64bit- 128bitCAS-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
+, OBFF Disabled ARIFwd-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Atomi=
cOpsCtl: ReqEn- EgressBlck-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Trans=
mit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Compl=
iance De-emphasis: -6dB
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationCom=
plete-, EqualizationPhase1-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Equal=
izationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Advanced =
Error Reporting
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UESta:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCm=
plt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UEMsk:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCm=
plt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 CESta:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout- Non=
FatalErr-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 CEMsk:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout- Non=
FatalErr+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- E[=
=C2=A0 916.955543] pci 0000:01:00.0: invalid short VPD tag 00 at offset 1
CRCChkCap+ ECRCChkEn-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MultHdrRecC=
ap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 HeaderLog: 00000000 00000000 00000000 00000000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RootCmd: CERptEn- NFERptEn- FERptEn-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 First=
Fatal- NonFatalMsg- FatalMsg- IntMsg 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [140 v1] L1 PM Sub=
states
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L=
1_PM_Substates+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 PortCommonModeRestoreTime=3D255us PortTPowerOnTime=3D10us
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 T_CommonMode=3D255us LTR1.2_Threshold=3D0ns
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D10us
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport

01:00.0 Class 0200: Device 10ec:8168 (rev 0c)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Device 10ec:0123
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Control: I/O- Mem- BusMaster- Sp=
ecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B=
- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 2=
55
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Region 0: I/O ports at 1000 [dis=
abled] [size=3D256]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Region 2: Memory at 13600000 (64=
-bit, non-prefetchable) [disabled] [size=3D4K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Region 4: Memory at 20000000 (64=
-bit, prefetchable) [disabled] [size=3D16K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [40] Power Managem=
ent version 3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,=
D2+,D3hot+,D3cold+)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [50] MSI: Enable- =
Count=3D1/1 Maskable- 64bit+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Address: 0000000000000000=C2=A0 Data: 0000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [70] Express (v2) =
Endpoint, MSI 01
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512=
ns, L1 <64us
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtTag- Att=
nBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RlxdOrd+ Ex=
tTag- PhantFunc- AuxPwr- NoSnoop-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MaxPayload =
128 bytes, MaxReadReq 512 bytes
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ Tr=
ansPend-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit=
 Latency L0s unlimited, L1 <64us
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ClockPM+ Su=
rprise- LLActRep- BwNot- ASPMOptComp+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtSynch- C=
lockPM- AutWidDis- BWInt- AutBWInt-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLA=
ctive- BWMgmt- ABWMgmt-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+,=
 OBFF Via message/WAKE#
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Atomi=
cOpsCap: 32bit- 64bit- 128bitCAS-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
-, OBFF Disabled
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Atomi=
cOpsCtl: ReqEn-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Speed=
Dis-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Trans=
mit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Compl=
iance De-emphasis: -6dB
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Equal=
izationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [b0] MSI-X: Enable=
- Count=3D4 Masked-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Vector table: BAR=3D4 offset=3D00000000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 PBA: BAR=3D4 offset=3D00000800
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [d0] Vital Product=
 Data
pcilib: sysfs_read_vpd: read failed: Input/output error
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Not readable
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Advanced =
Error Reporting
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UESta:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCm=
plt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UEMsk:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCm=
plt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 CESta:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout- Non=
FatalErr-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 CEMsk:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout- Non=
FatalErr+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECR=
CChkCap+ ECRCChkEn-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MultHdrRecC=
ap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 HeaderLog: 00000000 00000000 00000000 00000000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [140 v1] Virtual C=
hannel
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Caps:=C2=A0=C2=A0 LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Arb:=C2=A0=C2=A0=C2=A0 Fixed- WRR32- WRR64- WRR128-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Ctrl:=C2=A0=C2=A0 ArbSelect=3DFixed
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Status: InProgress-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 VC0:=C2=A0=C2=A0=C2=A0 Caps:=C2=A0=C2=A0 PATOffset=3D00 Max=
TimeSlots=3D1 RejSnoopTrans-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Arb:=C2=A0=
=C2=A0=C2=A0 Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ctrl:=C2=A0=
=C2=A0 Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: Neg=
oPending- InProgress-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [160 v1] Device Se=
rial Number 01-00-00-00-68-4c-e0-00
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [170 v1] Latency T=
olerance Reporting
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Max snoop latency: 0ns
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Max no snoop latency: 0ns

02:00.0 Class 0280: Device 14e4:43ec (rev 02)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Device 17aa:0777
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Control: I/O- Mem- BusMaster- Sp=
ecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B=
- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Region 0: Memory at 13400000 (64=
-bit, non-prefetchable) [disabled] [size=3D32K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Region 2: Memory at 13000000 (64=
-bit, non-prefetchable) [disabled] [size=3D4M]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [48] Power Managem=
ent version 3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold+)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D2 PME-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [58] MSI: Enable- =
Count=3D1/16 Maskable- 64bit+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Address: 0000000000000000=C2=A0 Data: 0000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [68] Vendor Specif=
ic Information: Len=3D44 <?>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [ac] Express (v2) =
Endpoint, MSI 00
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us=
, L1 unlimited
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtTag- Att=
nBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RlxdOrd+ Ex=
tTag- PhantFunc- AuxPwr+ NoSnoop+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MaxPayload =
128 bytes, MaxReadReq 512 bytes
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ Tr=
ansPend-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit=
 Latency L0s <2us, L1 <32us
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ClockPM+ Su=
rprise- LLActRep- BwNot- ASPMOptComp+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtSynch- C=
lockPM- AutWidDis- BWInt- AutBWInt-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLA=
ctive- BWMgmt- ABWMgmt-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+,=
 OBFF Via WAKE#
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Atomi=
cOpsCap: 32bit- 64bit- 128bitCAS-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
-, OBFF Disabled
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Atomi=
cOpsCtl: ReqEn-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Speed=
Dis-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Trans=
mit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Compl=
iance De-emphasis: -6dB
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationCom=
plete-, EqualizationPhase1-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Equal=
izationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Advanced =
Error Reporting
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UESta:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCm=
plt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UEMsk:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCm=
plt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 CESta:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout- Non=
FatalErr-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 CEMsk:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout- Non=
FatalErr+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECR=
CChkCap+ ECRCChkEn-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MultHdrRecC=
ap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 HeaderLog: 00000000 00000000 00000000 00000000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [13c v1] Device Se=
rial Number 00-00-a2-ff-ff-75-5c-93
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [150 v1] Power Bud=
geting <?>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [160 v1] Virtual C=
hannel
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Caps:=C2=A0=C2=A0 LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Arb:=C2=A0=C2=A0=C2=A0 Fixed- WRR32- WRR64- WRR128-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Ctrl:=C2=A0=C2=A0 ArbSelect=3DFixed
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Status: InProgress-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 VC0:=C2=A0=C2=A0=C2=A0 Caps:=C2=A0=C2=A0 PATOffset=3D00 Max=
TimeSlots=3D1 RejSnoopTrans-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Arb:=C2=A0=
=C2=A0=C2=A0 Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ctrl:=C2=A0=
=C2=A0 Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: Neg=
oPending- InProgress-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [1b0 v1] Latency T=
olerance Reporting
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Max snoop latency: 0ns
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Max no snoop latency: 0ns
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [220 v1] #15
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [240 v1] L1 PM Sub=
states
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L=
1_PM_Substates+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 PortCommonModeRestoreTime=3D0us PortTPowerOnTime=3D50us
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D10us

Manikanta
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap=
_quirk_leaf);
>>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi=
_ht_cap_quirk_leaf);
>> +#endif
>> =20
>>  static void quirk_msi_intx_disable_bug(struct pci_dev *dev)
>>  {
>> --=20
>> 2.17.2
>>

