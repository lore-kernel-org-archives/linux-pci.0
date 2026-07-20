Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3590725A2BB;
	Mon, 20 Jul 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560778; cv=none; b=r/rVEz5iqxxelA2gYjUXPfhrGvPUvrvM5YKBmFoHvIT/KdzCJVd1vLpGZLEN1bxEHovmI6Vx9BcFB/DZOQaUPDNMWOO7WKtnthChv0/4uHEiNeA5Q6ASSXZ3wJX3jVO9k+qU/1TNAt60eUEVz2ecxZWnljRjS16vy1lY0zlc3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560778; c=relaxed/simple;
	bh=109Y4pROIOE4v6JzP2mj0CftObYJX8Ya91dyfcfsWxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oPLteRPX4eUiyHuTuIQmIqMVZLrNNOm/1jZPpti6z0LEnuOYI4TTsgZKoNrJFOKUxYt5JuAndPjt933YZSACnGTNs1AiGEqtIpSJpSSzO65SwFYXzoWncC/7kfciz858lGaSC4K35eM40Sx/A2KaOvtJkCNmIirBNhyIdIacLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy+bwBiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy+bwBiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599711F000E9;
	Mon, 20 Jul 2026 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784560777;
	bh=109Y4pROIOE4v6JzP2mj0CftObYJX8Ya91dyfcfsWxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vy+bwBiIt4/fUFI+dUDk9Dg3zDRGN2UgA1jFoqgAvQrFjEQnGxK7YR9zluelaeQgS
	 stMVCspUaWzWzsfvB1JmBUUTn0cVaIXPQ1HUwcr59isRzU1dGIBsEJa/94jKOzMDPD
	 uqh4Fk7DYaGoIHIZISEglZMTwGkxnVg2dHJToiIwSDMYflKWHGUBm9L9UCmRKUspU5
	 qTxtbft53cSn8jsEkEyz5Ax5r1yilj5wxH4HuNIIiw5qcBzzAoWHW1v30NflGcNuR/
	 3fmgbwp0AKk20q46+sgVgtC2+iVakW8dKOaEuIx2GuyFKRjRPbMjXuGmmG4uIVOomO
	 QjqPqfoMn3XGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/16] PCI: dwc: spacemit-k1: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: imx@lists.linux.dev, neil.armstrong@linaro.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260720150619.24733-14-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-14-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:19:35 +0000
Message-Id: <20260720151936.599711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Because .init runs before core caching, we call dw_pcie_get_pcie_cap()
> inside k1_pcie_disable_aspm_l1() to get the capability base, then add
> PCI_EXP_LNKCAP. Hardware is already enabled at this point.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D13

