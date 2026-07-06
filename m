Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F5397321;
	Mon,  6 Jul 2026 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360114; cv=none; b=CUzJAG8qdGBCdbRBDitUWHLYcPICRBA/CXNAjINnA847MCgsnx2RI2ls0LX0ntyj3EIrvscP0XyrB5x2SRvH08pF0soukdjarAwhSZRO/c/3RclW4WlNDUuhvA0wNSsMKua2J/Pz8DIxDfS3iL9EpvATe3T5Ht3a18p/9O5sZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360114; c=relaxed/simple;
	bh=Wq90EMgmt7e+14JVuA7NauCmDOqQOOv/GI10NOV1uGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2yWXuJBGXXNV1HNu4LWuayDL6SZFo2bi9+cJisenLB2hGMmK+ba0U5rfyQ2SCKTbVV3JCQgZY5bZO1Q3XooKD/HY/7DeE4LrzCQYfS4bRokhp9VpCRBk3rp4l6Z8/oAO0df6sgjFt6+CfgpJUdo7L6Zp2unebQ12LDb59cROYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xD7HUIFR; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xD7HUIFR"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gvBfj46F2z9t7h;
	Mon,  6 Jul 2026 19:48:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783360109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8jDaRtUMpq8g1D3hT8OlSV4lyB+CYZjnq+H5npk/3eI=;
	b=xD7HUIFRn6NMjBZsXGtVyPlCDmZNKasa/C9msk50NPO4X4l7LU7rQU4MPcqv3N9g+LB3x2
	eYAryU0gh6H3NgPtEftBa6qZagMkA6RCl/RDfUm7kQr/R8aIZReLuRw2vnc4Xgpx8F4U+6
	jzDEjR+SVW879/WNxtuBIrLHXb/ydXNpUrIWWn1Ot2dOdFN5nYWzFkIS85vd3GRr1SmoEW
	ap3zCqqf3mbwQEniT44tV0PX+kIT1GQalIC46P+kI8P0WO1lLWTP197tUApdn8POJcPH98
	f0UdFlPsdcx8PD57KCpRl+6NdG7NcGSabvp7ao5W2kPqB4aeDC7z2LGJzItjfA==
Message-ID: <8a921ce9-e339-445a-af05-d20f9f2df01e@mailbox.org>
Date: Mon, 6 Jul 2026 19:48:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/5] PCI: dwc: Determine whether iMSI is used before
 calling .init
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260701203918.63189-1-marek.vasut+renesas@mailbox.org>
 <20260701203918.63189-2-marek.vasut+renesas@mailbox.org>
 <4qyn4fljtb3cbzcmfpkdomkm7vqnwn2rfbtqng4iwmtvfd4bpj@t6kkw53erl7f>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4qyn4fljtb3cbzcmfpkdomkm7vqnwn2rfbtqng4iwmtvfd4bpj@t6kkw53erl7f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8koqiwhmrec16pchxx9cd39q3zdejbz7
X-MBO-RS-ID: 805b02712b98a9c1cea

On 7/6/26 6:43 PM, Manivannan Sadhasivam wrote:
> On Wed, Jul 01, 2026 at 10:37:44PM +0200, Marek Vasut wrote:
>> The R-Car Gen4 PCIe controller integration configures MSI registers
>> in the controller driver .init callback, because those registers
>> have to be configured while PERST signal is asserted, and the PERST
>> signal is asserted across the controller driver .init callback.
>>
>> The registers have to be configured differently in case the iMSI is
>> or is not used. Assign pp->use_imsi_rx before the controller driver
>> .init callback is called, so the controller driver .init callback
>> implementation can use the pp->use_imsi_rx value.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> LGTM!
Thank you. Can I get AB/RB before sending V4 ?
