Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093961;
	b=MoVW1kGBHgYKzazNV1of9J01oL8wmsEDSbYyksnFfdUezswGSvybYCkAJsURDqAFMDG6
	 l28uAhFmal+mDOyLR+ZWafUNqQs2tNUwrC/xv586Sgz+aN3nY+kcT4tqKHG8ONg7KcA4T
	 yPRvcRzmHFk6SOP06T6VSPQLf5iSQPhMdcRBl/thUTtzLIx2kOIp66i2DbIFD3dv0lLYc
	 buH1g6AflY/FeMn/wcBzKwCxku1ZeGubQu/3WEiaxq3AieVGi5WL1XkgYBqmXti+9LEmC
	 nBFReMzj2UDoSE3BNHin3l5pLlQkVWgbfZpCagLoZkk8ogb5EfKOy4dlRXKVChbZLDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093961;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lkXZm5NKaXwLnDwDjIWKPOUBRSTD+JqAiGd26MhjLyA=;
	b=cwLBudbTDZK7fjQCfjCNZkSgh5aF90177EQUk1VtHtUiDibUJSi+Hw/gkOU9RZG/z0jy
	 MAZF4VpKy9gE5xpjvpCz1W3yJ3cVKpUF2QoFan7z3maJd2uM7VorFU7rgQnqn0cHCPlaI
	 omDsIyHsdaisI5JwEqBUkh5WO2Cp7RlrEps9j406EIgk41ME/5EUjKzJfo86FIWCDcq+v
	 x6q1lCCpEkSZD5V7tgGcTbVfa+ijW3iD+zp79UzenQDo7lM75D1/njZyxg6pwC6GDg22u
	 NCOed7CIby9580GWk9g6h1MxOtijiyBQq0Otmobu/G6HI4SBtEQsGxPwbxuuf2rU0ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTciaAdD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 270FA606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTciaAdD
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 067EF1F000C6;
	Thu, 19 Nov 2026 13:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795093960;
	bh=lkXZm5NKaXwLnDwDjIWKPOUBRSTD+JqAiGd26MhjLyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GTciaAdDwr/woqstlq6RxNaAGJprNMhYO6bKYsb+uZnzJ7mE4LsXFKMxOLz4jN8cS
	 HjIZhFHpLcODIdCmDdskffnw6jxBgsyeNli1dCTfU4SUaRYMoqfw4Sr1PHGvppDk/n
	 vIcT6P9cT7T2PzEE+vM+WrDnL2cQcs4xVrBCtndAGgK7Icl1GvsCu6PxuLd5IUw33q
	 6wb32mQOibJTk/hKsg2NkordvVOz1M6oMMHDYyLqXq0Ok17c7xhI4r7qi7e39wU8UE
	 jv44r7WxdTOKfz8PPo4+5WGTgvkmssEgSwTqGCK1tT0yHT/+sWgo0wW/6Qu0V0k6cG
	 LyuLBeS8gMmUA==
Date: Thu, 19 Nov 2026 14:12:37 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Abhishek Kumar <abhishek.kumar15@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, krishna.chundru@oss.qualcomm.com
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: Enable 8 GT/s equalization
 fine-tuning
Message-ID: <3ru5dshu5gpp3qj3g5aselcwkdlffzl5uwrzdkengukmbttd6f@yfcbwayazcpr>
References: <20261119-tc9563_fine_tune-v1-1-b83c74bf1e94@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-tc9563_fine_tune-v1-1-b83c74bf1e94@oss.qualcomm.com>

On Thu, Nov 19, 2026 at 04:57:12PM +0530, Abhishek Kumar wrote:
> On some boots, links on the PCIe switch report a continuous flood of
> correctable AER errors (RxErr, BadTLP and Replay Timer Timeout) at
> 8 GT/s. This happens because the 8 GT/s equalization fine-tuning
> setting is never programmed: max_num_of_fine_tuning_iterations_at_8gt
> in K_EQUTUNING_033_028 resets to 0, so equalization only selects a
> preset and never fine-tunes the transmitter coefficients for the
> channel, leaving the link with marginal signal quality.
> 
> Fix this by programming one fine-tuning iteration on the upstream port
> and downstream ports 1 and 2 at power-on, so that 8 GT/s equalization
> adapts the transmitter coefficients to the channel. With this setting
> the links no longer report any AER errors.
> 
> Signed-off-by: Abhishek Kumar <abhishek.kumar15@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
