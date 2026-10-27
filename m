Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117995;
	b=NXxYfKO7FjkB+QfM09ZmzS6K74y+OVmrEedns9R1mtB8Rok1MTl/ODKWQ4ZnoKpy0G3e
	 9GrWxm28bMZQ6m4FAhTsV3BC4goux99Cj3zhDJf2YHn7BKca1/3JhBQYy8lW+Ju6Gb/ju
	 dvjT5Yr+FpKGHxdQ7D4yYIASpWyoX6OQcBu8khBIgjttGrNsd0LLMGpJbtlMFUcBYzlD+
	 nlQmK64Cdj5qs1xN7WHhn76WGqqU6/mqsNLNmeuMJKJpCRPUh0txWFZVHSwYKqe8uVeF+
	 hUdJsONLBpRg4QuY0seonZ30gSOxO7Uvq3HDzGc3qIUT75hAzv6+ZcaPHcTUoQ9bdAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117995;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LKeoDwmvpQoyAI3UPli+kXNTSq1owd1mj+Qq29ypkKA=;
	b=e4D2vcsKUPyqJeJf8t7ySTxdr+qRleKo/1EM3chZMMOI7o5qMl3H/cVUwArJkjz5NTtk
	 A7oqvnaH2mT9FAWWdoJzGarR+oYd/8FNlh9psej1GKSSRBMUtZcnSr+6Yd3gu0oV0NH4A
	 LRq9kOGso7nrtzKUMXkDsN1CrV3FAo2VE2QISeF84R7wuAIaP3rXljUc7QyfP70Sm/Uky
	 7CKsnTGN7raENHXDAU1BTdGQagJ7SARkH2UX83o3td3TisjTEncoSHCF3jGEfXCEKhQ6c
	 D0ipzxIk2why5OskkvDR/JF0uZv27HsG/q5DsM3W/2P9KwTzGUhoV2GijpP8UbF/76w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUJfhy+F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F3606A325
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUJfhy+F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41861F01825;
	Tue, 27 Oct 2026 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117995;
	bh=LKeoDwmvpQoyAI3UPli+kXNTSq1owd1mj+Qq29ypkKA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mUJfhy+FryL42SVKHd0KEalwCeGz38uzlHyNvbrWiWM0xyrjnhoGi9NXTv+GiYRTS
	 4zJXCykbCb6nHFRcPQNzbLAYfqoY6+fkybIopWwlLVPlDjRsg05Cup6GMyUJ3JYLzz
	 S+9ogWKag2iMyJIBJY0eSTmWgYyaqjIaNYrgobnvo7wvrwy7bkUezogPU5vJORT++R
	 m7+oyRHeA5eVO6MKmckXf7qYq8GZ1QwZcqjr5V5lkAZ80b83Z4EvgGe2FX/gl5oFwD
	 uEdJf9WV0S1CgOE/CctBWZXPB7V/+1uxlc6WonVBt2rf/6NZaPUkqDLQOKtP0eNyoP
	 +xPUW15D15RXQ==
Message-ID: <sashiko-outbox-186897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] liquidio: Use pci_iov_get_virtfn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-13-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-13-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:19:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> lio_vf_pci_dev_by_qno() finds the VF by walking PCI devices with the
> CN23XX VF device ID and checking that they belong to the PF and match
> the VF ID. Replace it with pci_iov_get_virtfn(), which looks up the VF
> directly by its VF ID.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D12

