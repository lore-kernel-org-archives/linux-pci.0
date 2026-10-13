Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F5522698;
	Tue, 13 Oct 2026 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912999; cv=none; b=JAWmAqynpAw17iRWJvjvohufPi0L7wdGOy8ll9Wuy7YHkZEQrAQSuAZI2JydvYl2yHEhkqVD5Hx1mokT80XFoYiWVA6yuPtHnaJDZLd8+naURu6Sthc3hTnukh+o3IEnQh/mu0HZCVoLAbToentORff5YjuTF0jjGq5Yi/vj3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912999; c=relaxed/simple;
	bh=cOmsE9Aa3q99k/VZfCPyuKtQLSO0LoXPs0Gh+wJvIAA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Wm7c5z3ydGnR8SR4T7pcC5OFrzCUq01avTERPX1/Ajl5g/CWY6bmG5Ft0kIJ1SdQBGBvI5i/9B635258NQSbIFr3INEbRJOXr4eb18PSQ3U+pbgdcmkKQNGPm5DI2wttfVQ125NuKtpnEtC+VQxvcpyxOPuiTb1MS9cd4SMOr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2p3ukm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2p3ukm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C995C1F000FF;
	Tue, 13 Oct 2026 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912998;
	bh=cOmsE9Aa3q99k/VZfCPyuKtQLSO0LoXPs0Gh+wJvIAA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=m2p3ukm4+70hK1qYhYpfgeQbdmu8dutlVS+8J/34b8uW3dNiED7HBsPsUauI4JJ7I
	 dldaOic+tkyyq30TpezJCwkxnHxldLiF2ByiAU92DF7aiBcAdrQCkeT3UevoJomBbj
	 Shgc4ri+FWsXqj9kbX+TF50TiUMGG6rocf9JHVeFaAkvFH87VShAg0Ap2mEi3Nq7j5
	 OOu63FR5hPp7qtQkBtHKmVez5ZInOZVnx3wBKzcRcEtY6pXh/zSsmSlb59GMeTWhmK
	 TU9A88qgGg3XwPNTqvy+rPkxd/0ULem4nhznA3t7mG2yZcYbTmb7jmMi+pFlD824px
	 B+QdQATd/PHNw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 09/10] PCI: dw-rockchip: Add system PM support
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pci@vger.kernel.org
In-Reply-To: <20260908151212.08E201F00A3A@smtp.kernel.org>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-9-fbabcca9921b@collabora.com>
 <20260908151212.08E201F00A3A@smtp.kernel.org>
Date: Tue, 13 Oct 2026 23:06:32 +0530
Message-Id: <179191299286.12828.2351526742198636358.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=mani@kernel.org;
 h=from:subject:message-id; bh=cOmsE9Aa3q99k/VZfCPyuKtQLSO0LoXPs0Gh+wJvIAA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzmwjib0lZPntW57vauq/BJngiFoG8aM2nhp7j
 fAUnyyQXBGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas5sIwAKCRBVnxHm/pHO
 9ZrACACnxHgfgAQRxyJu9hT9A6LqsjxcLpYjxFn23rTblWbLTmNA+30PzQXeyx4jFxtnSOqdj7X
 /33Rc1DfJgd0NyJ7oQEZFR9f55E6lYiezzTodRFl/k0iyLRfoPS0LIHNDH19OMs0spG+XrdI8y9
 HK1oQzVp2s0zHfjIVw+PwZJI8Qvt6AmNkpDkwUm2EYin6dQ7IL7oG4Q7MxQoUTuFxULhJgE1maB
 +q2iV1zXtmVhBNWFtreVbmi/DB2O1osW2AWNxS8gpRtgVoXogSPU3imsnSky75OB5e39PcV29rh
 YupRUjT444UB0kupSoiX+If5luPUtv/x7MB8nbXAv5YdYspi
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-08 15:12 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] System resume unconditionally re-initializes the host, leaking the existing IRQ domain and breaking legacy INTx interrupts while executing invalid GFP_KERNEL allocations in an atomic context.
> - [High] The PM operations `rockchip_pcie_suspend` and `rockchip_pcie_resume` are registered as `noirq` callbacks but call functions that can sleep.
> - [High] Missing check for the return value of reset_control_deassert() in rockchip_pcie_resume().
> - [Medium] Missing `reset_control_assert` in the error handling path of `rockchip_pcie_resume`.
> - [Medium] The order of initializing and tearing down the regulator, PHY, and clocks in system PM callbacks contradicts the proven sequence used during driver probe.

Lot of valid issues. Please take a look.

- Mani

