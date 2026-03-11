Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4D1A6805;
	Wed, 11 Mar 2026 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209886; cv=none; b=AX069WWaB1rk/WtUUSTPJtv9OXdAY44F1s5yQIfO0big/F7eYzFm9DowHM53QAWbkU0J6bhDxK6NbcuY/esSQtrgfJF9ZrRs/85DxmrYudKRCnXzNoh/ZCCfuikh/eY96zKCB1jDdFrsnTSRoxnQYQSdGxSdGfemnY//f59Ufv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209886; c=relaxed/simple;
	bh=+TnpEu3N3Wg7VpR+WRJAYIJe62zec1Zk48SN+3Vy2Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OX4uSBOOjrBA2ojmph+dfvTF9KcjZmUDM32JiJZSy93qEVpxor4nDewFZdzWkC525x2ibGfDs6c3rgwxj+l4s8lbfXvdA/IPFiGQzLJ30p7DhdeyH6EmMbKKPiBd8PXFSAB0TSft5XXzFwmLTcz5wCe1uAX8S5Q7gYDMpCspmQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER78y/T4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER78y/T4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990ACC4CEF7;
	Wed, 11 Mar 2026 06:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773209886;
	bh=+TnpEu3N3Wg7VpR+WRJAYIJe62zec1Zk48SN+3Vy2Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ER78y/T4wbCKahMJTXQyD37d1K5V2ARZEJ6uQtzLepoASt3iZ2FpZz1Kj8CRD0qlS
	 1G1t8oOECb23RA2UsV3ZyVToUesKNao5w0SOSU4UrJLtGbgFGbCYrNMTF0cVIs7/1U
	 35qE4faGd2RnFiQjlS3zrCxIy4jokHlx5A99hGs/G99qvu02NPEiv2Fz2oeq0sVX+O
	 lX3KDU8sqCnvRQnvqzTsi0e9STWbomld1dVkx4nAnQRBl4t0ZGfojzZCxCZd0Gh6Ps
	 7Y0jFwqc9SAd0s+3WoLEgSKQ+Zg3ptCsVxMkI2JlWZjPHggN0pzVaUtiguZHTNRH1l
	 2Ef+hIpMklArg==
Date: Wed, 11 Mar 2026 07:18:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: PCI: pci-imx6: Change maxItems of
 clocks and clock-names to 6
Message-ID: <20260311-invaluable-nondescript-manatee-a3c4cc@quoll>
References: <20260310075459.726495-1-hongxing.zhu@nxp.com>
 <20260310075459.726495-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310075459.726495-2-hongxing.zhu@nxp.com>

On Tue, Mar 10, 2026 at 03:54:56PM +0800, Richard Zhu wrote:
> Previous commit 1352f58d7c8d ("dt-bindings: PCI: pci-imx6: Add external reference clock input")

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

