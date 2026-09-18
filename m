Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92551A742
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752649; cv=none; b=eZEHFJQxUZSDdG4rkq5PAvlZPPF4BON6O98VYxpgUvg4M4szKFBmK8aDVtkZ+Wg/CS8vL+Iyb6Or8w/B637EhYsVZCUlCPC1/+bKywBqOVEo2KSQvXJ0j7nntOMfV12tWQBdsbCKQBb++j+R6NQj1VBqYI7nO/LrovOInF4cS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752649; c=relaxed/simple;
	bh=ztM8NevtOi3nBRaZFp/M8pEz+9DGEZBuEtOXqiLVgj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ii/J9RXlcr7Me37oz5SVd+3iTZ1IiOimBcwlsz9mxmfhCJs4sQBW3jZ8uHrN7fn/gEfg1pm2Ww+21spWnEt8IYoWA3pQ13yUtDMWt908CC6L3INWNoa+h/SltkyLgMOTvh1viBRBoSskrkMfjUGBAS8PoJQYOFmsI4SRewEJxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6PP8knG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6PP8knG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BE71F000FF;
	Fri, 18 Sep 2026 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752637;
	bh=pDjBqs1IHFI+uWt5X/Z1jJnwqDK/dTGkgZkayNlNqfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L6PP8knGaMG7WBMAGuhZ2J5PQq0yxyunvheRbjbkEeQy8UHCtdAh4BYfG4RkNv/VJ
	 TqgK0C0n/MycTH89opwPTMNV89jOJAY9l/oGEhYn3s9sqsrhRemnV9DNal2i7IH0EB
	 4mCqrmOKgd6+f6SwQ7hqKOnNMGj9Bjv90OT8Mf2DhJ5SNV7vOVRe/gwnazZDc7vaO3
	 PdBmmAvEycf3fELPOcCyekPDn9hv4oCJV7zkvQb15xMrN57OaGeImNmp/bEVsFkpn6
	 VVqA5ur2HMZU2gJ21xoAK2oDpXB6VcAw0eWvWQcFiLhidz4bySPGpRoKrfJwiRLeXw
	 psPALQvbTQHHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/AER: Fix struct pci_dev reference leak in
 aer_process_err_devices()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918-fix-aer-refcount-leak-v2-1-bdd1ff1c35a9@google.com>
References: <20260918-fix-aer-refcount-leak-v2-1-bdd1ff1c35a9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:30:37 +0000
Message-Id: <20260918173037.B1BE71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When an AER error occurs, candidate error-source devices are added to
> e_info->dev[] by add_error_device(), which takes a reference with
> pci_dev_get().
>=20
> A device can be recorded without any error status being present: the
> Requester ID fast path in is_error_source(),
>=20
> 	if (e_info->id =3D=3D pci_dev_id(dev))
> 		return true;
>=20
> matches purely on the ID reported by the Root Port and returns true
> without reading the device's AER status registers.
>=20
> In aer_process_err_devices(), handle_error_source() is called only if
> aer_get_device_error_info() returns non-zero, i.e. only if an unmasked
> [ ... ]
> handle_error_source() is static and aer_process_err_devices() is its only
> caller, so no other path is affected.
>=20
> Fixes: 60271ab044a5 ("PCI/AER: Take reference on error devices")
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-fix-aer-re=
fcount-leak-v2-1-bdd1ff1c35a9@google.com?part=3D1

