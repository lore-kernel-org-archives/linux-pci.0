Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BFC3644CF;
	Thu,  8 Oct 2026 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439665; cv=none; b=gXTAD5ADCkTc28v1qUjiS66lsiA2WTclDitSFFPh0kXjMJTyI7mKc8Z7Dr0xjz4nCCyf12Wj6J5M3/No09BDgmoo4gTDS0ipzK7D7EhGS4B1kjOYXGwKlmruLQ6AGG9ewRGIFFf5IMm2HyDgdA8RaNyqQHkOTQH1a1y8iYE8i0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439665; c=relaxed/simple;
	bh=vELXthh22qyeSRzwHPaSqSxfTAo8Ds3W2FSOcj0fM9g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lHYUPl2pJoO+xOrHnKBHZc3z/CXt2FP98eZR145PiK4rHYVvgnLne42ptFWLC/EJUCyI5pn0fXHw2dO1mUYUhYp0TZDE/tUM1IQV6eirBPaaIsN3C/pAJhDFLwmo9XacfttnpBG+VLC3Q8l4OtozhM9SR056aw5z5S/Y26gPq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlGb02pP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlGb02pP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9FD1F000FF;
	Thu,  8 Oct 2026 06:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439664;
	bh=vELXthh22qyeSRzwHPaSqSxfTAo8Ds3W2FSOcj0fM9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DlGb02pPBemG0d/rhTQ6/8Lj0lRi1jxk80gTXQK5Ch1j/j/v3Ij6Va8DSa36Ua/hg
	 3UG3wbSaY+BxelRnZrM5qCvZ3V9wt3zFGkEto2j6rDGoCOsikkKDLttjMCgMsFmDA9
	 gyKr1AikYdOGmnLj2hMpHjN2pzv8nab4Ar7Y9Sr4aBhlO7BIOCbySH+skoJQDAYJo0
	 kAuAlit8f7NSUdr4SLO7OtbFTjujLn3Uk4kbAxqbNo7xVs8lj80OmoUCANEq2UDji5
	 hWCWwYIEzu4Tic4awplx/LznfYGkqHErhs5md/VS3z21ulLgX482S+rJC55T5/yGJG
	 19BDcobD7RlhQ==
Message-ID: <sashiko-outbox-163655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/16] KVM: x86: Use file_to_kvm_x86() in SEV
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261008055955.4014342-4-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-4-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:07:43 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Steffen Eiden <seiden@linux.ibm.com>
>=20
> Use the new arch-namespaced helper instead of open-coding the file check
> and private_data cast separately.
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D3

