Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B13C1419;
	Tue,  4 Aug 2026 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880594; cv=none; b=JvveYu9hK6tyieAoqHOVQ5DiCJ+yEHgcT5cRtu5mhp1r/BGj2VFu+gNGGpAuaKhpxMLkxJXYJCebudnez0rmYf7QH5liJvHySAcU12FU9MBJDiM2aD1Yn12SYvRdnarl1XJY78TsDx9zzNChwsclDkMfFKyuDrnZZ5Wgf4e+qtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880594; c=relaxed/simple;
	bh=tBey52MboA+QfPgPpyx86JHVOQeKwAmSVSv2V7yNRH8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=P2UKBNzhfYWlopuM5kuC6AW0qjrrqsGMpk26d3Lipz9BA7BIzXCVmei152D87GCl8oLpnq7GROghZJBx/TNlOhR/9Z0HeRzp3WdfjAI3H5Ma6UPI22SvCOKgLjEIkVRZUNLuiSUQZG8LaL5TPbsNHQC93OmaPeouge2BoW9HkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=UbkxYsiH; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="UbkxYsiH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=2ZjaPusGm7oCCyaWHdROo0ArJZ50KdqtcdXZx/MR+bc=; b=UbkxYsiHglvDWQJbRDi3GYDmU5
	ihFi9HCuCCSbJ/T9BUrYJENtWPuZEvtq25T6AS0KWQbjlc77SEZoBon8xUi1a3jsJFeTJZp8nQZLZ
	70Xnik13lHMf5QNF+Uog4hIGDAxw5JTGV+CDajCgJfnangsbj3ZrDc80Wb7d3CaCTTGKbXUucytZe
	3q5xfG8fxqTmkLwjng7GVf14MvCknK8KEtP0OCJV1BC5NBqf/lQ+Sh4kZ9LRzmj+FDslLnPcE8YmN
	D8kBYPQcJwdR7kFwWyJe63lYZyQpVoIxOd7UQnabX6P2n9uy/W9Cb+bCRH1tBR1D8Wdk1yZIG5M8i
	qLd2fDCA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrN7f-000000002TF-28JA;
	Tue, 04 Aug 2026 15:56:32 -0600
Message-ID: <7d91cae7-1c57-4244-b019-51f374603124@deltatee.com>
Date: Tue, 4 Aug 2026 15:56:30 -0600
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
 <20260802-fix-p2p-acs-v1-8-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-8-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 08/13] PCI/P2PDMA: Honor ACS egress control vectors
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> An enabled Egress Control bit does not itself send a peer request
> upstream. PCIe r7.0, sec 6.12.3, table 6-11 makes the outcome depend on
> the Egress Control Vector bit for the target port: a clear bit routes the
> request directly regardless of P2P Request Redirect.
> 
> Read the vector where the paths diverge below their common upstream port.
> Keep a clear vector bit on the direct path, subject to P2P Completion
> Redirect.
> 
> A set bit with Request Redirect clear is an ACS Violation. ACS acts only
> on peer-to-peer Requests, so route it, and an indeterminate vector,
> through the host bridge.
> 
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
