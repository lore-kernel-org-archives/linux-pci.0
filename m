Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38FB271468;
	Tue, 10 Mar 2026 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773184751; cv=none; b=CHH2z2C3Crq7VOmBTQo7wBkzrkagMpJRge3aIipaIqQNnUX5DtQ8qStDFA96e2TSfaAyy9X+GRaKogosnuIuj5UmNXyTcfWzG/YqLBRnsZ3GW+iZu2DmkPU+zaJbDwE1LPYQTPadUZNP6TPm3VP8aBsasmfMnEXF+dNk1ZMB4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773184751; c=relaxed/simple;
	bh=VKt4TguhV3l7TB0c2pw/qx9dm4urWTxkSrePuNg0CTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JWkmqN26jwM/ejjMFxYIW0/TOW2TYXgaKVacAyoo29O4zKXoTrAMrr1zYzNqgWcAH7F6+VjuyvVE7El3IN6xOapx5yBG6eWHkMyaYpbkEiDAIIIColntY1P+iJ67ax/hTBbZD/ztZciT8z9VhC+2cqMXkW7pSsbAImTsojKJQCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzLhpTHn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzLhpTHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B14C19423;
	Tue, 10 Mar 2026 23:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773184750;
	bh=VKt4TguhV3l7TB0c2pw/qx9dm4urWTxkSrePuNg0CTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZzLhpTHnmI7oYiSCX1jCPAGN4M+auj53QhucBYMgvkcfnm4J1VwHmPduPiSfQUlSU
	 PlOUqvox/vvhiDnEnWFWRantVe5iK77WuzOOTV7mhcOlGyAiYZuJ3Ns7V4O4D9iXD+
	 Ecai+2dyXcXfOiinfvnZj9Vsl3Crckvrg8M9mQUAOOq/nzoH1mD1OKfMCoVT0GLIjx
	 zfMzn7VdGaZ9PIWOJW483WGrsVCYEgEk7uqhpUK+6/1x9FrV54fMr5z1s3tPZLfcfS
	 YS8lVHAvkc3WfOsKyzDEKHW3UWSc9WDKY3BN9MpnIJvSgc2nZYZFXwZDrHsAQnfXt1
	 l/5FoKuN+XQGQ==
Date: Tue, 10 Mar 2026 18:19:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/7] PCI: mediatek-gen3: Clean up
 mtk_pcie_parse_port() with dev_err_probe()
Message-ID: <20260310231909.GA860802@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310091947.2742004-2-wenst@chromium.org>

On Tue, Mar 10, 2026 at 05:19:40PM +0800, Chen-Yu Tsai wrote:
> mtk_pcie_parse_port() in the pcie-mediatek-gen driver has a bunch of
> 
>     if (err) {
>     	dev_err(dev, "error message\n");
> 	return err; # or goto
>     }

Mani, if you apply this, tweak this to be indented with spaces; this
has a tab that makes "git log" output look like this:

        if (err) {
                dev_err(dev, "error message\n");
        return err; # or goto
        }

I had already done this on pci/controller/mediatek-gen3.  ChenYu, if
you repost this for other reasons, you could fix it locally.
