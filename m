Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7571344D9F;
	Mon,  3 Aug 2026 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798056; cv=none; b=W/T9OicbFRe7pnO0/a211gJrDKIJt9vvCKEPKQnkXf0eHZNUs6f/+jbzIiCmCZzrklM9BWft0j5Osor1admJEgzsKlYkmRx5Wy1kBM4nnfikBU+ub1w5IAWpM45kxRL8Siox+mUVFpIHK5+xWe56a8Xr+awzP8X7LNK55m4HNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798056; c=relaxed/simple;
	bh=fH4BBFv/T7gkzNtaoBRTb2VhW1NMEfb1BaxI1lwXE4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6gOw6Tt6Ttfg8QkebPuzqOZIlZ7ut1pVXryYFO1iTVpJGA42upDvBNGIP2wz2Qxcg0i2NqC7XJwFGt1aTuXNIngtQhZ7OA+mYthT4XsFT5yjChLe73dbV/5d1CinvMs66JseGce8yxhAFZE+LAJNaCne+M0dQkiGs31Yr1dUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NFiqRJT1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NFiqRJT1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Gn9SSiRXtkm8nj+O6hE9EDsFLBR/Z51cxSq1fiuimlc=; b=NFiqRJT1hlUk7IFnvqd1/hNinU
	tj19dkH2W8ABMkawip3f+1GWYNndKR1SpCR+nAa7IfjpOwSceo9YkSxHuC5GMk/RlKf1PeS3mwJDT
	995Ehm4QfObtIyiIyByva3UroqFJ1uG+lzXfs3qa0Q+kbXUSDnmDQhBSqQWpHUxHbbqnZPTee1CbK
	sC10CQDfNlUtAviUOcZPB3BOt0STYtQYRYmqA43Ipdh6J56DcxEz/nbAwaylQA7i+hQYuIpndzTOK
	EnFTQ79UUox5QZRAy4xtpmq4BJJF2ERGy7uc5C137Mf+tK3Fiu5y3zy9H1wofyp5fdPr6DVea31YX
	UiytWiCw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr1eI-00000000eV7-30Ve;
	Mon, 03 Aug 2026 23:00:46 +0000
Message-ID: <91244d6e-8fb3-4b0a-abde-ac8809368bde@infradead.org>
Date: Mon, 3 Aug 2026 16:00:45 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] PCI/NTB: endpoint: packed vNTB memory windows
To: Koichiro Den <den@valinux.co.jp>, Manivannan Sadhasivam
 <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/3/26 11:04 AM, Koichiro Den wrote:
> Hi,
> 
> vNTB currently spends one BAR per MW. BAR count therefore limits the
> number of MWs, even when one BAR has room for several. A large BAR,
> especially a Resizable BAR, can instead be split into logical MWs and
> leave more BARs for config and doorbells.
> 
> This series adds packed_mws, which exposes up to 16 equal-sized logical
> MWs in one BAR. ntb_transport uses the new group operations to configure
> them atomically.
> 
> The immediate use case is increasing the number of ntb_transport queues.
> The resulting performance gain is shown in the Testing section.
> 
> Based on the latest pci/endpoint.
> 
> 
> Why not BAR subrange mappings?
> ==============================
> 
> An earlier proposal used mwN_offset and BAR subrange mappings to place
> independently backed MWs in one BAR:
> 
>   https://lore.kernel.org/r/20260312165005.1148676-11-den@valinux.co.jp/
> 
> BAR subrange mapping is currently implemented only by DWC, and that
> design still needs one hardware mapping per MW in each direction. This
> series instead requires one contiguous backing range and maps the whole
> group once in each direction. The initial implementation intentionally
> trades arbitrary MW placement for a constant mapping count as the MW
> count grows. More flexible layouts can be added when a concrete use
> case requires them.
> 

Hi,
To be clear, this is totally outside of the scope of any PCI or NTB
standards or specs?  or did I overlook that part of the discussion?
Thanks.

