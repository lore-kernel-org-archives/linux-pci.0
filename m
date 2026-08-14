Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC4418A29;
	Fri, 14 Aug 2026 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692732; cv=none; b=r7reaRjiuypQf06j932U2tNbBtRRvnx05tsfFTnEuVdo1GL28J/zUab/leBGKghcgYXBMeZY5oRQz6slF4UiiyTHDomeW7iS5Z1aZ5y666rCU2M43GlO/0+3S6cMGxlaGBD4cFQPdZv0K9FwUC++OB9nx1r/XAJ4uCu1RIiVy34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692732; c=relaxed/simple;
	bh=MqkTDxp/8qXnVd+GFPAt4lv/oZVBdhlanRag9FkJtGI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o/iiNpcDsK7ifOhXbNLHyUN2pnK09fqwNGSf85lMwxfXZpofRVc9NFKzpX3CdR5JBhFha6cMp2VpQjfKK+9w1sTOHD3fSzSC/e1ja4gPO+QuqmO9S1T1ACZcWHXSXgocqwcXpSSdfd9D3gWpZpcc2PmwiTtjnhZizKDyF6C91v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VZV+t0yd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jy7Fsfhh; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VZV+t0yd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jy7Fsfhh"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id B289CEC0251;
	Fri, 14 Aug 2026 03:32:00 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 14 Aug 2026 03:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786692719;
	 x=1786779119; bh=EPYSxmmnMRKyTN2BMjoGO85koxWbRxQ1smpRMmbGK5Y=; b=
	VZV+t0ydYPTRuUDg8ZBni2vQa6QPQm2JQuFvsGkcjsPDUHYs46V729ByeFP3G7mR
	2L//GrE5tTXJktCx6r0536ELpBOsMwKoKg18qjLcUzVANNAdQYeiGh6UGUyaukBa
	7Z4/hYm3VeU8N9skTbDCPVia+rxrTA+Azb4hp8t8gUzB4mdGvS036SExJe7Nrl+y
	QbqeWmmjdYoldyWAIIhatvlBdG9oXxrpbOZq3rXEOpQLI19gvCeAh3eLaaVta2nY
	9ok9TahzUKW7uVFDfO4RUlHca3bLwFoGgY4FQ2KfWQSoUkcASl63h5CDF5OTD5k+
	w/tYQrDlvZqfk4uO+sKpuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786692719; x=
	1786779119; bh=EPYSxmmnMRKyTN2BMjoGO85koxWbRxQ1smpRMmbGK5Y=; b=j
	y7FsfhhCvqETovnQgi+hDaatMg5EdcS5d9sgrigUczMj9nvl7fE0b7HzIk9hbXPY
	/eDLeRCJMv1RqkerP6C1Pd1So3YZ82sHgulWoec/QCrZPCrIkSPWKPghawrbMlcu
	Kd+CBAUU2iXuoCsBla7iMK75oNrBWbFR2JSyWC5nxcFGcCKnI/rzsnfe8YMLl0qu
	ZQlcgqUXhBIdzg3IzOeAvLqO5Nw+TjCiU+7m82FAtvFRKeuHBqhvOP2KQ9ZP7Cbb
	dXNURiz/DRpfo8L2VjxM1G9Qnk3IMYv0bRwJl+jo56EX6CVJhiJLLuKuKfEPxxYw
	X/leqlHCtg9paZFr+PPfQ==
X-ME-Sender: <xms:asR-apjzegEhbYFW6mKiAN2iu8HGT80KYEpiSyQeBbpJNAhXmtCAbQ>
    <xme:asR-ao0b41O3pR2y2K8xfFFzQclAQQ9UGVmm6Q1Z2sh1uSiKP3dSQ4dOwunZdBKiV
    LUoy0oX-e86M_u3knuDr1k_HaYlnAUYEC1L_SHoErpKCvdbhXhhXwR9>
