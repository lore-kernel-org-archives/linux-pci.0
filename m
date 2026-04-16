Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09743EBF3F
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370229; cv=none; b=WwfxVIE1uW7QrezFZyDyOamuZMOI0r+mD8dVN3RXaRdRhrKYnEwNZpLeerT4D7FNJ5UQTMFWQfJrnzc5hSq0rqUniefPxgLZn+KHjZ3KhNLanfwKDHx51YYM2Bsl9XtrgzQ+VhxOEtIUbqrAzW9mfCNTT0sTlpyBfpYUtwfYjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370229; c=relaxed/simple;
	bh=MkD9DwCcnBIq7Z8T9uV2Y+RpP1RkXdr9Ur81gqG++98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6IjZ/Vi6KZa/VPTXlwWDlY/OwVf1wuZEperLAFdzm4cxOHoXOjQPmGnqbP0IyoNzE+5XF65T2o1P5YN0+UHixOrJCUl6H+K8OZoo8fG8TH7WQ238ValgRaksSYy/vnrAmWWvk5OeZyhHz3OkFOQiG3JmQD+daBdEiuYzqoKELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Kc0QOxXu; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Kc0QOxXu"
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 999462805D4; Thu, 16 Apr 2026 22:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1776369792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7kEVMC1ak29EXqM+Wu5Pvij8q2P6GWJvi8FgJTpEDY=;
	b=Kc0QOxXuL2BFQLFsO7GjaUJhxmGfQHH8B19zYH0Q2vHF1p5QeT4Qt8nRVhV0ngDIaHbdK/
	iz1yhEQweot0ol30xk0V4LPevWZzLwp5O82Hd0uJ/okDjrtanClDdR5OQmPjmNvmWsr65J
	8ezZxWMWOGQFCF4eXu1tDP3Wi+XPhBM=
Date: Thu, 16 Apr 2026 22:03:12 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Mattias Nissler <mnissler@meta.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils] ls-ecaps: Decode DPC RP PIO registers
Message-ID: <mj+md-20260416.200014.48272.nikam@ucw.cz>
References: <20260416125706.3875359-1-mnissler@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416125706.3875359-1-mnissler@meta.com>

Hello!

> +#define PCI_DPC_RP_PIO_EXCEPTION	0x1C	/* DPC RP PIO Exception */

We use lower-case hex digits.

> +  if ((cap & PCI_DPC_CAP_RP_EXT) && config_fetch(d, where + PCI_DPC_CAP + 8, 24 + 4 * log_size)) {

Please follow the indentation style of the rest of the file.

> +    printf("\t\tRP PIO:\n");
> +
> +    l = get_conf_long(d, where + PCI_DPC_RP_PIO_STATUS);
> +    printf("\t\t\tSta: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c MemUR%c MemCA%c MemCTO%c\n",
> +      FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA), FLAG(l, PCI_DPC_RP_PIO_CFG_CTO),
> +      FLAG(l, PCI_DPC_RP_PIO_IO_UR), FLAG(l, PCI_DPC_RP_PIO_IO_CA), FLAG(l, PCI_DPC_RP_PIO_IO_CTO),
> +      FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA), FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
> +
> +    l = get_conf_long(d, where + PCI_DPC_RP_PIO_MASK);
> +    printf("\t\t\tMsk: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c MemUR%c MemCA%c MemCTO%c\n",
> +      FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA), FLAG(l, PCI_DPC_RP_PIO_CFG_CTO),
> +      FLAG(l, PCI_DPC_RP_PIO_IO_UR), FLAG(l, PCI_DPC_RP_PIO_IO_CA), FLAG(l, PCI_DPC_RP_PIO_IO_CTO),
> +      FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA), FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
> +
> +    l = get_conf_long(d, where + PCI_DPC_RP_PIO_SEVERITY);
> +    printf("\t\t\tSev: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c MemUR%c MemCA%c MemCTO%c\n",
> +      FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA), FLAG(l, PCI_DPC_RP_PIO_CFG_CTO),
> +      FLAG(l, PCI_DPC_RP_PIO_IO_UR), FLAG(l, PCI_DPC_RP_PIO_IO_CA), FLAG(l, PCI_DPC_RP_PIO_IO_CTO),
> +      FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA), FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
> +
> +    l = get_conf_long(d, where + PCI_DPC_RP_PIO_SYSERROR);
> +    printf("\t\t\tErr: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c MemUR%c MemCA%c MemCTO%c\n",
> +      FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA), FLAG(l, PCI_DPC_RP_PIO_CFG_CTO),
> +      FLAG(l, PCI_DPC_RP_PIO_IO_UR), FLAG(l, PCI_DPC_RP_PIO_IO_CA), FLAG(l, PCI_DPC_RP_PIO_IO_CTO),
> +      FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA), FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
> +
> +    l = get_conf_long(d, where + PCI_DPC_RP_PIO_EXCEPTION);
> +    printf("\t\t\tExc: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c MemUR%c MemCA%c MemCTO%c\n",
> +      FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA), FLAG(l, PCI_DPC_RP_PIO_CFG_CTO),
> +      FLAG(l, PCI_DPC_RP_PIO_IO_UR), FLAG(l, PCI_DPC_RP_PIO_IO_CA), FLAG(l, PCI_DPC_RP_PIO_IO_CTO),
> +      FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA), FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
> +
> +    l0 = get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG);
> +    l1 = get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG + 4);
> +    l2 = get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG + 8);
> +    l3 = get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG + 12);

Shouldn't you check that the log is long enough before accessing the
first 4 entries?

				Martin
