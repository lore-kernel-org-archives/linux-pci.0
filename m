Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD027A477;
	Tue, 27 Jan 2026 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531632; cv=none; b=gNO6qOTXSRUrbsi7/YYXisknGc7zT1n2WuhnzYnmo1G7epbjE6e0FuKOdWLO6ZsGWkC45V9vF4idNVzLn66fdxDURICfXinQp70f8Sf/vrvWO8OmG4KYrIux2/CN22guE/TK58RuPys6j9mjsYDGmo5mhLbtiblkl8SSLkNkaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531632; c=relaxed/simple;
	bh=JTqXH1Qqifjmcyrgctdw4sq45vF/LGfLBF2aO/b8q6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3gJzDRbfinwDvaSElfgjAqUZ/7dQwU1DZZcItv2n5DoxICp/Y55TtqZMf+s3d3+RZ8WcyPOJD5iyPMGVTdK3Eh20F1xAS0ArLET4nmkNq8VxNnzAiPucOX95dox1NAjty2TpRFqIbiKaH0hUe9gqPSgTo0XPynVSEknAU8SmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=cNZI6HH7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AF0/PoV8; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="cNZI6HH7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AF0/PoV8"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 818DB7A0085;
	Tue, 27 Jan 2026 11:33:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 27 Jan 2026 11:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769531627;
	 x=1769618027; bh=CSqp62/l1kyI9dkhKEQ8AI9Ns0bdUvTJ+dJ8IA5aSEw=; b=
	cNZI6HH7/JGrCPpzljH8eyycnsA4vw/cnsJEjQXRjWSFzntZp6PNo3uWS4sQ+tAZ
	svW3CV9+yNuijp0IUAVAG+ZMt7Hmun83KwqTGK6HJ1GVsvy2JSiu7XKPIpZl8IKW
	nVwPDgiY0N3ap2KGxS2cH92/r6tPpYNtaGVShYHpsQhKq31So+dbeKv2teB9bu58
	I23KvyY/we8WENs8e4Xodp0W0UGtao6XuViLq1zntRBCwAfocjzZU2pcuqn8/P2v
	PnTBbNa6yn45Q5Wn7AZnbi73CdjlZV+pL8JWILMXoqrRpgxK+hed+Bipjdl/u4aO
	+kaCng08kQAIdoKu22z5hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769531627; x=
	1769618027; bh=CSqp62/l1kyI9dkhKEQ8AI9Ns0bdUvTJ+dJ8IA5aSEw=; b=A
	F0/PoV8NoOpa5VfNN2ShjAtymtSni8djNBWPFJhZMhPfcWP1xS6r2msksAlWgZ7D
	GV/Gfu2nB+GlO80cleiYvsjd/evy5suroOY7/3FHRy7DMeft8EAR9H546p+W97v6
	CjQ1D/GlHUoVkql8G3+s8eGo0hZZEKVh1cIokBKENsyWl5hVyj++e9Z4hJasPWXF
	DZCu6YWxE5bNDVT937AHZEEUpxNbHh9C1Hh8hwsekSXx88DNQ7khmFi8gS3jOyJS
	o8GcOWV3kFC5+9jyrVIj3H+EQYftWN6YKJvI0T46r3g8yrWKFoAek8glGjSgJRm3
	lap5nFQYShOg9MIRM5mqA==
X-ME-Sender: <xms:6uh4abrce_KZOmkngK1zTIel-H0MjkrtxkvFiTKdxjCMCovGcjbDaQ>
    <xme:6uh4aUAB96FGopPEv_uiRemGCwVIaCkriNGQBdq1kZWPk1H3D94JU5m9os7ojeDnf
    AoRpyB5X_rZ7qGOMLSd07dWVcn25VQSDgmP9eltk_bGMPX10qV92w>
X-ME-Received: <xmr:6uh4aUPBtgN0Ppd8I_QzFW-TMiLpMb0HAhFXa8Ah3QwglZjZhaHsjO7QvrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhmrggu
    hhgrvhgrnhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggrvhgvsehsthhgohhlrg
    gsshdrnhgvthdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgif
    vghirdgtohhmpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpd
    hrtghpthhtoheprghlihhsohhnrdhstghhohhfihgvlhgusehinhhtvghlrdgtohhmpdhr
    tghpthhtohepvhhishhhrghlrdhlrdhvvghrmhgrsehinhhtvghlrdgtohhmpdhrtghpth
    htohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomhdprhgtphhtthhopegurghnrdhj
    rdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtthhopegshhgvlhhgrggrsh
    esghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:6uh4aSASkspPOXc0bSHtC_mpD3LbBqUVRpOPQVVwLi7m9pMtO4pYgw>
    <xmx:6uh4aS-ZxPtHe4J7opzXKOfnOXNaCxAP92F7WmR7-P_p6rrBi-Qqug>
    <xmx:6uh4aTEnuJdJniQ6oHJS858Tx9zChFbQ_h8z7fJkluVCfhaZ_3hNsg>
    <xmx:6uh4aZLDhCpczLpBmZFvfVrHLhk8wBrW5e1BS1gI-5vc5OJdwBRRwQ>
    <xmx:6-h4aQShcjzlnNNzPdiXw_rOJbrSkJ6V7SBaHuj3QwIZV367rD5dwwo1>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 11:33:45 -0500 (EST)
Date: Tue, 27 Jan 2026 09:33:43 -0700
From: Alex Williamson <alex@shazbot.org>
To: <smadhavan@nvidia.com>
Cc: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
 <dave.jiang@intel.com>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
 <rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
 <huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
 <sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
 <jsequeira@nvidia.com>
Subject: Re: [PATCH v4 0/10] CXL Reset support for Type 2 devices
Message-ID: <20260127093343.67715d5e@shazbot.org>
In-Reply-To: <20260120222610.2227109-1-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 22:26:00 +0000
<smadhavan@nvidia.com> wrote:
> Motivation:
> -----------
> This change is broadly useful for reasons including but not limited to the
> following:
> 
> - As support for Type 2 devices [4] is being introduced, more devices will
>   require finer-grained reset mechanisms beyond bus-wide reset methods.
> 
> - FLR does not affect CXL.cache or CXL.mem protocols, making CXL Reset
>   the preferred method in some cases.

This proposal adds cxl_reset to the pci_reset_fn_methods[] array, so
while the above suggests there are some use cases that would prefer CXL
reset, we're interleaving the capability into the default function for
PCI function scoped reset.

I'm concerned about use cases like vfio-pci emulation of FLR, where we
currently call through the pci_reset_function() interfaces to take
advantage of device specific quirks.  Such a use case (guest directed
FLR) might reasonably expect the scope of the reset is limited to CXL.io
without affecting CXL.cache or CXL.mem, therefore it's not clear that
pci_reset_function() necessarily has the correct scope.

OTOH, we also expose a reset ioctl through vfio-pci that could
reasonably reset the full state of the device, PCI and CXL.  cxl_reset
would be appropriate here, however cxl_reset is prioritized below FLR
reset in the default reset_methods array, so pci_reset_function()
doesn't have the correct scope here either.

Is it really appropriate to consider cxl_reset as just another PCI reset
method given the scope difference?  Does there need to be a way to
specify the scope when calling pci_reset_function() for drivers aware
of CXL.mem/cache?  Thanks,

Alex
