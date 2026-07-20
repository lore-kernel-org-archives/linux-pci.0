Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251932D0CC;
	Mon, 20 Jul 2026 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516310; cv=none; b=QeVb/ugd2XdPnw2pRlpwuETw0kC2mavl/cauCGw/o8BSYS4iR0SbG3Zqnj5ZFIF8XuJVZMRymDVWa+doI6jd6bDacCz1thytp7BBxTyo23GxQLo1mh8iKgtQomXC1DhGNkkg3n/hKEUqjdcWUQ6a48kiHntnY5IvLJ3M/RhZy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516310; c=relaxed/simple;
	bh=pGR4Y0znxna6ckgge8OJMKIcr1zR4rTPnOZEm1d80m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7xD0+zGpWDEcpwPZ6MtuyKeREXJY3iq7+TP9wB6ecMsi5V5B+nKjjip/xry+aC8lmANu4Me2ECOE8Y7P/oi5UjqDcejgx73YvT8khp4mXqWKHfA5tBmiEAbh7oMFu2N8k+8U0WMmwNJ38MWSILkW46xWCnXS7fqMtp39uiyi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PERaEy6r; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gAXFVmbD; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PERaEy6r";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gAXFVmbD"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h3QFG2yDKzMlFV;
	Mon, 20 Jul 2026 04:58:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784516306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwNJNPA0E6F9vF9igw8fxYfMSEab+/Oh8iY33ima5rU=;
	b=PERaEy6r6MoVeZsFMpuaCD5BgJ3C03OCQhH934KT5N0XTEvEgfXqrT3x5PR3iVtgbP0Y8n
	3AnJ72yxB0ChEwNrpM5boxR+2bvpFFrWv10lLXv3UL75H/IHVZIntjSpqBPG/9H6XyliXC
	z/bHEo/gg8S6cCkxPY0UkPQWzYvELkwhZoGkb6owkQWdRrli/441eZHzj4FG7TvFlGwC0c
	H8BzvxmWuDHKUMAKPsl0WHNAsQtNwiPU5pIIaMxx/2khwIbS2Zu1ioV15qT1ggPqLom63H
	2qOAeYTzoJwDDRAyCtcDV0l9//vHus0zM7Iu5eItvzkfsMxIO6PRq2Sav+vDxQ==
Message-ID: <e4958347-bff8-409a-82be-83018a71de6c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784516305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwNJNPA0E6F9vF9igw8fxYfMSEab+/Oh8iY33ima5rU=;
	b=gAXFVmbDvFAxqbOftkiKvcoozfRdIwaDBXosEm5cAjVUAw6v/giG8zdMUHIE/PxJAE72Xr
	KnbWTZTO1rV9v9t4ARvbuIGnnMCaNw1+k3uSWUeWuOQWxxNVwT2HbP8epsN0ElxEfvySno
	qC8kqvDzDHK8lM5i6r9su4f3PVAuHLakBwUjv5Vw+cR7HFxJ0XQpmaFKpArBnh4iIDuIAX
	69rWLtoWDm0S6dRTuLip4JKsnR0aCEhZ4jk9XV7toxZtCO/HNZiVcgLfYCBxS5c80xjJ6A
	C0qUqqAvMhlmmrZtrSX2J7uRWeXDREk27OOBkEgecbfhV+b6rO7PvTipcvhAlg==
Date: Mon, 20 Jul 2026 03:16:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] PCI: dwc: rcar-gen4: Handle PERST via reset subsystem
To: Manivannan Sadhasivam <mani@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260704202748.355708-1-marek.vasut+renesas@mailbox.org>
 <20260704202748.355708-5-marek.vasut+renesas@mailbox.org>
 <ceimnmpsyfmrkuvrrsgkjg3fk2yf7fj7z5ie3cj6vfyighatag@hyb3vr2nclpm>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ceimnmpsyfmrkuvrrsgkjg3fk2yf7fj7z5ie3cj6vfyighatag@hyb3vr2nclpm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 64e7dc89a0a513721ba
X-MBO-RS-META: f9z1h7arxay3bhhsqtiq7iqu4wz8ch9e

On 7/15/26 4:36 PM, Manivannan Sadhasivam wrote:

Hello Manivannan,

[...]

>> @@ -671,6 +705,8 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
>>   
>>   	rcar_gen4_remove_dw_pcie(rcar);
>>   	rcar_gen4_pcie_unprepare(rcar);
>> +	if (rcar->perst)
>> +		reset_control_put(rcar->perst);
> 
> I don't see reset_control_put() in any error paths of probe().
I will address all the items in V2, thanks !
