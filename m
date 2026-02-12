Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EFF2E0916;
	Thu, 12 Feb 2026 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939577; cv=none; b=SaF0xudh2z1mszhI0Ey6EHjgjZ9ku7cFUXOj0aa/IHr429LXPbbs+a4gvBAublGQxRPHHbc8dufMNXKKV71tMvmq7mTSoCnuFBzSI9aPGu3pMOgg3DMOIltmrfk39G6kHptokU5usPXbP1GDFMy33Ii8LVPHHOD96oHq3+kZflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939577; c=relaxed/simple;
	bh=MHkyUcytnOGwmc4gr6wYSkPIL7Wqdv4CCDQbJLkpkLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q40lyhFiONUQnfeuHrMxFtRvBKScxcxnXkkZD8VuKEWINokX7UkR4yHmEAdjpcwpMfzLPZoar7DvIyD8o/v7DRY8AIq7SqXXeatqHddi1rTz3jfJvIoT6D9AkwDVkeEwR/lC6HKlcuOwSgmrhkVRuZX7FWFl23LDBZyY43Qjt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyGn1kke; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyGn1kke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C7FC19422;
	Thu, 12 Feb 2026 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770939577;
	bh=MHkyUcytnOGwmc4gr6wYSkPIL7Wqdv4CCDQbJLkpkLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CyGn1kkekhGLDXI/BUD11YN1TYvHXZxZ1sw9zJtxbqnowimXip9YHyAsFQd1AtJiP
	 nLkKvvuej5PYl63Nh3anLbCLn+tvfzdOVrc1IfGKcWF34BZq4fISEJt094KyQP9B+w
	 AsA8WIaGnZngCih/YbBBSzSqWAAP6JCvQWxAGVr4Q8n7Wfrc/PYygrng3y/g31D8LZ
	 1hxhNVd95yR8jQjq3esnQJkbrCJ2ANykrzbjQsDf+NiihSZri/UI1KvQ+26Mf5xOfJ
	 XGAgUi4V1QNhAKR1kdggaiqDx5HfKtY5Ch4GA3F+EhelFdtbmr0VJ8hyNChuZCoTbl
	 MsNh1nycg4/9A==
Message-ID: <554897dc-1cd6-461d-9248-cc491b984a9e@kernel.org>
Date: Fri, 13 Feb 2026 08:39:34 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
To: Arnd Bergmann <arnd@arndb.de>, Niklas Cassel <cassel@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260211070812.4087119-1-arnd@kernel.org>
 <aYxGR-x3lGt7H1dp@ryzen>
 <8db96e1b-2559-4966-87d9-171854c6ce19@app.fastmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8db96e1b-2559-4966-87d9-171854c6ce19@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/26 18:37, Arnd Bergmann wrote:
> On Wed, Feb 11, 2026, at 10:05, Niklas Cassel wrote:
>> On Wed, Feb 11, 2026 at 08:07:40AM +0100, Arnd Bergmann wrote:
>>
>> However, I remember that you Arnd was one of the main reasons why Kishon
>> decided to use configfs to configure a PCI endpoint controller and to
>> bind a PCI endpoint function driver with a PCI endpoint controller.
>>
>> I don't know of any other way than configfs to bind a PCI endpoint function
>> driver with a PCI endpoint controller.
>>
>> To me, it seems a bit silly to be able to build PCI_ENDPOINT without
>> configfs. What should a user do with a library that they cannot bind to
>> a PCI endpoint controller?
>>
>> Why shouldn't we just do something like:
>>
>> diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
>> index 8dad291be8b8..d6f898094509 100644
>> --- a/drivers/pci/endpoint/Kconfig
>> +++ b/drivers/pci/endpoint/Kconfig
>> @@ -8,6 +8,7 @@ menu "PCI Endpoint"
>>  config PCI_ENDPOINT
>>  	bool "PCI Endpoint Support"
>>  	depends on HAVE_PCI
>> +	select PCI_ENDPOINT_CONFIGFS
>>  	help
>>  	   Enable this configuration option to support configurable PCI
>>  	   endpoint. This should be enabled if the platform has a PCI
> 
> 
> I think at that point we would instead drop PCI_ENDPOINT_CONFIGFS
> as a Kconfig option, since it is never user selectable. Otherwise
> this is probably a sensible solution as well.

+1. That option is mandatory, so it is not an option at all :)
If PCI_ENDPOINT is set, we must have configfs.

> 
>      Arnd


-- 
Damien Le Moal
Western Digital Research
