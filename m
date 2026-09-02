Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84393328B7B;
	Wed,  2 Sep 2026 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334773; cv=none; b=dBhEXtBSKn+yP9wcyDHEnio+ft6GEXMBG9srWWLnM2JNKjaDkCZyXulnLKJYYNhWUhnGSm0P8xzJSDAIfa8Idz2YfhyCTjzbVloM8JC5XajoD1t6AJyNQqkZMLZvSVkZhTk8gcfdqTU8vAB/Yhe+Ls818SGkz8P/WLNaFiAIT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334773; c=relaxed/simple;
	bh=T23Y/8MH4a976pJ1aTJSlZattyebK9SFXcC6KDIsuPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X+S8+40YLWjEdzL8y5PyaLNf0fy/OaUext4/ZA2Xi8Kt+XxsHQrh7YkOZ8As4O8qtY+VQcHyo9rmHqvroKpPrZNCGdSgERh/YWoIOxQvryM5uCcyrsPyT0z5Kd473066R5XCueszjUvIWt9aDZHTAvsoMsRDPzQ01eUG3dWFNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgYB/rWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgYB/rWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031E21F000E9;
	Wed,  2 Sep 2026 07:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334772;
	bh=T23Y/8MH4a976pJ1aTJSlZattyebK9SFXcC6KDIsuPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bgYB/rWG+ocw4puQ6R80RMhjr+us6cH0GThiryIkLBpiy21HRpJO5k5lkxdvLQH2V
	 21T4uiqQOaysBOnV8cmqVWmZoV/JGhULX4qtbOvtkzwV9K79ptGN0yUXk0l74+81X8
	 ScStKGyuLViChEo31Y1NoX7enjizSPeQ97Eho/PgQ7Kb3n+MKeqR+Ue049IO7PERHO
	 AQw7aPt1JOLZkvfdpW2OvzL3kO3LWLjruYTBHGa1WGNsJSP3r0PUr0RW43jilTtp+2
	 Iv+lhaa3c87KKuVNlKqyMX1b1i9724mp2rZwiyw6cbB+2If3FwleeoC67wKb4fFIPi
	 Ex5OG1jqSx+uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/12] PCI/CXL: Reject CXL Reset on multifunction
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902072804.665639-9-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:39:31 +0000
Message-Id: <20260902073932.031E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL Reset can be exposed as a PCI function reset method only when the
> reset is function-scoped. PCI reset-method probing runs during
> enumeration, so walking sibling functions there can race with functions
> that have not been added to the bus yet.
>=20
> Reject multifunction devices for now instead of trying to infer reset
> scope from sibling state. Systems that can prove a multifunction device
> has function-scoped CXL Reset can be enabled later.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D8

