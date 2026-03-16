Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535253596F8;
	Mon, 16 Mar 2026 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773649300; cv=none; b=snJM+rTxBpiBpGn38es4WDAo2k8BH5lvO+Rvcy9GFh97yjXIGsZjdDyUN+o4e3QBj26khNnDpjsRUP4akCuAa11+9nejejXpmEQMmltzupsx43EvONzs8Ijuh8s7Z6Ypl53EpGTC6ZO7zWm63nqrXc44eRy1Vi5SXLctQeKClTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773649300; c=relaxed/simple;
	bh=QymIldvWQHOa9u4HoUVVSN6ly5TVfP3/q37SKFHTL08=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=b7eKnmUqb9D7hc//NhIMRZ//fjkdv6cs3armsKIyMVKwmubnJVkm1cd3pImcOd8MbZupemE1rsvD066QTu0kTUyse2NgEhlAQLSydQa28G/KjsTkMfLFCSfMIoGmGWhdP9cJCug6vGf3kYyWH/ZEft8C/+JWjzbJ4DDtjB4f1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+jCuf6U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+jCuf6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA45EC19421;
	Mon, 16 Mar 2026 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773649299;
	bh=QymIldvWQHOa9u4HoUVVSN6ly5TVfP3/q37SKFHTL08=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=R+jCuf6UOPK0pb7EmxDzAN14G7fn+TYuilrdXvi9oRBAveNGvpG6spOjb7YF5w8Cx
	 7jJIzk6ukkCEL0WcItEyAlf585FczhEfwe2MhWGOQ9rc8SBE8OVhYbDZV1Qibn7EFv
	 zobC5n+8vQexckr8oU4Abp8llabvgrXBJRGGRajgJnC43wJH3g1PgUzk1RpJ1pt3qR
	 /2PjxUjggaADdhjtO8RwFETJ5USIqQZPvgHuz8Tom+OOrLBv0CEZO3NSMMggdT025U
	 O+ahkhLXe7wksOR14CICAggbX3Cr6k/66xNd3p7qRvMEBmmsRDacAshanu5pRoP0m6
	 3WVnLCLebrutA==
Date: Mon, 16 Mar 2026 03:21:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>
To: Jia Wang <wangjia@ultrarisc.com>
In-Reply-To: <20260316-ultrarisc-pcie-v1-3-ef2946ede698@ultrarisc.com>
References: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
 <20260316-ultrarisc-pcie-v1-3-ef2946ede698@ultrarisc.com>
Message-Id: <177364929764.1046214.13699651740074271027.robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: PCI: Add UltraRISC DP1000 PCIe
 controller


On Mon, 16 Mar 2026 15:06:59 +0800, Jia Wang wrote:
> Add UltraRISC DP1000 SoC PCIe controller devicetree bindings.
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  .../bindings/pci/ultrarisc,dp1000-pcie.yaml        | 108 +++++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml:26:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
./Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml:38:19: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml: ignoring, error parsing file
make[2]: *** Deleting file 'Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.example.dts'
Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml:38:19: mapping values are not allowed here
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml:38:19: mapping values are not allowed here
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1606: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260316-ultrarisc-pcie-v1-3-ef2946ede698@ultrarisc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

