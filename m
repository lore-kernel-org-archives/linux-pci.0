Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76A3C09E0;
	Sat, 17 Oct 2026 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258397; cv=none; b=keQ9kXiTL+qbuxqL82XqcKnDVEdlQZN+D8qsffsFh33UhRuygVyjjcTTRPegI1vDw5PVRm8cnPexHTzdEaIEJrJljZz6G95reSGkjQfMNqho3b+EWWOO8hCNE2WNphYxnSqoxNcO6m/GKVGd6eZUzdtigxus0awYmSaq/3dBNyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258397; c=relaxed/simple;
	bh=ntTcxfSZ3fDRZ7/8naFztMa2D6QsUn2rYE4svh10BaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBQ6BJYPDnYiEvbM2aQiYMkJUMzN4qkge22gdyGC5CGJ3j9vKj20cTjxvtxVNJjJyp6cuWQheOZOl8QAkDGvhrJVTbiH3kN+rmXJh4S32SpNTu4OFqwIEpoPvwSvQFwzMo8Uc6oMgYDpUMyprhiF9mCNe3n9RBbP3+MNkZ91SYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=HhTI9QfG; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HhTI9QfG"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j6TRW6r8HzKnjK;
	Sat, 17 Oct 2026 19:33:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792258391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQ8t9/fLcmwf2pGZuWlYvvYgGuI5tCDATttpvKen1xk=;
	b=HhTI9QfG53Xvz13UpGfk+ZZPnc/lmFRghi3/30t40EierbAyEVy8iyXke1MmFgDxFzhWQo
	0jeyVtr7g0a2y5TNSQPQpdhxwppblHLx2yBwOAGaQAIcdApzz+KQjCdsVmwthQEVRlwBo+
	EW/LbKCMur6wYzGcQoY463Jh00QXhKPeHISpRsw+L0GWPADBqNGZj+qs1bt53BDigV4k4M
	Zn/Px2xccqGwU4FGze41nal3ZEq4CXwcnegLjVIohX0hKmiCx3wOondrgWBQszWxW3QyeR
	AgXBjjtmfaSkgjgesSWoVnUV5+EOMrc7ye5avFZlH+10NgHc5P/HfSJe663KEw==
Message-ID: <93e693c6-8b19-4cb1-8dc4-4e6ea60746f5@mailbox.org>
Date: Sat, 17 Oct 2026 14:32:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] PCI: rcar-gen4: Add Root Port reset support
To: Koichiro Den <den@valinux.co.jp>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-10-den@valinux.co.jp>
 <f9258887-2cc5-4c88-b465-5ac7fc1e82ea@mailbox.org>
 <eivzz4zumuu32zrycw6wpt3orzk2dvlzuvj34krmbhjf7a3a6u@ccvu2nkupzid>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <eivzz4zumuu32zrycw6wpt3orzk2dvlzuvj34krmbhjf7a3a6u@ccvu2nkupzid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5rhy8s3p4biznsjywibh6myuhoxjmztf
X-MBO-RS-ID: a51a92d28dcc6f6efc1

On 10/5/26 8:14 AM, Koichiro Den wrote:
> On Sun, Oct 04, 2026 at 02:11:37AM +0200, Marek Vasut wrote:
>> On 9/28/26 6:52 PM, Koichiro Den wrote:
>>> Implement the host bridge reset_root_port() callback so PCI error
>>> recovery can reset and reinitialize the R-Car controller. This also
>>> provides the reset operation for the link-down handling added later.
>>>
>>> Call .reinit() with clocks and PHY initialization retained, restore
>>> the Root Port registers and restart link training.
>>>
>>> Rather than tracking which APP interrupt enables survive the power
>>> reset, derive them from software state through a single helper. A flag
>>> keeps the sources masked from the start of a reset until one succeeds,
>>> so a failed reinitialization does not re-enable them against an
>>> uninitialized controller.
>>>
>>> Serialize the reset with a mutex, as not all callers hold the Root
>>> Port's device lock: pci_try_reset_function() on a downstream device only
>>> locks that device before falling back to a parent bus reset.
>>
>> Please pardon my ignorance, but is this maybe something that could be fixed
>> in the core code ?
> 
> Yes. pci_reset_function() has locked the upstream bridge since 7e89efc6e9e4
> ("PCI: Lock upstream bridge for pci_reset_function()"), but
> pci_try_reset_function() and pci_reset_function_locked() still do not. I am not
> sure whether this is intentional, but in either case, that is a core matter and
> separate from this series.
> 
> However: more to the point, your question made me look at this again, and I now
> believe the mutex (rcar->reset_lock) was not needed in the first place. Every
> path to reset_root_port() already holds a device lock that excludes the others:
> - error recovery and bus resets go through pci_bus_lock(), which locks the Root
>    Port and every device below it, and
> - pci_try_reset_function() (even without the upstream bridge locked, as I noted
>    above) holds the lock of the downstream device, which pci_parent_bus_reset()
>    only accepts when it is the only device on the bus.
> 
> So I will drop the mutex in v3. Thanks for making me look at this again, it
> really helps!
Excellent!

Thank you!
