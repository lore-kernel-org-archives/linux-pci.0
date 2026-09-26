Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070C26B742;
	Sat, 26 Sep 2026 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790397261; cv=none; b=JSfg57eRi0TSETH/bUa0lJcHjnxx/2PIXJ8Di7tdC4T5Eb6RtvlI8DZr7Z5se7w/xWPZhmeDTtXdJOfeLADqG4qFSdiQUIYYSHFeWBts5e5r/hbXR3R0xtC2QWEtaS5NfXdG47CBPaE9SROo0y6m1Ex4q8CrBdcKEw4uC2WYlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790397261; c=relaxed/simple;
	bh=EeDEawESlDcdhv22Xgc+V2t6DxfBca/df8KEC9OnmmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKre/DWWTUqnq4MNh5yFCRo+QiWS8a5H0lQ4CL8e1+Bh88cNIfCYf0hssm1+UGNjLFZ+SMPeSURPE/KY1liPoPzhV4em9ifHstc1i8dm426hHq35DNFSf/JajCq3wlkaZ3ydikF07PMSWr98+RUk0//xEeivyp3rbictYoujL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MDCo314I; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MDCo314I"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hsF8Q4Y13z8v2P;
	Sat, 26 Sep 2026 06:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790397254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mNruMgEL3fGNghAL1UFG8QVNZq3M8EqHIjf+VgnEkc=;
	b=MDCo314I6VjAPnUo9loq2iA501bua9c83vSGksXe6VM1dXYDJIN/9E0Kt2d2aRZJdkiirc
	1GEVPUyWGuv7T+AWAgJaIJt4H53QSYhsDQTuwNruDwRL4iHw23bNx3zx3rhRxmycg7MAPB
	kYJDrTs6/8AXZpRbW9F+GX7Rfcd30LqBhEi4POGZmNnpnCtsn+3zFgby04o03jbMbNoSso
	AdOeSuceXsY89wRbp+qhBykBMTrbOtLAiP0GVSyYvw+xm97BXytyNlbXCr8yZ637GeHrZK
	fY6hZEwIheRbxj4nETZQslIxoitB5yJA4HnvSxRrrkuOaeuDZIZkkLcTYAi9JA==
Message-ID: <1ae0d036-82a2-452f-9ee8-f7120a7552ee@mailbox.org>
Date: Sat, 26 Sep 2026 06:34:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] dt-bindings: PCI: rcar-gen4-pci-host: Fix reset-names
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260925205158.GA2087943@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260925205158.GA2087943@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d0c00d7916057249204
X-MBO-RS-META: r7hagkew7hpnuaxmaajngby9jaredqob

On 9/25/26 10:51 PM, Bjorn Helgaas wrote:
> On Fri, Sep 25, 2026 at 10:29:51PM +0200, Marek Vasut wrote:
>> Drop maxItems: from reset-names, since the entry already contains items: .
>> Fixes the following warning detected by DT checker:
>> "
>> Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml: properties:reset-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'pwr'}, {'const': 'core'}]} should not be valid under {'required': ['maxItems']}
>>          hint: "maxItems" is not needed with an "items" list
>>          from schema $id: http://devicetree.org/meta-schemas/items.yaml
>> "
>>
>> Fixes: 50b1333e0c7b ("dt-bindings: PCI: rcar-gen4-pci-host: Document Application/Local register reset")
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> I squashed both of these into the relevant commits on
> pci/controller/dwc-rcar-gen4, thanks!
Thank you too .
