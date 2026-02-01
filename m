Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017829408;
	Sun,  1 Feb 2026 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769981609; cv=none; b=WWqUAii5GSMFQQgMxVddkAjz2gzWQCZsQAqF+acHqYj5DAxGvuiH8YnsrtXLmzEisg43RKPxnQqyuHKNeon8YsX+S5hNBPwFtiGMFpuyAMBnZQugmiymw3taGEx8qxl1HUY4nWlOoACk3SvZ60Y4ndnvgPgPsVmYhdFHTh+Og6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769981609; c=relaxed/simple;
	bh=P/xBdNFzDCB1oYLPnJGNSWaAU7jHB+/wsdP3QsByKJw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=GsLFNA91wK+imaL49p9T8aEy5bqnRr2qhijpbot0+gjJYjG9tWPTHanTtcDJAEjD3HA8E5due6NjSrJS0lQttCHCs5H5oW6osXGmExkzX4ntCFq0f+7WKBD95t995xA8kfRdIaPMyBCwM3FbhRlkv/KNnheYdeSLSVzFYLOlH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Len5HzB3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Len5HzB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCE8C4CEF7;
	Sun,  1 Feb 2026 21:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769981608;
	bh=P/xBdNFzDCB1oYLPnJGNSWaAU7jHB+/wsdP3QsByKJw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Len5HzB32w5XT59V6NFRY52UYdCM++QrvU7Q0H1LNwyG4G1zoEP9MPxzxSV7YgCNs
	 c4mIG9nmiuRZYnajLs/zOHfC3gX3r5Fer3E5ZGY5jpxRxQha/ivoQIVXpcyZ29fdaP
	 sL5cbyH0BtF6XBpx2jZRp9fcDpex5A0SVaVR6qLaR9g86hBSMimws6tFkaeAWF6yRH
	 +xgjNcS+BOemFlQJhYoi2yZwo91X2Ztgn4/bLG0khrX8Cbl0bLYGirmYq7zHfNxa6U
	 usQMrtoA0hlthzWIBq0PELCtTTMjWD0duLdxhZcT7d685cgclH2Lp3X0Yw3gI+7w6J
	 bNkMxu3H9Jsqw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Feb 2026 22:33:25 +0100
Message-Id: <DG3Y44DM430R.3OPCUJ8BP4QKN@kernel.org>
Subject: Re: [PATCH v2] rust: pci: export ConfigSpace
Cc: <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
To: "Zijing Zhang" <zijing.zhang@ry.rs>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <DG2WR3EOBWCY.DU3K4LRV4FUE@garyguo.net>
 <995384df9224283fab185b5e06f519506fff1873.1769877524.git.zijing.zhang@ry.rs>
In-Reply-To: <995384df9224283fab185b5e06f519506fff1873.1769877524.git.zijing.zhang@ry.rs>

On Sat Jan 31, 2026 at 5:42 PM CET, Zijing Zhang wrote:
> Re-export ConfigSpace from kernel::pci so users can name the returned
> type from Device::config_space*().
>
> Fixes: 4dc0bacb1d3c ("rust: pci: add config space read/write support")
> Reported-by: Gary Guo <gary@garyguo.net>
> Closes: https://lore.kernel.org/rust-for-linux/DG2D5ONS18FE.TC7K3O8V8SU1@=
garyguo.net/
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>

    [ Slightly reworded commit message. - Danilo ]

Applied to driver-core-testing, thanks!
