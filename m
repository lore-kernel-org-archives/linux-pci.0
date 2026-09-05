Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE93385A1;
	Sat,  5 Sep 2026 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623969; cv=none; b=TSecw1M6Rvc6lI2vrgIleDnfkaLYGAMAPZU8eY3NGHhuDrSpbwgm5mCl4vbMK32zGKqVHQExN0JB/uW/ifyN+hpOWxYxmUJfMYBsPFLKG8F9o7aXDE/pqzL+U71K07MQmcUepOn0qBMIby7pu2ihAbum1p8pe8pqOHH8P/Zrrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623969; c=relaxed/simple;
	bh=88Ms9CBJlWREIAQJmo6IhlWThxZT1h/P6YYp8uaWqjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP3vwWhJwJ2IdbIW9W2RRn8BQBv4qyf5GeoLM4uGna107brFOn1oprKN08dOoWmUNh94yLiHX1MDLZ/C++ssCTEEuV6YtvGOscPHGZoIhWsVBEjvC56vEZ7vO8vtiObolrJV20UsiOTcabKVOJldkmTfnQwTo9p+kNr0gkY1e4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX7oPQdy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX7oPQdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FB51F00A3A;
	Sat,  5 Sep 2026 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788623967;
	bh=l341z0u1/Ya391BvitsbeCx2UnhGCDtNvK9lgfbpZdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SX7oPQdy5JYTnhtND74ojX5DxnoGzClVbgBusTUCVBLHDKBUBsxajdXm9fYiPkw48
	 0CLo18VnKt2oRRUTRmQK9Kca2L3BgIct32u1mfIdQnwgapk82kyyZpWooh/BIokLQ8
	 plUK7SdXib4SbhTVhItcJY36IDoZmOCWobSPIO5lPriT9HLU6PeP3Jd+ehEIO3ebm5
	 52dRWKpQ9zY8lihKaIYXkYMV8+0/myv1DQU8+VsBXcw0DAcLUSrI1rBGOxpoZBWL57
	 9ti8HKXko+DkBTAgTLylLILkfVA98muarV/SrsMtCKGpHbtay3tVazLg2ZjKJ2saWx
	 wulhl90vZFiZw==
Date: Sat, 5 Sep 2026 17:59:19 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: "hpp.iscas" <hppiscas@163.com>
Cc: Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yu Ning <ningyu@eswincomputing.com>, Yanghui Ou <ouyanghui@eswincomputing.com>
Subject: Re: [PATCH] PCI: eswin: Publish the platform driver's OF alias
Message-ID: <a22ps7dgbiwkieqlckooflugm44w2zoimlsrofmeypsqfgb5xd@bwne6m26esmu>
References: <20260905134251.67210-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260905134251.67210-1-hppiscas@163.com>

On Sat, Sep 05, 2026 at 09:42:51PM +0800, hpp.iscas wrote:
> The ESWIN PCIe host controller is a platform driver matched through
> eswin_pcie_of_match. PCIE_ESWIN is tristate, but the table is not
> published for OF module autoloading.
> 
> Publish this platform-device table. Do not change the RISC-V host
> initialization sequence or PCI device matching.
> 
> Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver")
> Signed-off-by: hpp.iscas <hppiscas@163.com>

As per Linux Kernel DCO, a real name is required for the submitter/author.
Please refer: Documentation/process/submitting-patches.rst

'hpp.iscas' doesn't appear to be a real name.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
