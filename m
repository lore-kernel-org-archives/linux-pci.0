Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C643195EF;
	Sun,  1 Feb 2026 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769948698; cv=none; b=bdngcvKLi2oxBk+wyWqhadwU6NFoDQDrGGChjNqT8Sc5ceUWtGUDL2kgbb92WspcAUoLo9/SEc1F/ix51MQ8O9S8KRavlYgnHrT+VRPbZeSo20bWONPBBoNWRIqS+Vzh2H/b0gV1s0CpB7VAhHYQn008A6qvLgZRhs7K3BGB+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769948698; c=relaxed/simple;
	bh=e0FL0TcKkmbowDPf4LiX7QsYpwCM/WUr9bFfUtzr4Kk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ffq0hWJWxpV0f06l0VDn19PpZ7QkT9bxE9B7ZkQce/cL6UNbq35dMGUZe21Hfa15nkfzORqgrPjV3/IKF+A9om0QY8ngCxKr0xo4dP0PIfGdNl6YDG10l2CCVZYjWz9y0/2VluVSQhJSty0Mgn9JDujubwFJRdECb2W1ZoxlsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKCpE1Pr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKCpE1Pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5D0C4CEF7;
	Sun,  1 Feb 2026 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769948697;
	bh=e0FL0TcKkmbowDPf4LiX7QsYpwCM/WUr9bFfUtzr4Kk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cKCpE1PrSn1tpdFfW8mqJock00Ci868eBzjcTIml4DEamaH32f7kIo3lDI8YRPakD
	 xztQHuLUk/6/eCm1cdvwd89VNNFd7Eg1M4svtAWmOFIXg9fqv/PPVG/29QbDomfkRt
	 vbcyqVpA1HzMxVMprSO6fuMz7HADokwU72x99k+Yvibi7Ya8RfIHqCeYTZhmXjtKVS
	 2J0s4MQF0zHoyHXjYwxZi1GaSmjIeoClB5QUtbBamFuUN5asfDg4NfkxbieaGm2UEI
	 tkgh4Dd7yHa4Tm90vKYkKfzSKbiyCJO8V3sdidXGh8f2GOvI+mKmIYiz34mc/LHTgz
	 gC2mzJdDbbSKQ==
From: Leon Romanovsky <leon@kernel.org>
To: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 robh@kernel.org, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 christian.bruel@foss.st.com, shradha.t@samsung.com, 
 krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com, 
 inochiama@gmail.com, Frank.li@nxp.com, zhangsenchuan@eswincomputing.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
 pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
In-Reply-To: <20260129092629.1866-1-zhangsenchuan@eswincomputing.com>
References: <20260129092629.1866-1-zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH v10 0/2] Add driver support for Eswin EIC7700 SoC PCIe
 controller
Message-Id: <176994869472.79432.11245161336216033848.b4-ty@kernel.org>
Date: Sun, 01 Feb 2026 07:24:54 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773


On Thu, 29 Jan 2026 17:26:28 +0800, zhangsenchuan@eswincomputing.com wrote:
> Changes in v10:
> - Updates: eswin,eic7700-pcie.yaml
>   - None
> 
> - Updates: pcie-eic7700.c
>   - Remove devm_clk_bulk_get_all_enabled API, use devm_clk_bulk_get_all
>     and clk_bulk_prepare_enable. Add resource release codes and add
>     eic7700_pcie_host_deinit API.
>   - Update PCI_DEVICE_ID_ESWIN_EIC7700.
>   - Add reset_control_put release resources in "goto err_port:".
>   - Delete trailing comma after a terminator in eic7700_pcie_of_match.
> - Link to V9: https://lore.kernel.org/all/20251229113021.1859-1-zhangsenchuan@eswincomputing.com/
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: eic7700: Add Eswin PCIe host controller
      (no commit info)
[2/2] PCI: eic7700: Add Eswin PCIe host controller driver
      (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

