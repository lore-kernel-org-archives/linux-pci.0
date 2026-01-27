Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE22324716
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536864; cv=none; b=I//xz4LCeuDzjYojRkxu5mZnvFNJCDvkd9I3GA6QtnzVK0gCXHhSeRHsMhJSyXo1fJ0F+yjDyEzNLx/jFndIGnaViQ14tWcXlrlsMZzM4rLDIhN3l1VyzRFTF97oPxasbjGARDLQ827OLHY2KMUichOgREU/o1z5m+Y5+QHrNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536864; c=relaxed/simple;
	bh=tqCb+IWB4MsBS7ovL5icGy7qPouGgQ/bm47XGcZO4os=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qmE2eb2miZaWKwc0eF1s14nQDLlsWxMmodld9xZKb7CH+/DLnm9mfrwEs+CQyU4AFxndn9WtnpKVexpcAJvjNyXeSMeKkub/tw+UFdshKlZP7Qeng9GjKzBBn/1EoiT9FcRB3DhSKW4/TwjBTSCdqd92W7FObTzvtoFdx5V7qwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAv6QXrg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAv6QXrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC5EC116D0;
	Tue, 27 Jan 2026 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769536863;
	bh=tqCb+IWB4MsBS7ovL5icGy7qPouGgQ/bm47XGcZO4os=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NAv6QXrg7JTSley7H5mdv+XqUfO6Co5e2uzOAtjNwU4xk2KMAz28AI+9OFLGmu99l
	 kiArOilj7PVx4Kup+zw6pOxuj3o1T8mki62izC2KmIO1Ow0l45VAwfMtHzs1Se1LJQ
	 eqhArCty4Aupa7vtJir/POgO/ZV24wvmYZ2BB9M5srKPeZCVaTR9f3x0XLNpowzb30
	 LwOhRy/IRACaQPq9niOhaGyUHJlS1eRzkP7jb2FEMXW1c3OF19CnbEKEiiJOpsEyN9
	 Eb9t60aMvJldOjMzuqai7OkiCdDDIzUmyvzaw7rU+phdlyu/lqVlX8du3H+P3fV8dr
	 +nAxVbWRqSzwQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 72664F40086;
	Tue, 27 Jan 2026 13:01:02 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-04.internal (MEProxy); Tue, 27 Jan 2026 13:01:02 -0500
X-ME-Sender: <xms:Xv14abNU1POE5048UBPILOtqdqYyZ0NmB0Bi5goycRViJpusbg4Vvw>
    <xme:Xv14aQy2E8Bf8s1OrSild0R3o2e9pLk27AkFcZH5vCbzC-MinAly8IRr95ZTvTqSs
    R-CKGQh7DKDjcqdO18qPPJoPwU3tdiA77n4TiQ4rrEt1QbaAHJSSP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjeevffelgfelvdfgvedvteelhefhvdffheegffekveelieevfeejteei
    leeuuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhgvohhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdeftdehfeel
    keegqddvjeejleejjedvkedqlhgvohhnpeepkhgvrhhnvghlrdhorhhgsehlvghonhdrnh
    hupdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    sghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehsrghgihesghhrih
    hmsggvrhhgrdhmvgdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghp
    thhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhgrnhhghh
    huihhfvghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehkrghn
    ihgvsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepohhlihhvvghrrd
    ihrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehqihhnhihu
    nhhtrghnsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepgihlphgrnh
    hgsehlihhnuhigrdgrlhhisggrsggrrdgtohhm
X-ME-Proxy: <xmx:Xv14aUL2213F47XAMXuqXEWs1XsYMexQgEuXdseiY2vMzrvdRtpvfw>
    <xmx:Xv14aZVtPwdF_XSh5KtzwXdX6BXhjB2noMmaukrXIO0u9tHDwvAbAA>
    <xmx:Xv14aYEOPG3mvC_RMdoSLeOHSIr1i8usap3m8kRnt12L84cf88Bkiw>
    <xmx:Xv14aQ5SpFJGQX8zHawGI88mtpe30ApxnOLVcyjQyq4hOsBtvYc9Ug>
    <xmx:Xv14aWcXE331QFHDhThfCIcGT8kknzAU7eeUz3BhPyEJAh92Td_2sMgF>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4E9482CE0072; Tue, 27 Jan 2026 13:01:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANHFfUoI4SCB
Date: Tue, 27 Jan 2026 20:00:42 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Christoph Hellwig" <hch@lst.de>,
 "Qinyun Tan" <qinyuntan@linux.alibaba.com>, "Jens Axboe" <axboe@kernel.dk>,
 "Sagi Grimberg" <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 "Xunlei Pang" <xlpang@linux.alibaba.com>,
 "Guixin Liu" <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
 "Guanghui Feng" <guanghuifeng@linux.alibaba.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org
Message-Id: <197d75a2-4286-41fb-ab4f-9ad744885bb4@app.fastmail.com>
In-Reply-To: <aXjin6e18UxcTpQz@kbusch-mbp>
References: <20260127073344.2489873-1-qinyuntan@linux.alibaba.com>
 <20260127084807.GA342@lst.de> <20260127143143.GW13967@unreal>
 <aXjin6e18UxcTpQz@kbusch-mbp>
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Jan 27, 2026, at 18:06, Keith Busch wrote:
> On Tue, Jan 27, 2026 at 04:31:43PM +0200, Leon Romanovsky wrote:
>> On Tue, Jan 27, 2026 at 09:48:07AM +0100, Christoph Hellwig wrote:
>> > On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
>> > > The NVMe PCI driver exports the sriov_configure callback via
>> > > pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
>> > > VFs through sysfs. However, when the PF driver is unbound, the driver
>> > > does not disable SR-IOV, leaving VFs orphaned in the system.
>> > 
>> > That sounds dangerous.
>> 
>> It is not. In a real SR-IOV device, VFs are created by the hardware and
>> are independent of their PF. There are several use cases where an
>> operator unbinds the PF and reuses it to improve overall device
>> utilization.
>
> If this is expected, should the warn message "driver left SR-IOV enabled
> after remove" be downgraded to 'info' level?

It is not important, no one complained about it. People who unbind PF, simply ignore this warning.

BTW, the use case which I presented is for SR-IOV handled by drivers. Maybe VFs created by NVMe are different here and they must be destroyed.

Thanks 
