Received: from mail-m49214.qiye.163.com (mail-m49214.qiye.163.com [45.254.49.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E832B9A4;
	Tue,  7 Apr 2026 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522179; cv=none; b=Y9JOMyhqZtetabAzl55AMq2IoHK5p8mawNIPYj7mfwZwqAXEF0K19sayUqx7ds0sRZ1to/BYa1EHl9vpbTQuJJrVxxUlag3cL9ts78VC0cdEp+vAkr9Gx2KAjPEkbbngK+HgGC4gYDMZMxRidsZrcScgw/SYlntH2Ky1HfD+80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522179; c=relaxed/simple;
	bh=6eRAzJ45PCQCiDXtEItwr8s1AJEeHvhflxafwpGQwFI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uqb6AE3Ai+lZsrClTFufVoKnoAjiq0NQFnnD1N/gpMI+Iott5rZpU8FqmoCwElE9EDeNEa627mU6ZGqLATSby+R6khJwL5Ijg6N856+FI0kzzs8Mx3ihQ3QXnrR7N+me1QxVWFor7O+/njRM3nfglD0chZHx683Nw/MKB3AOamE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LY3jwkKP; arc=none smtp.client-ip=45.254.49.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LY3jwkKP"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39b4d3e0e;
	Tue, 7 Apr 2026 08:36:04 +0800 (GMT+08:00)
Message-ID: <0e7148cd-06ec-e0dc-b5fc-ff21582041d4@rock-chips.com>
Date: Tue, 7 Apr 2026 08:36:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Cc: shawn.lin@rock-chips.com, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] PCI: Refactor PCIe speed validation and conversion
 functions
To: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, kwilczynski@kernel.org,
 mani@kernel.org, ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com
References: <20260406105613.1228673-1-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260406105613.1228673-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d655e308f09cckunmb837d4d4297290
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk8dHVYZS0pPSB5PTU9NSxhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LY3jwkKPvmMLxcKSLh3Yeczpm86YQLChwRoFd6GRnlGjvTR8OYC3oYKJA28YNOs8IrbeWI7OCGDxHIc0qZqGil7askGav7fxd+fWuRBbo5A+xaTw4guHduv3p0HRb0iXDQL8Y/tYywFQEIv4tZIKPZ/7MOqtlCzBejgm8tRuX7A=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=1kqfK6SZhGjN5NMis+LWoXUWbNwkXuJmrK0OrYSebIM=;
	h=date:mime-version:subject:message-id:from;

在 2026/04/06 星期一 18:56, Hans Zhang 写道:
> This series refactors PCIe speed validation and conversion logic to
> shared functions in the public header, eliminating code duplication
> and ensuring consistency across drivers.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
> Changes for v6:
> - missing one line of code:
>    link_speed = pcie_get_link_speed(pci->max_link_speed);
> 
> Changes for v5:
> https://patchwork.kernel.org/project/linux-pci/patch/20260406104708.1218648-1-18255117159@163.com/
> 
> - Rebase to v7.0-rc1. (pci/next tree)
> 
> Changes for v4:
> https://patchwork.kernel.org/project/linux-pci/patch/20251102143206.111347-1-18255117159@163.com/
> 
> - Maintain O(1) array-based lookup for speed conversion (addressing
>    performance concerns from v3 feedback)
> - Move pcie_valid_speed() and pci_bus_speed2lnkctl2() to pci.h
> - Update dwc driver to use the shared functions
> - Rebase to v6.18-rc3.
> 
> This addresses the feedback from Lukas Wunner and Manivannan Sadhasivam
> on the v3 submission, ensuring no runtime performance regression while
> achieving code reuse.
> 
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20250816154633.338653-1-18255117159@163.com/
> 
> - Rebase to v6.17-rc1.
> - Gentle ping.
> 
> Changes for v2:
> - s/PCIE_SPEED2LNKCTL2_TLS_ENC/PCIE_SPEED2LNKCTL2_TLS
> - The patch commit message were modified.
> ---
> 
> Hans Zhang (3):
>    PCI: Add public pcie_valid_speed() for shared validation
>    PCI: Move pci_bus_speed2lnkctl2() to public header
>    PCI: dwc: Use common speed conversion function
> 
>   drivers/pci/controller/dwc/pcie-designware.c | 18 +++-------------
>   drivers/pci/pci.h                            | 22 ++++++++++++++++++++
>   drivers/pci/pcie/bwctrl.c                    | 22 --------------------
>   3 files changed, 25 insertions(+), 37 deletions(-)
> 
> 
> base-commit: 525e91d84dc085492b36d4b87abb7c1cc93fcb44
