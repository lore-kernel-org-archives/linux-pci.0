Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793768987;
	b=oVt+UpHyi/GJqQ6oZJiskVk+dwh7XGsweOOn6g7hx/NTOUN8yqXbna57JBgIg5hl1oqE
	 SzAm1mh9DMjW9SlwTSs1JVQCa1yQ3cpZLbBm8H/bYIHlgd2ii1++F+shZKChi2v+Ey/Wv
	 JsfgdKNM5UEHQng9yyRq3K2rSsnQxF3cz6ntYE2mlA4dJF5fTiIlIeCEQ0nF7u1TJ4r+n
	 eSM1ToIP+VlXhasekEj58SWK3SGBZSekWjMMMxiMCaHK+jjA9KUZ/GRozXd8PER9BjJDl
	 RxAOBOVPbaiARHxJtyXFiAjzKl129mnJHxDHHGFV8dCazee4G6MTagtSxd+QeLe6ktQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768987;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=n6w25QXldxKqXI+FaY0Sg1PYQRh/ifXRDwx1Ijoxuzs=;
	b=GW0xjH67eGEd9CA+dBGT7rxyGVhViQnaqhgaMFSUVCadkcdkjMYO1AJ44FtxMtg6iWCS
	 WLbraxgjPKzB/ucM0UtEqjBgfow5ok4hWIxEk5atTOzGtLPlyoX2bv4DPQ4grfNkwFyD3
	 KetrIqLPpoFyyP61EoRWTQ5eyIaLOsiZhv5Nnr6sEPvmCnZAq5x+0HxBhRb/Gp/YspZPf
	 sVkQ2r1LtIoISnM6yk73q8F6u7q93ZY1HmOGDIVw6wzoLKxYtULUILEvZ8K4m4czowfwq
	 3OFyM5dD/Zw7Ar7CBpPjRvONEMMTEc8FO/koiLkEf1se2FUr7ZVqOsBgtXLwKJOi6Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=u7SuaNAv;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B81606A31B;
	Wed,  4 Nov 2026 05:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88B81606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=u7SuaNAv
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jKD5L4Ss5zMldY;
	Wed, 04 Nov 2026 06:09:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793768982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6w25QXldxKqXI+FaY0Sg1PYQRh/ifXRDwx1Ijoxuzs=;
	b=u7SuaNAvEoxamRy0OPW0VXMHT5yGBo6aTcsa55LdlK5lg4AxkP+mEvFluq0TtNwKCVl6Fv
	OOiH/OfKI0OzjGs1Iji5nM3jRgfleV9ZR1hR47WXY1gyfT/kPU9m6Z1kYdTOqYWjHEgjGK
	lX3a8ZfbN5CYoGYNMssQiamXZ60srTXlE5kyrnEHCeGXWb8tVBSwGL3lgf6u9p+6GMLdA+
	pbYNJXfq3S7tntUAnHFbZfEwyDAwsk3EQfWNLuC8yw0RYqqkNrxspqUgFS3i43Ke6AoTwm
	txKfMRiFM0lcD3TOkI5gZ8C8heayyInQVdeQqnDXgq8AOFLzKPsIvTOR4h4S8Q==
Message-ID: <0128eea9-c193-4c09-8271-32307c464016@mailbox.org>
Date: Wed, 4 Nov 2026 05:58:52 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: rcar-gen4: Isolate 256B MRRS limit only to R-Car
 Gen4 SoC PCIe controller
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20261028172208.20948-1-marek.vasut+renesas@mailbox.org>
 <179334040211.5551.2573230628622674128.b4-reply@b4>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <179334040211.5551.2573230628622674128.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: u4w955mh74kurmw4oy7yn3ho3zsuxdf3
X-MBO-RS-ID: f0973c2289f1e65d280

On 10/30/26 7:06 AM, Manivannan Sadhasivam wrote:

Hello Manivannan,

>> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> index 9a64a9f4ab0d1..1e4405181eef3 100644
>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> @@ -99,6 +99,7 @@ struct rcar_gen4_pcie_drvdata {
>>   	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
>>   	int (*speed_control)(struct rcar_gen4_pcie *rcar);
>>   	enum dw_pcie_device_mode mode;
>> +	bool mrrs_256b_limit;
>>   };
>>   
>>   struct rcar_gen4_pcie {
>> @@ -663,7 +664,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (pp->bridge)
>> +	if (rcar->drvdata->mrrs_256b_limit && pp->bridge)
>>   		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
> 
> I'd suggest moving this check inside enable_device() callback to make it clear
> where exactly the skipping happens.

If we do that, we would end up with assigning a callback which always 
does nothing on R-Car Gen5 (SoC with rcar->drvdata->mrrs_256b_limit = 
false), that is not good. I think it is better to simply not assign the 
callback on R-Car Gen5 at all. Hence this here.

-- 
Best regards,
Marek Vasut
