Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB5AC43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE6D2087C
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 13:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="WzGQy4wL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfCMNmP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:42:15 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:33654 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfCMNmP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Mar 2019 09:42:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 48E844195A;
        Wed, 13 Mar 2019 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:in-reply-to:mime-version:user-agent
        :date:date:message-id:from:from:references:subject:subject
        :received:received:received; s=mta-01; t=1552484531; x=
        1554298932; bh=sjTNNaf/vp3xHc3dvuu360rB525p64aGrshNr6woQHg=; b=W
        zGQy4wLDVWdAPbtHtGnFJjeXZ4DUP6Z3ACuzB5PDE2NCvpa8RoaLWXCGpv4oa06f
        0GfPU6tQfrwb+C8d3y0+Q8bRqic4Ac3uqL7ZY84HHEnM7xm+JC/D/eKihT36ODCI
        b4bXkx6oZfWUa4lFGAGZLIME5nW6vAPFagK+49hQ10=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nVKaxuf7uv_p; Wed, 13 Mar 2019 16:42:11 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 09CC84193E;
        Wed, 13 Mar 2019 16:42:11 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 13
 Mar 2019 16:42:10 +0300
Subject: Re: [PATCH v2] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
To:     Lukas Wunner <lukas@wunner.de>
CC:     <linux-pci@vger.kernel.org>, <linux@yadro.com>
References: <20190312120548.31875-1-s.miroshnichenko@yadro.com>
 <20190312122014.jrwgnqpuiywb7xsd@wunner.de>
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=s.miroshnichenko@yadro.com; prefer-encrypt=mutual; keydata=
 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
 lHi50np+KDDPzZS51tw=
Message-ID: <b1a7f0b6-2bbf-213d-0f56-bc828922dfed@yadro.com>
Date:   Wed, 13 Mar 2019 16:42:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312122014.jrwgnqpuiywb7xsd@wunner.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="FV7Ka7dkzCqStZBu4FGhdIgkPitgCsBy8"
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--FV7Ka7dkzCqStZBu4FGhdIgkPitgCsBy8
Content-Type: multipart/mixed; boundary="jqBJB6wauX2c9SkaaL1a4133auEuX42nO";
 protected-headers="v1"
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux@yadro.com
Message-ID: <b1a7f0b6-2bbf-213d-0f56-bc828922dfed@yadro.com>
Subject: Re: [PATCH v2] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
References: <20190312120548.31875-1-s.miroshnichenko@yadro.com>
 <20190312122014.jrwgnqpuiywb7xsd@wunner.de>
In-Reply-To: <20190312122014.jrwgnqpuiywb7xsd@wunner.de>

--jqBJB6wauX2c9SkaaL1a4133auEuX42nO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/12/19 3:20 PM, Lukas Wunner wrote:
> On Tue, Mar 12, 2019 at 03:05:48PM +0300, Sergey Miroshnichenko wrote:
>> During the safe removal procedure, a Data Link Layer State Changed eve=
nt
>> may occur after pciehp_power_off_slot(), and it is handled when the sl=
ot is
>> already set to OFF_STATE. This results in re-enabling the device and m=
akes
>> it impossible to actually safely remove it.
>>
>> Clear out the Presence Detect Changed and Data Link Layer State Change=
d
>> events when the disabled slot has settled down.
>>
>> It is still possible to re-enable the device if it remains in the slot=

>> after pressing the Attention Button by pressing it again.
>>
>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>=20
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>=20

Thank you!

> Did this work correctly before v4.19 or is it a regression caused by
> d331710ea78f ("PCI: pciehp: Become resilient to missed events")?
> Either way, it seems reasonable to backport it to stable and
> v4.19 is the earliest that it should apply cleanly to, so:
>=20
> Cc: stable@vger.kernel.org # v4.19+
>=20

Yes, that was a regression caused by this commit. I've verified it
applies cleanly to v4.19.

Best regards,
Serge

> Thanks a lot for catching this, I wasn't able to test the code paths
> which are only exercised if a power controller is present (because
> Thunderbolt doesn't have one).
>=20
> Lukas
>=20
>> ---
>>  drivers/pci/hotplug/pciehp_ctrl.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/p=
ciehp_ctrl.c
>> index 3f3df4c29f6e..905282a8ddaa 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -115,6 +115,10 @@ static void remove_board(struct controller *ctrl,=
 bool safe_removal)
>>  		 * removed from the slot/adapter.
>>  		 */
>>  		msleep(1000);
>> +
>> +		/* Ignore link or presence changes caused by power off */
>> +		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
>> +			   &ctrl->pending_events);
>>  	}
>> =20
>>  	/* turn off Green LED */
>> --=20
>> 2.20.1


--jqBJB6wauX2c9SkaaL1a4133auEuX42nO--

--FV7Ka7dkzCqStZBu4FGhdIgkPitgCsBy8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHW7T7ovP/cFp8+b3DHQ+aNFTs7UFAlyJCKgACgkQDHQ+aNFT
s7ULWw/+MLu92csOJkHBbhXkl6+01hRxCiaP4KMRXnjOA8TWLFdHTG5jXhqwlCDM
J7QRJZLyGsH1RSUvarDt9hCrePPl8Kaml0XuKkHRFr+m5gqCD3sTgrZhbnw3v5VB
KjCi0XGANckiFAmDF25hj0wJtB9FggSnf/TP+9fiZkNZEeqXr15Wr3gVGWfdNMl1
wU9ew4W/dwR7bhPLX8n4iOWPQ5CSO9F6vW85CeagVHTR6glmAYyJ/TP+6Nz5+Ecf
66KLyHsWOzz72GPJQIzqmPjpZHwt7UStO2TOT++5m+vPAx+f7UojGbIVfEiOYqed
T/iszQ4wlUc24qteq06QuMpwVXQcbGKXInsAZd7L0FJxqhF0x3XqgJEDoth8ip5I
NbRMYoW6JwI/QA+63ElNc4IOrAy4AnFpeBIfq/m8Tt+XQt8R+kAd1Pdj9gOUmOKq
uaQZn2fztpQaClxb+AD/lR10AYOorx+buC63XVlG1OqdjvDLn+DV/QvaV0ItlgZW
I7O4h8yj6VQEH79W9Vf0fLjxRqr551+aVZVChvi3xy/ujQmGr9KeZpx9UaC8eGbl
iIGOQLCCXzGXj9gKsC+mjf+jpIgjokMTtHL7B9N8hbR+e2YaqAYWYT9h+QG6wgB8
Y0UHCMfJFfrz1nVOKuQTw+c1v648n0oFNpa0cIQYnQigEIYSIcc=
=U22/
-----END PGP SIGNATURE-----

--FV7Ka7dkzCqStZBu4FGhdIgkPitgCsBy8--
