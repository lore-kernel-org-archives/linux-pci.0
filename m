Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2153396D2E;
	Mon, 13 Jul 2026 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783985249; cv=none; b=l2JQeLboAFaxUR4GLumftDykwsTcBA1mrz4il9d/f0Es1/mk/NyDjRoRu82MoDYsoQDlRP+cFHn3s9qj9KC31PU9v7LMqlMX6xRMenbONUJ7I2TFc+wJQ35v98+yuJlZwIDrCfp+po3XEExcFN8z9Ecf4dgA8b5nsyNVcCzeh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783985249; c=relaxed/simple;
	bh=WTOeZFVwbydTbITC916RTMXGirGA83RvQs9WHFn8m1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4F/4MNQP/kNmfpSfi/+xkaL5i5mmcgUjQ67+4DkBS+ueNPACwlMd4nC1vpWr9V3GDJW2xuaNBPt/XpyfFDdrdZxwmAyvgrEHA3+tMGCMikV/UBXsB+gdG8eKN9k+h9dlkpJ/646OWR6+QFDEXIL3r5VSnZfLaPbP6mCXuZ2TSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FW+MatIV; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FW+MatIV"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gzdrX0VmWzMlPJ;
	Tue, 14 Jul 2026 01:27:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783985244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XH/u9f3n9ze575dKtp+OBjodUyjg/aa/V3GePJcips=;
	b=FW+MatIV82GZ7usqlRMim9OBbQM4Rsy6V89NrvztMMtbJlCy7LJo6DlZaFeYeEe9iNyH33
	ROXKS03mQBvs/OPq4LtSk0ePcJoxNOcaRaAiKfuf/l6NnuLdDWvbSAR3IwKHoHTfVDJYHz
	7Ahgd0WoS8rcSBoLkY5nd0r2Nks/kpOklFHK/2/X2OGQMqQyBz4C7thHddYhJo/1zI+bSi
	DkD1HZB6bVZIkUMdePX8swPJqYiFIttMpLf/iqhJ2xjSjjE/TZJoK/cbqYVJ9XlXMs0SPR
	5NOphRYmYyyKUhNQRDT0wmHu6DtcsTJV+EHCI+bDotLuFHaCihK6TNtCP5TFug==
Message-ID: <2013cac8-d887-4a09-b1c5-6dc9606f16f0@mailbox.org>
Date: Mon, 13 Jul 2026 20:05:38 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-gen4: Inline GIC_TRANSLATER offset macro
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
 kernel test robot <lkp@intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260713175400.GA1258926@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260713175400.GA1258926@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 937e62b771432b11064
X-MBO-RS-META: 1467nai4bxnyrqy9i1zw7971mbwut18b

On 7/13/26 7:54 PM, Bjorn Helgaas wrote:
> On Fri, Jul 10, 2026 at 03:35:10PM +0200, Marek Vasut wrote:
>> On 7/10/26 10:30 AM, Marc Zyngier wrote:
>>> On Thu, 09 Jul 2026 21:10:03 +0100,
>>> Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
>>>>
>>>> Instead of pulling in the whole linux/irqchip/arm-gic-v3.h ,
>>>> copy the one GITS_TRANSLATER register offset macro directly into
>>>> the driver.  This repairs the ability to build the driver on
>>>> non-ARM non-GIC targets the way it was possible until now, which
>>>> retains good build test coverage.
>> ...
> 
>> So in the end, it is either this patch or limit the build to
>> arm/arm64 . At least this patch still allows building this driver
>> with more compilers on the various build bots, so I would opt for
>> this patch here.
> 
> I like the build coverage, but duplicating the #define doesn't really
> seem good to me.  It makes readability worse because cscope/tags now
> sees two definitions without an obvious reason.

I can rename the macro, or ... sigh ... I can reduce the driver to build 
only on ARM/ARM64. Which one do you prefer ?
