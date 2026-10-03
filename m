Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8C221546;
	Sat,  3 Oct 2026 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013110; cv=none; b=qNrlP237RnOJUGKYo1M5I/evkHynor8k+hrOXJUBXocUtSE7DKFQfFZaJ6FlYPXnmR99FRsdCpJesJYbxi1kO+pJQ92k8CFUIitDaGH2xVX0TYA/OFKVUM97XGKA3aG3CtZqOUZmFZ6FPKquCWpNJK8o16EgdqtSuYhtSTFq2GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013110; c=relaxed/simple;
	bh=7xpwWgiNI4RGu0M+o4wDPox+z+YSxbdo9VhP+uTDlzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAwBkSyyGQnpdawsWF2JEW0ACjklDI5wM5NlltyE4gba7eF+BT15KISnyBoV06hEG7/cpXHlKk/KBjP5Rsnp5Jbkwqm7Pgt23fuO7oSSn01zHgHZOCsIasBX2/0unuxJ0hRmaT9W9eagTmOmtz6tqcl9+16v3R9q4Fflf5dNhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rIfRf42T; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VGAPxFZC; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rIfRf42T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VGAPxFZC"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hxcvd3j8czMlJX;
	Sat, 03 Oct 2026 09:38:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791013101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBcP684Z8QNtJOdFLlRM1PVLXGw/B47oWdFMXgBYVbg=;
	b=rIfRf42TY7ZfMxnLDU6xM8F2G5+FEhVa7hOHwJSKzQHpdLj1GMg1GgUEq5mS9+RO0KkAE7
	iOBLXceA58i9IOApeFQCXLjrLqyrPuwVsihj1xfNfrJE7UGWCRbE3RE+JovKpw/x3cgpWk
	LS/xKxpIWaEqtcE4BHXgFoHQ+xgMX0LMVO4v4rbM5wo8iEfhRV8v+xI4DQjQ4bzInuc1ce
	bkBDRbSzfodccfTAHS0RxlFRII/Kb6RPjm4aHOlzHDINi9KQuFYLGANyjLJvGlANaMnfRF
	v5gAixDLOLlxl9FtaJc3cKtrUqdA7LMxVNP2ZEnjYXjxmZTIPQxebnQA1hVqLQ==
Message-ID: <a66e37d7-36d9-4e46-a226-cf15f9c803ba@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791013099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBcP684Z8QNtJOdFLlRM1PVLXGw/B47oWdFMXgBYVbg=;
	b=VGAPxFZC8+1g3h0GcDOjuE4pB2UC4HebeRZxykwnA9h1HYDAfye47RUJXcvMj02PO/ef0o
	j2wf74KoqSP9jrtU28DKXPjMmlQVkoFWx02q1he25FyiW80Jo5ycU2waE8QuU/vUu1kD7T
	LCEWsMbJdH7TQ9X7d8NPbiRjAXEc03mC/ZorRGk7qz5vhQEfhmcs/caCdUqephx320JqyY
	yjdAUmMPhWh0zZZ/XB0y8ba+ZD9IhRwCmSY0ha7hF9iCxVhdgqeBgufNxr07ZkjPYYj48u
	rHxJlo/1r3vwSJrJIh+uM0wij4nGQm5Jntr7MqI9yJ1E+3zlvsNUGZ5AX83nGg==
Date: Sat, 3 Oct 2026 09:38:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: rcar-host: Remove unused LIST_HEAD(res)
To: Bjorn Helgaas <helgaas@kernel.org>, Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261002233229.GA401322@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261002233229.GA401322@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: cchf19jh3e768p41fz7ybrd8xa3g1371
X-MBO-RS-ID: c1c609b8a7b23c717fc

On 10/3/26 1:32 AM, Bjorn Helgaas wrote:
> On Thu, May 21, 2026 at 10:12:56AM +0100, Prabhakar wrote:
>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>
>> Remove the unused LIST_HEAD(res) declaration from rcar_pcie_hw_enable().
>>
>> The macro instantiation defines an unused 'struct list_head res' variable,
>> which conflicts with a valid resource loop-local 'struct resource *res'
>> declaration further down in the function, triggering a compiler variable
>> shadowing warning:
>>
>> drivers/pci/controller/pcie-rcar-host.c:357:34: warning: declaration of 'res' shadows a previous local [-Wshadow]
>> 357 |                  struct resource *res = win->res;
>>
>> Fixes: ce351636c67f75a9 ("PCI: rcar: Add suspend/resume")
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> v1->v2:
>> - Updated the commit message to include the warning.
>> - Added the Fixes tag.
>> - Added Reviewed-by tags for Geert and Marek.
>> ---
>>   drivers/pci/controller/pcie-rcar-host.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
>> index 213028052aa5..cd9171eebc28 100644
>> --- a/drivers/pci/controller/pcie-rcar-host.c
>> +++ b/drivers/pci/controller/pcie-rcar-host.c
>> @@ -346,7 +346,6 @@ static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
>>   	struct rcar_pcie *pcie = &host->pcie;
>>   	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
>>   	struct resource_entry *win;
>> -	LIST_HEAD(res);
>>   	int i = 0;
> 
> Internal Sashiko feedback while backporting this patch:
> 
> [Severity: High]
> This is a pre-existing issue, but does this function lack bounds checking
> for the outbound window index 'i' when configuring PCI resources?
I believe this is addressed in

[PATCH] PCI: rcar-host: Validate IO/MEM resource count in DT ranges property

Thank you.
