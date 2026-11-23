Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402716;
	b=OVMFFWO8Ie32awfaQ9meiF1ZR3Uq+qB2JC8xy53DisfpU/5H3pl1WycQU7xZ0hr3leRW
	 /s5zXNVvo+4+fffl+k4nc5ACJ6jzomQw0dOTHraqx/GEMrhv7JF89i7X8HyxI0C0eMzbl
	 DOWBHykIMfWu0QEGXK8IAodcxonZ4cYuyWSZSrja6+78RGgxiSxGkim20PxDzKxSQANyY
	 2PDzpVhFMC0M818fGq0M0/CGwpmPavV6RqCvJe8etRS+9E73M88rJSl2yJKWCp6+c1U0U
	 pAamd+qNEYY1oMwokqWPEhbQd0CtyO+0pbmXCwAqMJ/NTGTFnSGFLn4u+5fXzGrA5PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402716;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZZZSVslha8uJkx9taQJ4LoPdJ4b7ubxVZisvj5bSTU4=;
	b=NASQbC0qW7EiE+Ydc77sT2GB9twLCoC9wy6ExW6jNdmpKW6QprWK8Q/NBgMVXESAPo+q
	 OFp1ItF87uh+vj5qFAEPnibR0R9Oy6wXvKG7IH5g8iaBrlnCOK7V1PZpxSds3sd/DPoCk
	 T5bGcT/zPq82A0uhj3sSPd1DxSRgc7/VkBaIlKf3rc3UGGdW10vEMllS1B7zNbSWoZK6n
	 zXPx42zKL9upzkpIOBW/tXDYBy9W58Ta8AZfqALJB9dNWM0JAfzijONtE9619INCwWmnX
	 fFar7cJqoG7LriojVXluySj4bu8ZL0aSLK1BnnXOqFBC73WU/YNRA0KqBVKHlOlMjYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nq5e8bSG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A67606A333
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nq5e8bSG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43231F000CA;
	Mon, 23 Nov 2026 02:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402715;
	bh=ZZZSVslha8uJkx9taQJ4LoPdJ4b7ubxVZisvj5bSTU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nq5e8bSG7EvtydY4uWb40ecWMp2tPjYn1wm8tyM8Go9jj4GhRWzSZUaqAgufORGBd
	 f9FgbXSgT+UwCYauCrYP8RQg1WWcVoX5G9ZRh69CtXQ7YB2am0u3jUBEpTxH8iRPep
	 CMxE7VjhwfRALvCfwCxkLao355smmrfHzOodvvL/0iOmPNQkJDQslJmIX82bNZpt32
	 5OKI3U9T6+lxMHyJsvFozYqZTeOr8H/H4AOTgF1BMKxd1+2FWIxPBkKbpK3Lkg/g11
	 52zZJgxZMwHmuthepw6es1nSm0MLPlXyUTfF6YFq5tNt9+cjiFs3fVggqytqSDdXES
	 wWf/YJJCSHNag==
Message-ID: <sashiko-outbox-228577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 00/13] vfio/pci: Add PCIe TPH support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261123023628.7728-1-fengchengwen@huawei.com>
References: <20261123023628.7728-1-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 02:58:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 13-patch series:

- Patches 1-5, 8-10, and 13: no issues found.
- Patch 6 ("PCI/TPH: Add helpers to check standard and extended..."): 1
  potential issue (1 Medium)
- Patch 7 ("PCI/TPH: Add pcie_tph_set_st_entries() batch ST entr..."): 1
  potential issue (1 Medium)
- Patch 11 ("vfio/pci: Add IV-ST TPH policy and TPH_PROGRAM batch..."):
  4 potential issues (1 High, 2 Medium, 1 Low)
- Patch 12 ("vfio/pci: Add DS-ST TPH policy and TPH_RESOLVE capab..."):
  2 potential issues (1 High, 1 Medium)

Detailed reviews have been sent as separate replies to patches 6, 7, 11,
and 12.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123023628.7728=
-1-fengchengwen@huawei.com
