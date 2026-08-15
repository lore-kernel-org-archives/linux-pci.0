Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780E38F950;
	Sat, 15 Aug 2026 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786826766; cv=none; b=VCo1jhOokpopAY4Lw7T9DpbV4ivKZkUVp52PZo6mmPwFNpXdtBkZhYYseiyKdVg1yWY7+khmYSPdyfymV6JgW/DV/tFiZq+AH7PMZVqtjl/JL4lbHs2O5stWIihWvCO0sXUOimue9EJHiJirbqRSY8qAJHq1qGSFBkt7DnBtGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786826766; c=relaxed/simple;
	bh=NWK4VDaRCEAOKRk7hmiqQxPbGCXhpAPXG0UfVqZWZes=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jAkW9MtmHHySXo9Vvj18s7VEgEfEmccwX5tJG8RKzPQ01kM54lJgL5ov16oS4E2KpeNLJARjBOPSNrmnceMLbQNepxbLhiV0qo4BqfftjJh2qFNjKl0VmGd+UwkzKoOgzLgd4Y3UAh5EDOEKXmTQ6dR9WVomHWrRN1F8Gzds1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beecBMTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beecBMTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E751F1F000E9;
	Sat, 15 Aug 2026 20:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786826762;
	bh=orrg1L1lkpXTAkedrMDweL5IkRJ68G6ofmpPlxyVlpc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=beecBMTxCMdVmysa+siS46bLQcsmVYidk2POtwt5y7FN57lA+702Pa9NWl3DamX+h
	 f+sWq7v01V6Xs3e8omVdxSceaKrfcpK8+zXW27QWvRGWBPtwFQpw/nkj43L+hW+wR+
	 XZfvw+ZP9PJA9XMEBv7mrRVqm+poj6IpH96EE7OjymvCGNWaeA/817zchNOH5MB/X6
	 0OTa7Hf5iQAaAui3PnU3kJSpYJCG5KWmzjFyEvIJDwug+UboQKzsuZekixOlEPTmO4
	 MYFBXGVBTgWftkD2waz3Xsns0XRT/G3hBvQmAuj+sJ1mkCHmWTFj6RhWAHvcZfJIIS
	 PqRH5cr+FP3Sw==
Date: Sat, 15 Aug 2026 15:46:01 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: bhelgaas@google.com, conor+dt@kernel.org, linux-pci@vger.kernel.org, 
 mohdayaa@qti.qualcomm.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
 daniel@riscstar.com, krzk+dt@kernel.org, arnd@arndb.de, 
 lbiancon@qti.qualcomm.com
To: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260813222943.1655453-2-elder@riscstar.com>
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-2-elder@riscstar.com>
Message-Id: <178682676059.2183315.4478974489132403040.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml


On Thu, 13 Aug 2026 17:29:41 -0500, Alex Elder wrote:
> Define the binding for the Toshiba TC9564 PCI endpoint function device.
> The third downstream PCIe switch port within this chip has an embedded
> PCIe controller, and that implements two of these PCIe functions.
> 
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../bindings/misc/pci1179,0220.yaml           | 150 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): pci-ep-bus@0:compatible: ['simple-bus'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): pci-ep-bus@0: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): pci-ep-bus@4:compatible: ['simple-bus'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): pci-ep-bus@4: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): ranges: 'oneOf' conditional failed, one must be fixed:
	[[0, 0, 0, 2197815296, 0, 0, 0, 16384], [2, 0, 0, 2197815296, 0, 0, 0, 524288], [4, 0, 0, 2197815296, 0, 0, 0, 2097152]] is not of type 'boolean'
	0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	2 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	4 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,1 (pci1179,0220): pci-ep-bus@4:compatible: ['simple-bus'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,1 (pci1179,0220): pci-ep-bus@4: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,1 (pci1179,0220): ranges: 'oneOf' conditional failed, one must be fixed:
	[[0, 0, 0, 2197815552, 0, 0, 0, 16384], [2, 0, 0, 2197815552, 0, 0, 0, 524288], [4, 0, 0, 2197815552, 0, 0, 0, 2097152]] is not of type 'boolean'
	0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	2 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	4 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,1 (pci1179,0220): 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260813222943.1655453-2-elder@riscstar.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

