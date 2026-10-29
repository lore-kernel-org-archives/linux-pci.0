Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290783;
	b=Fprspd/c/IBH26mC3xaPwuAyK3AnPpxr8EqtacvOOVTLYfOD4sgddKvPkpUtMfSjhEDH
	 R2+pAB7xQyvrHQVvw+l/+1uuw0KENAPxXzGOVEXLInotf5fzeGK8twL3T809olCyYjhJT
	 7WxErgE3qjs01EzXpafZtBXDKTzMSqIjl/D1HO1mGJyRIYusUBM9RzO57vyB76c+AU570
	 if7mJWFbArJ8Dr+yZrgCyNyI4W8kWramn24Axc6HjBBhBEcql12I9uS02kr8TA4Q9cAoq
	 OEHAIq+4Whtmd2SKXsOA0eZfWLvdlJQYmVcUa3zZ22rHvt5fU3rrTJGA/nVHqSs7QMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290783;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=ja8ONJDeIqt9tujNfkMOJEzhfIqvn10cyyDk1tyhMB0=;
	b=5K8CE8HEDnkiRKek+IOYefcInuEpp6bUtnFrlOlb3ZTaQr9XWa3GPj17uoDO8NyrwK+6
	 qVkE0z7tF8WoeeyzF6h7x0iwjL6rYCV1RkyDdes4TfAkvheKXdKVBIE2ZGimP4OWyoI+A
	 2Ub7Xd+2CtZKiJ5LJ1+7IYidBwndxuMEuvLpjp2ED3vCx3oeHyCTIh8gvHKStsJuwHt2B
	 sIAtOB5MErgRwJwm4UFDWSMgC+j8ab+0gRW8MhFSvQ9e7FBATXfl3NjNMlsNLCfv0oHxY
	 AlryZKByLeTWh+7hMVSqjNvNo23DJ9NfTCKhaKQGGgQL6hJpvPSuj1dc3R9znjkLODA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=odChcWSM;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1980606A31C;
	Thu, 29 Oct 2026 16:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1980606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=odChcWSM
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jFqF64nl1zMlKB;
	Thu, 29 Oct 2026 17:19:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793290778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ja8ONJDeIqt9tujNfkMOJEzhfIqvn10cyyDk1tyhMB0=;
	b=odChcWSMwA8bNdK3RYqvc+7E8BG+/3imST/PR+ARl/85GtsExrwkGZVGYrDCXAfzpDo9l0
	eCHq0GJszd2/VZmikSTGhqCClyEtAcOuYjHEeIAEoC36gO8q2v1D3kcWVgPunzqebvQx5B
	qt50I3Gjhh+ctKQRy3XLP6LmWIUOO05MsDhvruCVpHNJ6nEl2J0kZegSzjOIYAA30wweuS
	Qaw91K83uAy3n5S7UYz9bI9bs8S217ZH7s7eRUTXeOck9a4lDvGPLCf50+3o313aCKlC8r
	bQV2JUDVEYvPo7PlXIC9IUh0fxgo5YIcyFmwSyFBXzyNTRGAY+/xUecjp/JJDA==
Message-ID: <d71a988a-988e-4769-8966-0ca54eb00528@mailbox.org>
Date: Thu, 29 Oct 2026 17:19:35 +0100
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
Subject: Re: [PATCH 1/2] PCI: dwc: rcar-gen4: Replace pe_rst GPIO PERST with
 GPIO reset aux driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Alex Elder <elder@riscstar.com>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jingoo Han <jingoohan1@gmail.com>, Koichiro Den <den@valinux.co.jp>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Lin <randolph@andestech.com>, Rob Herring <robh@kernel.org>,
 Sherry Sun <sherry.sun@nxp.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vidya Sagar <vidyas@nvidia.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Xincheng Zhang <zhangxincheng@ultrarisc.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20261028172133.20903-1-marek.vasut+renesas@mailbox.org>
 <18b4e960-caa1-48b0-a5aa-f3585274787d@mailbox.org>
 <auNPg8kAs2_O2_9R@ashevche-desk.local>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <auNPg8kAs2_O2_9R@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ptz1tj3axsubh56cr1nuxefgp8b4ohyc
X-MBO-RS-ID: a2561e31dcc06d78995

On 10/29/26 2:52 PM, Andy Shevchenko wrote:
> On Wed, Oct 28, 2026 at 06:27:36PM +0100, Marek Vasut wrote:
>> On 10/28/26 6:21 PM, Marek Vasut wrote:
> 
> [...]
> 
>> Bartosz, alternatively, I wonder if there is any way to request the
>> reset-gpios as reset controller reset here already. That might be even
>> cleaner, but I don't think there is anything like
>> devm_reset_control_bulk_get_optional_exclusive_and_also_request_the_gpio_reset()
>> or devm_reset_control_get_optional_exclusive_gpio_reset() . Maybe something
>> like that could be added to the reset subsystem instead ?
> 
> It's already there, if I'm not mistaken, one describes reset-gpios in DT,
> and reset-gpio driver takes care of this.
That part works fine, but please see the DT snippets in the patch, I 
have both resets/reset-names and reset-gpios DT properties in the same 
DT node. That is why I need this crutch.
