Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33588C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 10:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC89E20684
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 10:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iDKlyYGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfDOKn0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:43:26 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16715 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDOKn0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 06:43:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb460390000>; Mon, 15 Apr 2019 03:43:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 03:43:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 03:43:23 -0700
Received: from [10.24.192.241] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 10:43:20 +0000
Subject: Re: [PATCH 14/30] PCI: tegra: Set target speed as Gen1 before link up
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-15-mmaddireddy@nvidia.com>
 <20190411200437.GR256045@google.com>
 <5bf9c119-5f1e-5f41-7c41-b4182cbba3c9@nvidia.com>
 <20190412143551.GD141472@google.com>
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <12a87ca0-4e59-15b5-881a-86e896009fd8@nvidia.com>
Date:   Mon, 15 Apr 2019 16:13:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412143551.GD141472@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555324985; bh=liiPt+ioraP75Vbrn8I4IFKG0G3YTqfEWMsYP+q5cqo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=iDKlyYGJ7GWtxVG6EWKgiaoaRGOCxVP9kmKvbSdVsQm9maxnzydX5pv/R/OjQY71s
         8GjbTa2saSCpZ5hAepkdUujBfY90lYEXOa9snEllqfhqVzHmU72s8B75eCaVujC0pu
         aVhdh2+wrQhGX3MbvrXQVBb3apqeW5PFGx9bLHCAY96lgNYeBEVWuNbnoTzXCkN5Wx
         RKdy9PCIVES8q2CGBjV79q1dyYvqspfCQw8N0qomJLS4whtiBlcVigQn3FToOxGGda
         OcVJthkXHRP/lap8d6zdaR7tXaYzeNyNakT1pJ5JrUrzXTNQqQ4Dz6TP99/aV7RoTC
         NmtDyPbNmSaQg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12-Apr-19 8:05 PM, Bjorn Helgaas wrote:
> On Fri, Apr 12, 2019 at 12:14:20PM +0530, Manikanta Maddireddy wrote:
>> On 12-Apr-19 1:34 AM, Bjorn Helgaas wrote:
>>> On Thu, Apr 11, 2019 at 10:33:39PM +0530, Manikanta Maddireddy wrote:
>>>> Some of the legacy PCIe endpoints doesn't enumerate if root port adver=
tises
>>>> both Gen-1 and Gen-2 speeds. Hence, the strategy followed here is to
>>>> initially advertise only Gen-1 and after link is up, retrain link to G=
en-2
>>>> speed.
>>>>
>>>> Following two cards display this behaviour,
>>>>   - Fusion HDTV 5 Express card
>>>>   - IOGear SIL - PCIE - SATA card
>>> This sounds like a Tegra erratum.  If you think this is an issue with
>>> the endpoints above, not with Tegra, we should see issues with these
>>> cards in non-Tegra systems.
>>>
>>> If that's the case, we might need a more far-reaching solution that
>>> would fix issues with these cards in all systems.
>>>
>>> If it really is a Tegra erratum, that's fine; just own up to it in the
>>> commit log and comment so it's not misleading.
>> Based on PCIe LA traces with x86 platform:
>> =C2=A01) x86 initially advertises Gen1, Gen2 & Gen3 speeds. Link number =
negotiation does not happen
>> =C2=A0as end point does not lock down to the advertised link number from=
 RP.
>> =C2=A02) There are multiple entries to detect<->compliance from the both=
 the sides.
