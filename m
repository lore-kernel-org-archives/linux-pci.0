Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4121FF2A
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781452089; cv=none; b=KvQJQq0N9GDSX/GmRbO/E56h475OtPkKYkVe/wOmcq8ecEZ49AWeDSoZYsSWPtxfzx483uTOzfqKw6QpYHZjFnRQ5IAKxRd0I1LHQ/cMb6q1hBelZ6fRvzb6LoKfcDuvf9VD40E2JIRpOELrFp6TqvA8/O2Mm9Bo8KrG8dntZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781452089; c=relaxed/simple;
	bh=7ljN951+yrvzpRzCkdNLmP+YBgbxuqOgHyk9eRVIRyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1+enau/y85EFVl3loCXUXVrzVR1h/JiOmTXe7GKogrqtX/bGmrgmayQZefc7qmvHmJwsdYg0hXmzjFmT3jTaq4QSn+2e1jwZuli4ZSFVzJ6NfUvuB8g4onQCj0aYGxEVTtSXeOBUhG/Xx9zAb6Qv9p2++2CTiTP1pgpmLym6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=waAHjGSu; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="waAHjGSu"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gdd1w3cCRz9v8h;
	Sun, 14 Jun 2026 17:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781452084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McoUIjsKPHtZi5KvuqzV+sLbmA0DFe/thhJqN7aTTro=;
	b=waAHjGSuLgP3p7sHY/SLNxNiFG2+AMSoXODjfu9S2qG58OecStm+bhU+EFrJZ2vTClU9FL
	eL11R8GE6ooI0qjD1unFEKgmq605nxpUgpJYu1E6v9k8MDLk59MbrXkZaZtDytpRy20sC8
	QFtDvrrIUeSQkDrsFKV6lbJuwkYVe4XPR37vQygG3T/0xjUXWDsWJ5ipFq/OQEV6xzpZJ/
	uu3YO8EQ1OCCJDSeIY/FUGpmnnqyqJXM77mgWofOsJPUoJiV3ZXXuC/64PLesUO2Cfur+P
	7neuXru96MT/6FXZk8jdHCjZcabnZpMx0QSvtZ27FapK0dFwOo2TBuODGqXzSA==
Message-ID: <f27eca90-adb4-4fcb-b97b-54a2d06b8a04@mailbox.org>
Date: Sun, 14 Jun 2026 17:48:02 +0200
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
 <14888440-fb68-489e-b894-e90df4c32fab@mailbox.org>
 <ltenx3sxptnzkut6z2xkpv6lpkp5qyzoutf2lqgua5hperr7hc@54ligpf2cdjy>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ltenx3sxptnzkut6z2xkpv6lpkp5qyzoutf2lqgua5hperr7hc@54ligpf2cdjy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 990c6c1b0e336d0c075
X-MBO-RS-META: 16umeqanq8qnpus6eoqwc7p969h49tua

On 6/14/26 8:22 AM, Manivannan Sadhasivam wrote:
> On Sun, Jun 14, 2026 at 03:56:42AM +0200, Marek Vasut wrote:
>> On 6/11/26 7:59 AM, Manivannan Sadhasivam wrote:
>>> On Wed, Jun 10, 2026 at 08:50:58PM +0200, Marek Vasut wrote:
>>>> On 6/10/26 7:11 PM, Manivannan Sadhasivam wrote:
>>>>
>>>> [...]
>>>>
>>>>>>> +static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
>>>>>>> +					struct pci_dev *dev)
>>>>>>> +{
>>>>>> [ ... ]
>>>>>>> +	if (pcie_get_mps(dev) > 256) {
>>>>>>> +		pci_info(dev, "Limiting MPS to 256 bytes\n");
>>>>>>> +		pcie_set_mps(dev, 256);
>>>>>>
>>>>>> [Severity: High]
>>>>>> Will modifying the Max_Payload_Size locally in the enable_device hook
>>>>>> desynchronize it from the rest of the PCIe fabric?
>>>>>>
>>>>>> The PCIe specification and Linux PCI core generally manage MPS uniformly
>>>>>> across the hierarchy during boot via pcie_bus_configure_settings().
>>>>>> Because this hook runs later during driver probe via pci_enable_device(),
>>>>>> if the upstream Root Port or Switch retains a larger MPS and transmits a
>>>>>> TLP exceeding 256 bytes, could the downstream device drop it as a Malformed
>>>>>> TLP and cause a fatal link error?
>>>>>>
>>>>>> Would it be safer to restrict the Root Port's MPS capabilities before
>>>>>> enumeration so the core logic correctly scales the entire fabric?
>>>>>>
>>>>>
>>>>> Marek, you said that Root Port's MPSS is fixed to 256B. So this means, PCI core
>>>>> will only set the endpoint's MPS to <=256B. So I don't see a need to limit MPS
>>>>> here.
>>>>
>>>> The MPS limiter is optional and I never saw MPS > 256 in my tests, however I
>>>> feel that to make this bulletproof, it would be good to keep this check. If
>>>> you feel strongly about this, I can drop it, just let me know.
>>>>
>>>
>>> There is no way the PCI core will let device MPS to go beyond Root Port's MPSS.
>>> So this check is mostly redundant and I would drop it. Also, add this note in
>>> the commit message since it is not documented anywhere.
>>
>> How about I keep at least a WARN_ON(pcie_get_mps(dev) > 256); in the code ?
>>
> 
> That's fine.
OK, done and comment updated.

Once I have input on the MRRS, I will send V3.

Thanks !
