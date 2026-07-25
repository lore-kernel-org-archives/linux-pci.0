Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504D31E82B;
	Sat, 25 Jul 2026 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970763; cv=none; b=Y0AeIpLp26tawSj5pMUgYYr+GfUyqQasIOARUH3fc8IpfyClbAYONqrTsgQV5iIilankLQe1fhvQ3qf2SWztXNEwGSlHHcr/pXu4YJnvd5LiI4vQAwxqz8h3K29tV4eCtn+iEk3ye6cua9QUeFC3QRSjVaMFxmtV+lzcg6f8GfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970763; c=relaxed/simple;
	bh=VS9wIdLx9Wnlk8rEKZBHVkhTnXIkUi6+wf7GwZdkwlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hdPQ4sYPFhTEFxddl1gD9WfirhGdoZwsgaHGBWGfDe776J65UMsWc+DzBL0R5VU7ZqxR3u5zEzjbaly5E4A76V3WjYCK0ZvFpF1YzxPM4ZkNjl4m4b29AlwJcy6ujgIm96lHo8phKw4nVmNfuVIHgupoXjkhZHoqobVDsWs4PRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9bDR9QK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9bDR9QK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C831F000E9;
	Sat, 25 Jul 2026 09:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784970762;
	bh=dW9m2CUkaacNqSNc0FzURfkE03aqT6Fsg52VxFW2VMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f9bDR9QKSdncGU0/1y8aH9cO4865gBQfyO8QOUngOQzzRPH/8xK6+AIG8vMllGCit
	 TbQ7elDjcux7LFMkfQjlvz87X9WD+x0myAKuzgCipJ3mTUDW1QlMkUrBdqx1TfUQHT
	 5K6v8ZiWrZxKehAiwaQf+/SmsPZ1nvYm8vaaThTJV7PqZYV/6ERExQPgKD/mUq6kyH
	 D+IG7wGEv7DuNRuaK7RZjfp3AZBtY+t3SgNwIKFNnSHEfwkToi8rBSgsYbkNjL9gGl
	 Ey61w1bAe7efr7saQHJnMKeU9S0O7UdfPT/n8ORgYhg0f6yzAM1+oSCG7r7EzU9zwg
	 gduhIuXQolt0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: PCI: toshiba,tc9563: Restrict Tx
 Amplitude, DFE and N_FTS to USP, DSP1 and DSP2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260725-tc9563-fix-v1-1-ec4286e31331@oss.qualcomm.com>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-1-ec4286e31331@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 09:12:41 +0000
Message-Id: <20260725091241.E1C831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Missing schema constraints on Ethernet MAC node silently allows =
all undocumented properties.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is an out-=
of-bounds array write in `tc9563_pwrctrl_probe` when parsing multiple Ether=
net child nodes.
- [High] This problem wasn't introduced by this patch, but the driver assig=
ns PCI switch port configurations based on fragile child node iteration ord=
er rather than `reg` addresses.
--

--- Patch [1]: [PATCH 1/6] dt-bindings: PCI: toshiba,tc9563: Restrict Tx Am=
plitude, DFE and N_FTS to USP, DSP1 and DSP2 ---
commit 54f91cfce5dde398e9e08b16babbdffbd75f5ca1
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

dt-bindings: PCI: toshiba,tc9563: Restrict Tx Amplitude, DFE and N_FTS to U=
SP, DSP1 and DSP2

This patch restricts Tx Amplitude, DFE, and N_FTS settings to USP, DSP1,
and DSP2 ports in the toshiba,tc9563 PCIe switch binding. It updates the
schema to explicitly disallow these properties on the DSP3 port and the
integrated Ethernet MAC endpoint, and adjusts the example.

> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/=
Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> index b3ad05d90201c..f084830c6d0cb 100644
> --- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
[ ... ]
> @@ -64,6 +64,21 @@ patternProperties:
>        - $ref: /schemas/pci/pci-pci-bridge.yaml#
>      unevaluatedProperties: false
> =20
> +  "^pcie@[3],0$":
> +    description:
> +      child node describing the internal downstream port connected to the
> +      integrated Ethernet MAC endpoint of the tc9563 switch.
> +    type: object
> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> +    properties:
> +      n-fts: false
> +    patternProperties:
> +      "^ethernet@0,[0-1]$":
> +        type: object
> +        properties:
> +          n-fts: false

[Severity: Medium]
Does this ethernet node block need an additionalProperties: false constrain=
t?

Without it, the schema defaults to allowing any undeclared properties.=20
Could this allow toshiba,tx-amplitude-microvolt to still be placed in the
ethernet node without failing validation?

> +    unevaluatedProperties: false
> +

While reviewing the binding changes, I noticed a couple of pre-existing iss=
ues
in the related pci-pwrctrl-tc9563 driver code that might be worth looking i=
nto
since they relate to how these device tree nodes are parsed.

[Severity: High]
This isn't a bug introduced by this patch, but there is a potential
out-of-bounds array write in tc9563_pwrctrl_probe() when parsing multiple
Ethernet child nodes:

drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:tc9563_pwrctrl_probe() {
    ...
    for_each_child_of_node_scoped(node, child) {
        ...
        port++;
        ret =3D tc9563_pwrctrl_parse_device_dt(tc9563, child1, port);
}

If the device tree contains more than one Ethernet child node under the
pcie@3,0 DSP3 port (which this YAML binding allows via the
^ethernet@0,[0-1]$ pattern), the inner loop can increment the port variable
to 5.

Could this corrupt memory? There are no bounds checks on port before it is
passed to tc9563_pwrctrl_parse_device_dt(), which uses it to index the
cfg[TC9563_MAX] array (size 5). Writing to cfg[5] would overwrite subsequent
struct fields.


[Severity: High]
This is a pre-existing issue, but the driver assigns PCI switch port
configurations based on child node iteration order rather than reg addresse=
s.

drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:tc9563_pwrctrl_probe() {
    ...
    for_each_child_of_node_scoped(node, child) {
        port++;
}

If a board's Device Tree legitimately omits an unused downstream port (e.g.,
leaving out pcie@1,0), the iteration shifts.

Will this mistakenly map the next port (like pcie@2,0) to TC9563_DSP1? It
seems this would desynchronize the driver's port layout from the physical
hardware, routing commands to the wrong switch ports and missing the DSP3
ethernet handling entirely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-tc9563-fix=
-v1-0-ec4286e31331@oss.qualcomm.com?part=3D1
