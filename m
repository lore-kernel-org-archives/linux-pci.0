Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3506BC43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 03:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E471720851
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 03:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NBFRMYlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E471720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeK1OBX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:01:23 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9284 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeK1OBX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 09:01:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bfe05040000>; Tue, 27 Nov 2018 19:01:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Nov 2018 19:01:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Nov 2018 19:01:22 -0800
Received: from [10.24.37.36] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 28 Nov
 2018 03:01:20 +0000
Subject: Re: [PATCH V2] PCI: dwc: Don't hard-code DBI/ATU offset
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>
References: <20181120175750.26141-1-swarren@wwwdotorg.org>
 <acc9aca4-2f1a-70cf-72f4-9f631951a75c@nvidia.com>
 <1f407736-7cfd-0aa7-202f-ab70314be422@wwwdotorg.org>
 <fc21e093-6b9b-4a4f-fb28-a83ed932828a@nvidia.com>
 <e7150ec7-b767-99ee-35aa-03e7d73657cb@wwwdotorg.org>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <5bb5a545-1fbb-d749-921e-4091b88a97f1@nvidia.com>
Date:   Wed, 28 Nov 2018 08:31:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e7150ec7-b767-99ee-35aa-03e7d73657cb@wwwdotorg.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543374084; bh=0rJDT7EZ0Z3x1L41L7qSYY6kNy5h2x5eGCXnk10Ey6Y=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=NBFRMYlHFIr/CcsQkQlXPYm9AKfgrZiPERX7EsyLJakmkeLzvDemGrtl4r4Bt/11p
         ss8XxmwjEJ5IyA687b8izALhNn6VOg1sOC3GrfPw2HDoND6nyi8Qmq/KI3DX8DcZOc
         lyqeWSGSH5+tJcAA7WDBTELgCxzOxilzk5V7Y93xRdYOMVVVnHcxoiMpmyWWrAYsIp
         lfHov4KO8gl19WoRPwD37C7w3gYEAz0gldIdzz0PS6D+aohylULZ+a7Kx2v1zzLgdy
         CPKpTOlK+8gAsJHRkbeJrquLV+cpz41MbBHqI+NJFJ8UoOAmTD/Nzy2Qp+b0vVeO7i
         KIXdNApQzhVlQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 27/11/18 11:41 PM, Stephen Warren wrote:
