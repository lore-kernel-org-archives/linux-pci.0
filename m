Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705733F12D3;
	Fri, 18 Sep 2026 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761742; cv=none; b=aviWrxt0Z1wETBgaJDmiLCSXTo7jlDL4gjN0+og5lQUL77V9ZnsbJGth/KdYJKydD51KcQQManNExcT7mk9FOHUiD2iTi2yyWDbyYvoDwTo3V12JxkjIG+VzY+7v5CKTQwndvcf4bvqeVTKCVMjyIxnUCGXkvlftSwX5ciJRWhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761742; c=relaxed/simple;
	bh=T5dpYYlP7jfHWjz5/AG/jMVuBFZdP1hWeWvJN95Q254=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DiTljRbxIQELzMyuqNQaO2xhWg+iu6jKeyR4yuzT2QLj0/BmfG2VvI7cK9YR2OqCL73Eo1rQnNPmwDF9SoHhWSS9aHgdtCHdxyYR+MauZSKVm2VjHXk4AjsZ8O79NvzWHg3nI84OsNy1p+uV6Y92Ud7H/dOc7jFBPnC+X2dMy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLmEd2lM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLmEd2lM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EC41F000FF;
	Fri, 18 Sep 2026 20:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789761741;
	bh=MnqXejbfjvShYjb9aS8GZazk3T+YHBYH0vyg1HBvdTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PLmEd2lMXJGsFa0mu20RtohwD/5jaz2c0N+gCCJ1JpUCYbcuvftdSgBMJgKflv/bg
	 eqw2AvekQ9AJcC92loN7wofjRZh4ZQEC4Ly6TRE+8svOfIDPBWjZ/KYqJxGkIzcDUg
	 /j7ceScyy/NYJ3AsOjeC5bzwNHfhdK0RFUUixMjaFTfgDr7IOy0URP5i+ZldjRoxOY
	 feP9tp81yfu0TTbGS7OsgUbe73+5jOc9v3aWMJLLZACENHs90eZKbz/u9FEMNUiTez
	 +ObfPvZ0AppprX7eRIOWq9NmRQdobJNQQ04wyA9W0vv28zSMbO30gJsj7pNGy8QW4O
	 PcugvlM8958ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: of_property: Omit bus properties without a
 subordinate bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260918195540.GA1187209@bhelgaas>
References: <20260918195540.GA1187209@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:02:20 +0000
Message-Id: <20260918200220.C4EC41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Author: Angel J <iamanaws@httpd.dev>
>=20
> PCI: of_property: Omit bus properties without a subordinate bus
>=20
> A bridge (a device with a Type 1 header) may not have a secondary bus
> allocated (pdev->subordinate), e.g., if there are no available bus numbers
> or the bridge secondary/subordinate bus numbers are not writable.
>=20
> The dynamic OF helpers of_pci_prop_bus_range() and of_pci_prop_intr_map()
> dereference pdev->subordinate without checking it.  When
> CONFIG_PCI_DYNAMIC_OF_NODES is enabled, this can cause a NULL pointer
> dereference and early boot hang.
>=20
> Generate 'bus-range' and 'interrupt-map' properties only when a subordina=
te
> bus exists.  Keep the node and its remaining properties for bridges witho=
ut
> one.
>=20
> The problem was latent since 407d1a51921e ("PCI: Create device tree node
> for bridge"), but wasn't reachable until 1f340724419e ("PCI: of: Create
> device tree PCI host bridge node"), which appeared in v6.15.  Before
> 1f340724419e, of_pci_make_dev_node() returned early because the parent OF
> node was missing.
>=20
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Signed-off-by: Angel J <iamanaws@httpd.dev>
> [bhelgaas: move pdev->subordinate test to callees, commit log]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918195540.GA11=
87209@bhelgaas?part=3D1

