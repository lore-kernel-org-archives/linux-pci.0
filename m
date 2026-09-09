Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7253264EA;
	Wed,  9 Sep 2026 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928676; cv=none; b=XqzUK1WD/tYLflNtPZqDjUrckOzQ1lxNJqLJFiFzuBj89Fy3o58cvQcJXhNG6GNE2Bjig1aIR6un4d/QUJi14Q4equDte0LOaoc3EjOL08Qp9fOZnBHZoS8S5Oq+3N6aObrvCrRKWvUJkPPDMh2aVDSGAxSM4qE2c4kNB99A06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928676; c=relaxed/simple;
	bh=eG9VVcfzi7pkWrfKLBjQkMTy5n8GJaU4Z9lPu/fZXmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asd8wV0srPKHy9voIMy3ZZ3WVynZIV15bwRJ3tZXd2x3m6SJhBWxvsdkqiFXatVyvJyfvLuTPLP8ujf4pcZt5NvZZJmggMLaTGGs9IVZ7E5iFhiRPjzf1FjUbm3vAkE6LcQvUVT4QOUXH9L6UwpZmhk2q18Wa/N72GhEyyQuI/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oLgjbW67; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oLgjbW67"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hfp2L57grzMlFd;
	Wed, 09 Sep 2026 06:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788928666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67tux91yUFkgKxFKhelqMsixAxrdmMG+zLHiWwpznfk=;
	b=oLgjbW67ZzrWy+uU+6rqhMzp+Flgwet2T1MJCW2P94GZQrL7r7we34erDsLcmhDziAGScw
	zAXBfnF01JZuMTz++QM043X+vELgsJTRSsc73ow7H5TfQFYIzdvUz0sL9r1ue0ulGgBXVh
	MffibHI1PJFwZEkeAWft86LogkEz1ylDc5uFu4IfheEUr/SSCLYw4o1ZYeSC1tC3kTgHtO
	+4rsoNiB15oNvZIAiC6TYqoimUpgb9OH35SeLu7w2IPoelY7nCMZS5Ov9Y6TklMbfIUkKg
	yCNHpe/+SgDSeLkdJjcDRyuRSJCO19I/v3f2Q1ujT1wmyRKIoyvMMGNoLkC13Q==
Message-ID: <1758591c-4583-4db1-a9bc-32430bbb6a37@mailbox.org>
Date: Wed, 9 Sep 2026 04:22:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing PM ops
To: Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260907163554.725127-1-marek.vasut+renesas@mailbox.org>
 <74il3j2dzfdt4xhqrfjkifhnpnmgqtplon2mtzfjzkbszwegi7@vou6a5rshcvr>
 <de8e26a0-cd05-4448-8392-0fb3953e7d3f@mailbox.org>
 <ain27ypszl767h3fygurivurojxctyjy2yprada6lgjef5c623@23nn7tsrecb6>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ain27ypszl767h3fygurivurojxctyjy2yprada6lgjef5c623@23nn7tsrecb6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9666f74209110f82f62
X-MBO-RS-META: pnrx5kkfu5j5zuj4856bbzec8ida5d3a

On 9/9/26 4:17 AM, Koichiro Den wrote:

Hello Den-san,

>>> The s2idle test with pm_test=platform now passes in EP mode on S4 Spider even
>>> with CONFIG_PCIE_DW_HOST=y. Thanks! Feel free to use the tag for it if it helps.
>>>
>>> Tested-by: Koichiro Den <den@valinux.co.jp>
>> Thank you for your test. I would like to ask -- is the EP side of PCIe link
>> behaving correctly during suspend/resume cycle on your S4 setup ? Does the
>> EP require any special handling during suspend/resume ?
> 
> To be clear, what I confirmed was the following:
> 
> - The panic I observed with v1 no longer occurs with this newer revision.
> - I could create a vNTB EPF after running the test.
> - With vNTB/ntb_netdev already connected before the test. ping resumed normally
>    afterwards.
> 
> Note: I used the suspend test from the commit message on the EP:
>    echo s2idle > /sys/power/mem_sleep && \
>    echo platform > /sys/power/pm_test && \
>    echo mem > /sys/power/state
> 
> Based on these, I believe this patch introduces no regression in EP mode on S4.
> Any pre-existing EP suspend/resume issues could be addressed separately.

Understood.

Thank you for your help !

-- 
Best regards,
Marek Vasut