> 
> Testing
> =======
> 
> The packed data path was tested with ntb_transport and ntb_netdev. An
> `iperf3 -ub0 -l 65482 -P 2` UDP saturation run produced the following
> results when only one Resizable BAR was available for MWs:
> 
>   Configuration                                   Receiver throughput
>   ----------------------------------------------  -------------------
>   num_mws=1, packed_mws unset (default 0)         607 Mbits/sec
>   num_mws=2, packed_mws=2, combined channels=2    1.19 Gbits/sec
> 
> Meanwhile, I realized that the in-tree ntb_test.sh does not fully pass
> with the pci-epf-vntb/ntb_hw_epf setup on the base tree. I had to apply
> a separate collection of local PCI endpoint and NTB fixes before this
> setup could be used for regression testing. These fixes address
> pre-existing issues and are not prerequisites of the packed MW
> implementation.
> 
> With packed_mws unset and ntb_msi_tests disabled, ntb_test.sh reported
> the same pass/unsupported results before and after this series. One run
> follows:
> 
>   $ sudo ./ntb_test.sh -r ${EP} -m 1048576 -p 28 0000:01:00.0 0001:10:00.0
>   Starting ntb_tool tests...
>   Running port tests on: 0000:01:00.0 / 0001:10:00.0
>   Local port 0 with index 0 on remote host
>   Peer port 0 with index 0 on local host
>     Passed
>   Running link tests on: 0000:01:00.0 / 0001:10:00.0
>     Passed
>   Running link tests on: 0001:10:00.0 / 0000:01:00.0
>     Passed
>   Running db tests on: 0000:01:00.0 / 0001:10:00.0
>     Passed
>   Running db tests on: 0001:10:00.0 / 0000:01:00.0
>     Passed
>   Running spad tests on: 0000:01:00.0 / 0001:10:00.0
>     Passed
>   Running spad tests on: 0001:10:00.0 / 0000:01:00.0
>     Passed
>   Running msg tests on: 0000:01:00.0 / 0001:10:00.0
>     Unsupported
>   Running msg tests on: 0001:10:00.0 / 0000:01:00.0
>     Unsupported
>   Running mw0 tests on: 0000:01:00.0 /  0001:10:00.0
>     Passed
>   Running mw0 tests on: 0001:10:00.0 /  0000:01:00.0
>     Passed
> 
>   Starting ntb_pingpong tests...
>   Running ping pong tests on: 0000:01:00.0 / 0001:10:00.0
>     Passed
> 
>   Starting ntb_perf tests...
>   Running local perf test without DMA
>         Peer 0 test statistics:
>   0: copied 268435456 bytes in 137063 usecs, 1958 MBytes/s
>     Passed
>   Running remote perf test without DMA
>         Peer 0 test statistics:
>   0: copied 268435456 bytes in 139188 usecs, 1928 MBytes/s
>     Passed
> 
> For comparison, the before-series run reported 1997 MBytes/s locally
> and 1950 MBytes/s remotely. No obvious regression was seen in this
> single-run comparison.
> 
> 
> Control layout compatibility
> ============================
> 
> The endpoint selects the control layout. Non-packed pci-epf-vntb keeps
> the version 0 layout. packed_mws selects version 1. "Old" and "new"
> below mean ntb_hw_epf without and with this series.
> 
>   EP configuration  Old ntb_hw_epf            New ntb_hw_epf
>   ----------------  ------------------------  ------------------------
>   non-packed (v0)   Supported                 Supported
>   packed (v1)       Not supported [1]         Supported
> 
> [1] The old driver accepts two or four MWs but looks for a separate BAR
>     for each MW. It rejects larger MW counts at probe.
> 
> 
> Packed MW compatibility with in-tree NTB clients
> ================================================
> 
> The in-tree clients handle a packed MW group as follows:
> 
>   Client          Behavior
>   --------------  ------------------------------------------------------
>   ntb_transport   Uses group operations. Without a singleton MW, MSI
>                   mode falls back to doorbells.
>   ntb_perf        Rejects a non-singleton MW group at probe.
>   ntb_tool        Loads normally. Per-MW inbound translation setup
>                   returns -EOPNOTSUPP for a non-singleton group.
>                   Doorbell and scratchpad access is unaffected.
>   ntb_msi_test    Fails probe unless the MW reserved for MSI is a
>                   singleton.
>   ntb_pingpong    Does not use MWs and is unaffected.
> 
> Further client support can be added separately when needed. A final
> singleton MW on another BAR can also be added later if MSI mode is needed
> with packed MWs.
> 
> 
> Notes
> =====
> 
> * About pci-epf-ntb:
> 
>   pci-epf-ntb remains on the legacy version 0 layout; this series does
>   not add version 1 layout support to it. A pci-epf-ntb bridge should
>   therefore keep its existing behavior even when its nodes run a mix of
>   old and new kernels. I do not have hardware for the pci-epf-ntb bridge
>   topology.
> 
> * About existing inbound MW clear behavior:
> 
>   pci-epf-vntb already leaves the inbound BAR mapping in place when an
>   MW translation is cleared. This series keeps that behavior for packed
>   MWs. This limitation is independent of packing.
> 
>   pci_epc_clear_bar() is not suitable here because it can clear the BAR
>   address assigned by the host. An EPF can instead restore a persistent
>   fallback mapping with pci_epc_set_bar(), as pci-epf-test does:
> 
>     https://lore.kernel.org/r/20250908161942.534799-2-cassel@kernel.org/
> 
>   pci-epf-vntb has no such fallback mapping today. Adding one, or an EPC
>   operation to unmap only the inbound translation, should be separate
>   work.
> 
> Best regards,
> Koichiro
> 
> 
> Koichiro Den (11):
>   NTB: Add atomic MW translation group operations
>   NTB: epf: Parse a versioned packed MW layout
>   PCI: endpoint: pci-epf-vntb: Add packed MW layout handling
>   PCI: endpoint: pci-epf-vntb: Implement MW group translation callbacks
>   PCI: endpoint: pci-epf-vntb: Allocate packed outbound MW space
>   PCI: endpoint: pci-epf-vntb: Add outbound MW group commands
>   NTB: epf: Implement MW group translation callbacks
>   NTB: perf: Reject grouped memory windows
>   NTB/msi: Require a singleton memory window
>   NTB: ntb_transport: Use atomic MW translation groups
>   PCI: endpoint: pci-epf-vntb: Expose packed MWs through configfs
> 
>  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
>  drivers/ntb/hw/epf/ntb_hw_epf.c               | 143 +++++-
>  drivers/ntb/msi.c                             |  19 +-
>  drivers/ntb/ntb_transport.c                   | 127 +++++-
>  drivers/ntb/test/ntb_perf.c                   |  16 +-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 423 ++++++++++++++++--
>  include/linux/ntb.h                           | 133 +++++-
>  7 files changed, 801 insertions(+), 76 deletions(-)
> 

-- 
~Randy

