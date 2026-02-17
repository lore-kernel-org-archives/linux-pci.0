Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26631A800;
	Tue, 17 Feb 2026 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326642; cv=none; b=fmbaeu+Gywn32B23druJH5MEIVxT58Ce7dhWYUmo943ByTRjzZA4Gc/GiJEDuEZPmjrKHGcoQD65C/HJqy3KdyBswFXTnNykzMmACUztPQ0DJAUkAgtknukiTBAFMhLS+8LRE0YFf+sj6k17eYeoTUMmbVuePtdL/V9PkpNk7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326642; c=relaxed/simple;
	bh=gHQK+7Chcd4VthUF4prpwCvbHfkpJN2yH4VNIqApsd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmrPA6F2524JDgoqfK7EnP3hmb9prrwI2CeqqJ6bW49K8PPkQywaeyQVf42cvNeQmQJc/oDTk5h9l9kyiUhKWp1FLsDGEFPW2ItSMuKOyHY2hSWzgW/P6AOUdxgzgCS3ZO0MGxO0lrz2z68IAysXiAIg3doJiLYG9sDooqqQ89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqXLYE7x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqXLYE7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F53DC4CEF7;
	Tue, 17 Feb 2026 11:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771326641;
	bh=gHQK+7Chcd4VthUF4prpwCvbHfkpJN2yH4VNIqApsd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqXLYE7xpPVZuxMxVbW2zFnh8282AFd8JY7ggX663f57ysjq7cuU8c9qYGIhR2HC9
	 sHbV7Kc+xvHEpxsPEuP+U9Y6jocx+0qtx8FkM61d69EtMFQSRxoDrgaSIz1uvqi4gw
	 vBSrynBXszjDJuNxI2P483WbIitweAHQWR9SALhIJ68UiueXwBdovwVLyIWzmCWgxU
	 a4hos7NF72b8I9f7qR9mgJrTIhwaZ7zqNwXdlM51m4+03oMmfkq1tvquQz73jMKfgT
	 mBGLbvR0i2xqf6IpGZM/7SAh/Fgb4kR7MN1M3SOARxnhQJTIe3RTzu7hsRow2on/Ig
	 PeBwuFIbrMAFg==
Date: Tue, 17 Feb 2026 12:10:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v2 1/3] PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ
 unwind
Message-ID: <aZRMrNlmU6cgrnVo@ryzen>
References: <20260217063856.3759713-1-den@valinux.co.jp>
 <20260217063856.3759713-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217063856.3759713-2-den@valinux.co.jp>

On Tue, Feb 17, 2026 at 03:38:54PM +0900, Koichiro Den wrote:
> epf_ntb_db_bar_init_msi_doorbell() requests ntb->db_count doorbell IRQs
> and then performs additional MSI doorbell setup that may still fail.
> The error path unwinds the requested IRQs, but it uses a loop variable
> that is reused later in the function. When a later step fails, the
> unwind can run with an unexpected index value and leave some IRQs
> requested.
> 
> Track the number of successfully requested IRQs separately and use that
> counter for the unwind so all previously requested IRQs are freed on
> failure.
> 
> Fixes: dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
