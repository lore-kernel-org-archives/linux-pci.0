Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3523E325;
	Mon, 17 Aug 2026 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786934654; cv=none; b=QnLA4ZWxhZORhekH+XIFjLWFSMftpURopH8cAv2rJn1dD+BPhp7DcxzIU89B9dQ5uU3chP76a1lcLJwc8EFboMuFQM7h35WNsLbaedC6sbyqQ9BA6W+H0+U3ZKK+2UQ0xE7P6dIydkHkBL5x9A+KDndsI+HoslD5bDj7MEDZ6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786934654; c=relaxed/simple;
	bh=jXWz8a4quTA9UUCfE3/dR/cgPqEwNcJqcp4C9L4xZaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eU+EE83CmQVyWdBZMrzbKZPwgQLQhmjFzl/prlxuGSqCappROzxDYY2/sKKqiA9YRLBp1gK9yfUFeqYqmj76+6kDXXCL4rmtWyRbaSCF6v1xB9jPQsDYsMngQ3tuvIYaVOoI7uA8Sm9Z98Xp8v3+jtkrBxqaxJOq4fLD6QMmqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUM12/DC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUM12/DC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409671F000E9;
	Mon, 17 Aug 2026 02:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786934652;
	bh=jXWz8a4quTA9UUCfE3/dR/cgPqEwNcJqcp4C9L4xZaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUM12/DC47uf3JC969jqV2M8xqsRG69kc2ZMf+dVmfrTg/ZSpcKVaSHtJIEyY7bW9
	 UCnMVQrg1proEEIIXtWYN/15jeTZFFIIdnl7N3PpzbA+20fBzSh1hB5JE2S/YqSkDk
	 op2tjaxG24vAaa+yflo/9mM1qg/DLpxOHJMhr2WYJx2eoaMIGAsHovrtk8ylCjsxtr
	 o8nzc1t2YXqKZi6nBQaeoFq4JGG1Md6eYxCAu9hD5wAEtYvT9zSIyn91LtKzJrK4ic
	 er9NZOQm/D0Vp+nI66Q+Jpdcuphy5o6waIQaQKx+1QY4QRV1p8gdcQRpOsM44fVebu
	 cF/kuOKGSjtIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260817023932.1743100-2-sai.krishna.musham@amd.com>
References: <20260817023932.1743100-1-sai.krishna.musham@amd.com>
 <20260817023932.1743100-2-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 02:44:11 +0000
Message-Id: <20260817024412.409671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe
> IP and integrates two PCIe host controller instances. Add the
> "amd,versal2-cpm6-host" and "amd,versal2-cpm6-host1" compatible strings
> to describe the HOST0 and HOST1 controller instances.
>=20
> Add "intr" to the vendor-specific reg-names in snps,dw-pcie.yaml for
> the per-controller interrupt register region used by CPM6.
>=20
> Update amd,versal2-mdb-host.yaml with separate register definitions:
> - MDB5: 4 regions (slcr, config, dbi, atu)
> - CPM6: 5 regions (slcr, config, dbi, atu, intr)
>=20
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817023932.1743=
100-1-sai.krishna.musham@amd.com?part=3D1

