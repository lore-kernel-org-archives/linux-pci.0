Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9739DBC2
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187553; cv=none; b=M4Jm9Jg+HW9KlrMhBKIvtYhDX8hKdWxx18wopM/Dc5n/n+M2v0MGJHaD7sdk3ofsWI2ZzW7AIVue8WRgyxWZuRCRWwC0YUDsZZtQiEd1m3O9+vcivkLxX44HAmFMsJl4mp/B6zHSw0qmySZxp88cYpoiRK2+T4CpsGquBZcUt7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187553; c=relaxed/simple;
	bh=Ks8gkN4AmkZWs9POQSMIPlj7vV1eMtlpqY48jX3w7CA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pCY/so2a5987/NnlRfMDJHks8L5x3UNff0OgplPJb8kqrBdk6LrbIHFsUv5Y7K5yKkyFCNY3eJ/GWhMp5rlo+pgziZJHZjHkYMY5WYjtKcX7f2DKp1x3rW73qq4R5/ondezajIdOf1c57CXrVbQKTrpE8uFGvPyKCHERm2orZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n74Fg2m8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n74Fg2m8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9DDC2BCB3;
	Tue, 19 May 2026 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779187553;
	bh=Ks8gkN4AmkZWs9POQSMIPlj7vV1eMtlpqY48jX3w7CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n74Fg2m8srAjEL/rPk30U7Cj4MKGynHqQ3qt5LGeVwM01201NsJHGRKW8rkbKVD4H
	 KyxSES0VRSYlk3lZiRt/HyurcF/aSrnmZwQrGjZUhwr9TWZ/9XIOtIUpwn5rjyy1+E
	 VsNg0m1q6P1BRScZiU/B1j2f2w/PfZJfqGF73Y2rPaaGrelRDsqFI/RUOF3eFdVmok
	 3Uzp7Xa+ajlFSPi8VEj0ZqU0yMhtllI6MUdSPZ8QKkwHfK+YDLMbqJKhLJz+Dc9nXf
	 54zpDaAlH0Bv5dGqgX/2HgfUuptFedltUbwTrrksrlB8yNG3jIV3lstlvEqEgJnhjW
	 oCM28aAfYQ3ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] power: sequencing: Add an API to return the
 pwrseq device's 'dev' pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260519-pwrseq-m2-bt-v3-6-b39dc2ae3966@oss.qualcomm.com>
References: <20260519-pwrseq-m2-bt-v3-6-b39dc2ae3966@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 10:45:52 +0000
Message-Id: <20260519104553.5E9DDC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing kernel-doc comment explaining the lifetime of the device po=
inter returned by pwrseq_to_device().
--

commit d29f3508bf71a5cf1f39e83cf08db650ff869721
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

power: sequencing: Add an API to return the pwrseq device's 'dev' pointer

This commit adds an API to return the pwrseq device's dev pointer to
consumers, allowing them to query the provider's DT node.

> diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/c=
ore.c
> index 4dff71be11b60..96ad557297f5b 100644
> --- a/drivers/power/sequencing/core.c
> +++ b/drivers/power/sequencing/core.c
> @@ -965,6 +965,15 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
>  }
>  EXPORT_SYMBOL_GPL(pwrseq_power_off);
> =20
> +struct device *pwrseq_to_device(struct pwrseq_desc *desc)

This isn't a bug, but would it be useful to add a kernel-doc comment here
explaining the lifetime of the returned device pointer?

Since this function returns a non-refcounted pointer to the provider's stru=
ct
device, its lifetime is tied strictly to the pwrseq_desc object.

> +{
> +	if (!desc)
> +		return NULL;
> +
> +	return &desc->pwrseq->dev;
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_to_device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-pwrseq-m2-=
bt-v3-0-b39dc2ae3966@oss.qualcomm.com?part=3D6
