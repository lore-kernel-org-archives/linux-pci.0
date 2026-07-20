Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B33D45C3;
	Mon, 20 Jul 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539581; cv=none; b=b58GRz2zkaIvzbSen7qfHy+91mlFBTnCGCYNnmFyUHoEAOcYFzgr4i+3vpSVXDEGU8IF/6ckF6Jjt5nUL75hxc0EppLG+D9kIJsrI6uojzRnRaGEXy+pZQ/B3XagNSqZMoSvohCt79D7knwI6hBI0D6yCok4STclBSwY3f8lan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539581; c=relaxed/simple;
	bh=JXks02qoIOvp/lrU+nsg/E65QdRy8lBiUdgEo8oHmDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vx4W2e7yPhxAGQf7hGULZXFdzHBZUlWnmogVndj/v75Lbg8No3rDL/yapUQ5GdBmIRVWOr2a7WDHa6l7tOaM64OqCYM0WLrkRV17a/CXehXzmcFAUX6W8rDJKmMV5QwpVC5617oajwi9WnwWAZ5xqk8g80z8zJvmAraDfaoc4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz27oyJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz27oyJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05C51F000E9;
	Mon, 20 Jul 2026 09:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539580;
	bh=JXks02qoIOvp/lrU+nsg/E65QdRy8lBiUdgEo8oHmDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oz27oyJmQCIqmrA7/EKXeCzfmsDXCZsPcdJDjGiqBNYWMFzDSiJaGXdsI2Ecn+Ofl
	 ikBx4DUkScJXdWC/cw69V6VAhaQskkO4KJ0nV3DuG8WyXTyLPdJzQo/DPrEgwwpXGE
	 fHqcHQ1xr70fKw8hSABTMkf7RhEsmPQvWKNgHKkkoTGxQiULh+DPw8uJUnV55Nzr4S
	 ug/VWrorYP+V7xvAWqgZKJmkBx5ue70xN7nSdigEBaXbEVYYVxL+AVQp53T4muVSiK
	 Dbt5rEuKvHmbtj3/FaVAfaMQS6bFpxFSJgMzT9D+JxlqSBFW8UaOsNahShIKQE60ur
	 bAI/1/Vj0rJvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] dt-bindings: PCI: mediatek-gen3: Allow
 memory-region for restricted DMA buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260720092116.1823562-1-wenst@chromium.org>
References: <20260720092116.1823562-1-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:26:19 +0000
Message-Id: <20260720092619.B05C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> controller memory access could be limited to a small region by the
> firmware configuring a memory protection unit. This memory region
> must be assigned to the PCIe controller so that the OS knows to
> use that region. Otherwise PCIe devices would not work properly.
>=20
> Allow the memory-region property with one item pointing to a
> restricted DMA buffer.
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720092116.1823=
562-1-wenst@chromium.org?part=3D1

