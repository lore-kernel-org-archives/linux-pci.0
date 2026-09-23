Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949AB37CD2C
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131128; cv=none; b=f06VT+doDRF2kE+nrEC9pm/5aYBdqipHNiM8vh/wn8PZ7aBAjZ5k8lW8W3u+Rj6b7H56LThNR3fjofiQRJypFSFC3799eFmaiEMdqdpm+dQG0ENMN58wDlwWlEMsIqaO0y/tdos/fwhp2OWtUBxmlYO3voJNyQPKPQ536O553rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131128; c=relaxed/simple;
	bh=q+EWfme/eTrL6Vr6Y5pZiF6tXVc/lNr4IsMfEV1b1d4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=keR+1uAd7rn6k59evnfUvhrbRlKCED4NLa1Rzolz0vd20Gs/zOvEoMJBDz29hSjgGREWuv6+9x8QCHvkju2+u0a+XSKfy7Umd4DLII90wOzMO586b8l+r2CV9b2VuF6ALHU16dH+LYXVdBufT+V67/1nyzMR3uqxmCX1TQ8Jbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM0jDotP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM0jDotP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3211F000FF;
	Wed, 23 Sep 2026 02:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790131127;
	bh=mJEPL5/0/WXrxDokEcUiXwSIgFaImCREx3HIOYjQisw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HM0jDotP6K7fk1dOcrnTwJGDpvms1VLLg8nB01HerdE4dCeUPh4diSLobX+4r5JMk
	 pX06ymESuqIaZCB7jq3Z74OgF4/91hE+KnCEXqDDS7uUrux++m88ugNhoPkP+UuV7i
	 WONNPumXfI80qxdfH9+mGfvcozcWXeH76glrqHnIlh2MlrrQia0mpA8rpIbl0NOFOL
	 /pAd5szxl3bOcCDJryQfZF47DZpPmvMn1nh+pqKM0jWn8iz46NadIaiY6rA5zOcu+A
	 xt8eC9HRMrrtD3LfWRwclpnf16hIdh/DhFau2AaCzWM3B/87jqB3eLfaqxdStwu0V5
	 K3QYrSY/gulpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/PM: Skip the suspend_noirq config save if
 runtime-suspended
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navon John Lukose" <navonjohnlukose@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923022511.24932-1-navonjohnlukose@gmail.com>
References: <20260923022511.24932-1-navonjohnlukose@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 02:38:46 +0000
Message-Id: <20260923023846.DE3211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_pm_suspend_noirq() saves config space unconditionally when the driver
> of the device has no PM callbacks, which includes unbound devices.  If
> such a device is runtime-suspended, the bridge above it may be in a
> low-power state with the link down.  Depending on the platform, the
> config reads then either hang the CPU or return all ones, which overwrite
> the snapshot taken at runtime suspend and are written back to the device
> on resume.
>=20
> Skip the save if the device is runtime-suspended, as pci_pm_freeze()
> does, since pci_pm_runtime_suspend() has already saved the config space.
> Use pm_runtime_status_suspended(), because runtime PM is disabled by the
> noirq phase and pm_runtime_suspended() would always be false.
>=20
> Fixes: 931ff68a5a53 ("PCI PM: Restore config spaces of all devices during=
 early resume")
> Cc: stable@vger.kernel.org # v6.19+
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923022511.2493=
2-1-navonjohnlukose@gmail.com?part=3D1

