Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E133D6D6;
	Fri, 19 Jun 2026 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781894346; cv=none; b=U/fjQrSeu7UHQOPv7/IXjpwEELj+MRYOuCKZYLU1vorcYAwKq2UBerNvPBQZoqc14Z9pYsoY5KWWHT2H96sXtLKg3SHntc5bKxQ9b1FOKFWSq5esCaNi/akBC6OLRyRGnjw51g75eCUmng1wefHfaNtpoVlvDRf20guqNjQVEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781894346; c=relaxed/simple;
	bh=tQgin4xqL1aJHnMGss8KRnjOtnhwcWsdrQ6/uPSCTNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny+GmsZYHeXisOOhMQAn8Pzg/xcQ4dIs+cr3bbPuFW+AFzWC3Diu20gn5q0MkHJoLpFSl2tHacq8R0+sxJODpbMIcxrTtfmmTwCAnApW9fPpadj9AyYI06AIlPhS6gJYJhL47xBP/jMNYoo+YDHj7aZcjFE7OEQpsImyjr5lwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaojH6LD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaojH6LD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3081F000E9;
	Fri, 19 Jun 2026 18:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781894345;
	bh=6q6+QsyXfGEG92de2glYz9EexNTcqa1QfzBhVghDvOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jaojH6LDYcKCn3dgewd6r0iMyWhoeXWxbAMY+QaxP4/ZbqH/GB2NKUBzfwy5f0RzY
	 FnZl8AyXeD0at65nDgl9jkmFAocHPKbrt/xMbMP9vBotjF958fYC5YBwMfmnjAi2G2
	 WfdplQTUlF17dHhK6CLdP4X7QzEHDDg5LLNzgoFLV1z1kfqO8LOS2dr99cAGXA/eEA
	 UKd1/snH2MGnB/tzCpxxVOwDIdTn/Cs8sZ3TEDtq+KgubtGT9pAWn9qGwZBEd/z6eR
	 gje/ubuPDZFjosCZd3+Isi8iWTWG2lCUXpVMXuIiTsbV8AmFrsNwAqB9qdaKwGnifi
	 3JeHPsMDxguyg==
Date: Sat, 20 Jun 2026 03:39:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Christophe Leroy <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Dexuan Cui <decui@microsoft.com>, Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, 
	Lukas Wunner <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>, 
	Saurabh Singh Sengar <ssengar@microsoft.com>, Shuan He <heshuan@bytedance.com>, 
	Srivatsa Bhat <srivatsabhat@microsoft.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 00/25] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260619183229.GC2528910@rocinante>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>

Hello,

> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.
[...]
> Changes in v8:
>   https://lore.kernel.org/linux-pci/20260508043543.217179-1-kwilczynski@kernel.org/
> 
>   - Renamed the generic resource attributes from dev_resourceN_{io,uc,wc}_attr
>     to pci_dev_resourceN_{io,uc,wc}_attr, for consistency, and cleaned up
>     resource macros definitions.
>   - Changed resource macros argument order to fix checkpatch.pl
>     complaint.
>   - Added two new macros, pci_legacy_resource_io_attr() and
>     pci_legacy_resource_mem_attr(), used for the legacy I/O and memory
>     conversion instead of open-coding each struct bin_attribute.  No
>     functional changes intended.

Updated the sysfs branch with this revision to get some testing coverage.

Changes here are mainly to clean some things up before the code potentially
lands in the mainline.  No functional changes whatsoever.

Thank you!

	Krzysztof
