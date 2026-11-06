Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=154.81.10.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925371;
	b=vDwvkBqTUrGdVm2+Z3r1o4vAPbzyYL1N9Mxp/7w908soRQ7rZw3aSpI5MmdE2kLZKtgY
	 Sse9y8id3yfcujN1NEHFu2RzYAJ9g2JH8gDzza7Zyh+3M3CqPdvKCRhNZVsZRJVScwu4m
	 A1Wd6YXO1dF1m30YXtUpKMrzPc+HBG8DNyW/aHd4K5/3xMtANV/DRDtal8hApq6p8yU3Q
	 uwUKdfB4SqlRMc2Z5hjv17jqOUy/kBweh+q8ZgZ0dtHVs7o333P5+CdJnu8eOifm0h2sR
	 VJ5sz6JOMD5Y15sFmBP+FBzXUQ8G4wkFXG4t/quvxYJmCz3aads0pI2753ieZ3Oxing==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925371;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=kQ/TzfU3HeuNw7uzOiPI9CLulv8c3xdEm3+EwYgyk6c=;
	b=an/f1p5R9c5xrsj+wFSVBFOWqebKp4/l6lRflpH9OikSyR5oUdTVgBHyMMybt+tJ5cQd
	 adkAuAbzDAXJK/K0n0ybhsT1hIwUJ1OCcC+2G4xzfHsNBBGzeWspJY6EQbVXQC0FjyXMB
	 8cqxj0N/03HYVeKgoGYEXkFhmUhe6LjyYjYXsRpUqFH6+CG7YRyELgXIvzl32v6eFuTTL
	 C1eklUQen2fkLTOU/orgssxHlItylfnx7qkiR1Ot3e9xIt5Cp7fZYHdO1wvr4VL8Z/CuB
	 wToTTiSFK+RYnbTj8YaQCBA3GnfoN3h3PuJ1iqY7l8xlnpoJn+RhZ05OKh/8VVqASuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=NQZjNUv8;
	arc=none smtp.remote-ip=154.81.10.87
