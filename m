Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FC36B916;
	Tue,  4 Aug 2026 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872466; cv=none; b=iwmRoW6zhZg5kipDUUDaLzzCY934KKqIszHFsyn0v5WOe+UApRwqX998TDwqyIP11S8XkvGsZNIHJjb31AuYhQ7p36ERD46dEnewU68Nsv5Nl4v26zE+K7GM7sJzjci637K0ZRVKePuMGSLzOXgHr7h9rDABZgbjiT7AEPQIXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872466; c=relaxed/simple;
	bh=NdBeqoKXMVUxt9hQl0V0hGv6n6vgrYmjJDqnz0bp04Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=meK7I+Sr/PYgkbN/4W1d5Rbgj5QlVmtOyJmeNse578QSA30i1Q5ugbET5LkfbxeFVb0pbeXjnw81B4Zr2px53MHpolfa48VRkejvssd/+W1tj8jbI9TXocodVGfHLX0J1IKsfEGLGxb/S9K7UzA/YDNjDhSQfBvYHWUS+NlMHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5l/20rp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5l/20rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAE51F000E9;
	Tue,  4 Aug 2026 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872464;
	bh=NdBeqoKXMVUxt9hQl0V0hGv6n6vgrYmjJDqnz0bp04Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J5l/20rpH8ety1Q6T97L6zRpKwv3Qa/l2ldvsGvh6b4eGi4DTP11P/GuMXBU7mrhX
	 8aBhVjxwL4Z4iJuQ2+3wV7w3TGXVE+e/Wc/cd1GNW6X/8b5FD/XziPaVCb4AejFql5
	 FBgIH5ft/21MA1c9pIV3UZS6zwto0IMBTfPA9y9M5sMiXl4ucGQxWebIHOg3+bZjzs
	 /aNzAVKIDEP15Rzb7IFHHxulbraymortmXU7XoRETEXoWyNgFGoUlNqyehX7S1HofW
	 yatwYM5/UhLKanOVfZS9o1EPtqqqKoEDVu7xfcOiFDSO4z9Tc08A4hkbdr4gm6bd+L
	 A3rOE83fowErA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/12] Documentation/ABI: Document CXL Reset PCI
 reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804192958.1823952-12-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:41:03 +0000
Message-Id: <20260804194104.4FAE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the "cxl_reset" PCI reset_method value for Type 2 CXL devices.
> CXL Reset is device scoped, requires affected memory to be idle,
> invalidates CPU caches, restores cached HDM decoder state, and does not
> request Memory Clear.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D11

