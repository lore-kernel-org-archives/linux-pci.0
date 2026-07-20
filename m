Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEDB41A905;
	Mon, 20 Jul 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553439; cv=none; b=EXuTrb3AibbBVRQ6xGDAGNIcGRqLlbc3b43HU3JlFgKf1R6Xjz0inZV5N7+WVizgz3BY/PshcICkyMux7wtQWOmcv5ELES6iEA9rGgdj5RtN00QKXUhrkpNUfyoNBASsY1fIw9BurKulSTvJRQMg6n55zc1CuE3LSlzVIuWE74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553439; c=relaxed/simple;
	bh=jX+mX67ZxrgkeJkqeNe8okks+Eglkhx80+ayUHc/KfQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ly218eizzbr3U8S2O4qdOc8tgdVoYPaoOHystP4NdZ4SYuEzAvKz5VEbcdNREzz6GDKkPscKNgayQvCiz0d4CBCRNkdEoHEAjpQt/CM2sdomC2b6bBUOQURy28G0M5XWDi+p3LUcTNZYy8LfLKqBzBLHewESsg3BBpXtCYQeD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekx0qK/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekx0qK/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AE71F000E9;
	Mon, 20 Jul 2026 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784553437;
	bh=QhC99x7vdLxugeCtGkIpVFaFlhQmyHyfood4QTosfNY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ekx0qK/Srb8oSP2eKbdTYsBPRyxMt/d9O3yjxos43A26fm14PVGfA99xc1oFaUNRH
	 t33/CXj4ytIGGRt26MnPn2GM3yH32lCmh3J0EUkGbmryEjN4mrgRsZ1tpDtOEQz8Hy
	 4QxR55IuxVkS02SgFKDZ0WSYhYKgc5DcDIqZdxqSMJFZQdRInsuvu+Bgit/wx0OEby
	 YB/2d3xzxjXnYSDAahvKQRQ3ewu3NupVczdRvQXI6TDe7ApQsF5top5L4+CsQ8icyg
	 SD8vyge5RQ40E6ems95LfxdFijgsxt98ytN7q+tX8TcxRtqAt0KzwtjH+5GJDO/VvS
	 85f/TrAelG57A==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
 Jacky Chou <jacky_chou@aspeedtech.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260708095814.385480-1-jirislaby@kernel.org>
References: <20260708095814.385480-1-jirislaby@kernel.org>
Subject: Re: [PATCH] PCI: aspeed: Switch to irq_domain_create_linear()
Message-Id: <178455343360.25926.10984869704341739230.b4-ty@b4>
Date: Mon, 20 Jul 2026 15:17:13 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 08 Jul 2026 11:58:14 +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_add_linear() is going away as being obsolete now. Switch to
> the preferred irq_domain_create_linear(). That differs in the first
> parameter: It takes more generic struct fwnode_handle instead of struct
> device_node. Therefore, of_fwnode_handle() is added around the
> parameter.
> 
> Note some of the users can likely use dev->fwnode directly instead of
> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
> guaranteed to be set for all, so this has to be investigated on case to
> case basis (by people who can actually test with the HW).
> 
> [...]

Applied, thanks!

[1/1] PCI: aspeed: Switch to irq_domain_create_linear()
      commit: f944349dcbaeaa9d6e1c8f2f8182f5560ba79581

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


