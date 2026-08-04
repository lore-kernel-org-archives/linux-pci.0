Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32816339719;
	Tue,  4 Aug 2026 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880905; cv=none; b=KWF5JkrLpKtUDlYHgN1LXEGjJhnwMfSs42+X6mviDnN0Xv31OLJUha/+nSNYbD9x3TK2lg/CmhPqNQxgGcDqlWbgnawr6ImuJPUKS5y07T8ImMBjDjxhaBW+tPFIxN+No5W+RaL3ZOjfcxZD2I4VKthtIBM1dlcSfHpW1Wi3EJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880905; c=relaxed/simple;
	bh=Jw9XDHWQpOb2TGg8xY2+gVNbXYm9BqS/vElJR1qqn4I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=nt+8CXZP3D9Q6pRXMJIYASAANf6Dc4+lqqv+3SJkR9g3KnmZh3z4NjysH3cfrSmLsVZA+0ViQ3KWAKq2raLGzWtRStwA+zlGeC2L6OjZScREue50bKbbW3WCM2f2oYO10qj7XUnFA7p9VfjjH4m2TmU9U2p70iirp2BFjcznsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=l5HUxPN6; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="l5HUxPN6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Jw9XDHWQpOb2TGg8xY2+gVNbXYm9BqS/vElJR1qqn4I=; b=l5HUxPN6LhX1A46iN9qGLgpTMr
	SIzs9AOTTZNHbwARQmy7R3qQ6ptEnM+xSUlj5OLZZmVnOh1Ox1AWn+Nm3aFpwG697EFyJOCht6gce
	NaOGvmSVVWAcudFPqanHKN1ViCCEfhhuvXAu9YmcPt/7Lkb/kh7jgIbE+CkgAB9Rcs8lI1UR2HoLo
	YEuwTPpDvBm9gVHPJtxlr7aN4DF4gfgSxmVUGCUC6/Y0SQRfZ4LnmQz8kzLSp17nAS87/27jqJY+U
	l+faw0oHp0zkgTcQTohLIDkm8mybRWo5JN5vu09MQTLRjeLTUHBUZ8sHcpvfBqc5sXSH7UDksQ8l7
	/mU65JBQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrNCg-000000002WI-0Zaj;
	Tue, 04 Aug 2026 16:01:42 -0600
Message-ID: <748b76b4-0a07-4145-87e2-9991412f0401@deltatee.com>
Date: Tue, 4 Aug 2026 16:01:41 -0600
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
 <20260802-fix-p2p-acs-v1-9-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-9-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 09/13] PCI/P2PDMA: Document ACS egress control handling
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> +ACS P2P Egress Control does not by itself force a transaction upstream. A
> +clear Egress Control Vector bit for the peer port permits direct routing; a
> +set bit redirects the request upstream when P2P Request Redirect is enabled.
> +When Request Redirect is disabled, a set vector bit causes an ACS Violation
> +instead. The kernel evaluates these controls together and routes P2P DMA
> +through the host bridge when the direct path is blocked or cannot be
> +determined.

One small nit here: I'd put commas around "by itself" to make it read a
little easier:

"ACS P2P Egress Control does not, by itself, force a transaction..."

Other than that:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

