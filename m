Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A523316199;
	Sat,  3 Oct 2026 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057753; cv=none; b=A0raprzJ0tQHsp5kEo0oGwEoL6MWy71ohJtOg/uwo9a80Y0tCQh809YDZ5fwQ9WQuWzn11vbXWnRpcBy4XyEbIr9T/3Os82dPuaC5CcxAmEP7dDAsM6ziNkZAjEtp+DYd9nidgzhsnTKAntTM62sfz37F25Eo1ZVIuv82mbF0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057753; c=relaxed/simple;
	bh=3Rm5KBexKJUFbXL8ySF2/d7ZjfFfjUhoBEWvM+NH1kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMc2Q2iDZk4LwlflRVpkS/LH+8/CfDt+3TRkq3s+rqEGGGt36uqN3cA/ElK4gmIKk3jO9ZEZf8Gp5n3yOz897FegIcg5xZEg4oFy3bFm43tLExdv+LS5yxCdouG3yB4EtrzoW2sRNuB8qSlHQW2Mr4BOkiQtP64KkmY5y2KoCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=J5/t7RuV; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=H9E0L8Fx; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="J5/t7RuV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="H9E0L8Fx"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hxxQF1jNGzMlGw;
	Sat, 03 Oct 2026 22:02:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791057749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2hx8mSXufXQMLy/HU5AvSxlylA0cdAKQG4bp36dpPg=;
	b=J5/t7RuViP01ibo2BwbZjgiQDNaCxQo1U/tJvOpsyujDaGeP9//9q3dXe1EaSAt04mvZVb
	yr0ZD49gCaHgGOfe4D0BNtVDSqVUp3B8Ao0DHv14yuAU7o4CdjvkcC/9Nkd+m19ZaWE6j1
	0VW3f7hEgzLakSzM1xWrzIW97+qXxg9UHtsYyKY2EvEmlWI4P1rWHomSOEM9u1bJqRyE8N
	ujntCoQcq9nsp8S3rGz8r5zAeJVrMWUZPQAKp7sSMcX5DuCN43AVd5wXZ7Drx37w78Ny+k
	98gtR/ERzVjWIQWDRr7OzDcBAOx2ZkS9GexzD2ns58SzS5zDgiidGBVxwBW/Ag==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=H9E0L8Fx;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <8e00c574-fe32-470c-b5fe-1569f7dda957@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791057747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2hx8mSXufXQMLy/HU5AvSxlylA0cdAKQG4bp36dpPg=;
	b=H9E0L8FxO54IZBV00OULKB9R6tAOTmS1GVZsRxtRG1RGa/0LBShrrvhYqg86MawwpXv6Zp
	xzFzMxcJs226rHseQcMk39rnUtztziV9J2MRUsXc55VDrsbfk7gzuhwkEJvb3skIqhMb1r
	ZiJcskigfybxNhyFW61X1zkmJhXgt4pZeBSYfoEkKzpPstQhlCQsMCydM1IE3ldAANzhry
	S1czqPMhzxm39DhbGWnpR0E+ftvkOnkYpSSBYQVyWzbHe2WRsO7cQso7sS/xxvdoyAI8cf
	5ILi/nRXpxYxYCewIFeEFutRvGtnFTEYXD5Wnu5nYfqBdTb3pjRBtgBTK8DErQ==
Date: Sat, 3 Oct 2026 22:02:22 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] PCI: dwc: Export dw_handle_msi_irq()
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-5-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-5-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1gs5oxn8z5t5czzh5jxh8xoysekjs6pt
X-MBO-RS-ID: aef3102c2ba403b93b7
X-Rspamd-Queue-Id: 4hxxQF1jNGzMlGw

On 9/28/26 6:52 PM, Koichiro Den wrote:
> Not every platform brings the iMSI-RX interrupt out as a dedicated
> line. On spear13xx and keembay it is a status bit in the SoC wrapper's
> interrupt register that the glue driver has to check and clear, and on
> dra7xx it shares the line with other sources the glue driver has to
> demultiplex. These drivers set msi_irq[0] to -ENODEV so the core does
> not install its chained handler, and service the MSIs from a handler of
> their own. spear13xx and keembay call dw_handle_msi_irq() for that.
> Both are built-in, so the function was never exported. dra7xx can be a
> module and has an MSI loop of its own.
> 
> Export the function so that modular glue drivers can use it as well.
> The R-Car Gen4 driver, where both situations apply, is the first user.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
