Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC205012B2;
	Mon, 28 Sep 2026 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631170; cv=none; b=VjxsHQQfygZeyVJVpEBS2rIoCPsjtA8hX8WSBakE0yMS3Rrp6fkgxusHEiBQ0PbQgV2Kl8oUpreccSvkW5fbXsXp/CViMN002uq8jr77iAKONgGPfrkpsHi5HC5mlJwTrm9DKoT6DKDEnk7X4m0r/OV+VVY3FEhBEdosuHqJJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631170; c=relaxed/simple;
	bh=epNoroeavcGYBU0gF0l4Ccj9MVBTx/Y5ypuGkTvRQp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=es5Vu3FR909wG2iPnaUXNGCR32WVJ8rCtWN+GH/Le4IWHyhPgjuEGht5DBjlPMjIC0tdcRqUNSAsUJN97lTwpGQkMctWhfyx2cbj39bdFlJ/yjmCrqo2+Syww4RputEr/XYv5rMeq5IB32CQECRTQYzD2E7HtECkMQOZcxIeNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jkF+kUhs; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jkF+kUhs"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4htvfd18H1z8vVc;
	Mon, 28 Sep 2026 23:32:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790631161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXP4kntCRSr0u9GLCjjrcHN16qzZLRh3uXI4VNGJVtc=;
	b=jkF+kUhsNBuDQ8l1B8GovLmQ2G6gJbB/kajiYp380+se5g6+slhn1RnbbaEK0kalnCNQl/
	+Tc8KmRNwZSYanK95gQA+PimSycl4X7zo3uEJ0DiCkxhmvxen8VqngSzgmkykjEWXDPvWg
	cBw0IWxlw73q9aDl1wTk5D5Hfx68voqpQ1hF7EPnOHXjmrNdX3BKJjmRm/bMzvnrF1f5J8
	vx3ftHeM43gST5ayX/k/pdmxVh1/ahl1SI+vtOMbmDOFSXGGIWRyk6tHonljMyjerFx0S5
	8YZz4VRzjUKop0+pg2SK8UZc6HroFLBQmITGvK0uzpvLfXPcgVDr+wiP76RXfA==
Message-ID: <3bb47958-09e2-4726-85e3-8e5d3873840e@mailbox.org>
Date: Mon, 28 Sep 2026 23:32:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H
 PCIe4
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260928210155.GA2260978@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928210155.GA2260978@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: w9fowsmy3hfd6ozkkg67j5hakjag8bcx
X-MBO-RS-ID: 2656e4effd21e824bcb

On 9/28/26 11:01 PM, Bjorn Helgaas wrote:
> On Mon, Sep 21, 2026 at 10:27:48PM +0200, Marek Vasut wrote:
>> Add support for R8A78000 (R-Car X5H) PCIe4.
>>
>> This driver previously supported R-Car Gen4 S4/V4H/V4M. PCIe features
>> of R-Car X5H PCIe4 are almost all the same.
>>
>> The controller initialization sequence is slightly different and is
>> factored out into controller specific callbacks, in a manner similar
>> to previous R-Car Gen4 handling.
>>
>> The controller does have a PHY attached to it, but the PHY is operated
>> by a separate PHY driver, the PHY driver instance binding is handled
>> in rcar_gen4_pcie_get_resources() and controlled in the aforementioned
>> controller specific callbacks.
>>
>> The controller driver is deliberately using "renesas,rcar-gen5-pcie4"
>> DT compatible string to discern R-Car X5H PCIe4 controller supported
>> by this driver, from R-Car X5H PCIe6 controller which will most likely
>> use a separate driver.
> 
> The gen5/pcie4 usage is confusing.
> 
> I often push back on things like "PCIe Gen4" because it's ambiguous
> (does it mean "compliant with base spec r4.0" or "supports 16 GT/s" or
> something else), but it's so widely used to mean transfer rate that
> it's hard to resist, and the best I can hope for is clarification.
> 
> But in "renesas,rcar-gen5-pcie4", I don't know what the 5 and the 4
> mean.  Maybe "gen5" refers to some internal R-Car thing, and "pcie4"
> is something like "PCIe Gen4, i.e., 16 GT/s"?

Gen5 refers to R-Car Gen5 (5th R-Car SoC generation).

PCIe4 refers to the PCIe Gen4 core in the R-Car Gen5 SoC. There is also 
PCIe Gen6 core in the same SoC, but that will require a different driver 
and different compatible string.

Since none of this shipped in any kernel version yet, would you prefer 
some sort of rename ? I can send patches.

-- 
Best regards,
Marek Vasut
