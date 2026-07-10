Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC383EFFC7;
	Fri, 10 Jul 2026 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672025; cv=none; b=hqb+Lxn03y53SZSp0WM/KbpltooF4rAflY8DQMnfCWeWOHsB6BcbZs73avGPs/7yqwNqyx3RYDWg21LDiRqrLiSqf8pm75IktTKGqYjRyj+vo9+8LuWwJRZxfBDOg0R6k3JM/NNQpAjXao7pSkphk/fa1JNG7lDKypcOQ495we0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672025; c=relaxed/simple;
	bh=0VYkM3uBUArqVEXCrFBstg1rybYH2SysBxCXUfrGiXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovhc//jk1lP8A9t0m0cHDgJDbWyZ4fQKk7j0KMxi57zY81UozZafLNVTxDJ4w9iSNA4ghulnldXvXba/0Uzl8vMCWxRmbvVTK4XHRLuw4QRWPTL8P4UCHEAeq1U87mC14cp9C3wEDJojpKfbVeQQd8VinzCd8I/Pxf10MG11gxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8nIWIZG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8nIWIZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC001F00A3A;
	Fri, 10 Jul 2026 08:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672023;
	bh=0VYkM3uBUArqVEXCrFBstg1rybYH2SysBxCXUfrGiXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y8nIWIZGYqucZMT4p9BmEz0a0kQ4S8X+RLckmdhwOQ+URQcUKKaTxlTEHzAUQtNT9
	 0d74POH+yTiCUkN4I8q+JRUmBv0ZS+Z4cktMao0xJZqc0+meBVu9v1zi0JaMeRlJjj
	 mB4YWJfjF/VsQRELn+lHEU/EddkJbucxIamijMFtagFnrlcxbiH/K2B6olBxGn/JnF
	 y/jAaoUaWBhbkX+xxAXQzYM0FGM3x5V/LRm+hRcxP0sCHk0ADH+ia8kMWbAYomPzyl
	 Idmyy/gzwysB8lCo2I7M9EuRexZlY1T89nET0dKW/FJoxNx+KrogXlk8aP+u1ytcp0
	 +ZEFyz7W+Bw+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260710082156.2395844-3-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
 <20260710082156.2395844-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:27:03 +0000
Message-Id: <20260710082703.8BC001F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Extend EPC auxiliary resource metadata so endpoint functions can
> discover controller-owned DMA registers, logical DMA channels, and
> descriptor memory.
>=20
> The DMA metadata is intentionally generic at the EPC layer. A backend
> reports the register layout, channel counts, logical channel resources,
> and descriptor memory resources. Logical channels carry hardware channel
> numbers and refer to descriptor memory by ID; reserving or delegating
> those channels is handled by separate EPC operations so resource metadata
> stays independent of any backend-specific DMA provider. Descriptor memory
> is identified separately so one memory resource can be shared by multiple
> channels.
>=20
> For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
> format so a consumer can distinguish legacy, unroll, HDMA compatible,
> and HDMA native register layouts without making the EPC API itself
> DesignWare-specific.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710082156.2395=
844-1-den@valinux.co.jp?part=3D2

