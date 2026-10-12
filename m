Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AE54E66DA
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838826; cv=none; b=DAAWVXMDdZFuSi9bEQ+3gwnxqbyfTRtb9eEYFq5fp8w/Eh0+vHuBohTQWP+mNnR1TJhoRtYUxPxbYY8+NrHy8oMWkqDhpAmtynqyu8xm7PJ05jNZasKA79/AN7xKAhIq4yXrKS44nLP9o00RYkwu/inplR0KkuDvngiKwGLg7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838826; c=relaxed/simple;
	bh=0Srmczaoe95PfVgrZrNEB8lUBT9dISAqNe1vW8FfZIA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=b+Rel8nz+JVoysvslLSH6keBfDESfqdwMP+v9SW4LFIbvI6lmcrx9D4NQGr1VnxU+QwOQSPub1i08Ku3idL9x9OOxbHCTAHfR9YBavCe05ucZ9qMBwxV8DefkxUACg9Zx+LC9HZw4v457Iu7j46OxHnO84jlb0qNlygtP10fHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K33o3T9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K33o3T9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE161F0089B;
	Mon, 12 Oct 2026 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791838825;
	bh=KGh20vlC+Hn5Simp3xk9VXvB8DhgLui7ckuW5wLWQ5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K33o3T9KMWLHEeWR6H6Wbwls3L/GJimnA6wchc95LWFnCqYLTNXXSury92WM2H+nc
	 cX6K9aZhQ1ioTnYYnQBbSrB3AOrHvwKGQMnwkW8eCGbFhthoDiQcdHVbch7dwb+tzX
	 z7KXxlyaYUNHNVmoc65QAJsiL3DDoAELLTBctxUSSbx11XwGNyPIT8xHbHX7QIfmVN
	 kxZX8J9XZZ/penFLQIcv+6b3rSTXT1XXlKrD+ygELRqIbAaufyAKIBGnygLfpPt+uP
	 cVoYyKztVjR9ZQ2h2PdtdNC6TrNOCZQS8uKD5fKcSLXm98lv3dOGvSNmY/n3EpV+5D
	 WYCB79eOQ6Ksg==
Message-ID: <sashiko-outbox-168600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Documentation: PCI: Document aer_inject's
 aer_mask_override parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261012-fix-aer-mask-override-v1-2-49a0d7aeaea0@google.com>
References: <20261012-fix-aer-mask-override-v1-0-49a0d7aeaea0@google.com>
 <20261012-fix-aer-mask-override-v1-2-49a0d7aeaea0@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 21:00:25 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> aer_inject has had the aer_mask_override module parameter since commit
> 457d9d088b02 ("PCI: aer-inject: Override PCIe AER Mask Registers"), but
> the AER HOWTO never mentioned it.  Describe what it is for (injecting
> errors that the device masks, in particular those masked by default)
> and how it behaves now that it works: the device's Mask registers are
> left alone, the injected bits are only reported as unmasked while they
> are pending, and the hidden Mask bits stay set in writes until the
> module is unloaded.
>=20
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-aer-ma=
sk-override-v1-0-49a0d7aeaea0@google.com?part=3D2

