Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC963D8107
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769598; cv=none; b=W4ZjkTntrwObRYbJU9S/ux+yQ5Lv3fx2JMBpn6/CSDUmhCfQMGN9LrTMoNCV/j6UZC5QXLBVgsd2W4CiOwPUqJkL4c+dy9tZ6e4+4wpUsSO/9ixgOgRvQtJbDa8urmNt5ZwDbgXQDc4t+rN3bJP9JitripzXqMgB1KFmedzrMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769598; c=relaxed/simple;
	bh=uYtxYcaY67acYb9exNabaoKK573YtYQ50AE6xh4JjQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvmsZgVtl2JITlqF8ah4u9v6CQd9MfzN0p/IkCM6gvEJw6GcDRGmWUfSYJC3vNj20VVJmgXDdjdCpNt8fUhOBx2Yq+eTizdD4vBYTC+oGI7lCkSb2qM7ybqrmIQqdJfTREUM32Az+n9/GqfWg2A6CuJNnkfZitqP7eERH/b4SVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8ajEdyO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8ajEdyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083371F000E9;
	Thu, 18 Jun 2026 07:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781769596;
	bh=TBHIX6qn20QALWjkuHPGPhqRjMc2KlIKK7EhuZZJgFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h8ajEdyO7IzcRt39B+VGSHA34Dj4JmFWQQfnHDPQZrTjBvMvPi45ui9xKHTY76UcA
	 pwAvgdkqYCKLIo3CBfV25ywkttGqxCxvC65dHNVbP8fJ18NrkJDJ2wgNOtGBShACc3
	 loXoKyYh6jHAFUiwRl8zheCJgovVYlLM7dJqghboBukKq3qat+zZoXcNnHbAia7tG8
	 9/jcjW7XlbpruiZL/53Srit1BAWTRo+jW7QWbut66KEiDasX5/DRg+nTvWAMqgRuKd
	 3547egT8tWvgAiTysrWR8IOGfqVs5iogVKrmlWINATdYh8qd5MrXRGxbwnMNKnfZ2T
	 diuxy2EaqN61Q==
Date: Thu, 18 Jun 2026 09:59:50 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mitran Karthikeyan <kmitran@axiado.com>, 
	Thierry Reding <thierry.reding@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: MAINTAINERS entry for MOBIVEIL PCIE IP
Message-ID: <aug5slqd7uv3rolpgolsd5pskwpufctiwsmxjfyzpewefc4a55@k4sllaxed2ez>
References: <ahWB7yRchlW_KjEm@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahWB7yRchlW_KjEm@wunner.de>

On Tue, May 26, 2026 at 01:20:15PM +0200, Lukas Wunner wrote:
> Hi Mitran,
> 
> MAINTAINERS lists your address <m.karthikeyan@mobiveil.co.in> for
> MOBIVEIL PCIE IP, but the address is bouncing:
> 
> <m.karthikeyan@mobiveil.co.in>: host
>     mobiveil-co-in.mail.protection.outlook.com[2a01:111:f403:cc2c::] said: 550
>     5.4.1 Recipient address rejected: Access denied. For more information see
>     https://aka.ms/EXOSmtpErrors [MA1PEPF00007264.INDPRD01.PROD.OUTLOOK.COM
>     2026-05-26T11:10:41.797Z 08DEB6EF7103D7C9] (in reply to RCPT TO command)
> 
> Are you still maintaining this driver?
> Will you send an update for MAINTAINERS as well as .mailmap?
> 

Since there is no reply, I propose to drop him from the MAINTAINERS entry.
Will send a patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
