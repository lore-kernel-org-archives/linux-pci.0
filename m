Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54686375F9E;
	Sat,  8 Aug 2026 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786186676; cv=none; b=pwGQUmPsyKrB5ouGYp9i0vYBRzHqx98iyw0zG6TGXaL4sJYJ/e4911iBtzuY2fdncnhkrwTIk0g28KjW6t79ZFQ6gBb6AcURGJhBw7QskVN2cxpW6LFyMrKkpL9BNujdiE7jVi0wbpfh6bGjFjlFLo4ywSCQXq3+hZRT+DkcLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786186676; c=relaxed/simple;
	bh=akhKCtl9xjS4MSZKXKvQhZtTwWcuu9PD2Q1RVJ2ypZ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0xC/KoeF8ncef3oHv5VlfDnJScai6UJaf0QltiREbUYsTXBq/LO6PeLBP49ATy9UCsWkzpl2yad3nL+2ml7RxKWE9R6EmVbvmyT3hFcIbFJiYANel3fcJEnNDaTsPFxHNThlJKGOLev9m9frWecf8dwSttZrZfUQSTd1lVtw/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Usiosg1z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Usiosg1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E331F000E9;
	Sat,  8 Aug 2026 10:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786186674;
	bh=akhKCtl9xjS4MSZKXKvQhZtTwWcuu9PD2Q1RVJ2ypZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Usiosg1zZRuaivPeoLoLpYY1vVdqvV3cIxWZbJrd93QZc7PgwgXd7NU9J4K00WWlV
	 W/c6x0+LHGSS7qRKHYqNQY3XbFL58PwZlkIThbMHRsvXDUBr+ToZ5c+X/MML2NigDD
	 jlHNpcP1ex8sLdaj9EY1o/BGfGQ7mTFXfJZwFUB4E++LfA0IEDdtt5ucPj0CtpulgT
	 Cv4a1lJ/9V9QB1cLdcXbnBBpy1SlPO7YOYLHOaflFtrIRr/ZE9u8/HYDT7xFpeDrye
	 GmHs8H9fU/dEt5oPVj+h+2V6k3XuurBE6+DlJ7ONfDCPl/JTxJ28ueHTuu/3KObu4g
	 Z5zPWSz7vJT0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260808105256.3705889-2-sai.krishna.musham@amd.com>
References: <20260808105256.3705889-1-sai.krishna.musham@amd.com>
 <20260808105256.3705889-2-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 10:57:54 +0000
Message-Id: <20260808105754.98E331F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808105256.3705=
889-1-sai.krishna.musham@amd.com?part=3D1

