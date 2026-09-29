Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB722AD1B;
	Tue, 29 Sep 2026 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703856; cv=none; b=Ithnk2DnCBuUqJIeJLvYNXqsEZ6XivEoJwtbc1OtBIBfDffa8Zyxq9r6RBb7+Ji7nXhlrzQ8xBuvsnp9yWDuuqeGY/hs/I0QvX1Ppxzfa711Lh1Ck1xdMZguPPn1kDt8XutecIMUajvAWwqUs8McDsUqXG19iFniccjR7CQHscs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703856; c=relaxed/simple;
	bh=BLC9fPG4/Wvn8tfOwMBFuwEtkZBxgo+7YU8gSTUGxjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mbgt1JUiMux7i488HKLLC6t12V+h49ZyeDKk8f5mkOm0w4iu8fUNNSp0at67z50fz9JECmOqiS+d+E6KKyp+KtEOAu0sdvHK+/ec6JYIM7NB8dKdUNDWQ5KZDm2ft/W2pSYMrztCQhMXJv8DMwOhSEAOJuAFx9Dp2TCMy2TTioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ5FqSJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ5FqSJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A2F1F000FF;
	Tue, 29 Sep 2026 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703854;
	bh=BLC9fPG4/Wvn8tfOwMBFuwEtkZBxgo+7YU8gSTUGxjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJ5FqSJ2McDLqayW7JqQbcywbZ5ZSJ3IH43cVVBYdeBhpVAssciGmL0HMrF/0F77i
	 a9STRWGdZPX2oRx/gnYMQw8bnPETkTwxG/afwk7Kh5/G76yiKHctzznhP9SObPYoGO
	 iNkBi51P8cWMGnboMPjBwSz7cmk9U3N8XN8YMPTOKryogwzmPypKgBdkQC7Q/enueb
	 vud+k3RbEBTVHYm8TdcY5OWF25W7vPYQx9yoyhu+j1WEkYPbY2WxsqxLiQflGVNGYs
	 KaZjfrx3fYEA5pIVxoTdoQMFw1DkdYxwy6HZyO2+dQoVwM1AlDlSUi2VvYmt156fIf
	 4vV4pXFUMVmmg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 11/16] vfio/pci: Add INTx recovery start and
 finish helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260929173305.204856-12-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-12-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:44:13 +0000
Message-Id: <20260929174414.62A2F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add helpers to mask INTx at recovery entry and restore it on completion.
> Mask INTx at recovery entry even when no interrupt is pending. Record
> whether recovery changed the mask so the completion helper can undo it
> and apply deferred unmask requests.
>=20
> Preserve the current INTx mask when restoring PCI_COMMAND. Only update
> INTX_DISABLE for devices supporting that bit; other devices use the IRQ
> controller mask. Run the completion helper after access is unblocked.
>=20
> An explicit INTx mask cancels pending recovery unmasking, even if the
> interrupt is already masked. This preserves a mask request made after
> access reopens but before the recovery completion helper runs.
>=20
> Assisted-by: LLM
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D11

