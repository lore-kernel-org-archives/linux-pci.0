Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328339934B;
	Sat, 17 Oct 2026 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258408; cv=none; b=ECwsXZpRp9Y1OATRRLG2Co+JPdZ4ppF0mvDll6UbdhUmBu7xJI0uWgp+iYaH1H6lg87McibzU9/4AVIzKnn6M4pEN6huUHJmOORH7NVq/byO1JAs+CKykzcTCpWb2ScBKKlVaRDP6NEixsOkVIJdykYsUZbhYuWpiLRpsaQW2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258408; c=relaxed/simple;
	bh=s6/cmatAqVqg6hC99M2cPEWnJWGNfKTjMqdX2jSdkmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8WpXvY6O94Lcxs4Ze6iiHfMA4WQil9UnRUlpPB0IWkAVgVzPDS8VUEIL+Wm8RksMVC5gu8iIX3VDxJVzUppx8nBe89Uqa/8CRggzx0fJGsQxOdHKPJ63mN2oig2Z7N2YYYl2htnxDbBSMQpJBlQJdLaiKodDNcaB3PPr56Uypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WmkoFuMP; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WmkoFuMP"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j6TRk6wdvz8v08;
	Sat, 17 Oct 2026 19:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792258403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQ+eKS0Z/1rU2Bn7VbWKmDwK5Ut3PGP5cazZ1i97K1A=;
	b=WmkoFuMPjiU7j1hiohn8PUKzALEE7gInWfjj37sk0Lkf6oIsiTL4B4jBa6W9PN4Sa7XlSB
	WXuPf6+Pe/qwb5aJEQESOwWb5rSbwgtNtigy5qD5HilAYC0zJc7sH7BuCo9LFbJFflGPdQ
	t0NS3ht+WIpxe6bZLDOfRzIq7X8+5D48v2wxbzdy3z9ljZk5Qjw1Ap4Y+QWvDZtrhodsYr
	2m7rFptHozZ+a4/LlcaeDBbsT8bp8J80vuXS6wMT2CHemxMstrNE2mRYip4T0K0kjxLNzM
	oyksCGkL5bRfAGNG1lHGL5WX6O2UotgFdEfYj2kszZYAth/4MoqJoyfoHhyacA==
Message-ID: <c352666d-a3c1-4db8-ad17-e1c89c9ffce7@mailbox.org>
Date: Sat, 17 Oct 2026 14:59:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/18] PCI: dwc: Free the MSI domain after the host
 .deinit() callback
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-11-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261015033103.3076869-11-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 784f7537e3cef4a8e8a
X-MBO-RS-META: 5ujsieytgzpjcxn11h7t6sahaj1m5n4p

On 10/15/26 5:30 AM, Koichiro Den wrote:
> dw_pcie_host_deinit() frees the iMSI-RX domain before calling the host
> .deinit() callback. For a core-owned parent interrupt,
> dw_pcie_free_msi() removes the chained handler right before the domain.
> A glue driver that owns the parent interrupt and demultiplexes the MSIs
> itself through dw_handle_msi_irq() can only stop its handler in
> .deinit(), after the domain is gone, so a late interrupt can still
> dispatch into the freed domain.
> 
> Remove the domain after .deinit(), in dw_pcie_host_deinit() and in the
> dw_pcie_host_init() unwind. Keep removing the chained handlers of
> core-owned interrupts before .deinit(), which powers the controller
> down. Clear pp->irq_domain when the domain is removed so the unwind can
> tell whether it exists.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
