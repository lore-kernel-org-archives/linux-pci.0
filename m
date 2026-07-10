Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BB35C1A6
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716351; cv=none; b=ra/SFGRunkn4g2CheveIeBYyWAHehMY6/hWbAKi5oBX119Lc5FsSuWL6qWSr6ksm9jWmHXazb+TMwM+gZXcl6LCF9lXhNdFaSRdxA5Mx/L5ODfB51BWynt17X8OaM+GeCN8pj04Th+X+FEE9l+ldIbz1qATzN2WtJckjqbERSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716351; c=relaxed/simple;
	bh=a/5D9uvy7CE+nh22S+ywojXZ2qCzycGH3eQNAiYVPr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiiAyaBB9qtqMWzLagHulrvmuPUDx5y/8ubJHLPpJtW3IOXEZWdw1U8xL5FJjTuwodCVuy2xeZBi50YvGzqJ+2qmc2M3Wlwxa+Z5kK2BfMYkPIkcFCfAbRKBZzgGrrhVwOyx68iHFDBhancRrNyDPsXf0gAnmKYuzW2oq1F6Nvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=I+PQROLR; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I+PQROLR"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gxkPP1qt7zMlGZ;
	Fri, 10 Jul 2026 22:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783716345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yA8DCPfNfFl8+NUMRg0Pw5CP9XWsu7v/HiAVvMGc+WY=;
	b=I+PQROLRgG0bWaoVw3QGLu3oFm6yg9BXG6+k8y2qzstxsqYmPpCEKCCLMwrGfHRhU9UZXR
	GE+tgsvgA+Fz6ywxF8B1GsCJhNkyv+XdNRZR04HCk13KAZBzjR+nIOsA3v/ho4UgBKv2Zb
	RBotEJv5atdsFR4DrjjuRWO8snx70w/qUuPeauhCGoHFr7ZDeDOMvdQ7JPuNqPLm6WAmyp
	M6TtkFrIIl0gfUtvMpY6aS7PdkE+jd3v53RpefYuMsFxA9RN9CIljm5sK69VwPYcT+7Kak
	qzAJBYu3qZ+UJGphGz7JgXDDbz4NdT4EpErTY8P9TB/dpO/izjeYUILO0FP3fA==
Message-ID: <a3b46640-f5ff-4189-bf1b-fdf1cd873493@mailbox.org>
Date: Fri, 10 Jul 2026 22:45:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [pci:controller/dwc-rcar-gen4] BUILD SUCCESS
 6bd0f589488396d14c4d9e4f030954ccc2ee4f93
To: Bjorn Helgaas <helgaas@kernel.org>, kernel test robot <lkp@intel.com>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
References: <20260710185046.GA979125@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260710185046.GA979125@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d4224a42b44dc981b8a
X-MBO-RS-META: 4orzs49kz6zf5kn1b5rczipnaqqnxtcr

On 7/10/26 8:50 PM, Bjorn Helgaas wrote:
> On Sat, Jul 11, 2026 at 02:32:33AM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
>> branch HEAD: 6bd0f589488396d14c4d9e4f030954ccc2ee4f93  irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround
> 
> I don't think this "BUILD SUCCESS" is accurate.  On x86_64, defconfig

Indeed.

> plus all PCI drivers enabled, building this same commit:
> 
>    01:42:29 ~/linux (controller/dwc-rcar-gen4)$ git --no-pager show -s --pretty=format:"%h (\"%s\")%n"
>    6bd0f5894883 ("irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround")
> 
>    01:42:32 ~/linux (controller/dwc-rcar-gen4)$ make drivers/pci/
>      DESCEND objtool
>      CC      drivers/pci/controller/dwc/pcie-rcar-gen4.o
>    In file included from drivers/pci/controller/dwc/pcie-rcar-gen4.c:16:
>    ./include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: asm/arch_gicv3.h: No such file or directory
>      605 | #include <asm/arch_gicv3.h>
> 	|          ^~~~~~~~~~~~~~~~~~

Please note that the following should address the build failure:
[PATCH] PCI: rcar-gen4: Inline GIC_TRANSLATER offset macro
