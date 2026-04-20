Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACBF2D7DDD;
	Mon, 20 Apr 2026 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689068; cv=none; b=Qd0ck7FGCXeG5NWzE1M1PCWr9SO1NxGX2/YUj1RV+dLWIWV3RKLpxYEN2QpE8K4SqEteBE427/397ZHR92NwDEzmk8bKLDCFEom1XvSgHy8KNg5HcK2S8/xKNs9ZjwxcgHaBRu0pX00UZxNuuhEiF83O/mJkj2Dfe5zLad76U4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689068; c=relaxed/simple;
	bh=9wL5KxeyfjxOMUkEf3zWtEosxMah9Qh2tBiOxFqVj3U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Yd3IUrv2wmbe0snjg/TY505iz3Xr/9DgejklI/RZNAxpm8cb5Ug2jkHu6O5ivEIwiAj8js0bokqQcHv8pLgU+v4TLmSeYbg2udItgLEqIVIUhrlZlof3zDjfOd87kBlaFAda7nY8njip06yJNJxdgE8bdldZZa76pCmMc1CM4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Pgjkr2Ln; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bBOhESAs; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Pgjkr2Ln";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bBOhESAs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B61BF1400052;
	Mon, 20 Apr 2026 08:44:24 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 08:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776689064;
	 x=1776775464; bh=PFG2I97yMR7KlVf9K6jfXCbCWSxgm0jLhbElsjKcCLk=; b=
	Pgjkr2LnSvK7YQeCYBgBmivbwGSzvKM+c0YpZXjYCZhWsrs2jD4kTbvRJoJeBIwR
	8rMJaiK22/AHon5rL/qmE6VQ1h0wvDhMHHww2SZaaYRiz20KcUWaZu8FoPD6cFsU
	F414RXmdJY9unh9oVyfrEX7qZLkaomA3DSlRrpot3xsrhFZLvYhyqtOZexKbiA6D
	J2QgqtX3/gyX/pc9PtwsMbiwOpsVRd27sSzfJhcdqTp81iwrtz7Tb2UEJsLVm5Wh
	vQ61+F8bB8EwhbJChOyKCLWTU+mmsdjL5NjVoCcKh6kuz16NeEqIy4CoXii4GIS/
	Twa1fqTnXz5Z7NMLbsMgFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776689064; x=
	1776775464; bh=PFG2I97yMR7KlVf9K6jfXCbCWSxgm0jLhbElsjKcCLk=; b=b
	BOhESAsJKDnHN9tNB6DwsB6BAQwQbj/xwmh06+QU/C1QMtBEqUojP0HbXb275tEh
	14ENBq5+OBpjkJhz1DgmdQGk9Xknwd9zOsOieLhMZ6FOKHJ1MNlC7p2mipK0uhdq
	zoTsyXrJ9z639KtwcqXZ2hwpfCY5ooolaGZXG9DFr1t+KiENTxNOK6UI9vNFqbe4
	yqclpVphzMc6sr5iGCMCekuQNYnPIG0eghaLX411UbBZ2EUiWxmejXiHuodhWoVv
	0mBLNPBXWmpJLF8i1FtDPVupc5C152bpG+HuS6UmoBQJS3yTD/9xVAQ1g9+BR/ya
	/2xFvJUbibqqz7M52Cp3A==
X-ME-Sender: <xms:qB_maSwcQ8eBK5tQ8B2wlecJbxEBOJNh9kg971JUfyrv6wSfN76kaQ>
    <xme:qB_maZFaAR8d4cDhMCOjllx_Is-t7gRmJyBNHbltfi6F_Bmu-SO0vVNcF38PZmw15
    PzWI5I0P8LXyyav7cRqlWFX-OrzIezEVvZEW4NSFRfpn85PRcsVFhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetlhgvgicu
    hghilhhlihgrmhhsohhnfdcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrf
    grthhtvghrnhepgfeffeelgffgffevffetteeivdettdfgvdeiveefjeeffeffveetjeet
    udffgfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnrgiirghrsehmohhkrhihnhhskhihihdrtghomh
    dprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjgh
    hgseiiihgvphgvrdgtrg
X-ME-Proxy: <xmx:qB_maebFCIaLynXyZMX2hneFBBH4VoQuDBvK25sUbzITRrnV51qUyA>
    <xmx:qB_mac00JyYgkbo1GDxYIcDhqNUaWNyVgjkTpsiJOn565OWs4Ow9Iw>
    <xmx:qB_mace8CHML601Nw2U1nqC0Ph_Yc8BlWBZw4Q1omlQJCxvWK5fIWw>
    <xmx:qB_maVER9IjoJ1hLOChCiPqwME67JCjIBBA6ukQMgkPvKnV6vv3zZA>
    <xmx:qB_maYffjgyDSwFccDW04Esmy2-tmkudYpoclKnBEM-git6rCI5F8XS7>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 68F1515C008C; Mon, 20 Apr 2026 08:44:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_kkImiw7RKB
Date: Mon, 20 Apr 2026 06:44:04 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Nazar Mokrynskyi" <nazar@mokrynskyi.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Message-Id: <f732deb0-18e8-422a-923b-0e1c7e2c290b@app.fastmail.com>
In-Reply-To: <20260420122444.GN2577880@ziepe.ca>
References: <70de9b8f-b7c7-481b-8cb1-931e3b82eb0e@mokrynskyi.com>
 <20260420122444.GN2577880@ziepe.ca>
Subject: Re: vfio/pci: Qualcomm PCIe WiFi devices drop link during FLR causing host AER
 crash
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Apr 20, 2026, at 6:24 AM, Jason Gunthorpe wrote:
> On Sat, Apr 18, 2026 at 12:24:07AM +0300, Nazar Mokrynskyi wrote:
>> Several Qualcomm PCIe WiFi devices drop their PCIe link as part of their
>> internal reset sequence. Under bare metal this is transparent because the
>> host root complex performs link retraining automatically. Under VFIO
>> passthrough, the link-drop generates an uncorrectable AER error that
>> escalates through the parent bridge to the host, crashing it.
>
> If AER's crash the system then it is not compatible with VFIO, IMHO.
>
> For VFIO to work as designed the platform must be able to safely
> contain all the errors the PCI device can generate.

Aren't these also the WiFi devices that we tried to quirk because the driver writes the guest view of the MSI address/data elsewhere in the device which breaks interrupt virtualization?  The quirk was very fragile and never got merged, so I'm not sure how these devices are even useful with vfio.  Thanks,

Alex
