Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3903ED5CF;
	Tue, 24 Mar 2026 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352377; cv=none; b=VdMuM8GA/2+R6XeKZthtFaB2iLv+4nogga0gZvKbhnLIr9MbA6u6EMmo3fXSJhCVl6PzmF+BfeTLqxqwDwcKKb4MnubUApopLAEsWOEwBQozbNSeMI9XdnKSGG/GqVQJB8XopLz85J+eiFyUuJw08HFFfkwC/2aoSU/caYTOfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352377; c=relaxed/simple;
	bh=wsd8ayXzwZIf2OvsiCFxKkIRxILOgP6+SHpyFDVmOME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcSCn/uHLB4Gt+n5BHQwBbH9zO34GF4RXB/7lD3mJdlKSzy3I0x0ZuX43ZykVMIjDQR9/mEmT3SNab0riyzctWvQ7rb33xnbwbHApiAtYpnHGsBdQx4sliusbMkMDccsV+7vgXufbFwZbMnZI4RyVf3hSssu8x9RQ6tgee6WrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=S81Fyulz; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="S81Fyulz"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89E9A3A15BB;
	Tue, 24 Mar 2026 12:39:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1774352365; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wsd8ayXzwZIf2OvsiCFxKkIRxILOgP6+SHpyFDVmOME=;
	b=S81Fyulz3eWDvnLEZMjjxxBAFTnizb9Rf0UKcKtl9/U+bcK2JSO+lkMTy/RZYZmCQXtpi3
	DfMOclCgCcsUWo2N7KqQZ865pi/j25ADGEU3kbl27i1U6T667cth3mnBgH2DJMuss1G9Nq
	417CJsWtGluB4krKR9hpXpOJpucC7sq5xoBmoGvaggW/Yp0zSnC99H7pFQS02w6dXwBnND
	wbeeKVFH+sA+9KpGEWjyf96vKoqrz1NVEnrVLk3rDlbqYj/mEr/jSZPEWpSIBaympBAi+6
	bIYzP/ioBqdsEp4CwFRKX+h/iI7ngrqUWgl/g4qv4EDjXA2SNeM3S97Czg8wbg==
Message-ID: <aae953bb-1cf3-4831-8f50-66fb863ddaf6@cjdns.fr>
Date: Tue, 24 Mar 2026 12:39:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek: Add support for EcoNet
 EN7528
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
 naseefkm@gmail.com, ryder.lee@mediatek.com, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 ansuelsmth@gmail.com, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323213854.GA1082060@bhelgaas>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <20260323213854.GA1082060@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 23/03/2026 22:38, Bjorn Helgaas wrote:
> On Fri, Mar 20, 2026 at 09:42:11AM +0000, Caleb James DeLisle wrote:
>> Introduce EcoNet EN7528 SoC compatible in MediaTek PCIe controller
>> binding.
>>
>> EcoNet PCIe controller has the same configuration model as
>> Mediatek v2 but is initiallized more similarly to an MT7621
>> PCIe.
> s/initiallized/initialized/

Oops, thank you.

Caleb

