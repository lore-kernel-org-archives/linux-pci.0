Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7447D46C
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110192; cv=none; b=TQZQUEuVrYuqUiQWEAhkqu5iq7ZNsifQXyV4n8YlCqlU6So+/WI18qhY7r02eHxTg121Z6B7h2Xy9psKnXSQrPP6nMlPVo0xu1VtVobGrx2JNBGvfARmvgW+ZGStBazRaAy0l9MKjgWdJGNUx3UdGxsIt8Fi4PtqWMmdon/2iJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110192; c=relaxed/simple;
	bh=hcl54zkMhgdUMvI1hQ4c2g3wUaeHhuuPAC3UZUDlAp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mTZkEgZmXnIGkY40pTy+BwSd8DtB3+yLLh4jdk14q5wm94z8DojHlh/bt/OaLQqdO6/dVXZj4xhcRjtc1oo6krtTca04c1jOQ14wqc5XmrIbG08PqloUXNeYbHtJr2LFVBhra0o3hxcAXkr61h81U75k+C7MvMrxZA0IkXNebvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6fzshZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6fzshZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB9E1F00899;
	Tue, 22 Sep 2026 20:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790110184;
	bh=Pl596bjY3hEda8Sou4XPr8wKFnOrrnhi/+UVWP/PoWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6fzshZ65RZuew5XBw5LX39nqpHeKTAZAk4jH6+UMxE4aw2KlKLSHmtzugfYhA1E3
	 Nr/v3KaxKZw7tvlL+CpaPdPnBOII3VQcp4v3nAUwdqNI0U5HwNzJOZx+KU9ysINSA0
	 DJlV/oh6CK0Pv9+FGMRA/b4ho/yL+rps7/EhV6zCSvRTSout6BM5/ovW+rXCoTRyOC
	 BabZ30Sz2HiR7DLQDmHMrUiBw1bhZKTWgchprr5a10laHYqznAUEsXVNYbbrRDqPBz
	 +B5srvNmP//CMhOKjxro8NlpUyWDT2qafJt9uxQaPlxYqG6baBjeqP28NF+Nl8mrvd
	 wsHoN6nCg0dxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 2/4] PCI/ACPI: Tidy _OSC control bit checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260922204548.3884906-3-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260922204548.3884906-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:49:43 +0000
Message-Id: <20260922204944.1DB9E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add OSC_OWNER() helper to prettify checking the _OSC control bits to learn
> whether the platform has granted us control of PCI features.  No function=
al
> change intended.
>=20
> [bhelgaas: split to separate patch, commit log]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204548.3884=
906-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D2