X-ME-Proxy-Cause: dmFkZTG0OtlspBZbr4RZcO1Rzu1wUeNGWwaFqM0V+cwtwYj4L0XiTrR+8yMJxmDFZ6B9l2
    OLlA53d/9AQnT2QBrkniFswJId1MctwDfIbml38kVnafMWUbei3zeWc/Sy76HFTW67JCbz
    X3NvrQAHO1MTymzeOxYCepwaP+nvSfhR/6lErNXHevR3cuYfhX/sSGo1/B43XOWxv+7Znp
    IrjFKsNqg3cKpy8sVwM+zwn/JcrKSD1WmPurlGrwY/JG/fNiyPXMQxRUocb5NtuGFtSvi0
    yiFRpvLDvgCWFSHjWZ9xyzojheHW/CQTWmjsH4U4IARrtshtFlMS/bQ9pWJKTBsxqwXTOB
    0dxeyH+6DDulGlVfaB53iQCqYYpQ/vkK+wtRwnTRc2joLYf6ZADzcf7wY5B0LvhkoLVitw
    nsZfxYuJEaRUz0JeAdSAJa6l2e0rd9EK7v10yVfhE9PRL1Wr/az5pWyapXrbl6MciD83T5
    LJI9AmEVrHtJWwZcSRnPJvEDfGiBefnty+NTBk2yT+7JZP5h2nipU+UQR3ymHrxFuW+KX4
    n7kLNqvx/Kx7RAPIGu9yW7NcRJ2K9jyiNAHoXhSBUkfT+zcWPJBv5tZCqF++y7qdVckY05
    fqiBd/PXuin9NXk1mFr3UCQiJSvrBFskBgKVmKrdbm+Zgvb6O3rG8tgn9H6g
X-ME-Proxy: <xmx:bMR-aiXdqKhw4U7OqMtOMri9eBclt812FS8jlWHtR5AHPVYtUYXxog>
    <xmx:bcR-arSyW4iymXqHTiB_Jg3smTHrfOIKhnr37UUsUVAqbo5nONxkGQ>
    <xmx:bcR-aqSxdsF3Oam6mIpGEODLvyMKi9NHr_atmGuk6Cz3Ily2J8g86Q>
    <xmx:bcR-ajfuGJzlQHfvB6hK9j9y3k8OIqCeKhySNq7OsZBESBTJJm2dQQ>
    <xmx:b8R-ampoPNN0-awPuTEb7I2fcTbBFHHO1SiKGSvM06NDFjwZ9sH_PNNq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A5D3D32A006F; Fri, 14 Aug 2026 03:31:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoFL_al2QlXV
Date: Fri, 14 Aug 2026 09:31:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Alex Elder" <elder@riscstar.com>
Cc: "Rob Herring" <robh@kernel.org>, krzk+dt@kernel.org,
 "Conor Dooley" <conor+dt@kernel.org>, bhelgaas@google.com,
 daniel@riscstar.com, mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <56aef294-8d1d-40f2-a371-ea3f5ede2ccf@app.fastmail.com>
In-Reply-To: <2026081455-eternity-douche-900b@gregkh>
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-3-elder@riscstar.com>
 <2026081455-eternity-douche-900b@gregkh>
Subject: Re: [PATCH 2/2] misc: tc9564: introduce base PCI driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 14, 2026, at 03:11, Greg KH wrote:
> On Thu, Aug 13, 2026 at 05:29:42PM -0500, Alex Elder wrote:
>> +#define DRIVER_NAME "tc9564-pci"
>
> What about just using KBUILD_MODNAME?
>
>> +static int
>> +tc9564_function_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
> But wow, this is a tiny driver, feels odd to have it in misc/ but ok, if
> you think it should be here...

We have drivers/misc/rp1/ and drivers/misc/lan966x_pci*.c with similar
functionality, so at least there is precedence for putting them here.

From the old days, we still have drivers/mfd/sm501.c, drivers/mfd/cs5535-mfd.c,
and a few others that open-code the on-chip components as mfd cels
instead of using devicetree description.

At some point, we should think about grouping them into a separate
subdirectory.

     Arnd
