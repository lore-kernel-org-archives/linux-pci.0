Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F51440A26;
	Tue, 22 Sep 2026 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110965; cv=none; b=T7XTJ7c/DOkJYvJD34Dems7tGwu1raNOAIDFK90IahlgQXeuNP7Cf+wW5O8muqRL1lCodPycTUIkNWn8LR6wQyTqYFOb9xGkk1gfh8RUr4c3Pv7yNRNS+UrUH2nSSz+/MjecEpO/bn5kB6MXNlFt/X3iQyH2llVtzh61Kia76fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110965; c=relaxed/simple;
	bh=sjit43z4ihkXWP9gtYfOPZ8JXNh8kmk2P0chV9aooFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XulK7eAmASo2+93LQsV3ZEaueACxp6N0TO6h1eOk+rlA5DswZcpXeAKXeaDuS0v6R+J1knp1qmvFJ6UGtdHaOc3byc/unvFc3y9oa7ZE/ayWrNkjV7c6ZxfR26Ti8SiprAk1OYDfbdKRjDavsfOJDAQo+ha1ED5KDAxA2WVXImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Nc+rzA4d; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Nc+rzA4d"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hqCGV1l6Hz8v2B;
	Tue, 22 Sep 2026 23:02:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790110946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pMXiXOZBih5TRNk2H7zK8DHdtzZ6V/P9wJI4JX8u98=;
	b=Nc+rzA4dxxOFZwnM07jOR9nfZLAJLiP8KkuvrDGjLxc1EkYJc8+bkA01pbjAqVuSP+uCi3
	bO+LqiAx6FQ+pqohBBByBg1EbFfacHUD0yptwQqIfkTkr9jmYXWiiJMnzQ338sAnCA5d3a
	9URKq6Q9TFcuHVQy8bovz/2JQ7Yu6vnbZpePcxB9Bz1m6m/QCrgsJPOt1H6lOFGxWC3OSO
	GzziKSZ+p2mu75BKW4F1p3p4OwBGJlh4bwrcU+Ov7zcjk4biOQpjEtS2eyQIkewC6dy+2D
	tNYBLcPrKpL+p1nYfa/20zKzr1ewOLsdkpCwQ1MdKmD+jI5ij2mrKGJf9YQ4fQ==
Message-ID: <12004210-424f-4511-a2a5-e68cbc49dc71@mailbox.org>
Date: Tue, 22 Sep 2026 22:59:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 03/11] dt-bindings: PCI: rcar-gen4: Add optional "aer"
 interrupt
To: Koichiro Den <den@valinux.co.jp>,
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
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-4-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260918032038.2216471-4-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: wj1q7msf7f9ckmqrfhnzzz68otwtzn6f
X-MBO-RS-ID: d098b65c241eeb447b2

On 9/18/26 5:20 AM, Koichiro Den wrote:
> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
> 
> Keep the fifth interrupt optional so existing device trees remain
> valid. Extend the example accordingly.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
