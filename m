Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E814848A2;
	Fri, 18 Sep 2026 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710422; cv=none; b=PeH5OMhVh3AiP+uaN/EaYodBiXWBH9NeDulyIKl/JG2jUr6DYT8LP8gR4YfWuowr2HnNaEPinxz/4ajjmEjKB2tI8efnv1JkiUFq4AdYMiXzp8nwcTGKoApNkZQj1dQfwS1AiOU8E8lY9L3x+T966U+bYud3pvW7LyQRd4Jgj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710422; c=relaxed/simple;
	bh=krSGbGiEbDxXzAEfj6+tgz7u+3qEseaxnZFfxWuJsOg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OK/xq8+9d541n1GGuVnw5iqkmYEqu0SHlb9tl0k2UGrqlVi6ZZjFtE/PPNHKfhX5QTxSN18oZ/gET5QOlucyThgP+2yku4s8k5ZniCGFRQQkPRT8oYWc2mnPSs1WQLmZPr8wr/R64Tv2p2RY1aN8FGphJn6U2R7kP5aoNZ1C1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=c5GHBC89; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cwrMGDmH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="c5GHBC89";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cwrMGDmH"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 75A69EC01E1;
	Fri, 18 Sep 2026 01:46:55 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 18 Sep 2026 01:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789710414;
	 x=1789796814; bh=vOQuQl4xHHsYUfV8IRt8LMVoVN43GEAALICbdkpOnwk=; b=
	c5GHBC89/s1hAHxNTUo8NCa7NKYdQyoxRykEfZyL49V+tNXU7S9IqENKUYYogY5u
	TrXxouQNJk+/ukGxgr9NknzN4BSCVi1vpR5efoqRYitejvjK5tf743bZF0XTTM5b
	dfX//JrDEeE5kPvJDagxX6DXDe4zxVABUUkjfL1SunTFEHESuilyakwK1n16zAUp
	r6e+OYfP4iuiBOgkshONPsKeF6230D4P0KYhQy0qnMmgGMC4uKaQgLn0L48LrOvc
	hIsOk5RZsp63UWcHkqEu0F1d4CSDeel9tcqqW7l4vNuMPDf/tEXBOFV3gOHuCUnk
	32DSwwP7YEJQzAso3MYmig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789710414; x=
	1789796814; bh=vOQuQl4xHHsYUfV8IRt8LMVoVN43GEAALICbdkpOnwk=; b=c
	wrMGDmHD5MmmDR3xs+YhVGGiybgFiVCH2vZ3SUf6aGtZhku0SSlYJH4/ErgJAuRj
	+1riSm/EamIGfl2Fxk8IOBX0Ac0NZ7Kuk1uj+LEg0V4dz9lnUkdlCxf3d6OsOk1q
	bzyPK0GWEzNoQi8A4zRdyAsVyVRi8vOe0HCc1f6ogix1AqTyOWjI4eEL8JYR8Ykc
	VEWrtwTVVCj1o2QJSDaB1W44kjc91ODT3+bfttEquCcj8jFsFOI37NsnRC9I7kFN
	SdBZRvi9dI45VMSbkXpefayq/qcn9Zgig5+h9E0bHJXvPNShF1I7HXo5rZEc369+
	3bU/wPioWzRe6rkWUifHw==
X-ME-Sender: <xms:SdCsaqg2_UVmxD2QC5Nl2F_uy1ndELKzOzO9NrVLSZd_p-m72Fs15Q>
    <xme:SdCsal0JWjpPUeMlNTQQET40FqTB2xpfDqCtdn88KlU-a9xFi8kTpXAXITIgvCC5d
    iJaLo9lWWbh9eatrF1hwh4vkHZcgFy60t8vE2W5fgNCT07r-WuwTU1C>
