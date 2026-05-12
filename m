Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ACF383329
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549518; cv=none; b=mr2lhFobKQ4/GucG5HWGK/BnzfZOJ9lUkCxw/48Cx9DOnbZDA52mGgQG/tFbR7zKyCC3iH+abNqHmolGfJ6397jiWZXbK5rcTdwbQQ3V17r1NXBCy6DgU4Rmu+wu5Mw+mowkcUhm+eoUHmk9Dyn7SWEGZQuv+7Aq36rj4b//5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549518; c=relaxed/simple;
	bh=XGy6+8C1aaB95CGaQh1jbiIIs98qDoKJLW1z7n5TZXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WB/D/SeTkaLKKnmsoRSA1XreWCIjUHy8IsXfEyqErFblXRUmOhfIADVqa7JeQhw6C8sqmJ42RUv73eOhYsQRmNusiBAw8ns4qpn1S8ENm5eoHB5G+1ArRzXA10ksb9jlN8H8mPH5I+uyy22YzGPSFCm8HRcPiC/jYaHRp7pSQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBYI+T/6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBYI+T/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99675C2BCB0;
	Tue, 12 May 2026 01:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778549517;
	bh=XGy6+8C1aaB95CGaQh1jbiIIs98qDoKJLW1z7n5TZXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PBYI+T/6RFoym4tVqvZlm+ksJeZFxHJYo5etOUOTeHhlnOWGpt/74BrDYWT1o6dkM
	 5X0nYUHUSsAYn5tUyjyYzerkonsJ/Ph4U5pOP4d/8TcsCJAyxFNBVyiJcgpNtG6kbn
	 rs9XiDRijiDsu5ct19QMkCi2brnc/WdrSEZUTZ2nuyaN6rX+NOX5rZdUXcXcbJyr5b
	 bq/QgZyb+lEgX1+Y/JeapV1ad+6SS5vXYDQ5nJZbRGgTdZWJDKroJ56qjRrc3Q374V
	 q+le3Ck4Ztw/YTDc2QEmACDVkfq4icAcNZiXDEpifFAj9Nky0II9yRUkE6FKSvzMqZ
	 0OSSabE0q2crw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] PCI: aardvark: Add 100 ms delay after link
 training
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260511055923.37117-6-18255117159@163.com>
References: <20260511055923.37117-6-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 01:31:57 +0000
Message-Id: <20260512013157.99675C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Potential Use-After-Free (UAF) in the IRQ handler during advk_=
pcie_probe() failure due to unbalanced teardown symmetry.
- [High] Memory and hardware resources are leaked in the error paths of adv=
k_pcie_probe().
- [Medium] The commit message incorrectly claims that `link_gen` holds the =
negotiated link speed.
--

commit 1f92b585affbc960f9cf75de361f24796312c8bb
Author: Hans Zhang <18255117159@163.com>

PCI: aardvark: Add 100 ms delay after link training

This commit introduces a 100 ms delay after PCIe link training completes for
speeds greater than 5.0 GT/s. It utilizes the existing pcie->link_gen field
and pci_host_common_link_train_delay() to implement this requirement.

> The driver already maintains a 'link_gen' field that holds the negotiated
> link speed. Use it together with pci_host_common_link_train_delay() to
> insert the required delay immediately after confirming that the link
> is up.

This isn't a bug, but is this description accurate? The pcie->link_gen field
is populated during driver probe via of_pci_get_max_link_speed() and does
not appear to be dynamically updated with the actual negotiated link speed
from the hardware.

[ ... ]

Looking at the error paths in advk_pcie_probe(), if steps like
advk_pcie_init_irq_domain() or pci_host_probe() fail, the driver returns
without calling pci_bridge_emul_cleanup() to free the emulated bridge memor=
y.
It also appears to skip calling advk_pcie_disable_phy() to power off the PH=
Y.

Does this code leak the PHY and emulated bridge memory resources in these
error paths?

Also in advk_pcie_probe(), the driver registers advk_pcie_irq_handler using
devm_request_irq() and enables hardware interrupts via advk_pcie_setup_hw().

If a later step like pci_host_probe() fails, the error path calls
advk_pcie_remove_irq_domain(), which frees the irq domain.

Since the hardware interrupts are not masked and the IRQ handler is not
deregistered in this error path, devm_request_irq() defers unregistration
until after the probe function returns.

Could a hardware interrupt fire in this window, causing
advk_pcie_irq_handler() to call generic_handle_domain_irq() and dereference
the freed pcie->irq_domain pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511055923.3711=
7-1-18255117159@163.com?part=3D5
