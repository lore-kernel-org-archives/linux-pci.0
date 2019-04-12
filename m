Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC23C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 06:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B686E2186A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 06:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QxZGNwQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDLGon (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:44:43 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16081 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDLGom (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 02:44:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb033d60000>; Thu, 11 Apr 2019 23:44:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 23:44:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 23:44:40 -0700
Received: from [10.24.70.250] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Apr
 2019 06:44:35 +0000
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
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <5bf9c119-5f1e-5f41-7c41-b4182cbba3c9@nvidia.com>
Date:   Fri, 12 Apr 2019 12:14:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411200437.GR256045@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555051478; bh=EX9d+T8+gSIqkgbPK3sqJAwHlTB8tqGkZvbl4nqrMXI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=QxZGNwQEfqNItGtxet5WIlYEkief6PlIimhYZai7LxITdZiJ2j8b8uHi2+uQGK3oH
         /sTWAMuHEh3+ZOhDPiM6hod84GFNmLgNLQn+w2OoEpHBo3mIcEJKTiYw67D2BENamf
         rkJPl1oyj3x4wFUufG7Se6agEPWtVA75Mj+RVMbEfMJzYA7geWD5RkxME+MV7ab/n+
         IueE4O+jotSXji6pss8uhxAJhVHoGW95+mW79l8mJ/fHS02ipF8vdH9dr1wXlXS4Q7
         nbUUKKX8USBgIyeDTKXAgB9QRo6kPHeu2Tnvg+LD6Y8EteV4/xmnjKbyxmL+sV44pW
         2T3IRz9vSqnNg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12-Apr-19 1:34 AM, Bjorn Helgaas wrote:
> On Thu, Apr 11, 2019 at 10:33:39PM +0530, Manikanta Maddireddy wrote:
>> Some of the legacy PCIe endpoints doesn't enumerate if root port adverti=
ses
>> both Gen-1 and Gen-2 speeds. Hence, the strategy followed here is to
>> initially advertise only Gen-1 and after link is up, retrain link to Gen=
-2
>> speed.
>>
>> Following two cards display this behaviour,
>>   - Fusion HDTV 5 Express card
>>   - IOGear SIL - PCIE - SATA card
> This sounds like a Tegra erratum.  If you think this is an issue with
> the endpoints above, not with Tegra, we should see issues with these
> cards in non-Tegra systems.
>
> If that's the case, we might need a more far-reaching solution that
> would fix issues with these cards in all systems.
>
> If it really is a Tegra erratum, that's fine; just own up to it in the
> commit log and comment so it's not misleading.

Based on PCIe LA traces with x86 platform:
=C2=A01) x86 initially advertises Gen1, Gen2 & Gen3 speeds. Link number neg=
otiation does not happen
=C2=A0as end point does not lock down to the advertised link number from RP=
.
=C2=A02) There are multiple entries to detect<->compliance from the both th=
e sides.
=C2=A03) After some time (or some counts of detect entry), x86 only adverti=
ses Gen1 speed in TS1
=C2=A04) This time end point responds to the link number in the TS1 and lin=
k comes up

Tegra PCIe IP fails after step-2, it doesn't retry with only Gen1. This is =
the reason for

setting link speed to Gen1 and then start LTSSM.

I don't see anything mentioned about advertising lower link speed and retry=
ing

link up in "Configuration Substate Machine" figure in PCIe spec. I am not s=
ure

if it is mentioned anywhere in implementation notes or left for implementer=
 to

decide in PCIe spec.

I will update this information in next version of this patch to justify why=
 this is required

only for Tegra.

>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller=
/pci-tegra.c
>> index 7dc728cc5f51..7e24eac12668 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -670,6 +670,17 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_=
pcie_port *port)
>>  		value |=3D soc->update_fc_val;
>>  		writel(value, port->base + RP_VEND_XP);
>>  	}
>> +
>> +	/*
>> +	 * PCIe link doesn't come up with few legacy PCIe endpoints
>> +	 * if root port advertises both Gen-1 and Gen-2 speeds.
>> +	 * Hence, the strategy followed here is to initially advertise
>> +	 * only Gen-1 and after link is up, retrain link to Gen-2 speed
>> +	 */
>> +	value =3D readl(port->base + RP_LINK_CONTROL_STATUS_2);
>> +	value &=3D ~PCI_EXP_LNKSTA_CLS;
>> +	value |=3D PCI_EXP_LNKSTA_CLS_2_5GB;
>> +	writel(value, port->base + RP_LINK_CONTROL_STATUS_2);
>>  }
>> =20
>>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>> --=20
>> 2.17.1
>>
