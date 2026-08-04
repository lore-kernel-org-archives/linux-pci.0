Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0743E5EF7;
	Tue,  4 Aug 2026 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883060; cv=none; b=QvYlkNCtIRc5cAeS3eYgTxH2CBHCJ7OuhkLgKSxXSdSTuDl2RtVXP8RtyqHfCvYVTAaTk5eLxDbQ+H2GkqQITOP1PDzOzrw4s5LfoH6y3E4sKi/91zNBzKMQOI9FQ/Hk2rZVEy0wT6sOZCzoeEIOpRg2u/NmLHnuKu40HTyMPmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883060; c=relaxed/simple;
	bh=2+fz0XgdLiME6MG7rDg34LhhTBy9hs5w1tx4b0GwvsU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=QnPqVLeHwiR0DUP9Y/YaE96XBkFbr4KtGk6+/6NPZ0teTyNOU8YfVQtbvmsrpjpapWRugvAEakN66Aco10I4noKLpjQ3f7iQbrG97ZcdkJg/8CjQ+hXZlNV89RpxMkHByMrxUbmdyo/RXe9Lr6d1PpA+2zPRHcRcRO3r4n0XMa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=CK9n6+MN; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="CK9n6+MN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=LfOMkWBgICB6fPlTDHumUh9swbQ4okIyL8I1QZvcvnI=; b=CK9n6+MNOrQDCKhled1Ma8sBtb
	2auxhjrwKlGFpXtdPavgSPzAoRC7AoDfz7N5YRzx+jP8tBQLorTys5ZW99X/sKYT6p/GXiRFcvTHs
	H3E9I7GNjsLrwQRYFJD0kq9sC+6/o/kqWDEAQp0Opq9VBuk8U3f1t7CqIyK3pZ38MVg2zyAE4swwV
	YWWV8OiNNe1ghaBLK8UvRmLD2uIdD1XROxaFHj+3egA3Gr4bT6ToYgRgTpfBssYNt803TwpQqffHj
	7Qgah/rwKEKJXJcaL0GIaANT4Tz+HSwnnW8wHO3NSmnTpdofkCy5xrBwj7/+AC7yFrnMpmLdQ6+VK
	daAihIjg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrNlR-00000000388-0WWr;
	Tue, 04 Aug 2026 16:37:37 -0600
Message-ID: <0754a50b-e69b-4c72-9ed2-33af8cbb1dd8@deltatee.com>
Date: Tue, 4 Aug 2026 16:37:36 -0600
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
 linux-doc@vger.kernel.org, "Claude Opus 4.8" <noreply@anthropic.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-12-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-12-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, noreply@anthropic.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 12/13] PCI/P2PDMA: Add KUnit coverage for the ACS P2P
 routing walk
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Extend the ACS KUnit suite with end-to-end coverage of
> calc_map_type_and_dist(), the provider-to-client hierarchy walk.
> 
> A fabricated PCIe fabric (host bridge, Root Port, Switch Upstream Port,
> two Switch Downstream Ports and the provider/client endpoints) with a
> fake pci_ops backing the ACS Control, Egress Control Vector and LNKCAP
> reads lets the walk run without real hardware.  The tests assert:
> 
>   - BUS_ADDR when no port on the path enables ACS;
>   - THRU_HOST_BRIDGE when a Downstream Port's Egress Control Vector
>     routes the peer with Request Redirect clear (an ACS Violation) at the
>     path divergence, leaving only the host-bridge route;
>   - BUS_ADDR when Egress Control is enabled but the peer's vector bit is
>     clear;
>   - THRU_HOST_BRIDGE when Request Redirect redirects the request and the
>     host bridge is whitelisted.
> 
> calc_map_type_and_dist() is exposed under CONFIG_KUNIT via
> VISIBLE_IF_KUNIT.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Assisted-by: Claude Opus 4.8 <noreply@anthropic.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
