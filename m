Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAEA31ED9F;
	Wed, 21 Jan 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983824; cv=none; b=jSBGXGlKfGayIiToRMsyAwDJjWcD72F1ulyPJOQz0ZfNnfpKFrdjGvu8xkSRbVGK9eP/R0wMt3gGHVRhkgUt9lsXTk+8CwA53UudvtzPy2KjCb7xzixUtRddO3Cd7UJes/CXY4TSDBXheyr8CEWqQHwSUNJZcPwzIchf0FipmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983824; c=relaxed/simple;
	bh=0FIFmWRDaTwQWfRac5uIGswCMKQtlCeYeNWR97q+tCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVz8ZoIS/zkTqUzVk18XnkDqtan4opHY0kc7j00DmWK1J6QpGLq8lWJ1GrjUntT7S0WIonor/oyfHz+dMhPVIE2rM477yvZRzrzs1pgf/O6VLzxNh9RYzWbli4HJtXUe1GLSACmazHFKI7aoiLQbq/WKVwQIUX/jn/oI6frXyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/O2iBAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/O2iBAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33C8C116D0;
	Wed, 21 Jan 2026 08:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768983823;
	bh=0FIFmWRDaTwQWfRac5uIGswCMKQtlCeYeNWR97q+tCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/O2iBAJtXBTilnk12YTX/Q6CBJ3SYI3afWqN8plTdsoAP8M99bqlEsUIaA8vHGua
	 dhSvCLeWXPN/+5iCxQBUYqpc2710p0EZQlIo0efBB3QJaM0m4Sku3/kftmYzpK5+if
	 qw7eypQlTIYdgJxETjezWKG2I0gJgGdGIKzujWO4TUz+FCZJ0rQH0+iKwe46BzZE6t
	 PRBWNvxVmOYeOYJLfu0s7DXHNIU0fULBAFam6QwUEFBYkfXRU57vt5ctfPEwqbXbSO
	 RKKlSF2Y/LYsh3aXVPk61m1BCmVMrJ7HHm8iqmzZ9RAEc6Ac12HQRJ4zb8AxoIEdzF
	 y2eQuJsRKI8Ng==
Date: Wed, 21 Jan 2026 09:23:38 +0100
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
Subject: Re: [PATCH v4 3/5] PCI: dwc: Rename and move ltssm_status_string()
 to pcie-designware.c
Message-ID: <aXCNCqHdDKZpoiI_@ryzen>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
 <20260120-pci-dwc-suspend-rework-v4-3-2f32d5082549@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-pci-dwc-suspend-rework-v4-3-2f32d5082549@oss.qualcomm.com>

On Tue, Jan 20, 2026 at 11:17:42PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Rename ltssm_status_string() to dw_pcie_ltssm_status_string() and move it
> to the common file pcie-designware.c so that this function could be used
> outside of pcie-designware-debugfs.c file.
> 
> Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
