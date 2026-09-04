Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B03BD64A;
	Fri,  4 Sep 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537116; cv=none; b=WIuninOsACt7DmH/Vzilk8htbJGHKFgWo4hrZ8aJFArWfv+Vjyt3cou0L4TC9jt1B0damJHc1yEUIUtI+yD3eHNILpm2eP5RBaK1chu55bwl0egAeLFA5DxW5V6RKLXzhYeaFIOTJYoUHiJAymthl6MSx5ZVCFJF+zpSDBbPTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537116; c=relaxed/simple;
	bh=4JQyDfQsR0AAj1iinsXizU1kddrZUaQYNwe87/fkphg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B34P0C9eFC0Meh8Z0UUjKfnmXmpdOAtLcsy50CCHJyvmHodAW/dRHjyh+LqnWE/WantF07o/G+B3LC6rOWzBvhRfu/jxCF7d6GImOWqz1DhoGCezGkWevS2PCabz+HudhF/r3jHnGsafNSTXsGWie2wvevJrTvWVcdNjyauD7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kESLlF/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kESLlF/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982A61F00A3D;
	Fri,  4 Sep 2026 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537114;
	bh=4JQyDfQsR0AAj1iinsXizU1kddrZUaQYNwe87/fkphg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kESLlF/PVQrnZLBopPYtYPjVW+40Z+lyQbo8inGMWHoBnE7g/KMyW0A39pIAcTjsi
	 8pq7R5EW4Q2O8u80IwT/3UD7zUt6oQCQQJz+T5/0MZmTbq4npqp/20c1IX33oFPIbe
	 VD8m6zJEItXlcXFtJVRbdjhSasGMlY9Rd3qWSJ/C7h68fNuEwj4IicgKtD8XtXoXka
	 pjrj7v6ftoJmWqLUx6tynfAE/sZovkbBRv+hA0PJUI6KbLNmYbXfHUwQ00XqlktJ0H
	 WHPr8r7hC2U8AqJ/xy8R0tbaxObhqpbPETRCbxOk/pMvBEPYriaY4DjDHIsegEjfnW
	 iBTOp6yI8TJrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/11] dt-bindings: connector: pcie-m2-e: Add vendor
 LGA connector compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904-monza-wireless-v6-10-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-10-d8c5042b3efd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:51:54 +0000
Message-Id: <20260904155154.982A61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> Key E interface signals but are physically soldered as an LGA package
> rather than plugged into a real M.2 Key E connector socket. Such designs
> are not actual M.2 Key E connectors, so describe them with a dedicated
> vendor-specific compatible while keeping "pcie-m2-e-connector" as a
> fallback for the shared signal semantics.
>=20
> Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 found on
> Arduino Ventuno Q (Monaco Monza).
>=20
> Add "qcom,pcie-m2-1620-lga-connector" for the M.2 LGA 1620 found on
> The Lenovo Thinkpad T14s.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-monza-wire=
less-v6-0-d8c5042b3efd@oss.qualcomm.com?part=3D10

