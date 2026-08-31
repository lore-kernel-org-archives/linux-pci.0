Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6354A4413
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196187; cv=none; b=N75aZNVavlwWsvohd+BV/CoGDtQ6mc0SJVxUFtcNG2oqcE6zkr5fxe7PtZpQrlX6ShMQmB6+yiNIzfL+DduQLW4UNU/TnCgaXEnrGW8UIfWGUERfL2wHkMdQmT/QdSxYt11NU/ikNAy4UKT4TNZLmIwQraxPd2UybiWe/EneR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196187; c=relaxed/simple;
	bh=v9osccPwm4zvf6EU/TtWjOtSZv+aUOvTr1Af1qQoA/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d8mfS1wxpdbukPpnvfTrL21YF4Aojdaw/mjsbs3sqX/fQFCbjFhL7kJInOWDZJctNMPVmL9H5QVVJGo78hAIHcxIzB7EoqSxuhTcn37U0uiJGy52asYxemqHIWUCSA54hd9xQ7+ZSFsICAQEDXUzornbHmdskrYtLDRJR28o6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYG4mJ0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYG4mJ0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13E61F00A3E;
	Mon, 31 Aug 2026 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196185;
	bh=EZ3r5VjWDg7B6gtHUb5vHFPc0e7tSSbBapybqqLQCqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bYG4mJ0+AL1ncL++E8T+QXYPzQltRu9XCwmhlj1jTbH06ReQgWNkmq3eu1va6lwqy
	 u+6wm4PFnOr+kVLzt5n/827U0nH1J9qc4e61c5ejwSId2SHoeuGt0YLMdHCVIut8D+
	 ekTIu7bwfHghd/5hhm75eCS6tohbK76qf5Uahuk3pEzAvaMGNep+glFH/cdY5Xj7fv
	 2DzhT2HaWryGnQTO3g/9cgaIqmDXwfh0utEUgbix97Dq7ZJWefk1OspeloA+Jcgf7t
	 CLZQ7/LnFF3mRYf1F65cJSbp1OmuVryO9PbP0NWPIPtpiPgN9HrJAjJsV4ilwyhPLt
	 fhTt0LeF2SvWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] PCI: dwc: Protect root bus removal with
 rescan lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-570-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-570-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:09:45 +0000
Message-Id: <20260831170945.A13E61F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Hans Zhang <18255117159@163.com>
>=20
> [ Upstream commit 26335696498ab502e907a556e97c7039bc80a87e ]
>=20
> Hold the pci_rescan_remove_lock lock while stopping and removing a root b=
us
> to avoid racing with concurrent rescan or hotplug operations triggered via
> sysfs.  Such races may lead to use-after-free issues or system crashes.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> [bhelgaas: commit log]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/20260521161822.132996-3-18255117159@163.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-570-sashal@kernel.org?part=3D1

