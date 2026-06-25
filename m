Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1026B95B
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368122; cv=none; b=elqkmXm6DLw7oWas0DPImUP6LfpgPr47Px/0Fpae+EKlsaEzOuIHECpI+alMef3+ScttfED+GN2is9/BKIxrouOwfUzd6b9dj/Ts7JxAnvplo2XSnORxg76IoickL45rZ5KCzDqP2M2w/2Ez10rvqcb558fwyLWii6UWgdceOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368122; c=relaxed/simple;
	bh=pwTK/sEe82hmTtQnADdYsntBIANpRH1yVOsEZ+SznFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aGdldr60PGWoAXjMrf4F81RC5DXROt410N+agoVi2wuNN2KQFiQDXhxte6GEs2O3gpLISMa68FXN8IzJmO8M5rs4+4K2y8WuXrgsNAyafFxEQ8XCca8utu+xF77MxjDHl9qoKddn4Y0IKW5blHVJOZRSrl9jnDmM2U2nvAfz89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbPvcwKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbPvcwKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD12A1F000E9;
	Thu, 25 Jun 2026 06:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782368120;
	bh=pwTK/sEe82hmTtQnADdYsntBIANpRH1yVOsEZ+SznFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CbPvcwKCbvF+9x1Tq6d6L1sgvgx6OPxWt3PFDH78JXIU64q6AUGYgVn8bryjfoWiY
	 FBDahhUUD9TRuQdDkwxagLIdlFjvvtNoTydU9eAC53p6u5TNTLi8vx8Fmnfzd/PFDj
	 OviqS8gnXagFyl0dEyq8KIubO7q8GF+FY3xzOPlBUcDIJ8CpTAPkaMdc6jNaqEZtFw
	 sTyprTOCQeKBDhb9hBReXc3pLfXpnT1NWgm2SIpltBbgImg6DQVhixXOFgsMPqFoiH
	 Q42v/fLx9dXsGon/0s7GKLWCTW2tQTkffAUwGo15glHo1Xe3TUwF5bujSnGYme78rZ
	 Hgg9ysYSob3Tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/8] PCI: vmd: Add vmd_bus_enumeration() helper
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260625082940.1290740-2-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
 <20260625082940.1290740-2-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 06:15:20 +0000
Message-Id: <20260625061520.AD12A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the vmd bus enumeration code to a new helper vmd_bus_enumeration().
> No functional changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625082940.1290=
740-1-szymon.durawa@linux.intel.com?part=3D1

