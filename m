Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9502E5B2A;
	Tue, 10 Mar 2026 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186161; cv=none; b=daxXZ98RNEErH/uyqAPE+sUtS9u7/oHaac1qN005+/g544DOa0SwLYtdI7XkAl3zVvKeEgWrUR7fZMZ7ogy0xIIz3PizO/NyYTjP5Jh3vlAYYnVwK0FDtTXfXGEmG7ohMd5NaN92fj9fgacgXxOuRn+Rw7DV8x01OZ2HPmL2Ls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186161; c=relaxed/simple;
	bh=Rpuzb3qFLIHbB4t+hFWiH2qTADPLyy65pzE6mzOqFfw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kHlc+ID0WFGUYneNLMAHjHVgE08G8cwKwyidlArctaDt3TmfaCihB3XRFSa6qJI0wHxycGaCV4Ff2uQUcwN9We3PO91VbV1YLdLvgyybwqLlMsBm7q60ZIHqkc8WmivckVq+KZQKemQLrmUKpjUTA7Tj5+uFgTjejkAbONmm6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4pxsZq9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4pxsZq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06860C19423;
	Tue, 10 Mar 2026 23:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773186161;
	bh=Rpuzb3qFLIHbB4t+hFWiH2qTADPLyy65pzE6mzOqFfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q4pxsZq9nfJccNFgGTEpooCkqvdoKMUab7Ic79rlNmQmB71UyflWjnNtPKpHZp6bO
	 2I7c+vpokSgrBMXUXywc539WELU4Q2EtOd5wkkhEteR33Japc4j5NgdZmXHTMZL5I8
	 HHpAHLdkPw0VVuRUXJxwQvjxQvxikTDbfcY6E8pGPZBDrQ/ygx9ZzYIgexzzbj79Uv
	 he/00+lPgwYf6weNuwarrSbJDxVHY0gi2jdUD2wMZ5OtZiG88ewcVET/pBc0iDkzPG
	 gVmtCHU9eU6aC93ywrbOO9xHfSl9K9b5Q/kxuSbc6WF3Q0SdIh9apsK3fuRvD6Hefi
	 P8lZ1VDvIB86g==
Date: Tue, 10 Mar 2026 18:42:39 -0500
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
Subject: Re: [PATCH v4 5/7] PCI: mediatek-gen3: Split out device power helpers
Message-ID: <20260310234239.GA871399@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310091947.2742004-6-wenst@chromium.org>

On Tue, Mar 10, 2026 at 05:19:44PM +0800, Chen-Yu Tsai wrote:
> In preparation for adding full power on/off control with the pwrctrl
> API, split out the existing code that only partially deals with device
> power sequencing into separate helper functions. The existing code only
> handles PERST#.

> +static int mtk_pcie_device_power_up(struct mtk_gen3_pcie *pcie)

This function name suggests that there's only a single downstream
device, which obviously is not always the case.  When you later call
pci_pwrctrl_power_on_devices() here, apparently that powers on the
entire hierarchy.  Maybe this mtk_* name should be similar to make a
connection there?

> +static void mtk_pcie_device_power_down(struct mtk_gen3_pcie *pcie)

Same applies here, of course.
