Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43D3A3E7F;
	Wed, 13 May 2026 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701661; cv=none; b=A9mCTPlfowRVB3fIOCAlg8N1r9K2sNZBq1IIeVl5yLyXr7YGsDnNiuSp8DOxWhtnarPHJH65hRUXHkviVsfXg1lBwaDZSHKXeK3NtCZUdDb+PlaZFXTaN7wq2ujAflEO9QyAKmHrq3V+pTQ8du+kymcOEMyNCMhzUiFI2lLJTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701661; c=relaxed/simple;
	bh=rrQKK03WIh8RzNQzNNWa6G/QbwuSw5FsrXzHFJ5OZP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSoTupyHG5TWp0Stf8ged59Rf/4+hFqqCjMXBMi89xU0rjI1A0dKj5eJwvMQM8q8BSkcq5XbaN3nt7Rrt3++7Rn/hTnoCpuWNg2VhmRMzJ5f8083idwKsbcrf/u7Ll2pyza8m3ADEQHffN5r/cShzktvQ/mRXvV6tP9CJzQ16u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bN/HiWZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bN/HiWZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9F0C19425;
	Wed, 13 May 2026 19:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778701661;
	bh=rrQKK03WIh8RzNQzNNWa6G/QbwuSw5FsrXzHFJ5OZP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bN/HiWZfchkfVCMz6r6hXBjLdJUzCz9l8i5iQi7jF9IRwIfKnQOCND+WB6AnKmgGm
	 eRJMCB/EALxc12F6qoqhfFRIwTqmLdARf/fEAMkWptJ29Dn7kmlcE0Ulktb8iRsxZi
	 8KIlACcQDULnRO+SfGm1LEIkexQysdDzMsMwMl1BbT+6kaQTKhiECjfKeqwZVmYDaZ
	 StbCV5ENh+L1X2N1p4+7asgk5QNNMxVRmrwbzv6ejlagd9R+ifoCsWh/puaoWFhbhz
	 lSFPfwQY210eF2Ti7QxWycBNlMrl9iAYNyOKEOFF1X/aOQdOddnCt6lwFDwPQrGJBc
	 x5z7nLd7yXnpQ==
Message-ID: <16e82bc7-7c19-461a-8c5e-9dfc5e91a2b9@kernel.org>
Date: Wed, 13 May 2026 21:47:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
To: "mani@kernel.org" <mani@kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
 <20260430050954.3467984-2-hongxing.zhu@nxp.com>
 <20260430-proud-ammonite-of-gaiety-abaafc@quoll>
 <AM0PR04MB52202A13D528B3AE16C3616A8C352@AM0PR04MB5220.eurprd04.prod.outlook.com>
 <55258a51-9cdb-451c-be06-74b9b3020cbc@kernel.org>
 <GV2PR04MB12019F5425D6EB9AE52FC32CE8C3C2@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <t3d2s6rl25ywobis4xiwwdvjrccua2qrpwfsxqpvp6qw5pzofa@kjm4wzcpjcli>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <t3d2s6rl25ywobis4xiwwdvjrccua2qrpwfsxqpvp6qw5pzofa@kjm4wzcpjcli>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/05/2026 15:26, mani@kernel.org wrote:
>>>>>>
>>>>>> These interrupts are optional for existing variants (imx6q, imx6sx,
>>>>>> imx6qp, imx7d, imx8mq, imx8mm, imx8mp) to maintain backward
>>>>>> compatibility with existing device trees.
>>>>>>
>>>>>> For fsl,imx95-pcie, all 5 interrupts (msi, dma, intr, aer, pme) are
>>>>>> mandatory due to hardware requirements.
>>>>>>
>>>>>> This introduces an ABI requirement for fsl,imx95-pcie. The i.MX95
>>>>>> hardware requires dedicated interrupt lines for AER, PME, and
>>>>>> general controller events due to its redesigned interrupt
>>>>>> architecture. i.MX95 cannot function correctly without explicit
>>>>>> interrupt routing for error handling, power management and link event
>>> detection.
>>>>>
>>>>> fsl,imx95-pcie was added more than two years ago, so how it cannot
>>>>> function correctly? Are you saying that for two years you had here
>>>>> completely broken code?
>>>>>
>>>>> If this wasn't tested for two years, how can we believe anything is tested now?
>>>> The basic PCIe functionality has been working since the initial
>>>> fsl,imx95-pcie support. However, AER (Advanced Error Reporting) and
>>>> link up/down detection were not previously enabled. This patch-set
>>>> adds and verifies support for these advanced features.
>>>>
>>>
>>> That is not what you said in the commit msg.
>> Hi Krzysztof:
>> Sorry for the delayed response due to a holiday.
>> After reviewing this patch-set again, I'd like to suggest an alternative
>> approach: would it be possible to mark these newly added interrupts as
>> optional?
> 
> Yes, since even without these interrupts, PCIe functionality still works. Only
> issue is that it cannot report error and recover from LDn.

Yes. Please mention how the hardware or SW implementation behave when
these are missing, which is then serving as proof why they can be optional.

Best regards,
Krzysztof
