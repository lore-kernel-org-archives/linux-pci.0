Received: from mail-m118113.qiye.163.com (mail-m118113.qiye.163.com [115.236.118.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E0317B418;
	Fri,  9 Oct 2026 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529468; cv=none; b=YyskU9yXHgMJ8ycJ84ADIyZWhKTusJK9rekrQOZoFX64U6Lraf9k/DK5LQNI/7C45ixRSbhscZpxPyKa8FC4WDCQY/z7uoG5aCt4BXkQChLXOJVUNurDpjViHWQWP9dOk9BCZzWwEMvnicfId5qH2nQ5lTwKcwf38kpz6oTOIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529468; c=relaxed/simple;
	bh=YcwNrrY6M6KbcCLhKkfiVImmTdwP6VlcYA49Gn17QJE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GDxNREEudR9L08LyMO0156Ism03vT7V2NL/bdI3uSn1l4tpE9mzCu9W5TSqgvG9uM8Gg1ID6+UNtp6dhuTe257SymA7igoUba02u1Krwm7/D53/59qbMiJhGeTI5cR9Z8+uKDN3sTa+wReR2k1AesAqwD+BsfiP/qG7Z5vi/mbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cDLPDS8A; arc=none smtp.client-ip=115.236.118.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cDLPDS8A"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5069e789a;
	Fri, 9 Oct 2026 14:59:05 +0800 (GMT+08:00)
Message-ID: <3bd9f6e1-c670-42f5-b2ea-2b4848e37468@rock-chips.com>
Date: Fri, 9 Oct 2026 14:59:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] PCI: rockchip: 5.0 GT/s speed discouraged by
 Rockchip
To: Geraldo Nascimento <geraldogabriel@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>
References: <cover.1781622998.git.geraldogabriel@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <cover.1781622998.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa11f75548d03a4kunm5c17223adff550
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSRoZVhlOTx5KTxoZHUsdGFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cDLPDS8AfQJiV6enNljTDbaVs83pRqqyPjzVSyPDn0THv9O+K0X69w04Y6ECaYO9MGQ6Dn1RSvFwIjN1Ls1H3KCbz6HHT6NoaSI+8cSso45CIxF/uzDASquN9AJHY2Ja50uAj9Bp/vWNLysrNFLhAVhLvtzMFEoHcxGxEFD4MzI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=C7hpZuYgfofdrhjchTCVySwUHHelguJs02x7Rdk3AgE=;
	h=date:mime-version:subject:message-id:from;

Hi Geraldo

在 2026/06/16 星期二 23:24, Geraldo Nascimento 写道:
> Dragan Simic already had warned me of potential issues with 5.0 GT/s
> speed operation in Rockchip PCIe. However, in recent interactions
> with Shawn Lin from Rockchip it came to my attention there's grave
> danger in the unknown errata regarding 5.0 GT/s operational speed
> of their PCIe core, including data loss.
> 
> Drop all code related to 5.0 GT/s operational speed from this driver.
> 

Apologies for the very late notice that this series is still pending.
FWIW,
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Endpoint Mode driver was not tested.
> 
> Changes in v7:
> - In pcie-rockchip.c (PATCH 3) drop unreachable code
> - Link to v6: https://lore.kernel.org/all/cover.1781207474.git.geraldogabriel@gmail.com/T/
> 
> Changes in v6:
> - Squashed patches 3 & 4 together as suggested by Mani
> - More formal warning message as suggested by Dragan
> - Set the 2.5 GT/s bit regardless of if link-speed is set to 2
> - Link to v5: https://lore.kernel.org/all/cover.1772239598.git.geraldogabriel@gmail.com/T/
> 
> Changes in v5:
> - Changed commit order to not break builds and adjusted copy pasted
>    commit message. (thanks Charalampos!)
> - Reintroduced behavior to force 2.5 GT/s in case there's something
>    non-default in the DT. (thanks Dragan!)
> - Link to v4: https://lore.kernel.org/linux-rockchip/cover.1772169998.git.geraldogabriel@gmail.com/T/
> 
> Changes in v4:
> - Incorporate suggestion by Bjorn and refined by Dragan to drop the
>    "catastrophic" code
> - Link to v3: https://lore.kernel.org/linux-rockchip/cover.1772057799.git.geraldogabriel@gmail.com/T/
> 
> Changes in v3:
> - Clarify warning message even though Rockchip won't disclose details
> - Drop DT changes as they were applied as subset by Heiko
> - Link to v2: https://lore.kernel.org/all/cover.1763415705.git.geraldogabriel@gmail.com/T/
> 
> Changes in v2:
> - hard limit to 2.5 GT/s, not just warn
> - add Reported-by: and Reviewed-by: Dragan Simic
> - remove redundant declaration of max-link-speed from helios64 dts
> - fix Link: of helios64 patch
> - simplify RC mode comment
> - Link to v1: https://lore.kernel.org/all/aRhR79u5BPtRRFw3@geday/T/
> 
> Geraldo Nascimento (3):
>    PCI: rockchip-ep: do not attempt 5.0 GT/s retraining
>    PCI: rockchip-host: do not attempt 5.0 GT/s retraining
>    PCI: rockchip: drive at 2.5 GT/s, error other speeds
> 
>   drivers/pci/controller/pcie-rockchip-ep.c   | 13 -------------
>   drivers/pci/controller/pcie-rockchip-host.c | 20 --------------------
>   drivers/pci/controller/pcie-rockchip.c      | 14 ++++++--------
>   drivers/pci/controller/pcie-rockchip.h      |  3 ---
>   4 files changed, 6 insertions(+), 44 deletions(-)
> 

