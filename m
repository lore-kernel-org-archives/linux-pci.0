Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882083;
	b=O4Ft7HBL0IIrSg43V9JI0z3mOZ1Wskea7AzE7ckZ0Mf+Nf9U9tjhbO9Zlo0pn2iojoGj
	 ZE/9OmWA+fnQ8pEYVsKOxxDJVsmJmtLJJUVkAEkrmO82HYI9nz+5FyMlB1MYIsRGICV0T
	 FFutW1PhWzRJhNQLMFMvfyFwi8poDmDB+qIbcSwcUD2TKr67shpizezntPLpXgCZ0V1+m
	 OBFEPkZLNK7TofZgDJy5IrsCQNVOO/AI3ILGjeTBkuy3lpk0oSUAc9g074QzEjhgNXr9N
	 i0BOSFDX11SwMmKXLGMDoCz8CbTJO34d3QIkq1bzUI0AmOd7Csd4uqTlUS1bwol8LsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882083;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1xICXLkoltoG973pTU5+bCGheB4eRXzeQ6tdd0yZUTY=;
	b=GC0fSMDIb5Pd1MUX1Ua2LIILSoW9b2x6GCnHpVDhRlt+Jrqbyt1C+SiH3oTKFzFKMheJ
	 Gfa5Hg8VblSJ2UNzXryecBvd2yJ6AwcvBVzk/g5/+w3l8oNb66M41HVGoeThvTnKJky4W
	 Utkp+RZ9w3/A0wn54QXz+2ra4NakRzTJhKXaEmBtRU2rOEAE4oJnpxTBFmYGdAbrobbjr
	 2+nXISQmZIt5C70yGqSZvxDms1WkXDdX/JFkTqC9nG6JpEYJcwzxVDKSC5lH91NCbR1Un
	 qTDRX2EKgr5VzIIvoXRmdnkPbAEZK/Dlcn/eD4b4mFRnFnBC9aZfKq4JXc2P2tKXAGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOrUjcWF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EBC37606A326;
	Thu,  5 Nov 2026 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOrUjcWF
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 996C01F000C1;
	Thu,  5 Nov 2026 12:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882082;
	bh=1xICXLkoltoG973pTU5+bCGheB4eRXzeQ6tdd0yZUTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bOrUjcWFHI7vwsKK+wAtmWPvfqjVBr8IHGzYs+k/yJyvjaEnfq57Ex1fUNUCfwQ9j
	 QmfOxQdH62fbSDNvS8AwidP3Xzj4QtLNnILFJhO3bGQsKQ1Qk5u6VCnNg4XK7CodYF
	 QTneeyD/OdU7D5jPug7XaeGApDfNv/neZdjxSf2z+t6pS/97UC1M8wdlvtjKAGIX47
	 n8pVGJ4OQQOFzyPfOeVcS7fMCUm0cvdW6EmqCsmjm5jduqP1ogWPLDOiRbTY3esRSG
	 HHyvL2jGQ837QG7TVLSMgECJY3VmtMfL5LjQorK4MBx+2Z94Dh1swmYy+L/xwsATgO
	 dKn8BgtjJhmRg==
Date: Thu, 5 Nov 2026 13:34:38 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: mani@kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	krishna.chundru@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com, 
	deepti.jaggi@oss.qualcomm.com, yadu.mg@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Power on pwrctrl devices for firmware-managed
 hosts
Message-ID: <7c4jiphsi7z4pe2srkitn3hgznwjcghzmdftbhbb3vv64sbc5x@iaxheybo6jui>
References: <20261105101521.434361-1-zhangfei.gao@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105101521.434361-1-zhangfei.gao@oss.qualcomm.com>

On Thu, Nov 05, 2026 at 06:15:21PM +0800, Zhangfei Gao wrote:
> commit b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power
> on/off, destroy APIs") switched PCI pwrctrl users to explicit create and
> power control APIs, but only added the calls to the regular DesignWare
> host initialization path.
> 
> Firmware-managed hosts bypass that path and probe the ECAM host bridge
> directly. Endpoints already powered by firmware, such as NVMe devices,
> remain discoverable. Endpoints that rely on Linux pwrctrl and pwrseq,
> such as WCN7850, remain powered off and cannot be discovered.
> 
> Create and power on pwrctrl devices before probing the host bridge, and
> release them on errors.
> 
> Fixes: b921aa3f8deca ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
> ---
 
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
