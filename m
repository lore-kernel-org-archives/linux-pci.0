Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD323392E;
	Mon, 20 Jul 2026 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516307; cv=none; b=Cc/QW4r1VHrONCUoFixQhEx9YyR7GiqNAeAK+HMoxjzF4WMOXG3k6XXCxhGhSe8Hn2c4PjrJyMuA7DI0JBdu+ZgWXgqwOx01xk0/jKMq+fYLrbpgCWDLhmOcIWCB0aEqe2Grt5NhApILEnGQ80SadlNFgj6jaV79Z6Zr9l367fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516307; c=relaxed/simple;
	bh=HNmtvYBi4srl4mrmoo3jBrYIcly8lWi+rbu9dKGNNYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umARbse+8efE4pHic1C+R74ad5iGNzA5rRG4pC0v5kWxreN7wrbFaa6Zgi1pM+MW4VI/KfVAzn6HOO6qVMZAMv+0FXMdiNlS0hLAu4iQF3RmbXobtrhbo9oilOwY0RusYwG8ZAnw8W4uiRCBOOEK/P7/8W7klItrTmaWjgXa1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cFg8zuv9; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DEZa5n4a; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cFg8zuv9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DEZa5n4a"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4h3QFD1LjGzKnH8;
	Mon, 20 Jul 2026 04:58:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784516304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDbsBcpbGto2AtErEC/8BnnLavUYDVmkGajjKKEWV/E=;
	b=cFg8zuv91ZoAUKHA5GR6UA1HESm1QodZTMftcZwj0bjH9EEs5vTY8lDdmYan7Q+2QgmaQ8
	dcqlTzg4OFnmr5pRgGykjNcYnIgbSuKG9DLZOefqfEkUhb3EI/ClNrDsJc3CcTSI2btA6a
	mvq76w9SSX6iE0vmW1LQjliPAsH334c4Gx1iJ5bUhTZUy2oyikxfEW722B1jMjhbpAMseF
	bvUxrdkD2CQX2RDTcmQt2JSC6mE/AhsDL8by1XuokE5gqhjUFq1Sb1LeFeDX+U5pwk11ao
	KXwjjMohw2y8XZUyD4tOxIlApSNQ8S4FMob6h2mwOa/OC0newhv/V6aa647Maw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=DEZa5n4a;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <b30cbfc4-9135-4acb-8117-aa9129c46824@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784516302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDbsBcpbGto2AtErEC/8BnnLavUYDVmkGajjKKEWV/E=;
	b=DEZa5n4atFvvKme6YT1wtS0arDM+srZxLyfp1zCUtMDSooPS6A8DLVconMO/Yli8SIAkgr
	9k4091ouy6TT/bt6gecEauvTj3ygWbbUIpvNszxBQ8YUeAtpi2byFRpbWNPkGU3+ZxhLaP
	w9nJJhIz9n9Ue78PNP4IvIRA7JQ0L+ebASxErbtJqmi69k7zYTaWHkEhKXIx7brC+S5OnZ
	1nSyaGrK6Ot3ov8CgvbsxGAshqGMx+gprCy17nwp0/yn7w+1JJ6Xhg08bJ54gbZwCnWt1e
	Qsd8E24n3HrKwG+lFmOk5tNYaVgQ4bfPGa0oN4qEnixcWnK1oXO6nVvdsijQlQ==
Date: Mon, 20 Jul 2026 03:15:17 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] PCI: dwc: rcar-gen4: Handle PERST via reset subsystem
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260704202748.355708-1-marek.vasut+renesas@mailbox.org>
 <20260704202748.355708-5-marek.vasut+renesas@mailbox.org>
 <CAMuHMdUVqw-gqydVg5N7WiMj04rVAPuLjJjzgrk+eEgJpbzS2g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdUVqw-gqydVg5N7WiMj04rVAPuLjJjzgrk+eEgJpbzS2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 37ebed7c6518d2cbf4b
X-MBO-RS-META: 56ogwceop4q9hwmkhyaew45xge5ygajm
X-Rspamd-Queue-Id: 4h3QFD1LjGzKnH8

On 7/14/26 5:07 PM, Geert Uytterhoeven wrote:

Hello Geert,

>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> 
>> @@ -299,10 +300,27 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
>>
>>   static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>>   {
>> +       struct device *dev = rcar->dw.dev;
>> +       struct reset_control *perst;
>> +
>>          rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
>>          if (IS_ERR(rcar->phy_base))
>>                  return PTR_ERR(rcar->phy_base);
>>
>> +       rcar->perst = NULL;
>> +       for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>> +               perst = of_reset_control_get(of_port, "perst");
>> +               if (IS_ERR(perst)) {
>> +                       if (PTR_ERR(perst) != -EPROBE_DEFER)
>> +                               dev_err(dev, "Failed to get PERST#\n");
>> +                       return PTR_ERR(perst);
> 
> return dev_err_probe(...)?
> 
> This error condition is triggered on Sparrow Hawk and White Hawk,
> as their DTS does not have perst:
> 
>      pcie-rcar-gen4 e65d0000.pcie: Failed to get PERST#
>      pcie-rcar-gen4 e65d0000.pcie: probe with driver pcie-rcar-gen4
> failed with error -2
I switched to of_reset_control_get_optional_exclusive() and cleaned the 
reset handling further in V2.
