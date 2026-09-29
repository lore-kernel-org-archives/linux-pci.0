Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164A4A32
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654493; cv=none; b=H8HxulFMeWFQTJHZfa8MspZ9Mu9HYDkayWQGf6EmlULOqg4ANYPQf782C99wiq1xVHWago7du7uhKKq2bacGKIV42OaBcP2yclNC9QqxUGk1GiJGk1wy7SYCKXlig9E6RvGfSb11F0k+B16eylTmIev+j+AOmvYZzIPil5NG5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654493; c=relaxed/simple;
	bh=mpFbZZb7suWJm14J5Vjg6Ro6Lk8G+O4FFLU41zZ2o5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uYJD68GQNrlR/HvYQxBbgXfKKgnGO9fJnZCe0SuRZNIJYXllL6Nj2RkqpXTQtyu0tUqdrHTvXR7TrHDQMBoG+FpcZtts4MowRPJ6s6kJ1A+b4SpDguMTKmD1IMOSwu3GnN1P/uvXbwd5H080yBNI73MPuLNUATBMdgSgIsWI38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrAO10K/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrAO10K/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6378D1F000FF;
	Tue, 29 Sep 2026 04:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790654492;
	bh=mpFbZZb7suWJm14J5Vjg6Ro6Lk8G+O4FFLU41zZ2o5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hrAO10K/LjXqjw9HfIo2pbALk20PppjRygsFrEf6wAPN2oNgDtX3WEXlEHqjlQuzG
	 kepHlP82ef+kLw6vJqkiq7T1oxjU9B2W5mYRWqqHTLT4YIIPYb8+yNIoCI/xP/IDpG
	 sgkbdfe4qiZ0xneLJSb5Aar8vN6k2lPsHsD9XfdtC0WggdzJyUl5Z36B5inqGZJ95t
	 a4M3uWy8ULWFE1WEPCVJlM+U+2/gvROTgChxEem8SBYtmbzyMaqNJcRo+cqdjdVll+
	 W7Y4sPzjZNEmAhIKEMlRrsdkuUsoupHE7/KaQQn/oLTc250ibwQsEBy7h19xYxA7H+
	 m+85XN2MdSgew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/16] iommu/arm-smmu-v3: Add Q_POS() macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-3-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-3-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:01:31 +0000
Message-Id: <20260929040132.6378D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> A queue position, the wrap bit combined with the index, is Q_WRP | Q_IDX.
> It is a (max_n_shift + 1)-bit value that wraps at twice the queue capacit=
y.
> queue_inc_cons(), queue_sync_cons_ovf(), and queue_inc_prod_n() currently
> compute such positions by open-coding the two macros at each call site.
>=20
> Add a Q_POS() macro and switch the open-coded sites to it.
>=20
> A subsequent change will apply Q_POS() to a position difference, to count
> the entries that a queue pointer moved past.
>=20
> No functional change intended.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D2

