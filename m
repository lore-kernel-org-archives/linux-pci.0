Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F862DC767;
	Mon, 20 Jul 2026 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516306; cv=none; b=oXbeqzl8DFFD7p6LmC+z9smZIO00cmN9qfvLM1WHztOgKe9FvYyNgqxJ+vuENuaD7VvvVzYAYe9bNPx3h1X2IZ0S729HaVxX+b4q585he/hQXD50+tfV8AdoGdMcRx3vrQp9T/U3PeTq/EwnJ+DBko97hEr5qy6tib5sds2xgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516306; c=relaxed/simple;
	bh=TXXqHWUfZA+sMzPNKtylb5/GqOMLwnwlGU27Wft+SOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7XLprE2oI/oiGzgwD2IoRFH0K+JhqwAwZEvqihBZk+l5NuzhKV4GWEuZDx+8kT+UF3aw49vfIq5UGO3yo6aU3S1b70Bn4afUhEf22Fq5xL8/ujQE6IAMFZHqpPBvmyWnyFSWwThoAipa4l4G6IA8vGXuSKjqNQen1irLphfjeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NmKjILf+; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nwSHDsdW; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NmKjILf+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nwSHDsdW"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4h3QF955ZmzKn52;
	Mon, 20 Jul 2026 04:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784516301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKbUzqVmcsR0KY6sH7Z4b0Mw+o24+gimgDJSKmCYDYU=;
	b=NmKjILf+Wp0ozvEkyBj+UrD6E6WC3cMHYpkR6EyTvKhJXzjFUgMcxjqqi0WkvrTgBpVeTH
	uRdbcMDkXlheSuIak3DR7mdz9Jf4DSg9q+wmd6xewuQ3TFLTc6tFUBm6fZ4fGl1NAZMo2m
	gv5dHmzlY2aCGf0251u0Y0zsjMpn70+3MGLV2HhSMiMvPUxz3pUbRNkY+fkVlgHDl1yS2L
	7k1XDaF4iC8XhGu6VHCD3I7JDBvXYx7jEYdVlGyBWeYP9c8LpQclc1kKrGhWcbxg1thErg
	2KHGRu2x9huNQB6B29XGzgj0ewJ7mOUTT/E6GvIc2rSSj/S6wmMNiAWiGOKq6A==
Message-ID: <0f403229-b244-415e-ae88-c149b89c51d5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784516300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKbUzqVmcsR0KY6sH7Z4b0Mw+o24+gimgDJSKmCYDYU=;
	b=nwSHDsdWmh4Zw0ijhnYEgsNHfJi/HYYyigEGJrQ23K7IatysM0KP3VVXK7abTdHvXaiXAH
	a5PGEWqLILT/BmE3aIvc1RzJwgSqaGw+Qvpx+5APtyqaHy8+bIc/wUIg7y98hlvywgaqaF
	rVA1rP9FJkhtewZebt2TSGAprVMe7f0w80npKkSLUlqyB8fBqHi9TWne6XyfDtCM9NHEOy
	Dz6AguGr7q7WLF9PylDKrnEy5riE8aPf8lqBFBYTcsCY5xZLJudNSBrz/mTPK//DEcLnAt
	PPXkVtsKai81ylvn+ApKmhpwOwX+f2Dj14/5b2kTyCD5wIHRzWdbYFIck8u5qA==
Date: Mon, 20 Jul 2026 03:14:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] PCI: dwc: rcar-gen4: Return error code from
 .additional_common_init
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
 <20260704202748.355708-3-marek.vasut+renesas@mailbox.org>
 <k4huw3bsimjq5kyjweuwzksu5lc34rk5acbvxwhrt67tdwbom6@gx3lho54h6i6>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <k4huw3bsimjq5kyjweuwzksu5lc34rk5acbvxwhrt67tdwbom6@gx3lho54h6i6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ceb55350ffe6fb4263f
X-MBO-RS-META: 5qtdekzrgw4rd8nqkrqi9k3wc7nqfxsf

On 7/15/26 4:22 PM, Manivannan Sadhasivam wrote:
> On Sat, Jul 04, 2026 at 10:25:01PM +0200, Marek Vasut wrote:
>> Return error code from .additional_common_init callback and check
>> the error code. This is a preparatory patch for R-Car Gen5 support,
>> which may return non-zero error code from .additional_common_init.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Manivannan Sadhasivam <mani@kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>>   drivers/pci/controller/dwc/pcie-rcar-gen4.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> index 5f7211b91ee5b..7625cd338262d 100644
>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> @@ -87,7 +87,7 @@ MODULE_FIRMWARE(RCAR_GEN4_PCIE_FIRMWARE_NAME);
>>   
>>   struct rcar_gen4_pcie;
>>   struct rcar_gen4_pcie_drvdata {
>> -	void (*additional_common_init)(struct rcar_gen4_pcie *rcar);
>> +	int (*additional_common_init)(struct rcar_gen4_pcie *rcar);
> 
> Can you also rename this callback as init() and implementations as
> rcar_gen4_pcie_{ep}_init()?
> 
> Though this callback is a grab-bag of various register settings, naming it as
> just '.init()' will make it more readable and less redundant.
I did a bit more refactoring of this in V2.
