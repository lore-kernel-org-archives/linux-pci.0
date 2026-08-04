Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154923BD05;
	Tue,  4 Aug 2026 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880515; cv=none; b=OAqI7goML9t29fhalqcU+dHeioIYc8K0BFMxbTSFkUi1COC0y97C071w85M9O18u7L2/8k9qqSCgKiN1gOSl+CiBpF8gYYwhsp4BdxKe4PKcDNUgMtuMbv/IdjjSKj558EhtyvwxZABhUJN0LXs/Wz2Wo65fTPBO7TD3kaLkSJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880515; c=relaxed/simple;
	bh=BNlGTwv77xDvNM3zweL2sRSdgUzHcLmdv9arPz9TUtg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=XSVT+vJEewMgVJjHHO09vekoganujm1XYlOR9z6OSR1ctsDyGMC6cFa2KlOmRFu5yTadYa57Sj6g5gEpJ1veOXTm/U9YW5y6kAIRUbAx+5/6YCIv3h5XG6gDM8ddsHvylCmEYKpc8AqoFqXbSQ97GKwAlEzW7fj6fJrqEymrOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=A92oTeFj; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="A92oTeFj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=dS9LmTUFhhFis1TInv9ZHMbZSCzKM4cd3EJM1VsS6Z8=; b=A92oTeFjLcTu19/PMCBNLy7PgA
	53J05E1ADgTZW/K5Et6XuDUqNPv97+hxMNDRJ2ItqOkref+ITMiQCj7riiB7slVF2WSlLV/qxWTcS
	08OPD7rkPKilK7qUJ+14u+2LshSWE7MO05TcqlW9VRu/DZEQjVYwm/Ymg9z9LCgWunT9LphkJa1In
	h20J5oFtDa5TM/8jFRYV3H+eFAK9xc4UBbs1h3ux6lhQJIvf/fiL6rO3ol3kP3oTFO6FrlIFX4TIf
	IHka3mJ+4gzOodUDdFonzdXYCsyO7PSxL9p9Ne/dapPncrxY0ShfdJIdiwLzwE5PPz6qYRxl6k+Fi
	3fFmZQTA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrN6N-000000002Rm-2Mm6;
	Tue, 04 Aug 2026 15:55:12 -0600
Message-ID: <b69d8971-e1f5-4289-ae90-312f20cde3e2@deltatee.com>
Date: Tue, 4 Aug 2026 15:55:10 -0600
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
 <20260802-fix-p2p-acs-v1-7-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-7-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 07/13] PCI/P2PDMA: Derive peer-to-peer routing from ACS
 control bits
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The redirect test reports an upstream redirect for any ACS redirect or
> egress control bit. PCIe r7.0, sec 6.12.3, table 6-11 ties the outcome to
> the control bits and the target vector, and an enabled egress control bit
> alone does not redirect. Compute the result from the control bits so the
> vector can be honored next, using the host-bridge route while the peer
> target is unknown.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Ok, thanks, this is not the simplest thing to understand but I've
followed through this and the next 3 patches and I think it makes sense
to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
