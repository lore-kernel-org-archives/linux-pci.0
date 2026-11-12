Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523243;
	b=FIFWIM+WMUC86kLut87+xg5TrHWj9UHGtQxFDmJJlf/EyshISW98lqtXzQcoo1vp4DZt
	 HTdTAWb81w9HzBsPRCEvpbXxgqTt/PQ9x9UIQN8Dve0ZAEBeVXzk+UmVt6L7AQsuMsGOt
	 Qz9A11gNKg6bQMtLk+KkDCjEMuouHEgUHgVD+tpgMW28wV/dDAt2EHhA12mTyAagBU5VH
	 uGCzQTcoq5nWwI6RwBK5to7rLPW0bwxWj/6hJoJs7/IphAkxKR7Ssga7kPVY31oTVN+eJ
	 K6d3Xv9blCsxfkdhPtjSJTdn8bx2ZINW7K40hRPePnISVHOxW3zzSTjtZVyxiLFCYmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523243;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y8mccA3rnVeYhybd0To5XtK/l1R3oRm4MUJRh9My/aQ=;
	b=wt8r8QhVEqC7Q4kS14y6jhWwY6qRICrRsBvRLc/O32q5384G2m4xSOl17LtrtOmmzef4
	 rqtMr/azSzykMWHeFPiHcBfC8vvEdjabhK5FTIDY4hp67ZVVy5OSzAp8qgNPqQnE7zqla
	 gq9EED9TBUiYQkSJnTm0+B9gfeWMuUkvEE55aNnlWGlkZQdyzigZyVXbuMMBM4YizgKYx
	 6C6sCgonKURdbSq/zed2yM0HIKxAAkaGSDZn6ujnj1uEekUtx+32i9DkAxi+/zDAYcHCw
	 4hfKOQMcwgYG86qR/tP3LbJx0/BuJSSkiLDEl4OXCFEUmHbBneokpp0qWjgvQFNRW/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ingfs+yj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD1606A321;
	Thu, 12 Nov 2026 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ingfs+yj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800C21F000C4;
	Thu, 12 Nov 2026 22:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794523242;
	bh=y8mccA3rnVeYhybd0To5XtK/l1R3oRm4MUJRh9My/aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ingfs+yjgK8J4e3ba1OdpB21xw6Vobdl3VmX1KB3NlfBWu7YFblRmfyCEf+S+QS4e
	 Kl2nabipYec3PNLGzesMgLSKGxTyx07q6hISc+dbvl404Bhltp2BDYGM0pq3EKJIW3
	 Xx3ecnTeAaRZdKt+dD8AcX5lUKv1faL7x4I4SytjR8Wu/eBqvcJjZYWv1I25dDwZ+s
	 U66it7hsw4zysnGrposM3irYTHpcEQ1SYTsQO5m6exeApbjCi6u5bk7Q5tEwkr4Zei
	 dviD2fbV95PKfF0/74aw3unbb2QjUFr5HUpHOaNHUvGNse+5KeGYgcUp+Bnv05jkJG
	 NLe1xbs4GInQw==
Date: Thu, 12 Nov 2026 16:40:39 -0600
From: Rob Herring <robh@kernel.org>
To: Linghui Wu <linghui.wu@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
	Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
	Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>,
	Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
	Cheng Jiang <cheng.jiang@oss.qualcomm.com>,
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: PCI: qcom: document the Shikra PCIe
 controller
Message-ID: <20261112224039.GA1755530-robh@kernel.org>
References: <20261112083355.3884737-1-linghui.wu@oss.qualcomm.com>
 <20261112083355.3884737-2-linghui.wu@oss.qualcomm.com>
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
In-Reply-To: <20261112083355.3884737-2-linghui.wu@oss.qualcomm.com>

On Thu, Nov 12, 2026 at 04:33:52PM +0800, Linghui Wu wrote:
> From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> 
> Add a dedicated schema for the PCIe controller found on Shikra.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/arm/qcom-soc.yaml     |   1 +
>  .../bindings/pci/qcom,pcie-shikra.yaml        | 192 ++++++++++++++++++
>  2 files changed, 193 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-shikra.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> index 179aadc86a9f..72e0f1a824c6 100644
> --- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> @@ -43,6 +43,7 @@ properties:
>          - pattern: "^qcom,sar[0-9]+[a-z]?-.*$"
>          - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
>          - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra)-.+$"
> +        - const: qcom,pcie-shikra

Pretty sure we don't want this. Surely this was pointed out before v5.

>  
>          # Legacy namings - variations of existing patterns/compatibles are OK,
>          # but do not add completely new entries to these:
