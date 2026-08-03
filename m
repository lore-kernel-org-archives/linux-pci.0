Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1230E0F8;
	Mon,  3 Aug 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768620; cv=none; b=O4NCW8NgsnB+FbZsoPhjrX/D3xg4ccZrvd1ZSp36nVIr4ITmwTeIBQH5+ZNlL3dw4LRyiSwh1YGTtMsnLVKh66ttS9sMV8uvgzLo10cHICa3/BI1vEutHF5SWiZQ24fN4U/qWlk3zxSj2GeqToR7NuFxlnUYMHj/YfdbTXsv+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768620; c=relaxed/simple;
	bh=13wspIIA/IGsOIaEqgdYaJbDJq1+ljuAblt7o7qNKO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jTlMoupxJNs3YiX+N7jUkXZt6DvpRuXTZ9gvoXYAcGltXuAi7dijVDgunTW6P5SJtIVAPnzdZXJ95jVZYLBbEAnTI8ORD+XJG+dcfTQ0RdbyS+RBxAZwFbdK7B9ZLOOVXGj8y8ojzUqUgM3ykc9yqju8MhCjhPujUwgl/Oa5clQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt3+BEZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt3+BEZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4F21F000E9;
	Mon,  3 Aug 2026 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768619;
	bh=13wspIIA/IGsOIaEqgdYaJbDJq1+ljuAblt7o7qNKO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zt3+BEZX6NCeOkoY25gzR3QjgzSOIbUn2DGHFEa1U4Mc5wf0qVgYcpn3hFIoc/YyR
	 7MqFiwk7573ssciBh57/BWRRALTKWjBXtNAl/UF+zX0agXfUp+orLXICTxcz/Gt72c
	 GUqvNlEQuw6G/1T+ZavTku/hFNG914sqma5DhfmsN08ieSWpLgHL3guU+HRkjrIKgK
	 aof/zh5r/ONuX3UCJr0Kh8sjegimWWZGX0cUn96u/ukxYat92Jo5meV3Hnvh/5AVr3
	 gciMnkSUTD+oPFSlm62CgQ4m6MD6JqSmqgi7eUUFtuiTHPTk+3KjNdXlHMNb1jGM38
	 VAiivwjrLlW9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260803144412.713639-2-sai.krishna.musham@amd.com>
References: <20260803144412.713639-1-sai.krishna.musham@amd.com>
 <20260803144412.713639-2-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:50:17 +0000
Message-Id: <20260803145018.0D4F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe IP.
> Add "intr" to snps,dw-pcie.yaml vendor-specific reg-names for the
> per-controller interrupt register region used by CPM6.
>=20
> Update amd,versal2-mdb-host.yaml with separate register definitions:
> - MDB5: 4 regions (slcr, config, dbi, atu)
> - CPM6: 5 regions (slcr, config, dbi, atu, intr)
>=20
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803144412.7136=
39-1-sai.krishna.musham@amd.com?part=3D1

