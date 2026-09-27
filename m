Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E873B8BA5
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533619; cv=none; b=g62n99UYNK6n5tdzPL4JPjrbEsLkhrb3597I+BPrj9lW4aX4iotSC0ljh4FwnKUC96dmTvO1a6zXuzRlZPSd6YdwoVunPLSqV5NFQtluQq9CrLefMjssLrSvQuLniZn2cnCf9Cc/1jBVKsQx0VGK+mHO2QT1VpJThqHuzajCQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533619; c=relaxed/simple;
	bh=jGDnE6ebYvkgJn06tLXGdA5aMv8wgS+pOV9iMf5KOSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d8D9TVXoe8WzuD1ryE1zDUPzpgPitWZTLcdGxSkRzyXAeZVbgDKbwa1bz5+kz+oZjaBvSkNNSFc4g4JYk+T+pP/6b7gq0W8CgEgegu3RBofNLVO0sowRXxyaweJ3GY7OVX35TV6bGLLShxFUe6DskLTG9aXlLXm/6mJpe9zMqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvtPgh7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvtPgh7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8951F000FF;
	Sun, 27 Sep 2026 18:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533618;
	bh=jGDnE6ebYvkgJn06tLXGdA5aMv8wgS+pOV9iMf5KOSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EvtPgh7eWEyiPh2EooODInn5GuQE7SScvam6vXq5MGaMOjVEMlAOlouljdZ3gjPta
	 PnjId0FHTG+EqkhJInmjVZJm2IVzYcFtzml2UkQY7DS9Tn4rK0zptMNijUK4nTLqm+
	 MPhniPhFIrbd8TydXhS1zehe6+9Q+2PILNX7AOVzmxEOkJ5jk4vrssqGxvi7Y6v59J
	 4ZV2pmhz5rsl1BhTOKy1kqft4juk5w2MK6XnG3Xm9zdZ/7FC3EEPJ1YEVs6Q1AOXqi
	 81azE3UTps1vC5+JIM4LB/4vLVPf88P+BvpudKsZsCf1AOyfXIpaifOuydHrYttEmd
	 K8ZcX7VosNBkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 2/5] PCI: pciehp: Add pci_hp_wait_link_change()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927182017.938565-3-abhinjoses@gmail.com>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
 <20260927182017.938565-3-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:26:57 +0000
Message-Id: <20260927182658.2C8951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_hp_spurious_link_change() awaits the end of a code section causing
> spurious link changes, such as a Secondary Bus Reset, and then tells
> whether such a section has executed, using test_and_clear_bit() on
> PCI_LINK_CHANGED. The answer is one-shot: only the first caller sees
> true.
>=20
> Split the wait out into pci_hp_wait_link_change(), which leaves
> PCI_LINK_CHANGED alone, and implement pci_hp_spurious_link_change() on
> top of it. Test PCI_LINK_CHANGING with test_bit_acquire(), so that the
> caller's subsequent accesses are ordered after the end of the code
> section even if wait_event() returns without sleeping. No functional
> change intended.
>=20
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182017.9385=
65-1-abhinjoses@gmail.com?part=3D2

