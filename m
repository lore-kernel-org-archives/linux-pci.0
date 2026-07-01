Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453EE18CC13;
	Wed,  1 Jul 2026 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782883198; cv=none; b=js/j1Pc+VV4BOWyC6bd80KO6AyOWH784nxXj7e4TcIWZgSHcLGiojOvDfM+IzrFOXTOPqeizz54nkIU5p45iKWGm4QsUwkdUIb3XJRaANW2ZJXZ6vSFhhGs+7PkSgeZ6KQ+44Frowfa7/u4IRkUHMpPj83eh48rUtVDpIrKyj7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782883198; c=relaxed/simple;
	bh=uvyyUacpMtn1No3HOqJu6z+gPlcYcdrO6Evr3RNbToI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riX4g+XXiBWDnD3J6rg5JKQ2UThGlMnCqY4UU/CtYP/Os0xnOZJ2Opg2vYapt25J1R3YKGV3OE0WKSx2eXjCDw6hdTdL/BDjdb9hdQnblA5rPz5sB2Zi/9ybv4/Ng3vuxM2EGJmZlVhvJvAX6nvBNcMs57O+V+0eYrs7IxzhiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+vqI88F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+vqI88F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988861F000E9;
	Wed,  1 Jul 2026 05:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782883196;
	bh=fcmfciDTWfkR8FwYZpBwm3/AMInT5rTinzN2Y5PrDVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G+vqI88FYjHNGmlhKiboUpVdqUu9I84LG9cM6HmZ15PndAZtP0ayZJ++kdx9Qv3lk
	 UKSA69iFqPXDktnbnijGJfeMp8LwM/zZxq3sQzzftJXyjxyaSIFLyp8wd42cktWP5/
	 dj6ih1oh6r4FoanJoHFzhbB/5jQOJ8lOO1Hhzo9Yasd1d0UVudV/xLoY4zYvyWQZvU
	 tInaBuVLrC4iMPMxWvu1glfqPSWq+xen4HXtKKULCOU+b6tXjQzqyQ+yzFjjirkABI
	 Qk1Wl86OopZ4fn40UlY4lDG8wMllRzQw5ls2DPPTEW41s6v2MI/Kl65rlEzX0chNeW
	 kBwacpqNUAltg==
Date: Wed, 1 Jul 2026 07:19:48 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, mpillai@cadence.com, a-garg7@ti.com, s-vadapalli@ti.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] PCI: cadence: Add HPA IP debugfs for LTSSM status
Message-ID: <ikehyf77rcngzebtphevbqmuw4kpyizspg3rbcwpnw5qx7nlpp@p22qqao6sary>
References: <20260611165933.20071-1-18255117159@163.com>
 <20260611165933.20071-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611165933.20071-3-18255117159@163.com>

On Fri, Jun 12, 2026 at 12:59:32AM +0800, Hans Zhang wrote:
> Add debugfs support for HPA-based Cadence PCIe controllers. A new file
> 'ltssm_status' is created under debugfs, allowing users to read the
> current LTSSM state as a string and raw value.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

This patch doesn't apply cleanly on top of v7.2-rc1. Please rebase and resend
after incorporating below comments.

> ---
>  Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>  drivers/pci/controller/cadence/Kconfig        |   9 +
>  drivers/pci/controller/cadence/Makefile       |   1 +
>  drivers/pci/controller/cadence/pci-sky1.c     |   4 +
>  .../controller/cadence/pcie-cadence-debugfs.c | 211 ++++++++++++++++++
>  .../cadence/pcie-cadence-host-hpa.c           |  21 +-
>  drivers/pci/controller/cadence/pcie-cadence.h | 153 +++++++++++++
>  7 files changed, 403 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/Documentation/ABI/testing/debugfs-cdns-pcie
> new file mode 100644
> index 000000000000..c1104e28e4ee
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
> @@ -0,0 +1,5 @@
> +What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
> +Date:		March 2026

July 2026

> +Contact:	Hans Zhang <18255117159@163.com>
> +Description:	(RO) Read will return the current PCIe LTSSM state in both
> +		string and raw value.
> \ No newline at end of file
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 9e651d545973..cb010bc97aad 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>  config PCIE_CADENCE
>  	tristate
>  
> +config PCIE_CADENCE_DEBUGFS
> +	tristate "Cadence PCIe debugfs entries"

As Sashiko pointed out, selecting PCIE_CADENCE_DEBUGFS as m and
PCIE_CADENCE_HOST as y will cause build error. You can just make
PCIE_CADENCE_DEBUGFS as 'bool' to avoid this issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
