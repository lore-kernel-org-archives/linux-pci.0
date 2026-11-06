Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983459;
	b=aTib7buahp/ZoZgIyynIE1JPb5nVGcWG6V/xjFMNnKm23hCxhxOAj1AFllaSRTfRYkyK
	 xZVW1ky2l0XWDvc1fhLq+AsoqtwRP4u6MlE5VWktIXQMnF5LjbEmIr98CeibGNRbH0e7x
	 ekWcJkccBWDllS6qDTb2gJvbXMZHTDRAigbZGymF+7Mp+cWRdcjPOW3rIAaiLSKKoQSF0
	 0txWr5rHSpoWeIhXYGwyrMt0/5D3/iW1QUBNo0tR5S+TJ4c+I07a19YNBXG/kKRHSoPgA
	 3aSit5AucOTuhxxCc8PQmBmeXnps1y42YN5TGqBkLlqD0UbNhYOQCPp4r6Ej49rpaiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b3qv5if0cgNsD4ed1ntC4U+lmDe4Zg0jIsb/f6lTS3c=;
	b=42AqvIOQOpUJscs981T3F4AkbYmRrL4mCA5utpAYIp8yrCleklLfV+0nHA1HuiyRIm2+
	 f7CBrvlASs2YDjlaTnj3dJrFzu3QAArrajRe6JI6mMnL8n/dqrznbon79aB8HXri1tgpp
	 1IuilPIL5fCIIZKKfSy7ahkLGNxlptXEsPTFVuGO9ghMPzbv7JlsSTUWeVvC2VaceLIr5
	 xitHuAxzW7ECSLuWFN+SgldP/nU4ektT/wrS2CV/BA4hpNftQ2mnwFXijGFrt7bnNqM5Y
	 gUgpnQzl98po97J7c3+adHjiUT0xIVYfBpxSggUD6IUlySjw9yxFfN1zP/B6my7LrOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meHRjZ0M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC1606A32D
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meHRjZ0M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275581F0089F;
	Fri,  6 Nov 2026 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793983458;
	bh=b3qv5if0cgNsD4ed1ntC4U+lmDe4Zg0jIsb/f6lTS3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=meHRjZ0M7JosAQmCjScyHUvtyF0bs05kJzcPsWlG6InGTTBTFcF2ciwZov1kXhXBL
	 3FP7UihaS0AA3SlZg5ZknQFShmOJuSmBCDYXuFFpU/WGphWGvswQYR5FABC7l2ATMD
	 wVdurzu3WhRnP0I80648nHagoWzuBIitImWb4ItQO9b8nVracqmwUxz6mCuRXNzdRe
	 Q9+rf1teSX3mGNhv0ET6PSuG5OV77FgxL5XQkWa/D5FB5JsE8IkxxCrzvqzePbctHT
	 qBq0yPat6udhdY1G8qqGMFptEqSEkBOkfA4F+MdEGqzAgIKtYWRmbSny8trkS6F2wy
	 Pq5iIS0qUfacg==
Message-ID: <sashiko-outbox-201852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/7] PCI: vmd: Add vmd_configure_membar() and
 vmd_configure_membar1_membar2()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106184256.4130-4-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
 <20261106184256.4130-4-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:44:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move the MEMBAR1 and MEMBAR2 registry initialization code to new helpers
> vmd_configure_membar() and vmd_configure_membar1_membar2().
> The refactor preserves MEMBAR address/offset/flags programming, but
> resource name construction is now generated in the helper ("VMD MEMBAR%d")
> instead of using two separate string literals.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106184256.4130=
-1-szymon.durawa@linux.intel.com?part=3D3

