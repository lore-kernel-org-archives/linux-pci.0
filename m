Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3750EC1D;
	Tue, 13 Oct 2026 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901832; cv=none; b=MtvFagKyRro6q0PO7tnkiZ8Lt1hIlX81T12uD7DmKGzcoiy+2KiVbu56PLXWR+/NR6MapgunbGTZeSzqnsx8kpKccdr6VhwhaEkX7rLypL/YCJkVG0H/KUKxJ5pIFunKNQSCdDTu2Gt22Ekql78P6mWPazbBvINHPBwVXQj4Svo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901832; c=relaxed/simple;
	bh=3MFLx517Tx7IH5aCfo+sCO/6FlAkqYuYGn0TVyRjYfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aykpRIMUGi+dEMv6b9A1S/tgb1SWWzL3/5D31dH0m2SX98vzUj4CSUkvGl3x/CpVXWgR9qh64BkkeVgEhGnJ9kk1eXMkoA5EcwI9l+fEUiOvw7eei/ZPF37BtgjYZOPXEBbdM0oLt3IhXesu80qAfbUcKNhc+ieSp+b9hku4ydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hiw71KUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hiw71KUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4760A1F000FF;
	Tue, 13 Oct 2026 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901831;
	bh=hxI830Znhf1eUKwsacLAKMMhqO6J1DV7fCznwlmn66w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hiw71KUCD5C2iEwNYgLt+yXI6FH0WI37cPXhaL2ETbDFDhy1UnpMV9Gn9UkJkLzP5
	 D0XNJMDMm2462i7mG4MNsrKXwTWCEauOhGLZQ4r2mfO4c0k04FpMXB12yLHCjbEuh7
	 eeN37t8v6+P/3BITOJt/H312Rjyn8euIpVh+S/no4+/NYmm4VDY+g6AuN4L0c4HbhW
	 FYGisIVPSb4umteMt4DMhF1LkGho4dWR7JgGIh7byVaj0DgZcgWstvuW8L9VmBXDa2
	 7YTfVY6svCQ8WWLNlCiHEIRtFkTsj6rWHrnYNbhU2LlVai1yhk6vfybGo3SkU8xEjf
	 mu34zuzhamcOQ==
Date: Tue, 13 Oct 2026 20:00:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>, Koichiro Den <den@valinux.co.jp>
Cc: sashiko-reviews@lists.linux.dev, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Message-ID: <as5AVg7I_A8MwQe3@debian>
References: <20260904162049.3432464-1-den@valinux.co.jp>
 <20260904163355.165061F00A3D@smtp.kernel.org>
 <mbwka7qsw3gcphdwgl4wdqb3t4dweujrwvoj3rogxhwrpoorfx@3wdhmvi4lgfg>
 <179190161902.12828.6253963189949078339.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179190161902.12828.6253963189949078339.b4-reply@b4>

On Tue, Oct 13, 2026 at 07:56:59PM +0530, Manivannan Sadhasivam wrote:
> + Frank
> 

Really added Frank now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
