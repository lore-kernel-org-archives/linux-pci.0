Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F7EC4161D
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C152146D
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 19:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hm+Gl7Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C152146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeKUGQ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:16:58 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8286 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeKUGQ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2018 01:16:58 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf464760000>; Tue, 20 Nov 2018 11:45:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Nov 2018 11:45:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Nov 2018 11:45:50 -0800
Received: from [10.24.37.36] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 19:45:47 +0000
Subject: Re: [PATCH] PCI: dwc ep: cache config until DBI regs available
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>
References: <20181119222602.28001-1-swarren@wwwdotorg.org>
 <BN6PR12MB11714E3FED1EF50D7F3CA3C9B8D90@BN6PR12MB1171.namprd12.prod.outlook.com>
 <921c50a5-35b7-33e7-398b-3c4cacef8529@wwwdotorg.org>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <1a624400-5f3f-b1b8-50e1-e5aa4b1eb112@nvidia.com>
Date:   Wed, 21 Nov 2018 01:15:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <921c50a5-35b7-33e7-398b-3c4cacef8529@wwwdotorg.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542743159; bh=/v+whejfp56eZNAw4OEustugwTfFkxXyGZxt2+9VZFc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=hm+Gl7Fdlv2vLgy+558E2jhhKJ1FWwgYsDwBPJETqhgw9c9RDMsqhUx3X0eSfB1Ve
         OMz99aZkvTdcVH5QTdFJqtEO+MYEMB1DfEl051LzjmjbIv5CvRz0xn+UBYmf8oW31q
         /6w1wCCyfFm+Ac6wleXDOFNIq8nRQOszWac52/y2KNa16eBPpYzuY4OZyJ0y3JVSVE
         ZajIzLTF8wHzB+iS7li3Z1riMVGoADaVa8ckPMibjQ8MF4RE4QspGkhXJs2XrXlr8+
         0YafTanEBAH+W1wpUFICUguIp+Jq80oSfQtA2X5dTbnjw6ApR4KECaezgzJcXcL9HW
         HB8Az0LqrL3iQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 20/11/18 11:11 PM, Stephen Warren wrote:
