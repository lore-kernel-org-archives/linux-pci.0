Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807033D7D77
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399539; cv=none; b=myELf6KBI8A6067R4XI7G6HuN3kouPDffOAx3AitV5h3FU4EAFLmb5WdO6I3J0Fv5SSi6TmN8YaPjpf0HCMOMgJ/V7QJWB3P/urKxVC52sQGJUlxgraOkJNjs1mfHvpvNuklytjxc2t4OkIx2jK72/L8WRNbmxn8WwUboGQoWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399539; c=relaxed/simple;
	bh=E3GRxUsoCPKSJ/HIptqNUcLhld3qaAUpDhGTKfHsi+g=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=IZvt+fQEoQlhmoY+7qMIQJpOZDfNH9ewmzVao46vuGY+WY2GT3Ow+5yMN1jxA/x3qo/+u3qiorq+l3J610T3eys5ovFAm+qzqHhaIv9QM6iPt+avIdKdWGPc63TPORaUeU1q0DIwRdBEIUSyU0ErlByKAXLNNPQSkZlZ+U6ByJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3PkqVqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3PkqVqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B12D1F000C4;
	Mon, 19 Oct 2026 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399538;
	bh=E3GRxUsoCPKSJ/HIptqNUcLhld3qaAUpDhGTKfHsi+g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=P3PkqVqCAgTGjeTS7PbmLuKQfkfO81VzerNu8u+nX0yhORqb9RyWXJDJzf1HREb92
	 WEMYb0IsDKvtMch5PL06BVeuxlUYqBtIq2Xa8U80a1WJF4rqGcu2nxUhdHcte9RbA1
	 v9Zy/U/gY7+on6LF21NRl+XzyqVnUFnMXGEu7IV9frXHcFxn5f1yyXwFqjsqS4cjMq
	 NkzgxMD+6ZRmiGjJx2prkVoe4yw4ol3H3gTGw9rQyy+eYevUn3g1Y36ZJZFRCeiP/V
	 8TSC77JdVN2erK9+9ZopR3OrnhKsr1rrJhCbS4YwYAuInu5wpfAiup6tVHo0HUwfsQ
	 EerLflUq6QTrw==
Message-ID: <sashiko-outbox-176832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/13] ionic: Lock VFs around
 pci_reset_function_locked()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-6-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-6-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:45:37 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_reset_function_locked() now requires PF callers to hold the device
> locks for all enabled VFs as well. Lock VFs around the reset in
> ionic_pci_error_resume().
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D5