>> =C2=A03) After some time (or some counts of detect entry), x86 only adve=
rtises Gen1 speed in TS1
>> =C2=A04) This time end point responds to the link number in the TS1 and =
link comes up
>>
>> Tegra PCIe IP fails after step-2, it doesn't retry with only Gen1.
>> This is the reason for setting link speed to Gen1 and then start
>> LTSSM.
>>
>> I don't see anything mentioned about advertising lower link speed
>> and retrying link up in "Configuration Substate Machine" figure in
>> PCIe spec. I am not sure if it is mentioned anywhere in
>> implementation notes or left for implementer to decide in PCIe spec.
> There's a note in PCIe r4.0, sec 1.2 that says
>
>   Initialization =E2=80=93 During hardware initialization, each PCI Expre=
ss
>   Link is set up following a negotiation of Lane widths and frequency
>   of operation by the two agents at each end of the Link. No firmware
>   or operating system software is involved.
>
> I interpret that as meaning the hardware at each end of the link
> should be able to initialize the link without any help from software.
>
> I think the hardware pretty much *has* to be able to do that.
> Consider the native PCIe hotplug case: the OS has the generic pciehp
> driver, but no knowledge of any device-specific behavior of the
> Downstream Port leading to a hot-added device.  I don't *think*
> there's anything in the spec about software having to be involved in
> initializing the link in that case (correct me if I'm wrong), so the
> link has to come up correctly without any OS or firmware intervention.
>
> I'd argue that the same applies to this Tegra root port situation.  If
> some issue requires a workaround to bring the link up, you do have the
> opportunity to apply the fixup at probe-time.  But if you ever hope to
> support hotplug for the root port, I think you'll have trouble because
> I don't think there's a hook that lets you apply this fixup at hot-add
> time.

When you said "link initialization should happen without SW/firmware

intervention", it is after LTSSM is started, right? This patch programs

the target link speed before LTSSM is started.

As mentioned above these cards works on x86 because PCIe IP tires

link up with only Gen1 advertisement after "link number" negotiation fails.

Where as Tegra PCIe IP doesn't try with only Gen1 advertisement. i.e

=C2=A01) After LTSSM is initiated by driver, Tegra advertises Gen1 & Gen2
speeds. Link number negotiation does not happen.
=C2=A0as end point does not lock down to the advertised link number from RP=
.
=C2=A02) LTSSM state moves to disabled.

LTSSM sequence with current patch,
=C2=A01) After LTSSM is initiated by driver, Tegra advertises Gen1 speeds.
 2) This time end point responds to the link number in the TS1 and link
comes up

Setting target speed Gen1 is OK because HW autonomous speed change support

is not available in Tegra. After link up driver retrains the link to Gen2 a=
fter setting

Target speed.


Tegra doesn't support hot-plug, so no need to worry about this scenario

in hot-plug case.

>
>> I will update this information in next version of this patch to
>> justify why this is required only for Tegra.
>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>> ---
>>>>  drivers/pci/controller/pci-tegra.c | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controll=
er/pci-tegra.c
>>>> index 7dc728cc5f51..7e24eac12668 100644
>>>> --- a/drivers/pci/controller/pci-tegra.c
>>>> +++ b/drivers/pci/controller/pci-tegra.c
>>>> @@ -670,6 +670,17 @@ static void tegra_pcie_apply_sw_fixup(struct tegr=
a_pcie_port *port)
>>>>  		value |=3D soc->update_fc_val;
>>>>  		writel(value, port->base + RP_VEND_XP);
>>>>  	}
>>>> +
>>>> +	/*
>>>> +	 * PCIe link doesn't come up with few legacy PCIe endpoints
>>>> +	 * if root port advertises both Gen-1 and Gen-2 speeds.
>>>> +	 * Hence, the strategy followed here is to initially advertise
>>>> +	 * only Gen-1 and after link is up, retrain link to Gen-2 speed
>>>> +	 */
>>>> +	value =3D readl(port->base + RP_LINK_CONTROL_STATUS_2);
>>>> +	value &=3D ~PCI_EXP_LNKSTA_CLS;
>>>> +	value |=3D PCI_EXP_LNKSTA_CLS_2_5GB;
>>>> +	writel(value, port->base + RP_LINK_CONTROL_STATUS_2);
>>>>  }
>>>> =20
>>>>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>>>> --=20
>>>> 2.17.1
>>>>
