Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C535675D;
	Mon, 11 May 2026 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778542133; cv=none; b=oPWnXGOFrjty8qBl9De+TO5xo5rfUSEhNYmcp0Q2VUDi4+e75J5BKZLGJ+HCIJJURID5lvVF4KWM5Wl9tkGJm9TodBbsSGNxIhjpd7BCO2i/cDUpE2EkBWQzdEsSxYJRzOJVSWiCL5/0EtsGeBJaC3gPZBesS2NBqr0SkFUhpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778542133; c=relaxed/simple;
	bh=aADp7DgVuAPyaGlpb+SO4KZbRsMSVdrHhsP3kBXCfLw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XZKAwcAfXxSVBvFuwqCzR1LXAVBtAWuFYs+wmtGL7yPHxef7jz7gROz0+a+kOs8s9hjnjXq3pQ1LK1GCEnPFM/N0IOAJ7uqfJdDfsXooMDrRJTaw6zBG1B2WAR4LNu2n6Uiwz18JQBknq+nDGcgtyZH4DCdtWCgd4kwiuAA6SCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKnAaPhY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKnAaPhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5080EC2BCB0;
	Mon, 11 May 2026 23:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778542133;
	bh=aADp7DgVuAPyaGlpb+SO4KZbRsMSVdrHhsP3kBXCfLw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VKnAaPhYkMjXtNYBBpR+2rAoWThQGtiVYS0cvvCDMVWbZRVYbRy3R2a6Y7E0q7csH
	 6MUQbAEo6sj2tW+YaiBaqK5Hrsac9zUd4kpCOT3RLz05zSkwSJOPzkOL7RMz7UDZRL
	 AdcqDrpFllD4sG+JIgRgHV5Tg8Da6xoWM3ViLZjBcL+XgVSlhD0GvY30gG/ZWOE4l2
	 lHYZiPfFVDQxyKBTAjM2qtCsoae5G0MWvTnrRghRLYM1rbsbt/qQLwLPP1KlLVkBex
	 m4nmDCTq7Fm3lVw+mIqwmhIGcqCMYxNmEPyPQRuPE/H9Ed/PJxn3BtVezk/WJvf2yW
	 ZA51GmYvWsOfQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 75475F40069;
	Mon, 11 May 2026 19:28:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 19:28:51 -0400
X-ME-Sender: <xms:M2YCamdbFM64ymqngWj5O329txdA3O7T--Vb61oKSNUrTeG5TrjH6w>
    <xme:M2YCap34CBrDTBhQ4CwEYsKD_WHBOjjBPVinCH1bfp0TMjzxS8cY-WSx_y8bnVfJX
    _6UIJWcnqhBIScn9pXo5JZyjrr9QExFUunM2kLonFsjCqab7Cwd>
X-ME-Received: <xmr:M2YCaq9QUKhUqMN3glWylDp-vYyKfjBZZqt0UAu2djEQy34H5HKJfncVZE7FnfwiiFOyXEqlidVQMhTeP5rCIkbUMyHqqrUVRgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevkfgjfhfugggtgfesthejredttddtjeenucfhrhhomhepfdffrghnucgh
    ihhllhhirghmshculdhnvhhiughirgdmfdcuoegujhgsfieskhgvrhhnvghlrdhorhhgqe
    enucggtffrrghtthgvrhhnpedtkeelkefgtdegudeiiedttdfgueegieekjeffueffueet
    jeffkeevtefflefhheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepughjsgifodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqddujeejvdeftdegheehqdeffeefleegtdegje
    dqughjsgifpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghr
    tghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtvghrrhihrd
    gsohifmhgrnhesrghmugdrtghomhdprhgtphhtthhopegujhgsfieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepug
    grvhgvsehsthhgohhlrggsshdrnhgvthdprhgtphhtthhopegurghvvgdrjhhirghnghes
    ihhnthgvlhdrtghomhdprhgtphhtthhopegrlhhishhonhdrshgthhhofhhivghlugesih
    hnthgvlhdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepshhhihhjuhdrjhhoshgvsehhuhgrfigvihdrtghomhdprhgtphhtth
    hopehmihhnghdrlhhiseiiohhhohhmrghilhdrtghomh
X-ME-Proxy: <xmx:M2YCaq10C2R19tgRVDbetC1eA6Y1ve7S_ozN2VQ7W1imQnHn_6TZOQ>
    <xmx:M2YCat15BnSUZfq7j-azLAw0GkgNrJHlGVux7mFHPicElCdwRnFuAg>
    <xmx:M2YCamuw78kLXFUdqy2k4BpVPSkoHDrbVM-y-kmY0lgntnoCAYi8rw>
    <xmx:M2YCatbtSxrQ8fMcUmYP5btnJLC6pfsG6Hk_Pd4Rgoi6Cx4hIGcrDw>
    <xmx:M2YCasJ70O4NK3-xFJ790GKeQhUzcgUhDb6l4YD4PXRCj_guGD2Ixa-A>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 19:28:50 -0400 (EDT)
