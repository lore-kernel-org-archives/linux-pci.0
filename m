Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82920364953;
	Fri,  7 Aug 2026 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132186; cv=none; b=pycnsp/vOZbHbXY4YkDzHNiMQ4yMMlXdDmH0R+iRW8lVZ8QUBJVeGbMyuhsjjt6mXgY35PADP+AMokHkBBJPR7DsqS9BLUF4xvjX/J/rNBZ01AzAP7kBxoVqZ46SB75bwlwASUzeqY5m9nQvOEF5ULky67z6THI/llZuDIFgahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132186; c=relaxed/simple;
	bh=/jGpdA/Ptdc9nT4WnnfQYMmemnUTuBLwSN+/rFHPc+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WFXCMCUjfQjS5fxR6kqbCxtC+MHtRJGcj35GAiESGWw13VS0DuQBbsgvkdNEiCe/g+lZB7PoL2Zw82Hian+fgaIM6zgHYUgTXDjC7kdjU8reEjxd8VxQR2HILETwmWC4PCCfUZlVXnfzvatqhQuuFYqyg1/PVDLSpAIlGrXrt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvCtb8rR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvCtb8rR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE001F00A3A;
	Fri,  7 Aug 2026 19:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786132185;
	bh=cs4/mM47aIJKc8K4fr0iTIuSeX56EGiBWC86xOGmIgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gvCtb8rR3PreHEo1T7O1r1H47ldRqto2iwRnMlFdLUxX04wzwP6pZ/cVBRLwpYZiG
	 Gy/c+LWZgoeLZ5wt0rkiulqpggp4xyuL2zjkQoEvBzcwKZSEftWkv+/KjOpnilglym
	 BiEb7ETTqxn91B4vKorXZDvNrN1lQ5FG7WQMsgLo0LmTYZ7X0eQQk34p5kPxg9PQSE
	 8Nkl/NaYx87MM8EEYG22pWVpMTKMmxI28vLcvrid0XWB7j9H6M1HQ5FhdrnSfepgMu
	 naRYbsZjxJoNDQEmGPeEdqirHWtDc4GSXO80NxelIue6j3el2ILwinlguN+nHWC+HK
	 a1GTtx2H95vZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] PCI: of: introduce of_pci_verify_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260807194100.455599-5-elder@riscstar.com>
References: <20260807194100.455599-1-elder@riscstar.com>
 <20260807194100.455599-5-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 19:49:44 +0000
Message-Id: <20260807194944.DEE001F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The static DT node verification function `of_pci_verify_node()` =
is mistakenly placed under `#ifdef CONFIG_PCI_DYNAMIC_OF_NODES`, making it =
a silent no-op on systems that only use statically-defined nodes.
--

--- Patch [4]: [PATCH 4/4] PCI: of: introduce of_pci_verify_node() ---
commit 29170ab92dd207c740eed74438cd2e09bad49131
Author: Alex Elder <elder@riscstar.com>

PCI: of: introduce of_pci_verify_node()

This commit introduces a runtime check to verify that statically-defined
(pre-existing) devicetree nodes for non-bridge PCI endpoints do not
incorrectly contain the device_type =3D "pci" property. It adds a call to
of_pci_verify_node() during PCI bus device addition to catch these errors.

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1265,6 +1265,7 @@ static inline int of_pci_get_equalization_presets(s=
truct device *dev,
>  struct of_changeset;
> =20
>  #ifdef CONFIG_PCI_DYNAMIC_OF_NODES
> +void of_pci_verify_node(struct pci_dev *pdev);

[Severity: Medium]
Since the intent is to verify statically-defined devicetree nodes, will
placing this declaration inside the CONFIG_PCI_DYNAMIC_OF_NODES block
accidentally disable the check on platforms that only use static nodes?

If CONFIG_PCI_DYNAMIC_OF_NODES is disabled, this falls back to the empty
stub below, causing the verification to be silently skipped.

>  void of_pci_make_dev_node(struct pci_dev *pdev);
>  void of_pci_remove_node(struct pci_dev *pdev);

[ ... ]

>  #else
> +static inline void of_pci_verify_node(struct pci_dev *pdev) { }
>  static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807194100.4555=
99-1-elder@riscstar.com?part=3D4
