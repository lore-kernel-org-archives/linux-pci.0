Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795746783;
	b=pYJAlerA1W0pMfTpaGfEi/Qj29Ln62hZ8ztNk7L6IBcvJ/Q3AmzLQepBOWPal3UuPbSL
	 YqhXPRiq5kw0uV0eEDKM7m+/Vyf98bTs7O6yjwgRFnHTt+Y3BuAK2xBF1e1Bw3xpbw6Cq
	 4nv/HWTMbq5igrgJqYIeDxfW+UHJrENspqUsJ+BfpdQ9p+3mVXROc71jNAb8/ePkEVsWD
	 HxExhCNPDxE38RpEggt6vtRaKSPPHGt2umz9WLiV+MORwhN3cCV+72l2kBVvev76PiSwJ
	 eXSP/9pr2gFhL69nSc6DV7/qFLGPxyZnSF89ex3RMoYM55XoxMYCv/giXEYh19jAoVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795746783;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2xnIaxT4r9jr0gITMOJ99bfHbMO49PaSZcTjmCWievs=;
	b=knPmFU+E66CO6O9NHjCUcszTCoNAl8fgvTyqU91k2jHhCRyniATSwOqmeoZ/epVA0I4+
	 AzCq6rgHQGCBHFs/VFhquND1eH+ltBLXhAySGfCbb0se4EnNI2NTSG0M89KVdLpuJms0G
	 dMIDsy8b2TqtBMpuOy8EhHmZieDOD6bATJlY7/2sYzUks7iVjK9Y765nyPB4DHuRVBl68
	 dUNF09udNsNJgrg3ims49c30nY+BdsRsFcX1gR4b1iHeOYgr/+BnCLjFLigCzltGItgQD
	 mGZqERzVw8oGyUb6O3XtxiA1ev6P5MWDZUmebRZN9qMPruJrspQiV5ler14T6AgUI7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmSZAwSu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F11606A323
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmSZAwSu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF341F00893;
	Fri, 27 Nov 2026 02:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795746783;
	bh=2xnIaxT4r9jr0gITMOJ99bfHbMO49PaSZcTjmCWievs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XmSZAwSueCdhMuwuXlL7nIg+TZlLt0GCOhox+t9TkxunPkGVT0EVkGlDQGb6+f4q7
	 8mc2lh1l8W/YKfObCjMu4KEPwwtutBlfi1vIlfXoxfA2hgtqJ7aGyHAihyuLi6tWCn
	 kPxuXVAF64N8C16fnCFQ4DRcNVHxHvS/7Yxn4xHP9oRaey2x814tXBN8UC2HsKjqKF
	 DjMKi7RtWYepfFmUhNeHIPVN2f6ys+uPLmWqO4KBsfk49pjRoH8VDxR19DigpkRn7S
	 dNyW9B6UTOjsXCY52EAWy50Y34Jh+NiyNi4DLkjzagdDSYC7Yaes65FoMpQfm62e11
	 60ytXPIgkdYiQ==
Message-ID: <sashiko-outbox-236456@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/3] PCI/ASPM: keep software state and hardware in sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yaxiong Tian" <tianyaxiong@kylinos.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261127021128.147354-1-tianyaxiong@kylinos.cn>
References: <20261127021128.147354-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 02:33:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 3-patch series:

- Patches 1 and 2: no issues found.
- Patch 3 ("PCI/ASPM: Disable ASPM left on by firmware after a H..."): 1
  potential issue (1 Medium) and 1 related pre-existing bug

A detailed review has been sent as a separate reply to patch 3.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127021128.1473=
54-1-tianyaxiong@kylinos.cn