Date: Mon, 11 May 2026 16:28:49 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: dave@stgolabs.net, 
 dave.jiang@intel.com, 
 alison.schofield@intel.com, 
 bhelgaas@google.com, 
 shiju.jose@huawei.com, 
 ming.li@zohomail.com, 
 Smita.KoralahalliChannabasappa@amd.com, 
 rrichter@amd.com, 
 dan.carpenter@linaro.org, 
 PradeepVineshReddy.Kodamati@amd.com, 
 lukas@wunner.de, 
 Benjamin.Cheatham@amd.com, 
 sathyanarayanan.kuppuswamy@linux.intel.com, 
 vishal.l.verma@intel.com, 
 alucerop@amd.com, 
 ira.weiny@intel.com, 
 corbet@lwn.net, 
 rafael@kernel.org, 
 xueshuai@linux.alibaba.com, 
 linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Message-ID: <6a026631b4f86_1b86a100d7@djbw-dev.notmuch>
In-Reply-To: <09796934-e093-44e6-b6e2-2d0dd5a29673@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-3-terry.bowman@amd.com>
 <20260507190836.70197e24@jic23-huawei>
 <8913c666-a343-4717-8ab2-0b8546d1bdfb@amd.com>
 <20260508150533.04e19cf9@jic23-huawei>
 <69feaebd471c3_1b86a100b@djbw-dev.notmuch>
 <09796934-e093-44e6-b6e2-2d0dd5a29673@amd.com>
Subject: Re: [PATCH v17 02/11] cxl/ras: Unify Endpoint and Port AER trace
 events
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Bowman, Terry wrote:
> On 5/8/2026 10:49 PM, Dan Williams (nvidia) wrote:
> > Jonathan Cameron wrote:
> >> On Thu, 7 May 2026 13:33:45 -0500
> >> "Bowman, Terry" <terry.bowman@amd.com> wrote:
> > [..]
> >>>> This concerns me (sorry I wasn't paying attention to the v16 thread).
> >>>> It is a userspace regression against code that is out in the wild and typically
> >>>> not updated in sync with the kernel.
> >>>>
> >>>> If you are suggesting breaking ras-daemon at the very least +CC the maintainer.
> > 
> > Sorry, that was not the intent, see below.
> > 
> >>>>
> >>>> To get to a unified tracepoint add a new one that does what you want, but
> >>>> maintain the existing ones as well.  Userspace can then migrate and maybe
> >>>> in 5+ years time we can delete the non unified ones.
> >>>>
> >>>> No actually comments on the code, just left it all here for Mauro,
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Jonathan
> >>>>   
> >>>
> >>> Dan was clear about using a single set of CE and UE handlers for all CXL RAS 
> >>> protocol errors. While I understand there may be concerns, please direct any 
> >>> objections to Dan and clarify what changes are required to avoid this 
> >>> repeatedly going back and forth.
> >>>
> >>> [1] https://lore.kernel.org/linux-cxl/69cb2d5ba3111_178904100b7@dwillia2-mobl4.notmuch/
> >>
> >> Sure - Dan's on this thread so I'm sure he'll see it sooner or later.
> >>
> >> Perhaps I'm missing something that makes this less critical than it appears.
> > 
> > No, it is breakage and a thinko on my part on the advice to Terry on the
> > backwards compatibility rules for tracepoints. At the time I was only
> > tracking data type and order of the payload. I.e. string at same
> > position. However, the name of the argument is ABI.
> > 
> > Something like this incremental fixup I think gets this back on track.
> > It keeps legacy ABI support for "memdev" field in the payload. It
> > incrementally lets updated userspace understand "port" and "dport"
> > events. It stops us from growing a new set of events just to update the
> > arguments. It enhances the CPER events to now handle switch ports in
> > addition to endpoint ports.
> > 
> > The bulk of the change is passing @port and @dport to the CXL trace
> > events instead of a plain @dev.
> > 
> 
> Thanks Dan and Jonathan,
> 
> I have a few questions.
> 
> Does this miss logging the Upstream SwitchPort device errors? Add another 
> entry "uport=$"?
> 
> How does the user know which of the devices (memdev, port, or dport) is the 
> erroring device? Do the traces need another string variable inidicating which 
> device triggered the error?

I expect that can be determined from what values get populated.

Endpoint:
memdev=memX port=endpointY dport= host=parent(memX)

Downstream:
memdev= port=portX dport=dport_dev(dportY) host=uport_dev(portX)

Upstream:
memdev= port=portX dport= host=uport_dev(portX)

If dport= is populated, that is the device that triggered the error,
otherwise it is the host= value.

> And, I need to confirm: the Endpoint is NULL unless the CXL Port is an Endpoint 
> Port?

You mean memdev is empty, right? 
