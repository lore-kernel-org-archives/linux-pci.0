Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9635A39D;
	Sun, 27 Sep 2026 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790539207; cv=none; b=iy26daYA2b70DDnXokLGqhxf8hVxHIUyyhzIU1KlBJmZFE6Zum3heF574OFaXw7/z9sjnvmGDuv66KAsd1Pah1zX/yb9H73zQbhYoyendTl6xfi17f9h3o+URUapu9wiqi+QLfCQUvDwSv8Iz5L6fCmff6VlWKw6xCqETgrHVcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790539207; c=relaxed/simple;
	bh=I5GmwhcR9dEV4MtTDUzhSc57TT6erNzKqlpqSHAuWLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POlZLTwHUHyDIevwa5nn4+Yk6C4Zsqhgzrmx1DCiFKYO9zqvvgN+BgnG4Cazr4XonKMgbgJWRJ6+r5Owfk1OS+aJbbgwArIGNwRmNcqsISuAHtVPxpN3HxKsmi3sTTbHw+eIul6TLpopSx3juj4LmwFwRS6BNvq0hgRYnQLg4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OTBZXL7R; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OTBZXL7R"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4htFf44GRbzMlrg;
	Sun, 27 Sep 2026 21:59:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790539196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3GpgvsWKyshpzVFnG9ZkXrNBlSawI5/txD9KcqJ8SE=;
	b=OTBZXL7RH1YysOqlopuUr0xIA2u7qMmsR/0tKJ+kMyAcD0f6d7sr0fC1Z6QRG0MHp7rYZO
	twUpIDxcEmHqFl0Q81wRXsgBKiJ0eFjBbHyekHA/ab86c1y+Hc8K70FI8NsUPDJR/CIdL1
	GBuOB5s+hbzVOXVU+CFP8kiwP4rGa8vnRTmSgdNtrajCq0aJdYSjBEMLtufZkzLjGWqZFw
	+Pud2xcM59cXqdshafivTLeKyC+3ZzFMNoblLeNJprKyv9PorbPGP2vo19cnk8LUHR6eHw
	tIJYjH9sQJbpdVweCLmj1AxLNz7+UDtVj4OkFrhBMR7dopc0AdE5qYRJCiyb6w==
Message-ID: <badcd2d5-7d61-426a-86d6-000043a6aa93@mailbox.org>
Date: Sun, 27 Sep 2026 21:59:50 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 02/11] PCI: rcar-gen4: Drop the APP-based link_up check
To: Koichiro Den <den@valinux.co.jp>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-3-den@valinux.co.jp>
 <c2807afc-3e69-4744-8588-20f60839a603@mailbox.org>
 <4peziifkgyfpglfl4jtyvcxqht2yo4r4bswmkweicpxdf45ejc@jxbqgurozlft>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4peziifkgyfpglfl4jtyvcxqht2yo4r4bswmkweicpxdf45ejc@jxbqgurozlft>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: nypqomd6k5cuq5i8h1cykuee7hg4apcs
X-MBO-RS-ID: 46d6c11dbd740c7fa7f

On 9/23/26 4:56 PM, Koichiro Den wrote:

Hello Den-san,

>>> @@ -298,7 +285,6 @@ static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>>>    static const struct dw_pcie_ops dw_pcie_ops = {
>>>    	.start_link = rcar_gen4_pcie_start_link,
>>>    	.stop_link = rcar_gen4_pcie_stop_link,
>>> -	.link_up = rcar_gen4_pcie_link_up,
>>>    };
>>>    static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
>>
>> Can we include some form of the draft patch below, so the S4 Reference
>> Manual rev.1.40 , page 1564 , Figure 104.5 Initial Setting of PCIEC ,
>> bottommost diamond in the figure (smlh_link_up and rdlh_link_up = 1 test),
>> would still be fulfilled, and the initialization code in the driver would
>> not diverge from the initialization sequence listed in the reference manual
>> ? What do you think ?
> 
> If always relying on the PORT_DEBUG1 check instead of the SMLH/RDLH check does
> not introduce any regressions, I'd personally prefer to keep patch 2 as-is
> because it keeps the code simpler. We could just add a comment noting that this
> link-up check diverges from Figure 104.5.

I think the SMLH/RDLH does behave slightly differently, because those 
SMLH/RDLH bits are set and latched in, and they have to be explicitly 
cleared. The DEBUG1 bits report the current state of the link, which 
might (?) be susceptible to bouncing (link going out and down in a short 
window, but ultimately being up) ? I am not entirely sure whether that 
might pose a problem or not.

> That said, I agree that in general we should follow the R-Car reference manual
> where possible, and your draft makes sense for that purpose. If we go that way,
> I have one question: would we need a polling loop with a timeout
> (PCIE_LINK_WAIT_MAX_RETRIES * PCIE_LINK_WAIT_SLEEP_MS) in
> rcar_gen4_pcie_start_link(), similar to dw_pcie_wait_for_link()?

This is a good point, and I think we probably shouldn't do it this way, 
because we can reuse the DWC core code for that purpose.

How about extending the .link_up callback, and check both the SMLH/RDLH 
bits there (to fulfill the datasheet compliance, dw_pcie_start_link() is 
always followed by dw_pcie_wait_for_link() which calls the .link_up() 
callback) and the DEBUG1 bits (to make sure we check the current state 
of the link) ?

That should cover all our concerns (datasheet compliance, DEBUG1 current 
state of link check, polling), shouldn't it ?

> P.S. I'll rebase v2 onto the latest pci/controller/dwc-rcar-gen4.

Thank you, and I apologize for the inconvenience.

-- 
Best regards,
Marek Vasut
