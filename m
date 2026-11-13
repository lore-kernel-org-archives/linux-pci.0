Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535413;
	b=jyG+omOJ+RWOzwHF28Uh/mmrEkjmmjgeVRdZyVMvl3c/PJCHSQdq8ZpYSFLXS6L9UqWB
	 rPLz20ILZ/pYa6Etj04TariTOlvUqsVskLyfQ+ONPGbgyRJhsQiz07vG1skEwWpLC68UG
	 L6hWSSTnk0n5YocuXQY37jchFoV1iA93x08X3VfqE7pSRA8WIed6Wn+5HHypABxwhWzlf
	 w4oD5Gs0BhJyRa9n22vPTBo8Unhlt/Mq5NmD2iVBCKtUVrBKB4V6Yfdy3/yE/Xm3lP3s3
	 7cWEwY9fq/mJEkKOQ0+R+BcOqvFihvcaBYU4lvY//qUk6SLn3mawVm5bKm0JSsRVkxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535413;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned;
	bh=WGp60iebrceeykw5z9ks0STNk2un0gKAwGb3SyzUjH0=;
	b=Suc+o41ff4SBYEN1GYQqNnIsRaqK/Rv1c4NISzuRREnE9kHHgB8BCyWczArYI6o1sTGg
	 2CufY4bURV9MrmnxKpyicUPOKwXB9WKKOCkJgJgI1sYTnrNkNOkwDSZtwMuOxsT2equxa
	 Bychh8PODWb07XUXsO5cInLANuiYyecJEThUGYhfwc3F4Lk/iuAgkaE4QjyP4yJmIYtEA
	 b96lzKazBC2cH6AEUKmUzhTi1M0Q0ExnDNAKgOVbc7894EadMTZy3xq7y2Henh8XYqlXv
	 psZXJApU7DRylYoMGuM2lizgNOsCU5OWVv+DFn70kcUY9OAWQrEDQbcQk5G8NsDT0gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=I1cJaawp;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6639606A321;
	Fri, 13 Nov 2026 02:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6639606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=I1cJaawp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=WGp60iebrceeykw5z9ks0STNk2un0gKAwGb3SyzUjH0=; b=I1cJaawpaQh/eqik9UCP6jlcV+
	+ff2nbpYP/YhCSCiPSviiivDaU1gSLMMWauYCgv5Oluq4obD8slgaHK48V5Jgj2/QAXFJajhUcXRH
	WgH3787xsl1fWBLE/qO5uqxVUXAUMgzK6WuZyA5HknUUaekzaBrmb729wRbktI6WljU95iQA+YSWC
	NlA0cONSDNFzMBE5+vxYyMnxyQ3IobzCgntDbcklSx8s7he2B/vXKl7sXJCP1vXJAOdbu/leNFdkZ
	k1iX0hBRmB6dO93Kcb9vc15bSJy5YoVJGrUkuLMCB1cFB6+Znk6j4jtKNltZ9NRjHYq/qSqDj1iN4
	sWecGjJA==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xRgdP-00000002R98-2ZLr;
	Thu, 12 Nov 2026 20:03:24 -0600
Message-ID: <1a07c926-d710-4922-a4a1-be235df7c74c@deltatee.com>
Date: Thu, 12 Nov 2026 20:02:53 -0600
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ben Cressey <ben@cressey.dev>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Wei Wang <wei.w.wang@hotmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>
References: <20261111-pci-idpath-selector-v2-1-83ea668e38f0@cressey.dev>
From: Logan Gunthorpe <logang@deltatee.com>
Content-Language: en-CA
In-Reply-To: <20261111-pci-idpath-selector-v2-1-83ea668e38f0@cressey.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: ben@cressey.dev, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, bhelgaas@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kwilczynski@kernel.org, alex@shazbot.org, wei.w.wang@hotmail.com, jgg@ziepe.ca, me@anthonyvardaro.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2] PCI: Add ID@path device format for pci= parameters
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-11-11 5:36 p.m., Ben Cressey wrote:
> The <pci_dev> grammar shared by pci=resource_alignment=,
> pci=disable_acs_redir= and pci=config_acs= names a device either by
> address, with an optional path, or by ID. When one command line serves
> more than one platform, neither form limits an entry to the intended
> device: an address applies to whatever occupies it on each platform, and
> an ID applies to every instance, such as all Downstream Ports of a
> switch rather than the one that needs different ACS settings.
> 
> Accept pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>, where
> <path> is the address format, and match only when both halves match. An
> entry written for one platform is then inert on another where that
> address holds a different device. For example,
> 
>   pci=config_acs=xx111x1@pci:10b5:8749@0000:80:02.0/00.0/08.0
> 
> configures ACS on the Downstream Port at that path only if it is a
> PEX 8749 port.
> 
> The path goes last since pci_dev_str_match_path() consumes up to the
> next ';'. The IDs are compared first, and the path is parsed only for a
> device that matches them. The <order>@ and <flags>@ prefixes of
> resource_alignment and config_acs are stripped before
> pci_dev_str_match() is called, so the callers are unchanged.
> 
> Suggested-by: Wei Wang <wei.w.wang@hotmail.com>
> Signed-off-by: Ben Cressey <ben@cressey.dev>
Looks pretty straightforward and the reasoning all makes sense to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

