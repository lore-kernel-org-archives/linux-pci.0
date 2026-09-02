Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B48D353A72;
	Wed,  2 Sep 2026 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358757; cv=none; b=Cc/0XhMbYyl28wVDIgxazwim72hOdsPdDomzCpcGq0/C4wGfcM4kdRNhW3ruHCIIkbCjeI0tv5eQ+Z5yOPRBIIboD7Sa7gf2/ogSw7GVJ+ZFHa09uw70chA/qRpYvtczuN5krH/2V3+q0h2ObsBZn9LKQa9WZ9yjKXkq1zOpmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358757; c=relaxed/simple;
	bh=kbrKl5e4379hEsAA7E/T/AviUYyj3FZSP0ovgl5d2mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8ejp6LU34F04M/PpxNFfoI9CqvpXtxuWa4LKj1eMw/mjLqpeHcekDlcoo+fSeM/gMwnoO9aLFI94pB3WySHeZNDMfnBGzM252s96O4rfVS+Nv1YyJB36cApAS+HuHHX9E47FH9m5PRRCFaMbuCEsxN3XR+9xPv+o6+gcjkFG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU6eYKrS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU6eYKrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E540F1F000E9;
	Wed,  2 Sep 2026 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358755;
	bh=LnppV9P7b+8rqmyGwQMs+haSzCHcWfsn64aXxpq3Uq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YU6eYKrSmZdtC8La7tKvTtTPAY5v9o5v1npTonUER9+FdVgzo9wxB5/l2642aLZ4k
	 Q7y0/3jDoiNWms76E/22/spi1QuLEjDFdgqiF1qnaT8Wz/5vjZyGcMCpv5izYMIIvS
	 d/ZlleWVATUWEJMhGlwpLFzv/wVJ1YY0uwchGk3jHxfa6DifqoYgMYuqMU+Yw9I0aP
	 KyNijkBEU8K176f3PA5uwv7nONRQRswEOsok1N6P4rPXodxdvFVsTw4wCQO0OzvMuA
	 kuegNJFxr3BWWI7Wmob9VmqhjC1aSj9YAJRX3tudrD5TUBEe+iPGs70PAebaLK7wBO
	 sGtqSo7SZd1bA==
Date: Wed, 2 Sep 2026 16:18:58 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>
Cc: jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, wangjia@ultrarisc.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU
 setup
Message-ID: <hwd2taeispmlyz2objfmqghrjftxvjwqzsguyznfnreomjhtue@h3wrfmgfde75>
References: <20260827055448.1818858-1-zhangxincheng@ultrarisc.com>
 <20260827055448.1818858-2-zhangxincheng@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827055448.1818858-2-zhangxincheng@ultrarisc.com>

On Thu, Aug 27, 2026 at 01:54:47PM +0800, Xincheng Zhang wrote:
> Some DWC-based controllers do not require outbound iATU windows for MEM
> transactions. For those platforms, programming outbound iATU windows for
> host bridge MEM ranges is unnecessary and may constrain the available MEM
> aperture.
> 

Can you elaborate why the outbound iATU mapping is not required? Are they using
ECAM or some other custom mapping scheme?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