> On 11/20/18 10:30 AM, Vidya Sagar wrote:
>>> -----Original Message-----
>>> From: Stephen Warren <swarren@wwwdotorg.org>
>>> Sent: Tuesday, November 20, 2018 3:56 AM
>>> To: Jingoo Han <jingoohan1@gmail.com>; Gustavo Pimentel
>>> <gustavo.pimentel@synopsys.com>; Lorenzo Pieralisi
>>> <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: linux-pci@vger.kernel.org; Vidya Sagar <vidyas@nvidia.com>;=20
>>> Manikanta
>>> Maddireddy <mmaddireddy@nvidia.com>; Stephen Warren
>>> <swarren@nvidia.com>
>>> Subject: [PATCH] PCI: dwc ep: cache config until DBI regs available
>>>
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> Some implementations of the DWC PCIe endpoint controller do not=20
>>> allow access
>>> to DBI registers until the attached host has started REFCLK,=20
>>> released PERST, and
>>> the endpoint driver has initialized clocking of the DBI registers=20
>>> based on that.
>>> One such system is NVIDIA's T194 SoC. The PCIe endpoint subsystem=20
>>> and DWC
>>> driver currently don't work on such hardware, since they assume that=20
>>> all
>>> endpoint configuration can happen at any arbitrary time.
>>>
>>> Enhance the DWC endpoint driver to support such systems by caching all
>>> endpoint configuration in software, and only writing the=20
>>> configuration to
>>> hardware once it's been initialized. This is implemented by=20
>>> splitting all endpoint
>>> controller ops into two functions; the first which simply=20
>>> records/caches the
>>> desired configuration whenever called by the associated function=20
>>> driver and
>>> optionally calls the second, and the second which actually programs the
>>> configuration into hardware, which may be called either by the first=20
>>> function, or
>>> later when it's known that the DBI registers are available.
>>>
>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>> ---
>>> Note: I have only compiled-tested this patch in the context of the=20
>>> mainline
>>> kernel since NVIDIA Tegra PCIe EP support is not yet present.
>>> However, I've built and tested an equivalent patch in our downstream=20
>>> kernel. I
>>> did have to manually port it to mainline due to conflicts though.
>>>
>>> This patch was developed on top of "PCI: designware: don't hard-code=20
>>> DBI/ATU
>>> offset" which I sent last week, so may rely on that for patch context.
>>> ---
>>> =C2=A0 .../pci/controller/dwc/pcie-designware-ep.c=C2=A0=C2=A0 | 199=20
>>> ++++++++++++++----
>>> =C2=A0 drivers/pci/controller/dwc/pcie-designware.h=C2=A0 |=C2=A0 26 ++=
-
>>> =C2=A0 2 files changed, 181 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> index 880210366e71..6910b64bfdcb 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> @@ -73,11 +73,10 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie
>>> *pci, u8 cap)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return __dw_pcie_ep_find_next_cap(pci, n=
ext_cap_ptr, cap);=C2=A0 }
>>>
>>> -static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_epf_header *hdr)
>>> +static void dw_pcie_ep_write_header_regs(struct dw_pcie_ep *ep)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dw_pcie *pci =3D to_dw_pcie_from_=
ep(ep);
>>> +=C2=A0=C2=A0=C2=A0 struct pci_epf_header *hdr =3D &(ep->cached_hdr);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, h=
dr->vendorid); @@ -94,6
>>> +93,19 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8
>>> func_no,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writeb_dbi(pci, PCI_INTERRUPT_PI=
N,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr->interrupt_pin);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>>> +}
>>> +
>>> +static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_epf_header *hdr)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_hdr =3D *hdr;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_ep_write_header_regs(ep);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> @@ -112,6 +124,15 @@ static int dw_pcie_ep_inbound_atu(struct=20
>>> dw_pcie_ep
>>> *ep, enum pci_barno bar,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_inbound_atus[free_win].bar =3D bar;
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_inbound_atus[free_win].cpu_addr =3D cpu_=
addr;
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_inbound_atus[free_win].as_type =3D as_ty=
pe;
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_bars[bar].atu_index =3D free_win;
>>> +=C2=A0=C2=A0=C2=A0 set_bit(free_win, ep->ib_window_map);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D dw_pcie_prog_inbound_atu(pci, fr=
ee_win, bar, cpu_addr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 as_type);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> @@ -119,9 +140,6 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep
>>> *ep, enum pci_barno bar,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 ep->bar_to_atu[bar] =3D free_win;
>>> -=C2=A0=C2=A0=C2=A0 set_bit(free_win, ep->ib_window_map);
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>>
>>> @@ -137,27 +155,66 @@ static int dw_pcie_ep_outbound_atu(struct
>>> dw_pcie_ep *ep, phys_addr_t phys_addr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_outbound_atus[free_win].addr =3D phys_ad=
dr;
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_outbound_atus[free_win].pci_addr =3D pci=
_addr;
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_outbound_atus[free_win].size =3D size;
>>> +=C2=A0=C2=A0=C2=A0 set_bit(free_win, ep->ob_window_map);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_prog_outbound_atu(pci, free_win,=
 PCIE_ATU_TYPE_MEM,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phys_addr, pci_addr, size);
>>>
>>> -=C2=A0=C2=A0=C2=A0 set_bit(free_win, ep->ob_window_map);
>>> -=C2=A0=C2=A0=C2=A0 ep->outbound_addr[free_win] =3D phys_addr;
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>>
>>> +static void dw_pcie_ep_clear_bar_regs(struct dw_pcie_ep *ep, u8=20
>>> func_no,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum pci_barno ba=
r)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>>> +=C2=A0=C2=A0=C2=A0 int flags =3D ep->cached_bars[bar].flags;
>>> +=C2=A0=C2=A0=C2=A0 u32 atu_index =3D ep->cached_bars[bar].atu_index;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 __dw_pcie_ep_reset_bar(pci, bar, flags);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_=
INBOUND); }
>>> +
>>> =C2=A0 static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no=
,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_epf_bar *epf_bar)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dw_pcie_ep *ep =3D epc_get_drvdat=
a(epc);
>>> -=C2=A0=C2=A0=C2=A0 struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum pci_barno bar =3D epf_bar->barno;
>>> -=C2=A0=C2=A0=C2=A0 u32 atu_index =3D ep->bar_to_atu[bar];
>>> +=C2=A0=C2=A0=C2=A0 u32 atu_index =3D ep->cached_bars[bar].atu_index;
>>>
>>> -=C2=A0=C2=A0=C2=A0 __dw_pcie_ep_reset_bar(pci, bar, epf_bar->flags);
>>> -
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_=
INBOUND);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear_bit(atu_index, ep->ib_window_map);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_ep_clear_bar_regs(ep, func_no, bar); }
>>> +
>>> +static void dw_pcie_ep_set_bar_regs(struct dw_pcie_ep *ep, u8 func_no,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum pci_barno bar)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>>> +=C2=A0=C2=A0=C2=A0 size_t size =3D ep->cached_bars[bar].size;
>>> +=C2=A0=C2=A0=C2=A0 int flags =3D ep->cached_bars[bar].flags;
>>> +=C2=A0=C2=A0=C2=A0 u32 reg =3D PCI_BASE_ADDRESS_0 + (4 * bar);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - =
1));
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_writel_dbi(pci, reg, flags);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writel_dbi2(pci, re=
g + 4, upper_32_bits(size - 1));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writel_dbi(pci, reg=
 + 4, 0);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>>> =C2=A0 }
