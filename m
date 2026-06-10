Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0772DA765
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117467; cv=none; b=aO/plZ5U1B/yCZd2R/2JvMQJV427zS0wgOme8NWIwR4lgNs2TKBVr8mDsO2BSbHaY3v5UoRQrYV9FG4NKysDPQeERPQhxq3tFAbf3ZSosX8jgetpuZzN5Fat/4H7yk0ctijUAcTgqg/aWHs5cykBjf8P0wIUFpwyxQfMeLTEAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117467; c=relaxed/simple;
	bh=vrvXTQGaBYmGZvNYYbz+ZPRnJFdVOK/6Ow0Uktp8Z9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWrfd8Wkhls2OsJmra3U7WTggEogKzzk2YT3GIlW54uaB6P+cqZow4KT1OWhkhoOBZ9MiDqTrMaSbXQIXUT52ILh19D1Dlzalj5Zht9SqQweDglodcGBCBDfLXDi7t28YaDSX8uBO/dYOTVtzuEaDaQegsmEe+zGVtZFzzK/4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wl96h33c; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wl96h33c"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gbFGr3SPXz9tlV;
	Wed, 10 Jun 2026 20:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781117460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZevjoKy/Qn5PiuRiWmQRfSmxLgVmXC1B3TwbFCvVne8=;
	b=wl96h33cWAdzstipbUMKPkpVZAWpxgEZRAcozi3Tih1NMAmt+e4n4/uTYgPsdpxATlASW1
	20bx2CmWqAwrU85fa/M70UlFMxh3gMjy+MM6tC9//7sBY7aYEy1nv0M620qDgBdllIk2Sg
	2JMiS2u3UqQ5FSrTs8fjrpOhxZEJ/jX4dW8XulhoR5a2Lv5Qw6igkwed3k4LQmoe3rq4lD
	a8yNnaWW70ApeOglgw3dVtz7Y9DbXDgQVvvzODGWl5Xu9i/S8JORqpX2Fp0lF1SKoR2jv9
	qu3talF8YzpY537ShSNKuEgLuVhs7zeSKUUEJPJJhxz0elyTj19fQINhl/nJEg==
Message-ID: <bc40e4c6-1922-4bce-99d1-341730a4e6f8@mailbox.org>
Date: Wed, 10 Jun 2026 20:50:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
References: <20260519195219.189323-1-marek.vasut+renesas@mailbox.org>
 <20260519202037.8BD001F000E9@smtp.kernel.org>
 <orrpfub5f2hkrgkmxrdtykhzmxyuclnky4dn6vnz3cgvvbdcvb@5altvzufcq53>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <orrpfub5f2hkrgkmxrdtykhzmxyuclnky4dn6vnz3cgvvbdcvb@5altvzufcq53>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ttpgyhrq88jjhdar35rhcjkyco9uaiyp
X-MBO-RS-ID: 175196a034898b0f73e

On 6/10/26 7:11 PM, Manivannan Sadhasivam wrote:

[...]

>>> +static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
>>> +					struct pci_dev *dev)
>>> +{
>> [ ... ]
>>> +	if (pcie_get_mps(dev) > 256) {
>>> +		pci_info(dev, "Limiting MPS to 256 bytes\n");
>>> +		pcie_set_mps(dev, 256);
>>
>> [Severity: High]
>> Will modifying the Max_Payload_Size locally in the enable_device hook
>> desynchronize it from the rest of the PCIe fabric?
>>
>> The PCIe specification and Linux PCI core generally manage MPS uniformly
>> across the hierarchy during boot via pcie_bus_configure_settings().
>> Because this hook runs later during driver probe via pci_enable_device(),
>> if the upstream Root Port or Switch retains a larger MPS and transmits a
>> TLP exceeding 256 bytes, could the downstream device drop it as a Malformed
>> TLP and cause a fatal link error?
>>
>> Would it be safer to restrict the Root Port's MPS capabilities before
>> enumeration so the core logic correctly scales the entire fabric?
>>
> 
> Marek, you said that Root Port's MPSS is fixed to 256B. So this means, PCI core
> will only set the endpoint's MPS to <=256B. So I don't see a need to limit MPS
> here.

The MPS limiter is optional and I never saw MPS > 256 in my tests, 
however I feel that to make this bulletproof, it would be good to keep 
this check. If you feel strongly about this, I can drop it, just let me 
know.

[...]

>> Should pp->bridge->no_inc_mrrs = 1 be set during this initialization
>> to enforce the limit permanently?
>>
> 
> This is a valid concern. I believe you should set 'pp->bridge->no_inc_mrrs = 1'
> in the Rcar driver to prevent client drivers from increasing MRRS.

I will add this one.

And I will also re-ask about the MRRS 256 Byte limit now.
