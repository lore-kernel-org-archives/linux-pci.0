Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B43DFC61;
	Fri,  1 May 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654544; cv=none; b=SGoSu6P9Es2NzLQTjs2Z3/3NJqNZ0gljqW/j59Tww+x6Mm3/tnj0c5QzY3PbThSJTF4h5DHOSwamtqyarAS5cwpTj9XGFFksnvct22dIBk3eXnJe2dxF8NLm5AbQrax7KNvNK0ibTRA6mQd08w5BM1qhchD4pU3pWBTXzX/wZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654544; c=relaxed/simple;
	bh=zZEX11EnodeOPZpk/nnPQyXHsNzmC0XGnL5siN3Bd94=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tQzOt4LHp1Gw4Ei/nLQQgyKXderNeoW57t/j/6fPN7aVKdk77wQYJcd5Ec/w1TnPNHSa8CGf5WovpOzmmJHK6YL4O1mebEGy/KsPnIteMFD2kp+PrfEfpYUinZ5FS6AuhBvxab2XaVvPt7mU3wWYkhibbMvHg359jEC0V8Sm/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ehjsaifn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ehjsaifn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F22EC2BCB4;
	Fri,  1 May 2026 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777654543;
	bh=zZEX11EnodeOPZpk/nnPQyXHsNzmC0XGnL5siN3Bd94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EhjsaifnSEQ9wgEVc8AVz4wYg13nMfDLPPzpVUZTH1dznjDbag578c9RpPplfp+yH
	 m1e2RIDAN0z3q3MflucrFj/XyFfFg+F7kwhirI4c2WIB8vu4D6Kw88VIsiguHdzE7u
	 P7jTtN0CnT9aCHkpmOFfi05BIuPbLCeTtPixgabTu0b9tfYw1+N0Ou4Ut8qFfOmO05
	 OhvYXrMkkWd8Ki+UZHdV8q0Inz9jPc8FRnyJ3RSq0Ygb18hCrmDP2gU4pOqEB9U/TX
	 /mt6Acjg+mUJRyirgEPr0YejDcPueACrAMCQVFr9cJXK636A568YnyHKGmKoaceewX
	 +YmDs+xipzEQw==
Date: Fri, 1 May 2026 11:55:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthias Dittrich <dittrich.m@gmx.net>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	regressions@lists.linux.dev,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [REGRESSION] PCI BAR allocation/D3cold failure: NVIDIA MX250
 inaccessible since Kernel 6.x on Acer Swift 3 (SF314-56G)
Message-ID: <20260501165542.GA491695@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a27da33f-96da-477b-b7ae-e7bcd3a34796@gmx.net>

[+cc Ilpo]

On Fri, May 01, 2026 at 10:13:41AM +0200, Matthias Dittrich wrote:
> Dear Kernel Developers,
> 
> I found a regression and did my best to identify the issue and find a
> workaround, but I am not a developer. I also published the regression in the
> NVIDIA Linux Developer Forum, but it appears to be a kernel regression and
> not a driver issue, as the latest drivers work on older kernels (e.g., 5.15)
> but fail on anything 6.x+. I did not perform a git bisect as compiling on
> this i5-8265U - because of its low performance I can only compile one kernel
> over night.
> 
> **Description:**
> The NVIDIA MX250 GPU on Acer Swift 3 (SF314-56G / BIOS 1.14) is inaccessible
> on any Linux distribution using Kernel 6.x or 7.x. The device fails to
> initialize during the driver probe routine.

Thanks for the report.  With the newest kernel available to you, can
you please capture the complete dmesg and output of "sudo lspci -vv"?
Don't filter out things that don't seem relevant; we can easily do
that.

Bjorn