>>>
>>> =C2=A0 static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, @=
@=20
>>> -165,12
>>> +222,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8=20
>>> func_no,=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dw_pcie_ep *ep =3D epc_get_drvdat=
a(epc);
>>> -=C2=A0=C2=A0=C2=A0 struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum pci_barno bar =3D epf_bar->barno;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t size =3D epf_bar->size;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int flags =3D epf_bar->flags;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum dw_pcie_as_type as_type;
>>> -=C2=A0=C2=A0=C2=A0 u32 reg =3D PCI_BASE_ADDRESS_0 + (4 * bar);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(flags & PCI_BASE_ADDRESS_SPACE))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as_type =3D DW_P=
CIE_AS_MEM;
>>> @@ -181,17 +236,13 @@ static int dw_pcie_ep_set_bar(struct pci_epc=20
>>> *epc, u8
>>> func_no,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>>> -
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - =
1));
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_writel_dbi(pci, reg, flags);
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_bars[bar].size =3D size;
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_bars[bar].flags =3D flags;
>>>
>>> -=C2=A0=C2=A0=C2=A0 if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writel_dbi2(pci, re=
g + 4, upper_32_bits(size - 1));
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writel_dbi(pci, reg=
 + 4, 0);
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (!ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_ep_set_bar_regs(ep, func_no, bar);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> @@ -202,7 +253,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep=20
>>> *ep,
>>> phys_addr_t addr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 index;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (index =3D 0; index < ep->num_ob_win=
dows; index++) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ep->outbound_addr[index=
] !=3D addr)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ep->cached_outbound_atu=
s[index].addr !=3D addr)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *atu_index =3D i=
ndex;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> @@ -223,8 +274,12 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc
>>> *epc, u8 func_no,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_=
OUTBOUND);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear_bit(atu_index, ep->ob_window_map);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_=
OUTBOUND);
>>> =C2=A0 }
>>>
>>> =C2=A0 static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, =
@@=20
>>> -254,7
>>> +309,10 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8=20
>>> func_no)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D ep->msi_cap + PCI_MSI_FLAGS;
>>> -=C2=A0=C2=A0=C2=A0 val =3D dw_pcie_readw_dbi(pci, reg);
>>> +=C2=A0=C2=A0=C2=A0 if (ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D dw_pcie_readw_dbi(p=
ci, reg);
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D ep->cached_msi_flag=
s;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(val & PCI_MSI_FLAGS_ENABLE))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>
>>> @@ -273,12 +331,19 @@ static int dw_pcie_ep_set_msi(struct pci_epc=20
>>> *epc, u8
>>> func_no, u8 interrupts)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D ep->msi_cap + PCI_MSI_FLAGS;
>>> -=C2=A0=C2=A0=C2=A0 val =3D dw_pcie_readw_dbi(pci, reg);
>>> +=C2=A0=C2=A0=C2=A0 if (ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D dw_pcie_readw_dbi(p=
ci, reg);
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D ep->cached_msi_flag=
s;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val &=3D ~PCI_MSI_FLAGS_QMASK;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val |=3D (interrupts << 1) & PCI_MSI_FLA=
GS_QMASK;
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, reg, val);
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>>> +=C2=A0=C2=A0=C2=A0 if (ep->hw_regs_available) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, reg=
, val);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ep->cached_msi_flags =3D va=
l;
>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> @@ -293,7 +358,10 @@ static int dw_pcie_ep_get_msix(struct pci_epc=20
>>> *epc,
>>> u8 func_no)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D ep->msix_cap + PCI_MSIX_FLAGS;
>>> -=C2=A0=C2=A0=C2=A0 val =3D dw_pcie_readw_dbi(pci, reg);
>>> +=C2=A0=C2=A0=C2=A0 if (ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D dw_pcie_readw_dbi(p=
ci, reg);
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D ep->cached_msix_fla=
gs;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(val & PCI_MSIX_FLAGS_ENABLE))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>
>>> @@ -312,16 +380,49 @@ static int dw_pcie_ep_set_msix(struct pci_epc=20
>>> *epc,
>>> u8 func_no, u16 interrupts)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D ep->msix_cap + PCI_MSIX_FLAGS;
>>> -=C2=A0=C2=A0=C2=A0 val =3D dw_pcie_readw_dbi(pci, reg);
>>> +=C2=A0=C2=A0=C2=A0 if (ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D dw_pcie_readw_dbi(p=
ci, reg);
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D ep->cached_msix_fla=
gs;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val &=3D ~PCI_MSIX_FLAGS_QSIZE;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val |=3D interrupts;
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, reg, val);
>>> -=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>>> +=C2=A0=C2=A0=C2=A0 if (ep->hw_regs_available) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, reg=
, val);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ep->cached_msix_flags =3D v=
al;
>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>>
>>> +void dw_pcie_set_regs_available(struct dw_pcie *pci) {
>>> +=C2=A0=C2=A0=C2=A0 struct dw_pcie_ep *ep =3D &(pci->ep);
>>> +=C2=A0=C2=A0=C2=A0 int i;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ep->hw_regs_available =3D true;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_ep_write_header_regs(ep);
>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, ep->ib_window_map, ep->num_ib_w=
indows) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_prog_inbound_atu(pc=
i, i,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ep-=
>cached_inbound_atus[i].bar,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ep-=
>cached_inbound_atus[i].cpu_addr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ep-=
>cached_inbound_atus[i].as_type);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_ep_set_bar_regs(ep,=
 0, ep-
>>>> cached_inbound_atus[i].bar);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, ep->ob_window_map, ep->num_ob_w=
indows)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_prog_outbound_atu(p=
ci, i, PCIE_ATU_TYPE_MEM,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ep-=
>cached_outbound_atus[i].addr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ep-=
>cached_outbound_atus[i].pci_addr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ep-=
>cached_outbound_atus[i].size);
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, PCI_MSI_FLAGS, ep->cached_m=
si_flags);
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, PCI_MSIX_FLAGS, ep->cached_=
msix_flags);
>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>>> +}
>>> +
>>> =C2=A0 static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum pci_epc_irq_type type, u16
>>> interrupt_num)=C2=A0 { @@ -330,6 +431,9 @@ static int=20
>>> dw_pcie_ep_raise_irq(struct
>>> pci_epc *epc, u8 func_no,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ep->ops->raise_irq)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>
>>> +=C2=A0=C2=A0=C2=A0 if (!ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EAGAIN;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ep->ops->raise_irq(ep, func_no, t=
ype, interrupt_num);=C2=A0 }
>>>
>>> @@ -391,6 +495,9 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
>>> u8 func_no,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool has_upper;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>
>>> +=C2=A0=C2=A0=C2=A0 if (!ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EAGAIN;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ep->msi_cap)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>
>>> @@ -436,6 +543,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep=20
>>> *ep,
>>> u8 func_no,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __iomem *msix_tbl;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>
>>> +=C2=A0=C2=A0=C2=A0 if (!ep->hw_regs_available)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EAGAIN;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D ep->msix_cap + PCI_MSIX_TABLE;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tbl_offset =3D dw_pcie_readl_dbi(pci, re=
g);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bir =3D (tbl_offset & PCI_MSIX_TABLE_BIR=
); @@ -494,7 +604,6 @@ void
>>> dw_pcie_ep_exit(struct dw_pcie_ep *ep)=C2=A0 int dw_pcie_ep_init(struct
>>> dw_pcie_ep *ep)=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> -=C2=A0=C2=A0=C2=A0 void *addr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_epc *epc;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dw_pcie *pci =3D to_dw_pcie_from_=
ep(ep);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D pci->dev;
>>> @@ -543,11 +652,17 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ep->ob_window_map)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>>
>>> -=C2=A0=C2=A0=C2=A0 addr =3D devm_kcalloc(dev, ep->num_ob_windows, size=
of(phys_addr_t),
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>>> -=C2=A0=C2=A0=C2=A0 if (!addr)
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_inbound_atus =3D devm_kzalloc(dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(ep->cached_inbound_a=
tus[0]) * ep->num_ib_windows,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>>> +=C2=A0=C2=A0=C2=A0 if (!ep->cached_inbound_atus)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ep->cached_outbound_atus =3D devm_kzalloc(dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(ep->cached_outbound_=
atus[0]) * ep->num_ob_windows,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>>> +=C2=A0=C2=A0=C2=A0 if (!ep->cached_outbound_atus)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>> -=C2=A0=C2=A0=C2=A0 ep->outbound_addr =3D addr;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 epc =3D devm_pci_epc_create(dev, &epc_op=
s);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(epc)) {
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
>>> b/drivers/pci/controller/dwc/pcie-designware.h
>>> index 02fb532c5db9..c116b289aa51 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>> @@ -192,8 +192,6 @@ struct dw_pcie_ep {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phys_addr_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 phys_base;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr_size;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_size;
>>> -=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bar_to_atu[6];
>>> -=C2=A0=C2=A0=C2=A0 phys_addr_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *outbound_addr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *ib_window_map;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *ob_window_map;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_ib_windows;
>>> @@ -202,6 +200,25 @@ struct dw_pcie_ep {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phys_addr_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 msi_mem_phys;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msi_cap;=C2=A0=C2=A0=C2=A0 /* MSI capability=
 offset */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msix_cap;=C2=A0=C2=A0=C2=A0 /* MSI-X capabil=
ity offset */
>>> +=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hw_regs_available;
>>> +=C2=A0=C2=A0=C2=A0 struct pci_epf_header=C2=A0=C2=A0=C2=A0 cached_hdr;
>>> +=C2=A0=C2=A0=C2=A0 struct {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atu_index;
>>> +=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cached_bars[6];
>>> +=C2=A0=C2=A0=C2=A0 struct {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum pci_barno=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bar;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_addr_t=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_addr;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum dw_pcie_as_type=C2=A0=
=C2=A0=C2=A0 as_type;
>>> +=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *cached_inbound_atus;
>>> +=C2=A0=C2=A0=C2=A0 struct {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phys_addr_t=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_addr;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size;
>>> +=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *cached_outbound_atus;
>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cached_msi_flags;
>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cached_msix_flags;
>>> =C2=A0 };
>>>
>>> =C2=A0 struct dw_pcie_ops {
>>> @@ -363,6 +380,7 @@ static inline int dw_pcie_allocate_domains(struct
>>> pcie_port *pp)=C2=A0 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);=C2=
=A0 int
>>> dw_pcie_ep_init(struct dw_pcie_ep *ep);=C2=A0 void dw_pcie_ep_exit(stru=
ct
>>> dw_pcie_ep *ep);
>>> +void dw_pcie_ep_set_regs_available(struct dw_pcie *pci);
>>> =C2=A0 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8=20
>>> func_no);=C2=A0 int
>>> dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 interrupt_num);
>>> @@ -383,6 +401,10 @@ static inline void dw_pcie_ep_exit(struct=20
>>> dw_pcie_ep
>>> *ep)=C2=A0 {=C2=A0 }
>>>
>>> +static inline void dw_pcie_ep_set_regs_available(struct dw_pcie=20
>>> *pci) {
>>> +}
>>> +
>>> =C2=A0 static inline int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep=
=20
>>> *ep, u8
>>> func_no)=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> --=20
>>> 2.19.1
>>
>> What is the guidance on setting "hw_regs_available" param?
>> I mean, in case of hardware platforms where registers are always=20
>> available to write (Ex:- pci-epf-test.c), how do they
>> either (a) set the param hw_regs_available to '1' or (b) call=20
>> dw_pcie_set_regs_available() to commit all cached values to registers?
>
> Oh yes, I forgot to add that part when moving this patch upstream.
>
> Right now, our downstream endpoint driver calls=20
> dw_pcie_set_regs_available() when it has made the registers available.=20
> Drivers for any hardware where the registers are always available=20
> (i.e. all current DWC EP drivers in mainline) should set=20
> ep->hw_regs_available during initialization. So, this patch needs to=20
> be amended to either:
>
> a) Update every existing DWC EP driver to set ep->hw_regs_available=20
> during probe/initialization.
>
> b) Replace ep->hw_regs_available with ep->hw_regs_unavailable, so that=20
> the default 0 value (assuming kzalloc is used to alloc the ep struct)=20
> means the registers can be accessed, with the ability for individual=20
> drivers (i.e. Tegra's) to set that value during probe/initialization.
>
> Before I do that though, I'd still like general feedback on this patch=20
> so I can incorporate that into any updated version.
>
>> I see a need for APIs to establish the link among dw_pcie_ep ->=20
>> pci_epc -> pci_epf_driver.
>
> I don't understand this part.
Nevermind. With option-(a) above, it is not required.
