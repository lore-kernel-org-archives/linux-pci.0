Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232623C3C01;
	Wed, 11 Mar 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227125; cv=none; b=us2ExhvYTuAolTmyyu+nLPWdA29p4GTuKI9oKeD9Gic2JMAMoZ01uqS/3JDO4YvimWVutqnwrbRhumhbxhZVjbG35LKKaTVZ8UvCuLb3g9IuuRHmMhA/YJ7YUTxmKCNHRotWGo51SCMiChtWOlwzaDJiPSpB0ddF7g963mwLrjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227125; c=relaxed/simple;
	bh=BgLuLCpNt8YikxfkQc3yHUtyj3A7U731tcqZVJqZcPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuE7U1OQoaL0bnZWCNEJZTTgN1P70lDjWRFqIzh3l5ysofTCcAvDwZkidOdc0pkNqS8/U9/abKDmfkNty8Zyiy+Lj+v2ySLIL30KFpJjMo8w/+BV9/fFxvdEak2MYLg0je8HyPpi3QRxdUs7KgKrT3ruv2wo6M55Q5vqvRFnQmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq24ij66; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq24ij66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6B7C4CEF7;
	Wed, 11 Mar 2026 11:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773227124;
	bh=BgLuLCpNt8YikxfkQc3yHUtyj3A7U731tcqZVJqZcPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eq24ij66oMbyTp1yMVUcNGzHc65udFXi7P4njEUQUTlsmxGbZAXKzJnJ9FlGX4OH5
	 8EJdF+H5q/pNCEc9m2zibOEiho3mYxp4rAL9uS9PPqOtvTL8xHBpnRMGEbfimxABGW
	 iwMIRCPAVGeGn0VdA1SK0UaD2BwdtnTi6a4F0LutKSrnZ0AUkgwHiWqYHeq2Yo+hQB
	 BX77RFSPRFEXfbCIFMcHngXlOR7zC1ZXJuzsO2W8TO5YKYMAyOP3XiWDOWdC2AEfyb
	 Py7eKU8OcsajO4JUfyO2uBjjwKK/FMz5jqIaK34DcCF4ou2NdzrBnCexEbFUbfSP1d
	 bXzS+9ypNh3XA==
Date: Wed, 11 Mar 2026 12:05:15 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>,
	Brian Norris <briannorris@chromium.org>,
	Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <abFMa6DCGGLUHddA@fedora>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>

On Tue, Mar 10, 2026 at 07:31:58PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Changes in v7:
> - Dropped Rockchip Root port reset patch due to reported issues. But the series
>   works on other platforms as tested by others.

Are you referring to

## On EP side:
# echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
  sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start

Then running pcitest only having 7 / 16 tests passed ?

If so, isn't that a problem also for qcom?


There is no chance that the patch:
"misc: pci_endpoint_test: Add AER error handlers"
improves things in this regard?

Or will it simply avoid the "AER: device recovery failed" print?


Kind regards,
Niklas
