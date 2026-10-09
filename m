Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489353DA7E3;
	Fri,  9 Oct 2026 05:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522103; cv=none; b=WIFPcyEQpTtCNEvM+o5HzbZSP1W5GsRUy6D2ICYcsbHO+wRzV7HoVEagC728mEDDOd+i8rbG0aL3oH7Xm6TcRqdD0VnpEmJ8vcAfbdSDxFPVTA9/1asZAX97M+dF7hTkH8CKobYwn9lHkbG68axpjvCLuE9nOWCvxUFd97QO+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522103; c=relaxed/simple;
	bh=qDR18W/67HY/2iWirn3jnaIQnUfp8Mzb0wsaVwWsE2c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AKAVhBWvsu8ld4PROQjdTINk0a4YTt/f/Y61TRtcI2oXgzGF7vluIIR08F+zmsNPpX+j9R2s+0LjHdoKXCulVZl4JAHeKLXQFFPpVnhbSPrX1TsA/dWhzc7h7mCuioLvFOy+cs/Z5O1gdxf/QTDN5wDU3PnmoQzqqAKWlKT2Ov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImVqtgF8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImVqtgF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06BF1F000FF;
	Fri,  9 Oct 2026 05:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522101;
	bh=qDR18W/67HY/2iWirn3jnaIQnUfp8Mzb0wsaVwWsE2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ImVqtgF88tBCau9KzJByTp82CM+U4uskR+uie/NTIZaUYaoU5qTRxa2v4NhOWF13c
	 x6f05pPryggN4+rv6SlqQSh1jRQcQjGLh7Vk9Sdtc5EAPVym6KmqhsTvB52UUPh5qN
	 PzNNXNc4jFjFVRsZg7N8UQluUXiPTiztRkYcZUfTX0bILeYydW+tkleRBkwaT7Et95
	 7NB3V5BWT5NlINyTW9E9ENXdu3utmINlDl64DpQYsPvzqkHYn7AS1102GJoERY64F/
	 sB9cmStrqCJdr/RLlSdLCHPyX12/8/iymTTu1+gqjDsjg2nng/mHhU05PTTyE62k7z
	 RrNMKV/4f6c/w==
Message-ID: <sashiko-outbox-164862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/7] Documentation: PCI: endpoint: Document vNTB DMA
 export
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20261009045949.1109871-8-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
 <20261009045949.1109871-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:01:41 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the dma_bar attribute and the requirements for exporting endpoint
> DMA channels. Also document how the selected BAR may be shared with an MW.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009045949.1109=
871-1-den@valinux.co.jp?part=3D7

