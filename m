Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBD3C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 15:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B5720854
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 15:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="VkWDbnTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCRPnD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:43:03 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:33444 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfCRPnC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 11:43:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 750A541207;
        Mon, 18 Mar 2019 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:in-reply-to:mime-version:user-agent
        :date:date:message-id:from:from:references:subject:subject
        :received:received:received; s=mta-01; t=1552923780; x=
        1554738181; bh=7T3Y3hysDyMaHpcyBA/Ohu4ntx4t7p/ubTN5Z17xhsk=; b=V
        kWDbnTbLnJ9H1TBxdhDYMD+NbHyMmuAfVMpwTKrXFzvKNNpxpTDzenY9qQaMEUZO
        FZIeCafNPYB4Zb249iQvk9T3YR3c8ApkPg8NAqGME53VMQsQY+MLm9SH7J9dim8A
        MGBqwtHqNwG+uRJyNU0ozCSadSUpJ3O4wEQbSaWuqI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AZCHq07_VSch; Mon, 18 Mar 2019 18:43:00 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0B9D741957;
        Mon, 18 Mar 2019 18:43:00 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 18
 Mar 2019 18:42:59 +0300
Subject: Re: [PATCH] PCI: pciehp: Don't wait for Command Completed if this
 interrupt is disabled
To:     Lukas Wunner <lukas@wunner.de>
CC:     <linux-pci@vger.kernel.org>, <linux@yadro.com>
References: <20190318143129.6640-1-s.miroshnichenko@yadro.com>
 <20190318151337.f53xmhb372bwbhbc@wunner.de>
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=s.miroshnichenko@yadro.com; prefer-encrypt=mutual; keydata=
 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
 lHi50np+KDDPzZS51tw=
Message-ID: <8fc134df-4344-af88-783d-bc58667b8fea@yadro.com>
Date:   Mon, 18 Mar 2019 18:42:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318151337.f53xmhb372bwbhbc@wunner.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="7BFphZbCoC3mN5ZBmfEvjVHlz76dy1fIc"
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--7BFphZbCoC3mN5ZBmfEvjVHlz76dy1fIc
Content-Type: multipart/mixed; boundary="W0RqenDHpylVWlG48awZqLcXGhDrIC5pX";
 protected-headers="v1"
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux@yadro.com
Message-ID: <8fc134df-4344-af88-783d-bc58667b8fea@yadro.com>
Subject: Re: [PATCH] PCI: pciehp: Don't wait for Command Completed if this
 interrupt is disabled
References: <20190318143129.6640-1-s.miroshnichenko@yadro.com>
 <20190318151337.f53xmhb372bwbhbc@wunner.de>
In-Reply-To: <20190318151337.f53xmhb372bwbhbc@wunner.de>

--W0RqenDHpylVWlG48awZqLcXGhDrIC5pX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Lukas,

On 3/18/19 6:13 PM, Lukas Wunner wrote:
> On Mon, Mar 18, 2019 at 05:31:29PM +0300, Sergey Miroshnichenko wrote:
>> pcie_init() invokes pcie_disable_notification() for empty slots, which=
 in
>> turn disables the Command Complete interrupt (unset PCI_EXP_SLTCTL_CCI=
E)
>> and right after that waits for Command Complete event (PCI_EXP_SLTSTA_=
CC).
>>
>> This results in longer boot time - 4 seconds of delay for each empty s=
lot:
>>
>> [    4.200325] pciehp 0042:04:08.0:pcie204: Slot #40 AttnBtn+ PwrCtrl+=
 MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
>> [    4.200607] pciehp 0042:04:08.0:pcie204: pciehp_get_power_status: S=
LOTCTRL 80 value read 1c0
>> [    6.217938] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command=
 0x01c0 (issued 2020 msec ago)
>> [    6.217966] pciehp 0042:04:08.0:pcie204: pcie_disable_notification:=
 SLOTCTRL 80 write cmd 0
>> [    6.237938] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command=
 0x01c0 (issued 2040 msec ago)
>> [    8.257939] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command=
 0x05c0 (issued 2020 msec ago)
