Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFD64779AD;
	Wed, 21 Jan 2026 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983742; cv=none; b=EPAXuD2Xt2uYeYZ+I3GDZoBASNtgW580e5yGDTM+XxGhmSyveRYhtZOpdUDcNYdaChEl9OKNXueuenBhqrca6ay3ZdEpcQPlw3d68SICTohFICoj8APr11q/7Ow44eMr3ZNta0yZOjlckjaGoMG8xvhEdWcU9wl/aHH6vo/dkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983742; c=relaxed/simple;
	bh=n8sexnik+ScYU6cWCdimxijHD/TDpaRP4AIcpqQFamk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmqaXcbSmhpdkprGnzIX+/mrxp3LJf6LupLFm4mkVz7/FIMdJksrEBF/KtWmgeA4cw4OcGNkrARp/+ZATVbuBao53yl/lwbYL9n7HOi2ezurYT8bDRkkbDDgULrqNqwxbw6oBbfBwvfiv5SDRLT5kQIBiYc6NXoXaozaLuPYKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggXffywQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggXffywQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B021C116D0;
	Wed, 21 Jan 2026 08:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768983742;
	bh=n8sexnik+ScYU6cWCdimxijHD/TDpaRP4AIcpqQFamk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ggXffywQ/Fap7jCSlASLxJ3flGw76M3U27kdDHXIYmh/1V5AOiyX/E43QNL7LJWxF
	 bQWIDm9EzQAf1QFjBqYxXwqQfia2WPe/0R15D/YqXv9cwqM4D5CYtm1+Tt6Djz87ic
	 bdfMSc0wdeOdVi/CPrLFZ+wqZhbntgxNJFyoVJvfErrDL809QrDSu5RR8CXpMB5MnS
	 AVrpMc88qxIbXY6AzCCXIn4/809GKgAvFYta8vh4aVRtNsaJ3Ya9yE5MOh/SUairHF
	 AV/zgDwMlJrvzls6afhQRHqtbFXPV5piLD+L6PvScoFhVp2HzWqdAv7M6gqf6wCkwo
	 M/0mb5Adxo9gQ==
Date: Wed, 21 Jan 2026 09:22:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 1/5] PCI: dwc: Return -ENODEV from
 dw_pcie_wait_for_link() if device is not found
Message-ID: <aXCMuCQXbcWOEqEn@ryzen>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
 <20260120-pci-dwc-suspend-rework-v4-1-2f32d5082549@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-pci-dwc-suspend-rework-v4-1-2f32d5082549@oss.qualcomm.com>

On Tue, Jan 20, 2026 at 11:17:40PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> The dw_pcie_wait_for_link() function waits up to 1 second for the PCIe link
> to come up and returns -ETIMEDOUT for all failures without distinguishing
> cases where no device is present on the bus. But the callers may want to
> just skip the failure if the device is not found on the bus and handle
> failure for other reasons.
> 
> So after timeout, if the LTSSM is in Detect.Quiet or Detect.Active state,
> return -ENODEV to indicate the callers that the device is not found on the
> bus and return -ETIMEDOUT otherwise.
> 
> Also add kernel doc to document the parameter and return values.
> 
> Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
