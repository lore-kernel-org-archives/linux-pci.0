Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51266C2EA;
	Wed, 18 Feb 2026 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431339; cv=none; b=nRy854i/YVq3hccKoCAJvK1tgU0vxC9DByh9acdXVM5SE/MYCgIFM0Oqbm/gy2Vg6TJHCfiqbabE6uW2+9MXhKAxGP8xT/5A8u0GI+uzLYGLb2Yi1f78tr1aBu92KuLgaJQpGabSUgmVRqBDoqohfAWY0TDzWUlSyT5CaF0gUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431339; c=relaxed/simple;
	bh=xL5VM69A/0vbujbXc0YQYgH0/VGEmNZM+GY4AU1e324=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oy4ymf6KW4OnlrzTVSQcs0EDHx7HzgYSEpWya6b4ZokMdO1qUF0CzFJpqOmnsus7Yb8ldt9+iUaPxnJnV5WtyB4j2QdpHrAhHUVRCnslnUGLc4VCN56W60CLn8qw34hczZDhoadoApftzLmGKJsZNSHAA3yF1zq0ujdzCexcWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAffxcn5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAffxcn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D302C116D0;
	Wed, 18 Feb 2026 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771431339;
	bh=xL5VM69A/0vbujbXc0YQYgH0/VGEmNZM+GY4AU1e324=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAffxcn5sTtX3oQihKPTDqjutddpgDh4rBMUfiHm9bQ9xW0lKg3DXRXqcTpXIbyqa
	 XbPQ+VwcpfBETiV/qgD/15WERqLriWBIynpXbeXuM00nXZFI2I4OdzxnfyVVf+NQpa
	 MLmweQRUUjIfQ5qRRJN16k4i9WcIR0rJHp1tuNX2lkbWJWaAbgOqFEC558ewA1rmJq
	 TgfFQvf7uGwqMCh2zwg5cvCDw1/NzCFw/GBtvSOy7/tfI+rejhXuh1NiZPuil0rht2
	 XvvSXcfeE7msrtNZ4m7h90po+/gD/lFYB1RrN4bsvP0eV7zeaTJqd+upV2bUjpC0Q3
	 tF6g4TIGhGFdA==
Date: Wed, 18 Feb 2026 21:45:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank.Li@nxp.com, jdmason@kudzu.us, dave.jiang@intel.com, 
	allenbh@gmail.com, kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com, 
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH v4 0/7] PCI: endpoint/NTB: Harden vNTB resource management
Message-ID: <7hqhqbtqvrw6bqraykdbccllags6gyal6rekb6yehcfx2tzhet@lex46cqheta5>
References: <20251202072348.2752371-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251202072348.2752371-1-den@valinux.co.jp>

On Tue, Dec 02, 2025 at 04:23:41PM +0900, Koichiro Den wrote:
> The vNTB endpoint function (pci-epf-vntb) can be configured and reconfigured
> through configfs (link/unlink functions, start/stop the controller, update
> parameters). In practice, several pitfalls present: double-unmapping when two
> windows share a BAR, wrong parameter order in .drop_link leading to wrong
> object lookups, duplicate EPC teardown that leads to oopses, a work item
> running after resources were torn down, and inability to re-link/restart
> fundamentally because ntb_dev was embedded and the vPCI bus teardown was
> incomplete.
> 
> This series addresses those issues and hardens resource management across NTB
> EPF and PCI EP core:
> 
> - Avoid double iounmap when PEER_SPAD and CONFIG share the same BAR.
> - Fix configfs .drop_link parameter order so the correct groups are used during
>   unlink.
> - Remove duplicate EPC resource teardown in both pci-epf-vntb and pci-epf-ntb,
>   avoiding crashes on .allow_link failures and during .drop_link.
> - Stop the delayed cmd_handler work before clearing BARs/doorbells.
> - Manage ntb_dev as a devm-managed allocation and implement .remove() in the
>   vNTB PCI driver. Switch to pci_scan_root_bus().
> 
> With these changes, the controller can now be stopped, a function unlinked,
> configfs settings updated, and the controller re-linked and restarted
> without rebooting the endpoint, as long as the underlying pci_epc_ops
> .stop() is non-destructive and .start() restores normal operation.
> 
> Patches 1-5 carry Fixes tags and are candidates for stable.
> Patch 6 is a preparatory one for Patch 7.
> Patch 7 is a behavioral improvement that completes lifetime management for
> relink/restart scenarios.
> 

Are there any dependencies between pci-epf-vntb and ntb-epf drivers? If they are
not dependent, you should always post them separately. For this series, I can
merge the endpoint patches (except patch 4 which got merged in other form).

- Mani

> 
> v3->v4 changes:
>   - Added Reviewed-by tag for [PATCH v3 6/6].
>   - Corrected patch split by moving the blank-line cleanup,
>     based on the feedback from Frank.
>   (No code changes overall.)
> v2->v3 changes:
>   - Added Reviewed-by tag for [PATCH v2 4/6].
>   - Split [PATCH v2 6/6] into two, based on the feedback from Frank.
>   (No code changes overall.)
> v1->v2 changes:
>   - Incorporated feedback from Frank.
>   - Added Reviewed-by tags (except for patches #4 and #6).
>   - Fixed a typo in patch #5 title.
>   (No code changes overall.)
> 
> v3: https://lore.kernel.org/all/20251130151100.2591822-1-den@valinux.co.jp/
> v2: https://lore.kernel.org/all/20251029080321.807943-1-den@valinux.co.jp/
> v1: https://lore.kernel.org/all/20251023071757.901181-1-den@valinux.co.jp/
> 
> 
> Koichiro Den (7):
>   NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG
>     share BAR
>   PCI: endpoint: Fix parameter order for .drop_link
>   PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
>   PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
>   NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
>   PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use
>     pci_scan_root_bus()
>   PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus
>     teardown
> 
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  3 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 56 +-----------
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 86 ++++++++++++-------
>  drivers/pci/endpoint/pci-ep-cfs.c             |  8 +-
>  4 files changed, 62 insertions(+), 91 deletions(-)
> 
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்
