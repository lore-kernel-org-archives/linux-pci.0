Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912CD3B5319
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407814; cv=none; b=uTA7Ae78C9+indLbmV2S2r8vE08E7CzyctGrYZBxYdrSg0NZVSVpKzeH8xWTWiqEA29387aP0ACriQ/g+3e0MKZydh+6X+S5ufm8lTiQMKworDfsAEAlnlZi2jOaUJF2M8l+9jHC4Esya/DxGhc6cfNs+RhqVrs2Ts2n1U8VfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407814; c=relaxed/simple;
	bh=uVzdAy4yKBBV4KMeyelFi5T0sVRYbl/o2Omqg74TZnw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vo0ba7qeVdkUPemBNa/rwSXGZpwR/okeUPInOS743YEqudkobhTFWx3FzDMElOuCNJS1g57pqd+712q7LOin7Cba6/6C2h5uKL2eBB1dBGsw5iPCFdey8NWGUlNTDbmwFn7jgsCRnKuBtSlBXJCbZyN/Dm6VjRi6w+I0WFhrQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V10/eLkn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V10/eLkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97E41F000E9;
	Thu, 21 May 2026 23:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779407806;
	bh=uVzdAy4yKBBV4KMeyelFi5T0sVRYbl/o2Omqg74TZnw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V10/eLknlSh8cIJFDBS4bYOY2MXQNj4Hsb2L8/2fkcB/jF//iA3BZXCB8EkzCIqp+
	 o2fJRvje681Ag54rEPhsAGPxExStCCs3yIx9YKFNuKxQKcCAgZmSZcj23YWfySpNVZ
	 64g7AX+FqYVuezRRlu19UMsHSIYDIIN43IEVgf6/yuh+Gpe10qz+oP+tlt04KREs4w
	 G7arg47Ik/IcEFzMSeDXBTsxR/ao39dK42kAGvcU1tNB/xlzWIipDwVKNOv/d2cOiH
	 jdYhq1VhRJBfsIIrqoKxp82XAu5SfSHo7J0dgkGfx4qfWF3H8oqRWGvJamIrRjeVzd
	 SQTEl/0rBj2sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/27] rust: driver: decouple driver private data
 from driver type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260521233501.1191842-4-dakr@kernel.org>
References: <20260521233501.1191842-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 23:56:45 +0000
Message-Id: <20260521235645.E97E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message explicitly states that the patch adds a `Data=
<'bound>` associated type, but the implementation only adds a standard asso=
ciated type `type Data: Send;`.
--

commit 36c9216be2c21a3bf349085eb24629f94228e6bd
Author: Danilo Krummrich <dakr@kernel.org>

rust: driver: decouple driver private data from driver type

This commit adds a Data associated type to bus driver traits, decoupling
the driver's device private data type from the driver struct itself. It
updates existing drivers to use type Data =3D Self to preserve current beha=
vior.

> rust: driver: decouple driver private data from driver type
>
> Add a type Data<'bound> associated type to all bus driver traits,
> decoupling the driver's bus device private data type from the driver
> struct itself.
>
> In the context of adding a 'bound lifetime, making this an associated
> type has the advantage that it allows us to avoid a driver trait global
> lifetime and it avoids the need for ForLt for bus device private data;
> both of which make the subsequent implementation by buses much simpler.

[Severity: Medium]
Is the commit message accurate for this patch?

The commit message explicitly states that the patch adds a Data<'bound>
associated type and details the advantages of the 'bound lifetime parameter.
However, the implementation in this patch only adds a standard associated
type (type Data: Send;) without the 'bound lifetime parameter.

Could this part of the commit message have been intended for a later patch
in the series where the lifetime parameter is actually introduced?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D3
