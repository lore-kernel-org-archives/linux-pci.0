Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B63F660B;
	Tue, 10 Mar 2026 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186555; cv=none; b=ET09xVe93CtebjvlpOHdUUHZyFgdF4NkPdW738Tzm/CvvpTEY5mNU96ieb9S9lgftBSHPWjQrPR59dU5dv4U6Wf3cW9TGUtf1w6I8ISs0LEBrbK6mmC7Qp6yjemN9HFtbY1Oeswo0PU8puJKTfmopo9ElX6508N0xheV3ReOhqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186555; c=relaxed/simple;
	bh=WKyMe7L4kmEhFwVr7IreJCVbASQUbCuM9pTkohLng58=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a/0Bbv0TCejH/KVH4xytSLbPXrD6kmIS7k1HfEIsZAv0CWaOSnWgdSXxoGoCP9J3euQGTkH+RMrzi3o2oXAZDDNpwxR1tFLneAN5tRIaFj+IjJad+ZMjoU08z/eaiYXvxAEAoE3+YIGPtW3EYL3WQWhF6IZ6T6YcVRBUIATVVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz9jftw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz9jftw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70775C19423;
	Tue, 10 Mar 2026 23:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773186554;
	bh=WKyMe7L4kmEhFwVr7IreJCVbASQUbCuM9pTkohLng58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Gz9jftw3oyW7mcL6QP2edC5JvYUfVj1j0c8NTHRzsTYtr70qC2WdthLp6eela6HGn
	 GREjj+o3SDG+LORvz0VchHzlfM4aPvSsxXBkco7dEPIiAiJJpboP9IQVFf7Nq8JvZQ
	 kU5Par3SJK86OTxJam29fEdfV3a2hWNSsKVifr+yPUXfIRLDUQQ+sUaHdxowVoNihk
	 bSirhWE+mH1/IZ2VmVhN+Yq8ivnx7A9kAsHLUzuSTHC9w3Js9oW72tI2j0hQGJgacE
	 GBN5iiAGFRANR2r6FAeUO/Oxu8ikpzej139Vf1AveXs/+OescUdAaBSttAZG6MB/BW
	 sQTrLHT4c9pUA==
Date: Tue, 10 Mar 2026 18:49:13 -0500
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
Subject: Re: [PATCH v4 7/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Message-ID: <20260310234913.GA874899@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310091947.2742004-8-wenst@chromium.org>

On Tue, Mar 10, 2026 at 05:19:46PM +0800, Chen-Yu Tsai wrote:
> With the new PCI pwrctrl API and PCI slot binding and power drivers, we
> now have a way to describe and power up WiFi/BT adapters connected
> through a PCIe or M.2 slot, or exploded onto the mainboard itself.

On pci/controller/mediatek-gen3, I had replaced "exploded" with
"populated".  Maybe "exploded" is industry jargon, but IMO it's a
little bit too obscure and evocative here.  I'm also open to something
better than "populated".