> On 11/26/18 8:52 PM, Vidya Sagar wrote:
>>
>> On 11/26/2018 10:24 PM, Stephen Warren wrote:
>>> On 11/25/18 10:51 PM, Vidya Sagar wrote:
>>>>
>>>> On 11/20/2018 11:27 PM, Stephen Warren wrote:
>>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>>
>>>>> The DWC PCIe core contains various separate register spaces: DBI,=20
>>>>> DBI2,
>>>>> ATU, DMA, etc. The relationship between the addresses of these=20
>>>>> register
>>>>> spaces is entirely determined by the implementation of the IP=20
>>>>> block, not
>>>>> by the IP block design itself. Hence, the DWC driver must not make
>>>>> assumptions that one register space can be accessed at a fixed=20
>>>>> offset from
>>>>> any other register space. To avoid such assumptions, introduce an
>>>>> explicit/separate register pointer for the ATU register space. In
>>>>> particular, the current assumption is not valid for NVIDIA's T194=20
>>>>> SoC.
>>>>>
>>>>> The ATU register space is only used on systems that require=20
>>>>> unrolled ATU
>>>>> access. This property is detected at run-time for host=20
>>>>> controllers, and
>>>>> when this is detected, this patch provides a default value for=20
>>>>> atu_base
>>>>> that matches the previous assumption re: register layout. An=20
>>>>> alternative
>>>>> would be to update all drivers for HW that requires unrolled=20
>>>>> access to
>>>>> explicitly set atu_base. However, it's hard to tell which drivers=20
>>>>> would
>>>>> require atu_base to be set. The unrolled property is not detected for
>>>>> endpoint systems, and so any endpoint driver that requires=20
>>>>> unrolled access
>>>>> must explicitly set the iatu_unroll_enabled flag (none do at=20
>>>>> present), and
>>>>> so a check is added to require the driver to also set atu_base=20
>>>>> while at
>>>>> it.
>>>>>
>>>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>>>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>>>> ---
>>>>> v2:
>>>>> * Modified patch subject
>>>>> * Added missing outer brackets to PCIE_GET_ATU_INB_UNR_REG_OFFSET=20
>>>>> macro
>>>>> ---
>>>>> =C2=A0 .../pci/controller/dwc/pcie-designware-ep.c=C2=A0=C2=A0 |=C2=
=A0 4 ++++
>>>>> =C2=A0 .../pci/controller/dwc/pcie-designware-host.c |=C2=A0 3 +++
>>>>> =C2=A0 drivers/pci/controller/dwc/pcie-designware.c=C2=A0 |=C2=A0 8 +=
+++----
>>>>> =C2=A0 drivers/pci/controller/dwc/pcie-designware.h=C2=A0 | 20=20
>>>>> +++++++++++++++----
>>>>> =C2=A0 4 files changed, 27 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c=20
>>>>> b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>> index 1e7b02221eac..880210366e71 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>> @@ -504,6 +504,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "=
dbi_base/dbi_base2 is not populated\n");
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL=
;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 if (pci->iatu_unroll_enabled && !pci->atu_base) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "atu_base is=
 not populated\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D of_property_read_u32(np, "num-=
ib-windows",=20
>>>>> &ep->num_ib_windows);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c=20
>>>>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> index 29a05759a294..2ebb7f4768cf 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> @@ -699,6 +699,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(pci->d=
ev, "iATU unroll: %s\n",
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 pci->iatu_unroll_enabled ? "enabled" : "disabled");
>>>>
>>>> I see that dw_pcie_setup_rc() API has code where=20
>>>> pci->iatu_unroll_enabled gets set based on reading a viewport=20
>>>> register.
>>>>
>>>> IMO, we need a check like following to avoid=20
>>>> pci->iatu_unroll_enabled getting modified (if already set)
>>>>
>>>> if (!pci->iatu_unroll_enabled)
>>>> =C2=A0=C2=A0=C2=A0 =C2=A0pci->iatu_unroll_enabled =3D dw_pcie_iatu_unr=
oll_enabled(pci);
>>>
>>> That's only true if you believe that dw_pcie_iatu_unroll_enabled()=20
>>> will give the wrong answer in some circumstances. It's working OK=20
>>> right now, so I'm not sure why that function would start having=20
>>> problems?
> >
>> Since dw_pcie_iatu_unroll_enabled() is reading PCIE_ATU_VIEWPORT=20
>> register and in case of Nvidia's DWC based PCIe implementation, this=20
>> register is not listed. In case, if it is returning '0', then,=20
>> pci->iatu_unroll_enabled which was set by implementation specific=20
>> driver gets overwritten with this value. Though it is working fine=20
>> now, I'm not sure if we can take this for granted that it would=20
>> always work.
>
> For current hardware, I think we can assume this works, because it=20
> does now. The HW behaviour isn't going to suddenly change for a=20
> specific chip that's already designed. The behaviour seems to be a=20
> property of the core DWC HW since the driver already relies on it for=20
> multiple different vendor uses of the core DWC HW. If for some reason=20
> it turns out that this doesn't work for a future HW design, we can=20
> always fix it up then.
>
> I don't think this patch affects this issue at all though. If you want=20
> to modify the DWC core and all DWC HW-specific drivers so that the=20
> HW-specific drivers always set iatu_unroll_enabled when required,=20
> rather than auto-detecting the value, that seems fine, but I think you=20
> should send a separate patch for that.

Fine. I'm convinced with the explanation.

Acked-by: Vidya Sagar <vidyas@nvidia.com>

