Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393D224AF2;
	Wed,  1 Jul 2026 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939151; cv=none; b=kIkj/U29kG3sZxbV5y26fakefcWT7S7UTNipt8kvxHmore9k5hmLC60kiQdTA8pOFpZNHKWmH6E7uN+lIYJXqBikVHOc4z2OXD/2qulQvKdSco6Nf5dx0Jrrzh0eJwloHhutYjyeoAIizdOkUy/ScI2NBehF9mDpGQo0ROcxK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939151; c=relaxed/simple;
	bh=06d5UixropJOx5Wzd+7xarOFInoOx8I+uLprKKrYIr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUDzbtRrwdHB3Q293axbGFkz+52lOURgwTAos09hp0tPBe9RnYE9rLG+UMlu+iXtV3C0tNIvUbimJV91awDi6hLI9UWf2brtFaCWSsjwJJ0C4cqP0jE5XrbHHc+nUNkebeJwRSMNuE928TZvocOaVmCMM+pzX8DvBdGZQrFye5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=geH9T1ar; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="geH9T1ar"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4grBzG4rRRz8tyR;
	Wed, 01 Jul 2026 22:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782939146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tv5Thx4xib2D6u4nvbTd9PHuQp4UEDPoY3zy319g1pI=;
	b=geH9T1arvT8RTmOWz5KdbwFviwOTdh/WRViFR5QKc+jSW/6YrpIe5oyhTCKkx7ZnOQ/JRf
	kzQ9iL8hAlzSCAxaireIkvfa1z5KIp8dTCEGaiGupDPsHH28HHi4+j7wPEdUzc2e4wUbz4
	E/fW0qP1Go3iej80kV3T+MRl0gsy9tFtA2nmKCLWynaVOfEMkS8CEDc2oDtG39Z6dsqQMb
	lcetn1jAsUslp16VJ/vVlELgT4i0CM74jgFPMUIxQEyGmjE70PSgJ1xm+2luUtIzd55VRD
	521wUN7Ebj1Waw8nwaTTQ61nRerjqWZvc8pYzvWPmmaPTXTmH1CF5bq8tM7Hfw==
Message-ID: <5d557687-8c7f-4d96-a9e5-699188faa0e7@mailbox.org>
Date: Wed, 1 Jul 2026 22:42:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] irqchip/gic-v3: Add Renesas R-Car Gen4 erratum
 workaround
To: Marc Zyngier <maz@kernel.org>
Cc: linux-pci@vger.kernel.org,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260618220427.14325-1-marek.vasut+renesas@mailbox.org>
 <20260618220427.14325-4-marek.vasut+renesas@mailbox.org>
 <864iivsuaq.wl-maz@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <864iivsuaq.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 266789d046c87441d76
X-MBO-RS-META: d9yyryhzrw8zw46ps7fhxqzeyyscywhd

On 6/21/26 7:00 PM, Marc Zyngier wrote:

Hello Marc,

> On Thu, 18 Jun 2026 23:02:01 +0100,
> Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
>>
>> Renesas R-Car S4/V4H/V4M GIC600 integration has address width for AXI
>> or APB interface configured to 32 bit, it can therefore access only
>> the first 4 GiB of physical address space. This information comes from
>> R-Car V4H Interface Specification sheet, there is currently no technical
>> update number assigned to this limitation. Further input from hardware
>> engineer indicates that this limitation also applies to R-Car S4 and V4M.
>> Name the limitation GEN4GICITS1, and add a driver quirk to mitigate this
>> limitation.
>>
>> The quirk is keyed on the combination of the GIC implementation
>> and the platform identification in the device tree.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> With the SoB chain issue addressed:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
I hope this is now addressed in V3.