Received: from mail-m1087.netease.com (mail-m1087.netease.com [154.81.10.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5D606A326;
	Fri,  6 Nov 2026 00:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4D5D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=NQZjNUv8
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53adeb366;
	Fri, 6 Nov 2026 08:35:57 +0800 (GMT+08:00)
Message-ID: <6a6ca2e5-9a61-465a-a877-e167188e0b81@rock-chips.com>
Date: Fri, 6 Nov 2026 08:35:56 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Alexey Charkov <alchark@flipper.net>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v9 0/9] PCI: dw-rockchip: add system suspend support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1ae489ed603a4kunmfb28950e220837
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHk8aVh8aSkhCTxlKGh4aQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NQZjNUv8fGoO9xeRIViLMwP/ALH9EtJ32byg9Zlp98Oo5UWNYhF+FVT4v0hp9AB7PEzNfWVkSOOuXk5nYWviqK68r2X7DnAEheG+rYyOneCft2zGxoHCGnZasO8O4EgkPHLvzu1+LZTPAYGaZxjef042RSCItLD4H9sn+MG5PgU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=kQ/TzfU3HeuNw7uzOiPI9CLulv8c3xdEm3+EwYgyk6c=;
	h=date:mime-version:subject:message-id:from;

Hi Sebasitain,

在 2026/11/05 星期四 21:33, Sebastian Reichel 写道:
> I've been working on fixing up at least basic system suspend support on
> the Rockchip RK3576 platform. This series is a follow-up for Shawn Lin's
> series with feedback from Niklas Cassel and Manivannan Sadhasivam being
> handled as well as some of my own changes fixing up things I noticed.
> 
> Tested boards:
>   * Sige5 (RK3576)
>   * Rock 4D (RK3576)
>   * RK3588 EVB1 (RK3588)
>   * ODROID-M1 (RK3568), Igor Velkov (previous version)
> 
> Somewhat related, RK3588 also needs [0] to fix PCIe IOMMU issues after
> resume. Additionally RK3588 runs into SError on resume due to a USB2 PHY
> problem, which is fixed via [1]. RK3576 does not use PCIe IOMMU and does
> not run into the USB2 PHY problem (at least Sige5 and Rock 4D), so this
> series can easily be tested standalone on that platform.
> 
> [0] https://lore.kernel.org/all/20260929034510.2023173-1-praan@google.com/
> [1] https://lore.kernel.org/linux-phy/20261105-phy-rockchip-inno-usb2-clock-fix-v3-0-b20608c08b94@collabora.com/
> 
> Changes in v9:
> - Link to v8: https://patch.msgid.link/20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com
> - Collect Reviewed-by tag from Shawn Lin for pme_turn_off patch
> - Ignore suggestion from Shawn Lin to make pme_turn_off return error
>    codes as out-of-scope. I think it is sensible, but should be done
>    in a separate series as it will touch all glue drivers. (Shawn Lin)
> - Update rockchip_pcie_rc_reset_root_port() to also use the
>    rockchip_pcie_set_controller_mode() helper (Sashiko)
> - Update DLL IRQ unmask helper to also handle instances not involving
>    PCIE_RDLH_LINK_UP_CHGED (Sashiko)
> - Move INTx caching after dw_pcie_suspend_noirq() to avoid a race
>    condition (Sashiko)
> 

You seem to forget to take TB tag from Igor Velkov as he tested your v8.

> Changes in v8:
> - Link to v7: https://patch.msgid.link/20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com
> - Drop the final debug patch; I took that over from Rockchip's vendor
>    tree as it seems useful for debug purposes. Using it involves reading
>    the register via /dev/mem. It's not directly tied to actual system PM
>    support itself, so it can be submitted separetely. It's not worth
>    fighting Sashiko for it.
> - In LTSSM control mode patch also replace one occurance that I missed
> - In system PM support patch add guard not suspending an already
>    suspended PCIe devices, which can happen when resume failed following
>    the example of UltraRISC (Sashiko)
> - In the same patch replace 0xffff mask with PCIE_INTR_MASK to avoid
>    overflow issue; the new mask is not functional equivalent as we just
>    work on the lower 8 bit now. The following 8 bit are reserved on
>    RK3588 and RK3576 anyways, though. Thus this effectivly better
>    documents the purpose of the cached value. (Sashiko)
> - Drop incorrect custom PERST# handling in the resume handler (Sashiko)
> - Modify interrupt masking to follow RC instead of EP logic (Sashiko)
> - I've not picked up the Tested-by tag from Igor Velkov on v7
>    as there are some changes (even though I'm fairly sure they
>    don't matter), which add RK3568 to the tested SoC range.
> 
> Changes in v7:
> * Link to v6: https://patch.msgid.link/20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com
> * Rebased to v7.4-rc1
> * Collect Reviewed-by tags from Shawn Lin to (mostly) unchanged patches;
>    I skipped some due to changes in v7
> * Keep dev_err_probe() message for rockchip_pcie_phy_init in patch
>    restoring vpcie3v3 regulator handling
> * Avoid dynamic mask for extra flags in "enhanced LTSSM control mode helper"
>    by just adding specific support for the extra flag needed. Apparently
>    some compiler configurations don't like it.
> * Avoid duplicated register define in In pme_turn_off patch
> * Move bit defines to the correct register defines in pme_turn_off patch
> * In broken L1SS resume flag patch move the explanation comment from the
>    code to the commit message (FWIW this comment is not AI generated by
>    me, but was copied from the Qcom implementation).
> * In system PM support patch, set pp->suspend_poweroff to fix the issue
>    identified by Igor
> * In system PM support patch, just return 0 for DW_PCIE_EP_TYPE (Mani)
>    to keep the status-quo (I've not tested this specifically).
> * In system PM support patch, use the same init order as probe (Sashiko)
> * In clear debug buffer patch, drop dw_pcie_dbi_ro_wr_dis(), which
>    is already done by the core nowadays (Sashiko, Mani)
> * In clear debug buffer patch, fix actual register write (Sashiko)
> * In clear debug buffer patch, update patch description with
>    better explanation about the register (Mani)
> 
> Changes in v6:
>   * https://lore.kernel.org/r/20260316-rockchip-pcie-system-suspend-v5-0-5bb5ad37d643@collabora.com
>   * Rebase to pci/next
>   * Minor changes to make checkpatch happy
>   * Update patch description of the last patch and drop RFC tag
>     according to feedback from Shawn Lin
>   * Prepend new patch, which fixes Nicolas Frattaroli's conversion
>     to FIELD_PREP_WM16 accidently dropping a flag.
>   * Add another new patch, which sets .broken_l1ss_resume to tell the
>     PCI core that the controller is powered off during suspend following
>     the Qcom example
> 
> Changes in v5:
>   * https://lore.kernel.org/r/20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com
>   * rebase to v7.0-rc1
>   * Add an RFC patch at the end with some bits I found in the Rockchip vendor kernel;
>   * Made some tests on Rock 5B+ (RK3588); with this patch series suspending works
>     when setting pm_test to devices. A full system suspend fails in a later step,
>     but that is independent of PCIe.
> 
> Changes in v4:
>   * https://lore.kernel.org/linux-pci/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/
>   * rename rockchip_pcie_get_ltssm to rockchip_pcie_get_ltssm_status_reg
>     in a separate patch (Niklas Cassel)
>   * rename rockchip_pcie_get_pure_ltssm to rockchip_pcie_get_ltssm_state
>     in a separate patch (Niklas Cassel)
>   * Move devm_phy_get out of phy_init to probe in a separate patch
>     (Manivannan Sadhasivam)
>   * Add helper function for enhanced LTSSM control mode in a separate patch
>     (Niklas Cassel)
>   * Add helper function for controller mode in a separate patch
>     (Niklas Cassel)
>   * Add helper function for DDL indicator in a separate patch
>     (Niklas Cassel)
>   * Move rockchip_pcie_pme_turn_off implementation in a separate patch
>   * Rebase to v6.18-rc3 using new FIELD_PREP_WM16()
>   * Improve readability of PME_TURN_OFF/PME_TO_ACK defines (Manivannan Sadhasivam)
>   * Fix usage of reverse Xmas (Manivannan Sadhasivam)
>   * Assert PERST# before turning off other resources (Manivannan Sadhasivam)
>   * Improve some error messages (Manivannan Sadhasivam)
>   * Rename goto labels as per their purpose (Manivannan Sadhasivam)
>   * Add extra patch for dw_pcie_resume_noirq, since I've seen errors
>     during resume on boards not having anything plugged into their PCIe
>     port
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Sebastian Reichel (9):
>        PCI: dw-rockchip: Fix LTSSM set functions
>        PCI: dw-rockchip: Restore vpcie3v3 regulator handle
>        PCI: dw-rockchip: Move devm_phy_get out of phy_init
>        PCI: dw-rockchip: Add helper function for enhanced LTSSM control mode
>        PCI: dw-rockchip: Add helper function for controller mode
>        PCI: dw-rockchip: Add helper function for DLL interrupts
>        PCI: dw-rockchip: Add pme_turn_off support
>        PCI: dw-rockchip: Set broken L1SS resume flag
>        PCI: dw-rockchip: Add system PM support
> 
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 283 +++++++++++++++++++++-----
>   1 file changed, 228 insertions(+), 55 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20251028-rockchip-pcie-system-suspend-86cf08a7b229
> 
> Best regards,
> --
> Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> 