X-ME-Proxy-Cause: dmFkZTEYtRs0FMD0kTrhm17Art1N+H9Q4KIvT46UAFNPk7EDAm27bGjO2gB+rUw61KBpBc
    N/NOlpeBwTJV750SUVWhoqe465YW3OhPE7ybCjaKfhhSTQ4cUuPVRuWZUngKUruwRfYPn9
    /XKe+EiuHME6hif9UgDmQbEBUuXsGNOhyLiaHh06uObloHDh25jR69e4gfWbsYm6eCWiHT
    dNV1zwF3UIrYSoETX4EuMxaifvVZN9qCTQUsDFHwddpmb73lMFQKpKZt4Dev3MfR1hjD/s
    3Nzcoj6FPHAB02qFpS+loscNni7+4WNKnkQgBlDhkALW950KBLdQp+nSxBfGxU+w4gKbUO
    lycrwjZI3E2Ow/DqbTPEoj0glfcAtS/ADI91hAAjgMzku4/Yrwq+TDybw2h4OQ0KMzQTO7
    Ygu5W7hUt+fMR1Kg4c20ZSUsRKwFDVIwYE/oV+OmvzHeMr0bNkEC6JM6GDcZ417Ggk7IPb
    H1pOVj/4NAxHZ8+uK3SXL/w2xDr5mOo216qo3rDCJ60kQS4rp8K5yngJ1OVPEw/5D1eEpW
    nquPZMFIek4tpY/7dMK/RSTrbpQkNX89VvrNg/iOCl6jc5qoywlsSE/KKI3gIF8BEeB+Rp
    1YxzX7lycbnVGxe98b1dbxC9e4gIGw6G3u37DfyvlkTopr0wQ4s9mSUok7kA
X-ME-Proxy: <xmx:S9CsatF_qsk182wVJpA3lz2o5A86ug6hxGSGoe4pw0axhv3WJvd2hw>
    <xmx:S9CsarHNQrxA4dRP0cfZ9gtrgUIB4sGD0VXyO4dUVxEwfSFDrdTVLA>
    <xmx:S9Csat25CZVD6B_6lfV8t9NTEaEH4FWkTplIPkxxJwgAHIrN7_nCOw>
    <xmx:S9CsaldI95E6jk_5DVgVZLec53xnYDNQg-cFBbIQbHRoAc5cCWwPTw>
    <xmx:TtCsaipDFXDBPFz1X8UV0J2_D3uxYHL49Qb4-3inkgdWZNJehpr46lvW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3822632A0084; Fri, 18 Sep 2026 01:46:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1v-knPnKEnN
Date: Fri, 18 Sep 2026 07:46:28 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Semih Baskan" <strst.gs@gmail.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>,
 bhelgaas@google.com, "Ray Jui" <rjui@broadcom.com>,
 "Scott Branden" <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Rosen Penev" <rosenp@gmail.com>,
 rani.hod@gmail.com
Message-Id: <8f36b2ea-38e0-4b57-86c9-9efef8fa8fa8@app.fastmail.com>
In-Reply-To: <20260917214801.GA1054958@bhelgaas>
References: <20260917214801.GA1054958@bhelgaas>
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 17, 2026, at 23:48, Bjorn Helgaas wrote:
> On Thu, Sep 17, 2026 at 10:27:54PM +0200, Arnd Bergmann wrote:
>> On Thu, Sep 17, 2026, at 20:36, Bjorn Helgaas wrote:
>> 
>> It feels wrong to me to change the devicetee file when that arguably
>> describes the device correctly, and we still need the node for the
>> bcma bus probe in the end.
>
> I don't think pcie-iproc-bcma.c needs anything from DT at all.
> Everything it needs is in EROM.
>
> Some PCI drivers, e.g., wifi, need DT nodes, and I think those need to
> be enclosed in a node for the PCI host controller, but
> pcie-iproc-bcma.c itself doesn't care.

I understand that it just works without that, my only concerns is
that having a DT node (which is required for adding child nodes)
without a compatible string is going to cause problems later,

From the DT perspective, it would be better to add a second
(or third) compatible string to identify the device better and
keep the existing generic string as a fallback. The
pcie-iproc-platform driver can then skip the device based
on the more specific string.

Simply replacing the existing compatible string with a new one
would solve the probe order problem and at least leave a
well-formed device node, but this would still count as an
incompatible binding update, which we try hard to avoid.

        Arnd
