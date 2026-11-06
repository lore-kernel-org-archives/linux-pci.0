Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982816;
	b=bvx5lyMYYSVi7ggNXFJb3zuFYCL9WbdE9WUsPQXIoE46bbr6sDiG1ZdARfimvOhsHYFo
	 xYPFvzSPJo2EtuUMLKGcoGxFFWgGMJ1BzoYAdn3SQ33mJNOa66/pOtJPzoCzMNTeIEfUg
	 RVpA+IkbQKcYYeEwKxXhRCfiHKZttQVY1FgdVexoYtYcRM1cUQgnohKG3GgjVxNEe6TF5
	 VNooP/0MyhNqLkc7/sSPF9bHjT0+/zigTBRZ9HZpl+jqLVwaOwUmUQnTw50CODD2vE2qL
	 p8fRI75rCKUgCUeK6hLO30u6ZsA8ZnqV934c1tfKCmGs8RIHpli93W54BpizRgP3gcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982816;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j9Tw3q4hl3SZQXuEcOsXZlzTcZo4BWpJSRBvdaUApKs=;
	b=zpup3bSfeXdDywFQM94aqGvZpbWQZfDnfF1kEXx+y8Z4IkXta16geJfzLVnawcsUjbCP
	 h+JgEgXbSBvXk3sYgBm+OZhePw+od2nUAqjr+yrzmVYFbxl2nq/eWjG3Xi5zM0XDGKA8X
	 9XZjkZYhvdrO98ugCSv716GDMIpSxSi/Ux99IF3Q0bJjeRcoYYlGKnZ4NBQZKlmUBU688
	 WnHlfLGg2vPfEFGtxRLE9MRzhYoXSpN5cxC/NWkAafRqsdqmGf+rc+SmPb+ugN1Ks8MbG
	 HJAMaxBzcQzalB/FHh1oObcMFZe4pErS4lr44qugspy9NsyGgb6MClfGiQ2PcVv0eUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mF/215lL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8124606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mF/215lL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C5A1F0089F;
	Fri,  6 Nov 2026 16:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982815;
	bh=j9Tw3q4hl3SZQXuEcOsXZlzTcZo4BWpJSRBvdaUApKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mF/215lLU6PmB8KrONeS01BERuPcNXLXmgFAyj9MNoCLUsNo4YLNlcDUCUjlrqwUJ
	 cLD+3hykQAO8/zcT9s888QEngokyujYx9Vc6J1ZSxHCZCnKQu+EHVeqh/Ey/QpGbtF
	 cW6qk9ox4413siNnyEQ0BTwdcZDota3SVf+1Mat8G9eON45bBbeE8wRicNO4aWjWOq
	 Vo4Txi8jUsNQfLHwQqNQ3pshxIoQQV4+au0WdX+e/ebj2OZATo9ZVrjPkIeC3DZ9IQ
	 ZoQatrYf9RdY4lkPHdIRZgjCYbh3uHGzv1PJRbg0NSLFvTcmkzc1sMymcE0LXnzH6m
	 0HPtyH9Xnqk6w==
Message-ID: <sashiko-outbox-201826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/7] PCI: vmd: Add vmd_configure_cfgbar() helper
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106184256.4130-3-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
 <20261106184256.4130-3-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:33:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move the VMD CFGBAR initialization code to a new helper
> vmd_configure_cfgbar(). No functional changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106184256.4130=
-1-szymon.durawa@linux.intel.com?part=3D2

