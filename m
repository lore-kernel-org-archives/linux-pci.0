Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93C1FF7C5;
	Thu, 15 Oct 2026 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043525; cv=none; b=OCzzyUDHZbEyxC7qUc3dOk4YdFQ+pWwnVlVjcqvWlPqC+wXqTl8MZ3Pa91AQ1qygB1AzSauPNG//Vl3lzpTAdS9FiV+z1dexXGgp7V3WfWE85ko7wUMP9m9DaJpUyk4bZJhdGDCIeBsc34bQqGJXKwsIR6XwKBoKcesnqytwNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043525; c=relaxed/simple;
	bh=4IYNkY16EAh39c6kNBUMk2l7PG2UWZs+3/kCOMzSGec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+iZJ3r1cpjugQUvZIoE1I7qSbUpAVEB+QgarSWzNH2kDeJMynh2S5ucGOdCSWCGy8vTRwaiIDcyoc0hHyyri0q/dbB9mkucYv5GdkKZQ3FYLSZyRm2okNWZxwQA6SlC2jmBcsdCMunEKYbBY/czjKP9JZrtK8FLij1yWwYI23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgD2i9y8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgD2i9y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB641F000C4;
	Thu, 15 Oct 2026 05:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792043524;
	bh=MGju5ukjNfBStkyk8gEHaDvZRVV+f+0KLBrFgdUTE+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HgD2i9y8zoIQInSEfFKm1BzV2V+WUH/gGe/EGzflmtE8JVmIDzXuxUH5tcGlZO94Z
	 eGFAVSTAA1f1OWJhZRYFkIWEGskUe/JbR5PUzZxUxhjNVZa/xQ+w0D4bO2NsHhpiev
	 8/+cdTBwMbVvtju6ADrRPeKrozXzztxuF+Ue+z6xu0bzJZmFptGHZlEsoIxL+WbSAQ
	 /Ij9B/dNm5hk6pKYqxMwX+oeuUG56hfk9d4q9hcfIKx5jeWblLtjmaQt1wfcmEIo/D
	 d/5sTx39LHEohQoOyk6YM01eSIYzL6TIaRtVymYwIk9fl5Gnku1PzlsmBu6NGhVAC3
	 MT5KSee39+Cxg==
Date: Thu, 15 Oct 2026 11:21:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.li@oss.nxp.com>, Frank Li <Frank.Li@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Message-ID: <atBo0WvV9S2xhVc4@debian>
References: <20261014053256.2378817-1-den@valinux.co.jp>
 <as-UJX1jD8ZFiBxk@SMW015318>
 <x53diijgm6cqfjc5rlihi5q2q54nxdbgvs5u3cfxg5zfdo5w4z@hayq2svzwfes>
 <j43nhj3wyu5tocjiots2xm4v2yxtngsxoaafkvxtputxxttw7j@snrzxkr66vkp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <j43nhj3wyu5tocjiots2xm4v2yxtngsxoaafkvxtputxxttw7j@snrzxkr66vkp>


[...]

> (+To: Mani)
> 
> BTW, I'm thinking of basing the next revision on [1] (thanks for the review
> there too). This MSI-X fix conflicts with it, and it's not just a textual
> conflict; the new link-event notification also needs to care about the MSI vs
> MSI-X selection.
> 
> Since [1] already has your Reviewed-by,

You mean Frank?

> I expect it to land in pci/endpoint
> first. Please let me know if you have any objections to adding [1] as a
> dependency.
> 

It mostly looks good to me. I'll apply it today so that you can send this patch
on top of pci/endpoint.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
