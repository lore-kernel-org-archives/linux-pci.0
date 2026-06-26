Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968F3DC4B6;
	Fri, 26 Jun 2026 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462764; cv=none; b=MOydFxfmIzwq9s9ZYI1B7mflmZ8v1tsMY+gwYVb35JPihYG58lT9kFUoeh7uHxUZOgZdzHRS62KNE8RKYMWHbJIO7hxti3Mla05twUffX/NGerTs1w7H/Cwh/vQqcMsMoetcpbcLATRFKsCCKuo+sEE99WkZLRquovdWc2sgczQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462764; c=relaxed/simple;
	bh=Pt1xeEVxh+RMnwFejIPeJvhA3QGy1clGAAUaufBcNhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+rGWMTX3FmZAw/URfPLIwaLhYi22ibdRmbhSnLOOVPpwjXMNEIoXXJEe1nPOWkIR+R2x4sJlHn2N+vBVBIZtwP/qRDv+I+1qQ53u4VOKe91c4QUcx3fZINDWGgYZB/iOk5/CX2LUHbdFwhFh37mBPrhZw34lWNTb0g5c0PpF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3Oj9lvO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3Oj9lvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7731C1F00A3A;
	Fri, 26 Jun 2026 08:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462762;
	bh=m8LKJpnC3p6wTPDBmbIkqrfhxk5v1Qrw3pMWR/si1lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F3Oj9lvOV3ySNdBuR+ByW4k44FLixXZjv5EZXg6uNLvi0t2KYkTErTorNksn3UR8m
	 NEtysbAvZ6uUnbLDG4YyLB0crCrjrK0gZE3/4XgGhU3g9NDQ/ZII5oNwvwGoXyYeck
	 /JhCoS5pyM9s8ObDwB8zcRsiV9Sn1ZOoTtTeVBD6ZphmntocsSPEOSOxMSMNOPg02G
	 C79rtWCHT0QfXBzn2wZBdO9t6B2jkO9ZSUs/KPVf5VLVOd5AhZbj8JEdJmiSJZXNM8
	 SdSQ3H1hc/9Pgzgdf0eZZgRvNXZedtWgIJKyYQk1068QiMabXs3d0o6hJvsiI2YbVz
	 nTo2J75zfT4rA==
Date: Fri, 26 Jun 2026 10:32:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matthew Leung <matthew.leung@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: qcom: Document the Hawi PCIe
 Controller
Message-ID: <20260626-lovely-scrupulous-mantis-bfcbed@quoll>
References: <20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com>
 <20260625-hawi-pcie-v4-1-1a578603cd86@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260625-hawi-pcie-v4-1-1a578603cd86@oss.qualcomm.com>

On Thu, Jun 25, 2026 at 08:38:58PM +0000, Matthew Leung wrote:
> Add a dedicated schema for the PCIe controllers found on the Hawi
> platform.
> 
> Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 196 +++++++++++++++++++++
>  1 file changed, 196 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

