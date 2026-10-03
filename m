Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985A497B8C;
	Sat,  3 Oct 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057647; cv=none; b=Ui6OijoMr3CvxN5Bcyc9lDuFCfdVsNrt0L0dWgp4GpzTE986OcSA6u9ttp7mQncKNfuX4xW9afxNfRyi6yUM6N/sGLO/fBrTtEXcqy/txsMJM9sl3PKXMUBOq2u98ZEDkrB9oEdsOPVGR1DssqvQ1xfKMxump4DsMUZ5w0Y7Cio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057647; c=relaxed/simple;
	bh=pTSMk1VtoaQNX0HqdfZAJm7PXcmWA0aJSYW7GVRkWZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvfBbdatsN9syvKf4soQ/fLBjJxx2nohOawtfVOX7WFo6DBzcRVjuxIaS+BX9yjZhKoCsGZndaVPrkOgE+AwRlg0ZBnGBb9Nqexn+FYsSZ4AASmAd4If9bJhOt403bjkF/S/KW4DHRoaSk06iyESNKes98Z2ZibGpDK2qS/G7zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mGaB9bCQ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mGaB9bCQ"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hxxN736bpz8sZN;
	Sat, 03 Oct 2026 22:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791057639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QC54eSMeHWFYzE9rta4N0u+v7CTrqYjjHRiilvdOt0=;
	b=mGaB9bCQj7RXM0NyyoTwRG9BuhsXbPjEIuqYX5uimTAB5GrtafZGBBLzN1fT4fiv2lMefE
	zNYxl6QqsHMUPMggrTMnhavQeLqaopMznBq6O6Zb3xiO5b/NS9cSr8ASdOKZqSgnBUj2+p
	rAVYB49LlUqG0tY3+3sWxWOViyQJn8s5e/487a2aSvF2viVQBB651DaSkjH9nq0PTHG8Mu
	yNXPwXrqMmaLjjwrToBMdaHe4K58Dvh7ujnxBLWVSxNUm6j0Ntm6PN3Iq7XBHM69k1mCB3
	BIK1/bppFQBRg6ioJ9gLvtlHb6LQSRIjDt4GA6PM4CrAmERlWCcc/hT1dWElYQ==
Message-ID: <974d8621-b97f-4797-a315-307a9438f2fe@mailbox.org>
Date: Sat, 3 Oct 2026 22:00:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] dt-bindings: PCI: rcar-gen4: Add optional "aer"
 interrupt
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
 <20260928165230.3397664-4-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-4-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: acfic4wyff3ku8nhyzzygqumhkmbojtz
X-MBO-RS-ID: 73976a04d903cb887b3

On 9/28/26 6:52 PM, Koichiro Den wrote:
> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
> 
> Keep the fifth interrupt optional so existing device trees remain
> valid. Extend the example accordingly.
> 
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
