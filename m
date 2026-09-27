Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB654279FE
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533504; cv=none; b=KVurUrcR/lFvxt+RwLZiQprYpTgUSVlpxjvnmngBxZbrnYHhrloP4+vFcsRyOx+Aq776AqjhEui9E/ftShQLTbz3Hi6QyUQI42EvskbcVUKGJ9zQwv1alrCWEdfydK8KQyZUobv2zNFGhBRQyVIWL8A6f0jg0ElIjCurf6sY9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533504; c=relaxed/simple;
	bh=hGskFRHpVYOUjXSwgoC0God9ObA7BBMDYzfdYj/JRjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NiAq4QTTsVD7hbRVMIurkgiKNP2uNOt4XCVcyMFJk3DHjepDKN7SVbso6nOMVqFW2Fjhwl7IbWmDfCYOjJblwEVBfUe9X8tMqYTl7gAz1CCpJYwLv29T5dKjMFSD3JIzl/qoQa0O6HcMppIh9F/3sWzpA1Yw9hQ0fnHP0+9t2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3JX+/be; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3JX+/be"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DDA1F000FF;
	Sun, 27 Sep 2026 18:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533500;
	bh=/5/tV5t8eRUaGADVw8IugSkJsUoNF2OTrI0ZbA436nY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T3JX+/beHKnWCKQG0/V61sOdgYNlGeGCVPB7LqbBzCLml2siOWbf3Du6BzQOlFq4e
	 R9uajjsJQQ75jcIdLf2BpcrEZTSDtO3fJtxNd/RL2/KCZBZ7H4sWvhqfZWhyldlhBd
	 E1jrLshYDVySiTWpXG39/fLaQOpPlCZohr9d7rUvbhTDIQQpYWIQ7B3imXpDgSpgXt
	 SwFALKI0d4k7OibwdyYpDopNXM9nQsoVREx2SsiAe4QrU2oAEK/T7d9mdV0t/vPrdZ
	 PFPKLfi1pChvNfOoIPrdZI5hWj6R0QOKygxkTmPfibSw4DV3Vciv0y0bB+HRxJPw0J
	 3LhcsqU44DRYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 3/5] PCI/DPC: Add pci_dpc_wait_recovery()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927182017.938565-4-abhinjoses@gmail.com>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
 <20260927182017.938565-4-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:24:59 +0000
Message-Id: <20260927182500.15DDA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_dpc_recovered() awaits completion of DPC recovery and then tells
> whether DPC recovered successfully, using test_and_clear_bit() on
> PCI_DPC_RECOVERED. The answer is one-shot: only the first caller sees
> true.
>=20
> Split pci_dpc_recovered() into:
>=20
>  - pci_dpc_hp_sync_supported(), the check whether hotplug can
>    synchronize with DPC at all.
>  - dpc_wait_completed(), the wait for recovery with its 4 second
>    timeout;
>  - the final test_and_clear_bit().
>=20
> Add pci_dpc_wait_recovery(), which does the check and the wait but
> leaves PCI_DPC_RECOVERED alone. No functional change intended.
>=20
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182017.9385=
65-1-abhinjoses@gmail.com?part=3D3

