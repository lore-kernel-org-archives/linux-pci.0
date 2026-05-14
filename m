Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C1221DB6;
	Thu, 14 May 2026 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740963; cv=none; b=gOno/4hTLL/AmOZQG8h71Yc9RPx2KGTpLl5KnAMq/BtVfSKmlTakjazBOtj429V3i+TIBqIWgOlRyICu9L5mvdbvZqiIXjCSA/GXL2XpLMny+WwBKV+MAQNVtz0ONVl/1TtzD7rJMjDWtCHKyiwuQaiHAuQWjyIRLZuM+VkybKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740963; c=relaxed/simple;
	bh=u6Fv4WkWRbnSt3GLKcz8V9+xRKv5gNL94RdpSbTxSKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxXVkv2jxi5qzjoWhWpPKB0mJ/1IzU21jodDc7cuolOCbVasUr9mLWSZoZI+mz29h9ky2OgMvq3U7b9ZGPJGVsCjjufC09JM3E00BwlJBeHNL0BVsoXv5rBV0mqorDbOd39vwJWkY0LB6X9xGjWwoV9bjuo6Dlb8afF191Ztgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRP9w5RW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRP9w5RW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA4AC2BCB7;
	Thu, 14 May 2026 06:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778740963;
	bh=u6Fv4WkWRbnSt3GLKcz8V9+xRKv5gNL94RdpSbTxSKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRP9w5RWQyD9boQWSYflutS/uF/Jr4aFBSoJD/xQmVS4SZ6CfaByKwo7oTDvl5rqf
	 e53gIbu724mcQwQNNdg6W0SmcGAv50YSEl1BpNdDSaHLPKqmfavveLBiJp+M/7HpRs
	 uu2fa80OU/3FQYXWTSjpNavl3W/anMStzhc5T6aU4qECLK0RgH5J2TZT7VRVTIKWYk
	 ygjtSoRqhOQefRzLMlWenSRXPC20u/sDrpMrDIXUXEGV6hbXcg3ZO3qCUl/Ls5wBqr
	 AMoEkpdon3IWZ45pvo1rQ/zGBQKEPe+wU+XheZS9mnucUM/ksNSzZSdKzHClzkjo1e
	 L5vZUenp3mV7g==
Date: Thu, 14 May 2026 15:42:41 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Manage hotplug attributes through group and
 make slot attributes const
Message-ID: <20260514063920.GA1038693@rocinante>
References: <20260514-sysfs-const-pci-hotplug-v1-0-3b0b6c6f7481@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514-sysfs-const-pci-hotplug-v1-0-3b0b6c6f7481@weissschuh.net>

Hello,

> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

No cover letter?

Thank you!

	Krzysztof
