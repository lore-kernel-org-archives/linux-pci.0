Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF83C43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 12:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7CA206BA
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 12:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="NjPK0FiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfCLMDc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:03:32 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:53066 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLMDb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 08:03:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 21F9441974;
        Tue, 12 Mar 2019 12:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:in-reply-to:mime-version:user-agent
        :date:date:message-id:from:from:references:subject:subject
        :received:received:received; s=mta-01; t=1552392202; x=
        1554206603; bh=gTa5CjNbblsSZIg64hWlZ2NjcF+c9xUqI1aGqmeuJVo=; b=N
        jPK0FiFq37CZAAPBCp1ZzyoqGca8txnP6I1ClFfxUgyQbOLITBlhYt1l/LELz8xO
        Os1vRfQI8fmayNHZ3YkazIwgObbjVD8J3R5bdPsiEz0qqATig6BfAvNKn1VS7TEl
        E9hEZTKaOjwPEbJ/4bZjI4I+vRCzr0aGFrIL2Zgz28=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oUXi_jKvuYHE; Tue, 12 Mar 2019 15:03:22 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 2727641953;
        Tue, 12 Mar 2019 15:03:22 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 12
 Mar 2019 15:03:21 +0300
Subject: Re: [PATCH] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
To:     Lukas Wunner <lukas@wunner.de>
CC:     <linux-pci@vger.kernel.org>, <linux@yadro.com>
References: <20190301161251.26774-1-s.miroshnichenko@yadro.com>
 <20190305110134.drw4hb7h2eruewkp@wunner.de>
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=s.miroshnichenko@yadro.com; prefer-encrypt=mutual; keydata=
 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
 lHi50np+KDDPzZS51tw=
Message-ID: <30e8d881-41ba-13ad-24a5-587d5eda959b@yadro.com>
Date:   Tue, 12 Mar 2019 15:03:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305110134.drw4hb7h2eruewkp@wunner.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="7yX9B05X21s1wHv9023fdicUEbxf5SsEu"
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--7yX9B05X21s1wHv9023fdicUEbxf5SsEu
Content-Type: multipart/mixed; boundary="yehosS5NaRqhvl9INlEthYKdohQ2wiiJY";
 protected-headers="v1"
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux@yadro.com
Message-ID: <30e8d881-41ba-13ad-24a5-587d5eda959b@yadro.com>
Subject: Re: [PATCH] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
References: <20190301161251.26774-1-s.miroshnichenko@yadro.com>
 <20190305110134.drw4hb7h2eruewkp@wunner.de>
In-Reply-To: <20190305110134.drw4hb7h2eruewkp@wunner.de>

--yehosS5NaRqhvl9INlEthYKdohQ2wiiJY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/5/19 2:01 PM, Lukas Wunner wrote:
> On Fri, Mar 01, 2019 at 07:12:51PM +0300, Sergey Miroshnichenko wrote:
>> During the safe removal procedure, a Data Link Layer State Changed eve=
nt
>> may occur after pciehp_power_off_slot(), and it is handled when the sl=
ot is
>> already set to OFF_STATE. This results in re-enabling the device and m=
akes
>> it impossible to actually safely remove it.
>>
>> Add a check for a Presence Detect Changed bit to filter out this inter=
rupt.
>>
>> It is still possible to re-enable the device if it remains in the slot=

>> after pressing the Attention Button by pressing it again.
>>
>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> Cc: Lukas Wunner <lukas@wunner.de>
>> ---
>>  drivers/pci/hotplug/pciehp_ctrl.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/p=
ciehp_ctrl.c
>> index 3f3df4c29f6e..941f77b71df4 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -251,6 +251,14 @@ void pciehp_handle_presence_or_link_change(struct=
 controller *ctrl, u32 events)
>>  		return;
>>  	}
>> =20
>> +	/* Handle the DLLSC from the slot which just has been turned off */
>> +	if ((events & PCI_EXP_SLTSTA_DLLSC) &&
>> +	    !(events & PCI_EXP_SLTSTA_PDC) &&
>> +	    present && !link_active) {
>> +		mutex_unlock(&ctrl->state_lock);
>> +		return;
>> +	}
>> +
>>  	switch (ctrl->state) {
>>  	case BLINKINGON_STATE:
>>  		cancel_delayed_work(&ctrl->button_work);
>=20
> Hm, I'd instead prefer amending remove_board() like this:
>=20
>  	if (POWER_CTRL(ctrl)) {
>  		pciehp_power_off_slot(ctrl);
> =20
>  		/*
>  		 * After turning power off, we must wait for at least 1 second
>  		 * before taking any action that relies on power having been
>  		 * removed from the slot/adapter.
>  		 */
>  		msleep(1000);
> =20
> +		/* ignore link or presence changes caused by power off */
> +		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
> +			   &ctrl->pending_events);
>  	}
>=20
> Would this work for you?

Thank you for the review and for the proposed change! This discards
exactly the event which caused the issue - I've just checked it on our
hardware, and will resend it as a v2.

Best regards,
Serge

>=20
> Thanks,
>=20
> Lukas
>=20


--yehosS5NaRqhvl9INlEthYKdohQ2wiiJY--

--7yX9B05X21s1wHv9023fdicUEbxf5SsEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHW7T7ovP/cFp8+b3DHQ+aNFTs7UFAlyHoAkACgkQDHQ+aNFT
s7Vg7A//cDUhaw788GZr2epprusMwgRzj9PjHt+gm7NDYQWK3WgSexHj9JGlVe2b
6yGdUmgGLA71XlQ7Iwd2lP9VfxCLVAo7dmDgW7IRKbuiOLIsfIFeuvPsCSbzVsBI
3ol/7hJjqdvmiR6qnGAGVs2nEADNsawSGz6r3R8PlzSIEoXnUtqh6lCY2r20h5a3
XbNd6HCHiTzMKZQZ1UDqgd5PgRcdDxxq8vQtBO8/mWWAa5ACgv0nsQkIXwzj02dM
w9v+V42HD/4ddCZeY6IzaMWl4xYhyK0hsuRgQH5T61KPzQ0nsSfG/vWUzKkkRLtd
7RwSy89GF9tsGT1V0mFaXlR5MtDX0vTivptOSifqwmQ6skF+Cy1wgIyLPmqtGFHe
Mz6JPoQOdg2sXvkHzVK1n8RN9H1P59AqGY/GC8fVuVX1BhxR0Yx3x2tjGo8sCa7B
qfkdOc+/VIyL0/tqN+Qif9kINJ6KE0HuyaBPs/BMO8B1RMs6eEU9z1mIt74FfVcX
y+k2Z2M+yDJyvnj389geBtb2FofpyiffZkjqQZL6o507rBkrHFiY1o7N+hLalEDg
aCnK8vJrdV30YC0Mi1ic9tz3fXBVMagRYuikDDfDMF9dolqRQfWNZamGyZ7wT5oj
8lyq8d2QID4HS5aqfYp2Yntkp9usS2NAsaD934sf/ow2o1wK2O8=
=bmEX
-----END PGP SIGNATURE-----

--7yX9B05X21s1wHv9023fdicUEbxf5SsEu--
