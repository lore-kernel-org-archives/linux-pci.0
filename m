Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188E116ABFA;
	Fri,  5 Apr 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322391; cv=none; b=iIMcXakP7ddPxaLHwN2vsugCZAWusrT84CCnsMcQJeumQu4JkODG1bp47OkGUQk/omkUwkinwsiC4J7IVxAUGGZCljtK8nYv1f9B8ER/g2pwp3/BgDcW0pLp57jSGCfq9J3o1duOnpz7MLCN9jYw+/RAZBq4TdKWgsHbH+FncMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322391; c=relaxed/simple;
	bh=YljZRN04HiQc8Wt3luG12vSGapEED3ffuFFBqFi0cl8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lelpJZp0W3XJRzFrjGAuAjVYv2Ece8I5kwrBZW9ojfOS0XeaGB0T20kX1uiDnQwljkWL7GPHbjz9qhyk6nJKWbSFczg3wTGdkYA3kMxGE0swW0rsnQYngbucxFHtvm3XVKxYCEClMCIJVAEPlzPTx41kDh44CRhPNItQmvrkTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Kra4dFt5; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Kra4dFt5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UBqDaTZzUF/U4d8S2p0/DyPa6gFbPu12hq+e26cZbaA=; b=Kra4dFt51r+1M3Ng+yvTwc4kPy
	wU9Mex2+lsP3H0WX4jKl35z8+Cy7WybyBOR7szfGSBqoaOttIByz2JV6BwWOaLiHyH5SNjaBltPsg
	3OkEaZP7TDAsmCqBjbnW4YYsxMpkEY78WsssbvuWkj4+m8T7zRelZ+uzSa9OH9eXQ00ZKjymvrWIl
	R2Gg9hlVlOA2oE2Wg2r64OPA/uzaLWObuyP1xmVrC3pTuw7RWdQVjnfcVLp3IOjih6i3ag8DxX1kt
	Mf1DYRDk0ur+WyFJndxkBZ9f9m8p0TdBwqYTUyCLf2ryl9Kl/2azb3cL17SeIFhOwHXkprz+Fkhku
	J8H8TSxA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rsjGu-0000R9-Qj; Fri, 05 Apr 2024 15:06:20 +0200
Received: from [178.197.249.22] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rsjGu-00Fqav-0L;
	Fri, 05 Apr 2024 15:06:20 +0200
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 davem@davemloft.net, Christoph Hellwig <hch@lst.de>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7f728d06-3a8b-945b-de0f-d0691d3c1eab@iogearbox.net>
Date: Fri, 5 Apr 2024 15:06:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240405122646.GA166551@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27236/Fri Apr  5 10:26:04 2024)

On 4/5/24 2:26 PM, Jason Gunthorpe wrote:
> On Fri, Apr 05, 2024 at 09:11:19AM +0200, Paolo Abeni wrote:
>> On Thu, 2024-04-04 at 17:11 -0700, Alexander Duyck wrote:
>>> Again, I would say we look at the blast radius. That is how we should
>>> be measuring any change. At this point the driver is self contained
>>> into /drivers/net/ethernet/meta/fbnic/. It isn't exporting anything
>>> outside that directory, and it can be switched off via Kconfig.
>>
>> I personally think this is the most relevant point. This is just a new
>> NIC driver, completely self-encapsulated. I quickly glanced over the
>> code and it looks like it's not doing anything obviously bad. It really
>> looks like an usual, legit, NIC driver.
> 
> This is completely true, and as I've said many times the kernel as a
> project is substantially about supporting the HW that people actually
> build. There is no reason not to merge yet another basic netdev
> driver.
> 
> However, there is also a pretty strong red line in Linux where people
> belive, with strong conviction, that kernel code should not be merged
> only to support a propriety userspace. This submission is clearly
> bluring that line. This driver will only run in Meta's proprietary
> kernel fork on servers running Meta's propriety userspace.
> 
> At this point perhaps it is OK, a basic NIC driver is not really an
> issue, but Jiri is also very correct to point out that this is heading
> in a very concerning direction.
> 
> Alex already indicated new features are coming, changes to the core
> code will be proposed. How should those be evaluated? Hypothetically
> should fbnic be allowed to be the first implementation of something
> invasive like Mina's DMABUF work?
My $0.02 from only reading this thread on the side.. when it comes to
extending and integrating with core networking code (e.g. larger features
like offloads, xdp/af_xdp, etc) the networking community always requested
at least two driver implementations to show-case that the code extensions
touching core code are not unique to just a single driver/NIC/vendor. I'd
expect this holds true also here..
