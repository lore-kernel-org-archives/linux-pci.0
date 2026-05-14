Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E23BF66E;
	Thu, 14 May 2026 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792099; cv=none; b=m+bEvXQ9pAbgDBFHu2QWKADlWV3N1hZoYlaAXFgKT7GeWBugWnmlXlX/VXyBYMjscS6b2sxIwlTCsstyInohLUMx57W9kODX0+DqHn+eOZWtIE0ydR9gE2yOcJ6xOlGfzN9M7xuu6Rt0qjiDWRhmqB5eLAvOeGd/7evqRZJ3FUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792099; c=relaxed/simple;
	bh=XSUK659bHU/759JDNCAQEU8tqPSbTHfhLWfjVN5v5i4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cG4znNjB/VvAjRjojglIVRGgZ2HeJ+RWJteQ9/I/En/56iuYsFnApcvDuCt83sF8sci8qg/NhkDPaxoWESlHDL5Cz4CvulaWVyV6yEZs2KewOxqtT13mfb80aUEWo/lD06OyJvOi1lKfpSM2zNW2Y2qKPFSwhW6XqMpAFc4yRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=KpmatAqv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HlY9NhoC; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="KpmatAqv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlY9NhoC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 691317A0067;
	Thu, 14 May 2026 16:54:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 14 May 2026 16:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778792095;
	 x=1778878495; bh=rMenxW/Hx789jrWDQA4V1Qzae7pTnjqglK7bzzRVy3Q=; b=
	KpmatAqvzHZdk/xky9zD3gCLaWZnVlvGnn6qXKXx8fnqeUsp0Sxp1ZWge0OAi1aG
	HNUijgYoeNlsmeErOIk1pwLti4WYA0HVe/TcRpVoWpuJHIwyX32ORXyJICO/DE+5
	n+zmukQxAW2vFVlfnU0B9Mab29kC1fA9+9sYtCX6PoyNS9djOOExQ2usbkEiIq+x
	01x0I5CRzssPrq6zEMCzgiKOTomvQuRPxxNPzX5WOmaYc5c2FCd/WjxxBTw3rfSI
	iRgk9Ew5yM4nR5fUboQ9RbVuaI3FMZhk7iQHkv3SEGH5fymHQz/SITASSA0t56Ag
	u530n7z+1Nf2o90OpMfOzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778792095; x=
	1778878495; bh=rMenxW/Hx789jrWDQA4V1Qzae7pTnjqglK7bzzRVy3Q=; b=H
	lY9NhoC8kJiJxzOc1HswlujzqigdtWQbPOFGOKqfzBmtVj/pV1bRnbd4kcfvYOpf
	AWK4udVedTgUNbrud3wzJB7qAjAgYSjMURpQId9I2QqEkGi1pfXV/XEUyXUfkT47
	yttXMbmfoLOTpdwT21OHXH1oRwicQRufyQZum/S2UdsHCmj/uBZ5JIsSHZqzpXHJ
	qxUwxsBxRpUD7BoXu9Mh8ORmDAfupb7uiqYTnt6jjO1oHJ3l3kLWi+qjUGj9Q2S5
	DBNSOXvwaM0ZCf+x3X9fQFRqHmveDnH1Mw9AW5XkSQMBEW2V7pys/XXDRYQqUK0b
	ghE7G+K8izMNSTz27mq4g==
X-ME-Sender: <xms:njYGagtqhRkdbehdJhuExJ9xcYC-xrRHzalvcSukkKp7kl335T4-lg>
    <xme:njYGauPXrW1AFJNISAjhFSuUN5XSWMQ0HdI1nuKAqpforIfr77IveUKuNkRRtvRtE
    FBJKQ7C7amp4ILKLOfTr7OyKflw2PX0nkgoSQZT0_H2oy10XiGmQw>
X-ME-Received: <xmr:njYGan78blFqq4V--ktNCOb-pns32Uu1iSVxFY4TkDN948yJy7Ke5hA7d2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjthhorhhn
    ohhsmhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrd
    guvgdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:njYGakQsS3kan8bhkxsa7xcjZKhsmJoKo_SuDuSaPeyqJpjxt3xGmQ>
    <xmx:njYGakD1RPStJwgzqmDZ3A_zVn0QLowZYdOKxxo6k5ISliEKmcvjHw>
    <xmx:njYGakHI93eKrIBIvUKJ6bCltF28mqbOXqMgDz_krwyYuYWfHU68zw>
    <xmx:njYGauAXBjvIrAx9lxhb0DyASC-8K1qrw2ZZLP_R5uo0PCRZO2M0pQ>
    <xmx:nzYGavldyU-ARZOMyCb5iZQftOXxFE0iEqexj-I4zDGrwr-afAqddEll>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 16:54:54 -0400 (EDT)
Date: Thu, 14 May 2026 14:54:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: lukas@wunner.de, bhelgaas@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v3 1/2] PCI: Add D3cold as general reset method
Message-ID: <20260514145452.44f9ac5b@shazbot.org>
In-Reply-To: <20260514123059.23829-1-jtornosm@redhat.com>
References: <agSNHLc_Sc_G-7vz@wunner.de>
	<20260514123059.23829-1-jtornosm@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 14:30:58 +0200
Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:
> 
> > I'd call it "powercycle" for clarity but that's just my preferred
> > bikeshed color.  
> I don't have any preference, although we can understand clearer what
> it is. If there are consensus, I am ok with powercycle.

I think "powercycle" significantly expands the scope vs what is being
proposed here.  This is specifically only testing one method available
for slot power, the one used for D3cold.  If targeted more generically
as "powercycle", that would logically imply support for other slot
power control mechanisms, such as for hotplug slots.  Thanks,

Alex
