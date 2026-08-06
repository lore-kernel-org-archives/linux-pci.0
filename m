Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C338AC75;
	Thu,  6 Aug 2026 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046139; cv=none; b=WylGplWTEBcYi3nKpdQNMIxRLcKPQGgN0FI1Q+yoet+dADOoCYOGxn1nyD35xfv/ao06dgBzeHpJKvtZ6G2sSE40Wz5TgR3iemCyFj5bZQCACbZyGbiWZKtjvQfTKTEPhyvHxVax56KrK4ozIFMv+b396XgxI5/HbDRsI3QyjdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046139; c=relaxed/simple;
	bh=ZoJf7DCLdQTZIRqX+YeoXgeaZG948nbrbSoT7Bc4BuU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lFdbj6SbKC/fVMIgCNFIlT/1L/z4lYlQssr1DuWBNPAo+a6OOvecZMTBZYvPX+l+QoRoNjaWOsv9NizykeF1rKW5Yz6eg4BucYm9IwG2US90KfTzLVcvl+yxdYTGOxzIRQsB97lA7BGNi8uqrujzDoOSPgD12dpcK/flAZYWqWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkLZHklg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkLZHklg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68D71F00ACF;
	Thu,  6 Aug 2026 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046137;
	bh=8V8MSCxS1zSv5He6itY4ooM4bAabvALiETJahUY3Eu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RkLZHklgqHB8KCQmWi1DR5ujcuhgafO9wwwBcA1llwPwY2TPBvWHveRJS6ByYX0wx
	 vphm+5tCCUj2xLCA1Ijl7o/FgNpFhqwIGLmDTgWnUIXTJE4zKTBHq0xChnfNH6Hw6p
	 akEUT7VG8YBQYkheNPZNz9fTArWJHi9rHMO4mWVZU6xzQUaGPp8AwtWcErFRUbgfxH
	 3VTm4Mb6xj/x5R1qkEj2evnbCKImlK3GF9N4vTNci6OdUus9gWikROjp2nIRAzz5rk
	 +2nKc3sHYeNG+1h3geahoSQcXEcQOJ1+wFYBXfbFHeP17uTpdBZvG2rW1zk5J5bPDu
	 bJNDHkP0OmuxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198823809A29;
	Thu,  6 Aug 2026 19:54:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V6 0/4] Add PCIe M.2 Key E connector support for NXP i.MX
 boards
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178604609663.1449574.5164434195319660259.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 19:54:56 +0000
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
In-Reply-To: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
To: Sherry Sun (OSS) <sherry.sun@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com,
 marcel@holtmann.org, luiz.dentz@gmail.com, hongxing.zhu@nxp.com,
 l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, bhelgaas@google.com, brgl@kernel.org, imx@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, sherry.sun@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Jul 2026 10:34:31 +0800 you wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> This series adds support for NXP Wi-Fi/BT combo chips (88W9098, AW693)
> inserted into PCIe M.2 Key E connectors on i.MX95-19x19-EVK boards.
> 
> For M.2 cards that rely on PCIe L2 link state and wake-up mechanisms, the
> card must remain powered during suspend. Patch #2 uses the existing
> dw_pcie_rp::skip_pwrctrl_off flag to skip power-off during suspend and skip
> power-on during the init path.
> 
> [...]

Here is the summary with links:
  - [V6,1/4] PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()
    (no matching commit)
  - [V6,2/4] PCI: imx6: Add skip_pwrctrl_off flag support
    (no matching commit)
  - [V6,3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
    https://git.kernel.org/bluetooth/bluetooth-next/c/c424d3c907ec
  - [V6,4/4] arm64: dts: imx95-19x19-evk: Describe the PCIe M.2 Key E connector
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


