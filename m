Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754773;
	b=sRdVSumeMbQVG9ZPdcFPBr3TG7fDyvBFwBCrmqWDr1Ew1UjAtLbLNAwG6wqWAcZyWW2z
	 0GYmKhB+PBjCCttI3276THjOO+qYCYRKk7BG/eeHhQinOTfZAlL9fGIsu2/+b6kEv0CAu
	 q3H/CV0SS1ZoAeKJ/dJT44ZUujvGuDyuYFFfhb9m/iDwEZeJmV6zXei++kltlFn7sbD/w
	 DGff3CGb2w28imlpiQJ/bGdO11r0WZYAfFg32OfRX62PMJFQ0Zng7Jdcvxc1s/ULMgyYB
	 3HVq2Vvzkl+Pp7akHMEeb8Gezwv5CAiYtx0So1J4TiKByHB7uIiai1zK9HnjoBWvjfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754773;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1Bo1vEAd/M/4X8VBvI8vKvM304W5rdaTEtbcvbUPJTg=;
	b=1s7guo9bWY4ONoRjBt3ZR9kV38SjtxejbhfcWqXIMRws12fzt2x00tHVVi5M/zLeZBFs
	 AvShQ3B8O1YgBFasVVtVMo8XaMD0E0RO/oPlI2ZjJc4zpiM974bywFIu2HnutevuWhvYe
	 1vV1O+3SFEQWzJROwxjZNMaDge3kJw7cbewVB+6/tkWrHG+ewFtWV4YFGhJNRJ7ivKbDw
	 H00+gNGhiyYo/xa/Fuk6E1DTsOVI58n8aerF9yzBB9A+yTce/0p8Hx9YgydnKNSKOfbO4
	 fk29PIeUNQciD8FpmXzUdKWh/744Rs7dp8sZMGOVUbj+NVRaagWvVBzt6wRqcx92OFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3r8MYnz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7401606A321
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 04:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3r8MYnz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4FA1F00893;
	Fri, 27 Nov 2026 04:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754773;
	bh=1Bo1vEAd/M/4X8VBvI8vKvM304W5rdaTEtbcvbUPJTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a3r8MYnzL6IAl0pnya7nScDpzbWyO1rGaaYpCrqlHHGL/Ihnl/AoRoBcNgcGxAps5
	 tCBxkLxQGzz+lEZwV8JfL+5DzySHAA8E22VgoMZMmPRk7iSQdDz32SVbL2TQ37ru4G
	 B6tZxT2l/DbyV0pwzwFgYZBaUVDQbVfSfe5ANeuj9NXrq49XZLlfdJFl/PBqIMfLSY
	 vr7cjVjuz0ft9t3afX6XnfArARmibsRlHnuLIzy3XfavkytdFUQ9nAwLlr/Sdt3+GB
	 GrsGWg/chwKYE5SvEh5up6tGRr2jmQQQq0lq42lfNhi7aIzAI4tSawM3tVkqL7/QVA
	 b2tEuug8KisEg==
Message-ID: <sashiko-outbox-236614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 0/6] PCI: cortina: Add CS7542 PCIe host and PHY
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261127-b4-cs7542-pcie-v3-0-b067875c56da@gmail.com>
References: <20261127-b4-cs7542-pcie-v3-0-b067875c56da@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 04:46:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 6-patch series:

- Patches 1-5: no issues found.
- Patch 6: skipped (not reviewed).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-b4-cs7542-=
pcie-v3-0-b067875c56da@gmail.com
