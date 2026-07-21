Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB1318BB5;
	Tue, 21 Jul 2026 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638296; cv=none; b=QlzRPHKBgqZWnlgTuvqc9xIf79y3QknI9YMGArU+hv1VVQ7kIvtwNua7VvKeKRL6YFyaq/b/UCI9uXq1sxRbXWGGe7k0yUoec/jYhsFILkp1ClZYXRqenlkD23z7b+QKh6c6hdXEBQMPNhkYYTH7XXqric5kLcgwDnGfxHzUvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638296; c=relaxed/simple;
	bh=jCB7YbkWN3TspUQvbkljppsVjyomSGKQ22IHa6F1tKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aljmb20IHWT++0QYGE2paihW0ZY1u9ZsnmKznqMHdjdbPwxzMAnpRRp7lf06cvDyJCRV1GhC0R1KttYWzTe+ntPtb+m4aPAwQolWo3aTIJBAmbSl8JX3ZMvyhnv3gWFN6dSsZ+8tFuiIMJl9kXj5+/xVV2G2hl05fUFxX0PKzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=VCzThVGy; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="VCzThVGy"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA4F449398F;
	Tue, 21 Jul 2026 14:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1784637854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cy3T5pzemSqkA0f9i+O7t2E/ky0Z5/5xbdxpitPxq6g=;
	b=VCzThVGyow8jXMatQb36WOM2wmWW5BsSDJSXOGXvMDCjFlKx1+qbqwW1TUdleo/WjqTiIA
	C/VqYpqpho0lDM+l894mAI6UFHz56QcquWQ9URbt/flESC4pzDApujDg1y7JxTg7Pp7mXL
	lckpw6VYybigTDzhxoF1LmKk9afW1O7fwLRIUxT1L4XFmyoPHdCUzlVzkjmEhbtqywtw2z
	QNrHTgnWPqUQnCDplwLuQohsbwsQc/ZxykVNRe8fVSIVavSBlUjyLCATvwx8Jb3D3w2XsP
	BbRwQg16bTdS7lrHtIx+BAIcMZaWSf49IEG3pv0/XOmoOl8yib77DK/Fz5pgRA==
Message-ID: <54817618-9086-4c0d-a871-2bc4f83934be@cjdns.fr>
Date: Tue, 21 Jul 2026 14:44:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v11] PCI: mediatek: Add support for EcoNet EN7528 SoC
To: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-mips@vger.kernel.org, naseefkm@gmail.com, ryder.lee@mediatek.com,
 helgaas@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 ansuelsmth@gmail.com, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260702150704.265282-1-cjd@cjdns.fr>
 <178412364176.146277.15805522323299213700.b4-ty@b4>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <178412364176.146277.15805522323299213700.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 15/07/2026 15:54, Manivannan Sadhasivam wrote:
> On Thu, 02 Jul 2026 15:07:04 +0000, Caleb James DeLisle wrote:
>> Add support for the PCIe present on the EcoNet EN7528 (and EN751221) SoCs.
>>
>> These SoCs have a mix of Gen1 and Gen2 capable ports, but the Gen2 ports
>> require re-training after startup.
> Applied, thanks!

Thank YOU for all of the help getting it over the line!

Caleb

>
> [1/1] PCI: mediatek: Add support for EcoNet EN7528 SoC
>        commit: 2077ccb9baa2cbbbccf5f0d8c2196dd9d5e43399
>
> Best regards,
