Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B94390C81;
	Fri, 17 Jul 2026 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328208; cv=none; b=XwhWoPKZpkJnvXeu7JzP/81QSmgtbVZ2TA1E2Pt/oi7KOOVcJTa9YgkC56Jh3+uK84N9Ss+M9oy4mgtYLOFGvyWdZ/UYMssAhyb7aYwm1Plaj09OW9iLnfWg4jSL70M1BKInmlBJwDrQfZvXTzjooSMBrGzQvHwYvsnnCITdFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328208; c=relaxed/simple;
	bh=7kjfVAoiaNqMWhYalPs02UTlLWdASMwynS8UH/Z7/HI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B5Y0cgUbJm+VVQMlgiOg8+EyhP+68ySmVMszoL4vw3HEvWQlR34amw7u5OP3vMKxlkVj70CfDIYxDvf2aUc6wOVlFwOM2NobZnJ3+o0miSIINIkWbNgQqOzNz+G8RGvldNBEOXXBuU0p++LE6dTirvfX4bEcJQZNHbjOZazfnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq/B8i6A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq/B8i6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DBF1F000E9;
	Fri, 17 Jul 2026 22:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784328207;
	bh=7kjfVAoiaNqMWhYalPs02UTlLWdASMwynS8UH/Z7/HI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xq/B8i6AZhMEEz7O/e90ApjqEuZKXmZMDf5mKPdz3m1HciU5f5KKLDti+BlKZH/O+
	 tQCJz76HFBXXbY7SDx6aTXn7ZwdnEMbD5FRtvdOwQGcQ9qL6DZ2frS10ZjhXEpCbBs
	 BIqqEcrKwRorttBQC4HeJq9epeSeSJ2Yl2Rj6IQ9sZjEVShfmxK55pji//p3vgcyTb
	 9c1lYutAQuakiM2f9z19cbt9yMIHerZ8TssPjIYlt2YaKegASo537y3w13XgVCWCKS
	 tIqaKOnRLIOFB48ZT6eq28opUyesUHvR1yyM9mtzS18FQ4Nvpne0DKQ9TxMVZA1VJ+
	 PeYgH6EF6wrHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 06/13] PCI: Establish common CXL Port protocol error
 flow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260717222706.3540281-7-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:43:26 +0000
Message-Id: <20260717224326.C7DBF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add CXL protocol error dispatch in handle_error_source() using
> is_cxl_error() and cxl_forward_error() to route errors through the
> AER-CXL kfifo. Expand is_cxl_error() from Endpoint-only to include
> Root Port, Upstream Port, and Downstream Port device types. The
> producer and consumer go live in the same commit to avoid silently
> dropping CXL errors during bisect.
>=20
> For uncorrectable events, call cxl_proto_err_flush() to ensure CXL RAS
> registers are read, panic policy is applied, and CXL state is cleared
> before pci_aer_handle_error() drives PCIe recovery. Without the flush,
> AER recovery can tear down drivers and unmap the CXL RAS iomaps while
> the kfifo consumer is still reading them. Correctable events do not
> need the flush and run asynchronously. RCH kfifo support is added in
> the following patch ("PCI/CXL: Add RCH support to CXL handlers").
>=20
> [ ... ]
> the lock inversion.
>=20
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D6

