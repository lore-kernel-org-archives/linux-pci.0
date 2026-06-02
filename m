Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6719CD1D;
	Tue,  2 Jun 2026 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407954; cv=none; b=O3qvFAZE3D+vcEehHPurKX+XHkENL3S3yrlLd/hAnW3oXHiN2wowNlzjoBknoKSgD3vceISvy3zALxr0KpSAwwt2OFI32vt3t4m51pui3fNb5cr5YZyLUUYRRJbdHA5WM47y2Urhnh9/xHOlNEAVK03iwF8dh1rHWGQvnTe2JJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407954; c=relaxed/simple;
	bh=i2F2xxA4N6W+L727x7k9zcmhj1x+y0qs/OqbqJewpmE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lJ/pbu5wSwnNHvd+mvG5wUzphtC/UXJHtLe5nLKa7plOMwcJoLz8BPzhNmSESHuL/8cJOIaMijQteyVkTrKAEEGz4+imJDxPZtHvELNsqIcO46QugwwHbozGFk2jtz7xcxmdAGSjL3/1wSeFMxlgnLUebsUYav6Ml8aZYn7kjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B98OVdpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B98OVdpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24AE1F00893;
	Tue,  2 Jun 2026 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780407952;
	bh=M9+6BaKxCtZ2oRdla2ck1apQ7Hfje/TDxTyYeJJkXPM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=B98OVdpJWUZAnFL1XvRYfwcafAsY8Qj0f7Suj/5iVWCuVw8xd59E+1gcLe/h2RJJO
	 r/PYoiWBfSmNDftOOJ0Y0B2n3RBwMrt58D34mIPQosd/3h3wOvsu/eUUzZ5TSSQe12
	 8QFAX4Yhzjt5aOHRTS8F5Z0I48MLo9jUjAikSnP5c/2ttsX7sAgVbFYAw2+y4eh2pr
	 DRGkB8gDqMu56oW20Oi+vzJcVnvZSMsRiovmHk0Keg+LxYamuHL36YfdPBSDSxSYOL
	 57HWDb3FHotn1jXRUpvoRnUT8wd9Qy9XCyhAGsyNnKXMdCbdPf7X9kqx6aWHlAJZDR
	 KIWb+xj137gOw==
Date: Tue, 02 Jun 2026 08:45:52 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
 Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Kevin Xie <kevin.xie@starfivetech.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-tegra@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, linux-pci@vger.kernel.org, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Aksh Garg <a-garg7@ti.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
In-Reply-To: <20260602-tegra264-pcie-v6-1-edbcfa7a78fe@nvidia.com>
References: <20260602-tegra264-pcie-v6-0-edbcfa7a78fe@nvidia.com>
 <20260602-tegra264-pcie-v6-1-edbcfa7a78fe@nvidia.com>
Message-Id: <178040795218.231197.636617303245801505.robh@kernel.org>
Subject: Re: [PATCH v6 1/4] dt-bindings: pci: Strictly distinguish C0 from
 C1-C5


On Tue, 02 Jun 2026 13:33:23 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Instead of using the ECAM registers as the first entry, strictly make a
> distinction between C0 and C1-C5. This is needed because otherwise the
> unit address doesn't match the first "reg" entry. We also cannot change
> the ordering of these nodes to follow the ECAM addresses because that
> would put them outside of their "control bus" hierarchy since the ECAM
> address space is a global one outside of any of the control busses.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v6:
> - add maxItems as suggested by Sashiko
> 
> Changes in v5:
> - rebase on top of v7.1-rc1, make it into a fix
> 
> Changes in v4:
> - ECAM is outside of the controller's region, so it cannot be the first
>   reg entry, otherwise we get warnings because it doesn't match the
>   unit-address, so revert back to oneOf construct
> 
> Changes in v2:
> - move ECAM region first and unify C0 vs. C1-C5
> - move unevaluatedProperties to right before the examples
> - add description to clarify the two types of controllers
> - add examples for C0 and C1-C5
> ---
>  .../bindings/pci/nvidia,tegra264-pcie.yaml         | 79 +++++++++++++++-------
>  1 file changed, 54 insertions(+), 25 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml: allOf:1:oneOf:0:properties:reg-names: {'maxItems': 4, 'items': [{'const': 'xal'}, {'const': 'xtl'}, {'const': 'xtl-pri'}, {'const': 'ecam'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml: allOf:1:oneOf:0:properties:reg: {'maxItems': 4, 'items': [{'description': 'application layer registers'}, {'description': 'transaction layer registers'}, {'description': 'privileged transaction layer registers'}, {'description': 'ECAM compatible configuration space'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml: allOf:1:oneOf:1:properties:reg-names: {'maxItems': 5, 'items': [{'const': 'xal'}, {'const': 'xtl'}, {'const': 'xtl-pri'}, {'const': 'xpl'}, {'const': 'ecam'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml: allOf:1:oneOf:1:properties:reg: {'maxItems': 5, 'items': [{'description': 'application layer registers'}, {'description': 'transaction layer registers'}, {'description': 'privileged transaction layer registers'}, {'description': 'data link/physical layer registers'}, {'description': 'ECAM compatible configuration space'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260602-tegra264-pcie-v6-1-edbcfa7a78fe@nvidia.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