>> [    8.257974] pciehp 0042:04:08.0:pcie204: pciehp_power_off_slot: SLO=
TCTRL 80 write cmd 400
>> [    8.258034] pci_bus 0042:07: dev 00, created physical slot 40
>> [    8.277941] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command=
 0x05c0 (issued 2040 msec ago)
>> [    8.277967] pciehp 0042:04:08.0:pcie204: pcie_enable_notification: =
SLOTCTRL 80 write cmd 1031
>=20
> Those "Timeout on hotplug command" messages look suspicious.  The port
> claims to support Command Completed Events, but doesn't seem to set the=

> Command Completed bit in the Slot Status register.  Ultimately that's
> the reason for the delays you're seeing.
>=20
> We already have quirks for various Intel and Qualcomm ports with broken=

> Command Completed support (see at the bottom of pciehp_hpc.c) and we
> know that older Thunderbolt chips erroneously claim to support Command
> Completed Events but in reality don't support it (see quirk in pcie_ini=
t()).
> Maybe the hardware you're dealing with needs such a quirk as well?
Thanks, I'll rework this as a quirk for PEX 8796. The "Command
Completed" seems to be half-broken there: the SLTSTA_CC bit is always
zero without SLTCTL_CCIE, but works just fine with SLTCTL_CCIE, so the
pciehp_isr() wakes up the pcie_wait_cmd().

Best regards,
Serge

>=20
> Thanks,
>=20
> Lukas
>=20
>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> Cc: Lukas Wunner <lukas@wunner.de>
>> ---
>>  drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pc=
iehp_hpc.c
>> index 6a2365cd794e..eec5d6107360 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -118,8 +118,10 @@ static void pcie_wait_cmd(struct controller *ctrl=
)
>>  	if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
>>  	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
>>  		rc =3D wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
>> -	else
>> +	else if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
>>  		rc =3D pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
>> +	else
>> +		return;
>> =20
>>  	if (!rc)
>>  		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec a=
go)\n",
>> --=20
>> 2.20.1
>>


--W0RqenDHpylVWlG48awZqLcXGhDrIC5pX--

--7BFphZbCoC3mN5ZBmfEvjVHlz76dy1fIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHW7T7ovP/cFp8+b3DHQ+aNFTs7UFAlyPvHwACgkQDHQ+aNFT
s7WaRg/+LF5HVzKKRGpcNug+NYYbCvJ6nKbHXfJPWxaorz8MEM3T6gI7v8TY7vVG
QJQIWYYv39MkqzQcp2lt41R5azxrF1TMCkPSkFH6kfY4jid4VSmHIvC4u1eqiv7S
6GhcpfNBTvy9SfEYlBWuQ6EWDiPMIRmMZ9F8mYeiRbU3rYOJAl8uZR9i+8yep0gU
txATgglfAaVtpdCGzjtO5iPU69yKxUf93CxOOjfP2D0517qT4DarfLTgv+RV8d7H
Fu0L6QyA5YtR7WUrLpGpSD6dXR4BwP6iENroH45W3VSIlNoC/RgXilCyA024NxQ8
litpU1TkyxTOJJF+iYE2RcDsco/eJT6OjUm6Ee+wknMLlkUiMDpXdyoTFEznn2EQ
yhmsyrf49WNypNOQLMDD+ZyIo9zINy7461+c46ETK/8Y6Lh97bQr6eNNQtRSjgVs
BabDvikXEVruNCWxB0vPDS8jk/MSHt4tvb6WMUIxWbO20miXR30V2Z3pSHvWGjkc
5NvVdZ2ZsJnVmM30uFyCWdxznlCpBbR2Ww+K212bsPU2Gyj58If1/IIzvBQM5kQ6
Ca2fd4FpZ+fY+3iU0hE2IyyJybv90PYiQT+2fik6RlzWfaVXnlFZtpfWO2GLL9x3
siriGD7cfAQl5sE4YdMjR64i1HtlczKsZpzTIAi7sF8EekmXm2k=
=z+Zy
-----END PGP SIGNATURE-----

--7BFphZbCoC3mN5ZBmfEvjVHlz76dy1fIc--
