Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57096361970;
	Tue,  4 Aug 2026 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873800; cv=none; b=p+YNlQrnhfexxFgIMDmrh5APGiI+GIBsYKid6wUpUsGlfArDquZ6v5pAxC+BbIhs6+gWM5VGOc61YLZHTsFFOc6jltUyfz8MxIO++r0mHOLZr1e9Hi5q4+W7+lJ8KyitdNqsMboAknJVUOJhWWCSDulhuM0+54rL8Y0URRKrQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873800; c=relaxed/simple;
	bh=EKl4VXD2TveRtNvkzzY0QLOs6hT9Swht+AhBNmDHQt4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=iznSgh9wsYKIvVe7ScXB901bmMZr8+rIObftX5gKDZ4oOWBG6LDiU+24amB37iAs/jH4rlI6l5UwjtYdpRuNdx2GzSPnEX4ITi4ZASR3KduIIGNAVAD5TQL3iI8ELS2Dm3ZGOLAGSS7t/+WnhL27l+0d1Jf8WIqCQFg03oqDs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=gmtSJEad; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="gmtSJEad"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=fXoKWej1UuOX16jfhGM2WAZHIRZZk8cB3V/1ULcgatA=; b=gmtSJEadokGFnG8BX5mTFCBbdO
	1e+v1x5/AO+DDGtiKayh79RMjVkjWlqkP0IQDDk9JJMIMpFCR44UZx54rtEwo+E1AYhTebTiWkXuj
	ZVh5RO4UhjHRpWtyhKjALoLMqQGwET/18Td88wfJAI1yvw4Ge4rME5OxZMpdnbNS0/JEaJj09d+0w
	TAZz6kKlvXS5XiK34EW8I7Dg1XHPf8WlZ3ECebrtzbB2BOJx3L1TKWQbyIJL3Iw8Uf8aV6RaNKny9
	hi7wwoUaGpBruJ4acqyfTWs2fvq6y85C36fkqL37GuIyv+oMza2TPYWagKwDLg5Y4WNQnY+PqzMVJ
	20dKILDA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrLM5-0000000016x-13yw;
	Tue, 04 Aug 2026 14:03:17 -0600
Message-ID: <b57d9ae9-8848-4acc-9827-3c7a9d659f1c@deltatee.com>
Date: Tue, 4 Aug 2026 14:03:16 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-4-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-4-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 04/13] PCI: Account for Direct Translated P2P in ACS
 isolation checks
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> PCIe r7.0, sec 6.12.3:
> 
>   peer-to-peer Memory Requests whose Address Type (AT) field indicates a
>   Translated address must be routed to the peer Port/Function without
>   redirection, regardless of ACS P2P Request Redirect and ACS P2P Egress
>   Control settings.
> 
> Request Redirect therefore does not isolate devices below a Port with
> ACS Direct Translated P2P enabled.
> 
> Sec 6.12.1.1 makes such a Request an ACS Violation once Translation
> Blocking is enabled, and that error "must take precedence over ... ACS
> P2P control mechanisms". Report isolation only in that case. Without
> Translation Blocking, devices below such a Port now share an IOMMU
> group.
> 
> Fixes: ad805758c0eb ("PCI: add ACS validation utility")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

LGTM

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
