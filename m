Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3C38B7B0;
	Thu, 14 May 2026 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779313; cv=none; b=PrpDVs4ELWBAIxl3fT9Xs9iZ7aaXTNMQjB7q3+hw2ipE9U90Qc0M77mfTtNzXm/VebFWnjOoi2T2KMMm17xGFdqUqXcNgrKDnZh7KTHUdHepgMdxWUv1UxzHs8Bw8hPbVGaL0wtL5oCk48N4FYkVE66FTi4cHMoHuX4ibQ+EyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779313; c=relaxed/simple;
	bh=pZwg25nf4mUh7Qf+CSSYXgpx08fS04gW/9MlbOOqyBc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G1s5yHbiY9G/ygY6v/NkLMQTtvSsaw7e202AOYlhd2oUqIpQFqj5SvX1SQoop9noeScSvNRiPfQbKUBbU4qTk6CPb1q1wKdxjXe3sVYW80ZyK2F2MqhbOiLiepE8n161R/JFib/0f7V8iNHiS51VqqrhqUhH/NFFSFFqqZ/X13g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnyMD/xl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnyMD/xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21F2C2BCB3;
	Thu, 14 May 2026 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778779312;
	bh=pZwg25nf4mUh7Qf+CSSYXgpx08fS04gW/9MlbOOqyBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pnyMD/xlWs8B2gzI1nXBEPPPnFwHFceNRoypISr4z8KM3WoOOJqqwzXrIHQm/XKTV
	 1JQ77RZtxZaMK+jERzOCi5ETYQjG4jlaD+97V6qj/2LxgY+N4cFFynAW9dTsjObqxb
	 9iEtiAvCwiT/eA/b2n4ihcXWKP/dHQtfCc+7IFtvzMFlNKz5A3iE+ACNCSBzG+fsRH
	 vPiu6EM9Gip9XQMj1ya50aeuGzlg0A96N7MfSPRKT9Gi4G+OVHaNy77EwnWyw8vXu4
	 mM9Fm373QxSFGman+sK9LVsrgaKnBLku34offJduPy2jxCjLPaRH7Q4RdQ6suhrMps
	 N+r3Qm+rG1E7g==
Date: Thu, 14 May 2026 12:21:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew Leung <matthew.leung@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: qcom: Add PCIe support for upcoming Hawi SoC
Message-ID: <20260514172151.GA410819@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-hawi-pcie-v1-0-0c910906f7e5@oss.qualcomm.com>

On Fri, May 08, 2026 at 01:02:13AM +0000, Matthew Leung wrote:
> This series adds PCIe support for the Qualcomm Hawi SoC. The Hawi
> platform features two PCIe controllers: one capable of Gen3 x2 operation
> and one capable of Gen4 x1 operation. The first patch adds the device
> tree bindings documentation for the Hawi PCIe controller, and the second
> patch adds driver support by enabling the Hawi compatible string in the
> existing qcom PCIe driver.
> 
> This series depends on the following prerequisite series:
> - [PATCH v3 0/7] clk: qcom: Add initial clock controllers for the
>   upcoming Hawi SoC (Change-ID: 20260316-clk-hawi-1ad4cad36d6a:v3)
> - [PATCH v4 0/2] interconnect: qcom: Add support for upcoming Hawi SoC
>   (Change-ID: 20260311-icc-hawi-d6dc165f8935:v4)
> 
> These dependencies add necessary headers for running dt_binding_check
> against the binding.

These apply cleanly to v7.1-rc1.  I suppose the dt_binding_check thing
is the only real dependency?  Is there anything we need to do to
enforce the dependency when these get merged upstream during the merge
window?

> Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
> ---
> Matthew Leung (2):
>       dt-bindings: PCI: qcom: Document the Hawi PCIe Controller
>       PCI: qcom: Add support for Hawi
> 
>  .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 188 +++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom.c             |   1 +
>  2 files changed, 189 insertions(+)
> ---
> base-commit: 4cd074ae20bbcc293bbbce9163abe99d68ae6ae0
> change-id: 20260506-hawi-pcie-f61435ca420c
> prerequisite-change-id: 20260316-clk-hawi-1ad4cad36d6a:v3
> prerequisite-patch-id: c4fbb0620d748d7f1ee675ade5167775bd31c8ac
> prerequisite-patch-id: ae5e212518cc333a1a93564cabfc6abd128df664
> prerequisite-patch-id: 3c3816e0d595589fc02383f10e48c83a61fdc9d1
> prerequisite-patch-id: cbc13fb819d1c1ee77957393f0958f05db8db864
> prerequisite-patch-id: 17e2c0cfbbea826fefa1c67d0f5dc2094ab73d76
> prerequisite-patch-id: 150dc74750377f4558deab6b179632872bcbb71c
> prerequisite-patch-id: 38fe0da5b18610aeb32c7154f9e50187ccaec6a4
> prerequisite-change-id: 20260311-icc-hawi-d6dc165f8935:v4
> prerequisite-patch-id: a1ff655f0b21d6259b158ad9f99a95bde31257e6
> prerequisite-patch-id: db21b6b20451be8475129faece7ef4191d41273c

I don't know where any of these change-ids or patch-ids come from.
