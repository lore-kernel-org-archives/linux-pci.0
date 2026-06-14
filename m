Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9634280037
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781402215; cv=none; b=WFla9nS+ZW7j4GBq5b3l3JXuiZyHyYCD/ZsbRqNAer8VM4MDawQTLkmr+fxHVAykYeZ16aZg/Z2VizBMWYjOeyBIcG8sQU5Giz+/+KQCv0MYWF1MOMkwNCh7iVcKBBOjsGX7WtYANTPKDD6hOmATZIRFqI1Qc15yae5LNE4ckvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781402215; c=relaxed/simple;
	bh=C+ITQzJ8S8lx2FPVaXtwsKCAjLX7NCG60i49lqvoGt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtPrNH6MXRBtjPfXNN3FV7/YSgB7DpTmspA31LV0i/kREQW3QdeLq9l7oqtXXvos2O67TyxbcrM1oxw2x0josjZnQXjYEBWo+63dEbo41bbBuqlLOMYJFIhB91+q6751cEHV9ncfCFMrvODCdDt08PNMuKhDGbOmDRvnZxpTZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yQT6PCMX; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yQT6PCMX"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gdGZg4Rsgz9v9m;
	Sun, 14 Jun 2026 03:56:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781402203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khgYauhyJO6ZS2SJUlDz4bqIgJUmMUujTlBhRncm6XY=;
	b=yQT6PCMXwsrhMtUfnjfBNbNz7l2qLOT7nhWYiWvAOJG0ggmPf85kdyhies6ly45NHibnp0
	MlCBvA+FjahCSBplrJmBxTI7FI++VInkW5GuD7oxLwJnBoZInCRog+gb6m197msRTV94qd
	W53kh3fbVIQCjnUF5I4xeDb6QdJxBeoyrADm+upqjumMDgPRJIj4Ghmwf93vcA+5dnGRf2
	iGHC/0DJ023g/n+0R7QzFrzlOVqiP/yss9rqbZFq+gOZnkjM1EUmvDiTc7HgV5VrVlJ2du
	slQ5dq9oza1J99RRAwvBfiEOV0dmcO38OJ2tyI4EFN4T0gMbl/CmURvAqu7+SA==
Message-ID: <14888440-fb68-489e-b894-e90df4c32fab@mailbox.org>
Date: Sun, 14 Jun 2026 03:56:42 +0200
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
 <bc40e4c6-1922-4bce-99d1-341730a4e6f8@mailbox.org>
 <kg7uvgl4kaupiea56e63xiikhl3xqtgug4dqynxchw7prgdo6t@gclq5wdan4tc>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <kg7uvgl4kaupiea56e63xiikhl3xqtgug4dqynxchw7prgdo6t@gclq5wdan4tc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 43qjk5nqpp7km4spoep53gqucgf46d6q
X-MBO-RS-ID: 942d24cc23d74759f51

On 6/11/26 7:59 AM, Manivannan Sadhasivam wrote:
> On Wed, Jun 10, 2026 at 08:50:58PM +0200, Marek Vasut wrote:
>> On 6/10/26 7:11 PM, Manivannan Sadhasivam wrote:
>>
>> [...]
>>
>>>>> +static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
>>>>> +					struct pci_dev *dev)
>>>>> +{
>>>> [ ... ]
>>>>> +	if (pcie_get_mps(dev) > 256) {
>>>>> +		pci_info(dev, "Limiting MPS to 256 bytes\n");
>>>>> +		pcie_set_mps(dev, 256);
>>>>
>>>> [Severity: High]
>>>> Will modifying the Max_Payload_Size locally in the enable_device hook
>>>> desynchronize it from the rest of the PCIe fabric?
>>>>
>>>> The PCIe specification and Linux PCI core generally manage MPS uniformly
>>>> across the hierarchy during boot via pcie_bus_configure_settings().
>>>> Because this hook runs later during driver probe via pci_enable_device(),
>>>> if the upstream Root Port or Switch retains a larger MPS and transmits a
>>>> TLP exceeding 256 bytes, could the downstream device drop it as a Malformed
>>>> TLP and cause a fatal link error?
>>>>
>>>> Would it be safer to restrict the Root Port's MPS capabilities before
>>>> enumeration so the core logic correctly scales the entire fabric?
>>>>
>>>
>>> Marek, you said that Root Port's MPSS is fixed to 256B. So this means, PCI core
>>> will only set the endpoint's MPS to <=256B. So I don't see a need to limit MPS
>>> here.
>>
>> The MPS limiter is optional and I never saw MPS > 256 in my tests, however I
>> feel that to make this bulletproof, it would be good to keep this check. If
>> you feel strongly about this, I can drop it, just let me know.
>>
> 
> There is no way the PCI core will let device MPS to go beyond Root Port's MPSS.
> So this check is mostly redundant and I would drop it. Also, add this note in
> the commit message since it is not documented anywhere.

How about I keep at least a WARN_ON(pcie_get_mps(dev) > 256); in the code ?

>> [...]
>>
>>>> Should pp->bridge->no_inc_mrrs = 1 be set during this initialization
>>>> to enforce the limit permanently?
>>>>
>>>
>>> This is a valid concern. I believe you should set 'pp->bridge->no_inc_mrrs = 1'
>>> in the Rcar driver to prevent client drivers from increasing MRRS.
>>
>> I will add this one.
>>
>> And I will also re-ask about the MRRS 256 Byte limit now.
> 
> Okay.

This is ongoing.

-- 
Best regards,
Marek Vasut
