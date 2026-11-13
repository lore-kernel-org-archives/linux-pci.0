Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547408;
	b=c3i86X1sQikEMR+UKxzeZiNmXKq2BOPHgftsKulN+v/y+27VCo70zX/vke4loxzabgaU
	 6FyQfymCuWSKXeACct5wYIiaH5WBRCQSCevB11hUvzjd6L0IDH8cx0bEfLKmm+IHYNjz1
	 IuH1Pfon4a9pJ+8EanuROpaSl9gv4w0ezF1tEX/+Ez9Phb54xMQ6lROP6yUIgzvHSo/6D
	 uUuwyJ+ztejuB+S3H939nA5bfjVa1x4dRekyLR3pADBcK2MiRHO2ZDy5qoPiXhYJB6/wj
	 WzEoRyq/UXsZ4PpUTsm1BYVEO1QfVb6KgczTFOISAjGEH8A/B+P1Z9u4SFt5QgOm6hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547408;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oAxy74l9NqEKCof3pNxvq823Cwf06nSN8L9r4dpI3is=;
	b=FKMP3BlCNX7U85pRS7ZDSAst5EL4MO19sxW05x6606kjSRniLwjUuS8gwG7f/edduNwL
	 oqQ7HDClG34MwqGzWH0ElGrw4ZsLxx2sQyRR+GcCnz52l3uizb5A6wq9l/SjSJw2ParQD
	 WsDK78a1RNvwOwhSl3fzPbZB3lOA3eDfTBWvYNcjI5CPSZe2c24rxl6+mMSCyl0wKGR+j
	 65Yl+7cWVcHhXud9MqQ4w0cAz1KUQfTzIbwY46ZJhyOmqrkHw4wwuYSZrUPOhfsht+WeU
	 D9JBdJLtMJXEp+PSDskSb8Sq4vMu3LYSlouZwDd4A+pHKBNQlgmMA95PiJjSuWoIcpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=awOSaWIo;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662B606A32A;
	Fri, 13 Nov 2026 05:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E662B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=awOSaWIo
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DD77440E0184;
	Fri, 13 Nov 2026 05:23:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4Ex88StL6t4X; Fri, 13 Nov 2026 05:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794547396; bh=oAxy74l9NqEKCof3pNxvq823Cwf06nSN8L9r4dpI3is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awOSaWIocn/SfDur/ly8h7zKwHLzuXNRtqIXrzkhH1qy9I5uEBz/5co/Z4zNu/oBs
	 tBNmqkG7rSqBEbLDWCdaFHPa+X/Z4Gajnz8EzP6TOFcbmaaOYoCrLH74rgHt1Xfn0J
	 X0QjUVsMM8ZfKSMEqe+OPHZKU0UkoFeX1mPnONlrf8FFiox82xyVK6z3EivugWwT+x
	 2KrSj8UQX0MKRearWI4+H2/yc9AmnIlzurQqpCapfXzFe0JDhkaoAJDfRz/2vdlQ5O
	 C+A4gXU+9dRXDmXzU/EGDbcN7FKATMRzJVqA6gj14xOcjdFqxziBAPc8Bwcn6Qh0IM
	 vki49QAhcfTgMN6pdWXDnhIOzyTH4cA2yuOmPKeq+xezzVqzTOcJzd4AXzFw2yDou5
	 TWn0/Zn/OamFez81QAl3cgvb/sgFUkF8lIcj7VmyC33PhkXiM6u7rt3QITXXhmykEH
	 v9GUSC9NKn/cNReg2s9DEphoRsx6yITDE5b1FkL6N9SECxVYHZPMBIeDikAQASjbHy
	 LjLbaydMGjpmGsMVc/FnesDdsScMxtjpvopfIrEQAVjrOFnh6pOpd8luqoh/bUYqvH
	 bnY5QOJsY9guw2rh9Vi/n5j4JGqVtbSFrA9OrSIBWMifL5HluTkjR2cXwQChYwhNcr
	 atqxLS5WGDYZ4VbJYJQGZUog=
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A6B440E015B;
	Fri, 13 Nov 2026 05:23:03 +0000 (UTC)
Date: Thu, 12 Nov 2026 21:22:59 -0800
From: Borislav Petkov <bp@alien8.de>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Support preferring MMCONFIG for all config space
 accesses
Message-ID: <20261113052259.GEavaes_QlX4T9vD_Q@fat_crate.local>
References: <a7d2b402784a409f5564c1fdce77a41e09f29280.1793087687.git.josh@joshtriplett.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7d2b402784a409f5564c1fdce77a41e09f29280.1793087687.git.josh@joshtriplett.org>

On Tue, Oct 27, 2026 at 12:14:45AM -0800, Josh Triplett wrote:
> This *should* be safe everywhere. It seems exceedingly unlikely that any
> systems need this. Despite that, this patch makes it `default n` out of
> an abundance of caution.

I'm no PCI guy but my gut feeling is telling me, drop the CONFIG option and
add only a nommconf option which is an opt-out and goes back to the old
behavior. And then we can see what breaks.

But maybe Bjorn has a different idea here...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
