Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1B2E5B02;
	Sat,  3 Oct 2026 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791063283; cv=none; b=tGZNdSG6kgIBNtoHQnGbb30OT4dzDl05Eht9ldlwaqHMTfM7/puYJkzqgmse/oYS8b/3PdrHaMrHUiBbEVzTkCPD7yRgG7kP7V7BcORytIwLKJX0oEcgE8ug94ybVFh7mf4NyBVz/96PsIxJh5R9VDGfvgDsNLPa23WUIMdBnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791063283; c=relaxed/simple;
	bh=v2wkpbnJSVfATnhgeONgSDa62a3bELLGSq+xO6aN2OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkC8NmdYDRRIZaOkBkKUnwv3X4zeo9tCbbWkT64MQ2X2EWM3lbxUGiuWtPf/F4YJmZx/ol2aqVq8vyzuhq7iK9Ia5PcM6NfxffEy/dCojew5wvbJt2jK+KtL/526fi+u2q6PQjrhFzcXHfRMO06XSOMAPqsJDP0PtSCoW3MJZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TZtdaHHT; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=giMdF1OH; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TZtdaHHT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="giMdF1OH"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hxzSZ6FrhzMlQg;
	Sat, 03 Oct 2026 23:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791063278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsfgHb7ulzk4k9dY5hRDo2OMjswVPbj1J5spakfPYuM=;
	b=TZtdaHHT5XT1FJRszeKMinIqci9J1NkCeD/N9AsOyRZKUVbCitm79uivkRj7357GE6RP9n
	DFLuh0+GFamlSRNSx94L/NqSmKuvubukAED+oHxIeBFclW22kENEC15l8Dki2OhXBpv+oD
	7N5e9BAk2FIGH1WBjyNXFtSZPYjG1HponakHiV06u929T4slabi2VSJkH2YK/mxUsyTwy5
	YiV1oJYbqDqcyCZvxaoZKmT9Nx3G/vUvvFWBaaX9IAgAKHkp5XuvYkVI/8G90uwVXCSJrD
	dKkqb4l/80X9iWpc4eC0FNcJZiaanVhgxDZGAVlrEjmdQ+29TlWvZ9FgMiGIKw==
Message-ID: <5828adca-ccf3-4680-84d6-964321a2e0c7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791063277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsfgHb7ulzk4k9dY5hRDo2OMjswVPbj1J5spakfPYuM=;
	b=giMdF1OHJeF6yhY4ZirSzVyjAcHKgMx64UGhmvbYkSBfN8Zmqg7OkUk7AAtFN4fDuKXXgc
	r96b2Z0ZAyJM4NlW33ru3FYuSWGrjQS2R6EyVRgp6gZYRNCB0+BCjCnVCB2Zmq7NFEtqAZ
	pbffUtb912lBmnThsrE7T8qdQ644pjI5IyNhkOG51i/Ha75DPJZF5GfBEtXMKFYN/+6JsZ
	vceHIYBi2+a/br1sF3+iXgrUWvEywVhxp89OtxhkUO+jsbeb4rqNQUcZd+xlWsH2D91stR
	h7yMf4YoFEuKrRsVc5TC7NwmsjrVK8Z0s2IXjCI8i+gfASIy8nnvCxkUBuhXsA==
Date: Sat, 3 Oct 2026 23:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] PCI: rcar-gen4: Assert resets when Gen5 PHY
 initialization fails
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
 <20260928165230.3397664-7-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-7-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 77x8weoxogqgphm6d63qzuuo7ckb3jaz
X-MBO-RS-ID: 37f80b4baeea21761d0

On 9/28/26 6:52 PM, Koichiro Den wrote:
> common_init() enables the clocks and deasserts the power and
> Application/Local resets before phy_init(). If phy_init() fails, the
> error path only disables the clocks, leaving those resets deasserted.
> 
> Assert both resets before disabling the clocks to unwind the completed
> common initialization.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v2:
>    - New patch. Place the fix(?) before the initialization refactoring.
> 
> Marek, I looked through v1-v5 of your X5H series, but I'm not yet sure,
> was there a specific reason to leave resets deasserted when phy_init()
> fails? If not, this fixes the unwind before the restructuring in the
> following patches.
I agree, this change is correct, and should have a Fixes: tag .

Fixes: 3283c4db6009 ("PCI: rcar-gen4: Add support for R-Car X5H PCIe4")

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you for spotting this !
