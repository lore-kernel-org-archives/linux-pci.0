Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114A3DEFFE
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677027; cv=none; b=iM0auD0wjsgwFcN3pG3t7WIrd4g7g0axyVJg7MS94AG2LK6X7+ZBYzVWU4iF1Vw3VKJWZI6hWbU0jmZfCSyyRaJvfsTOTsLLrcjiLK7cZbcKmkqZ5lsAtsAkJ3LETiRYwzendk6kwnj7k9ZurmvRJxUiPN7/HYZvMRF4ApRFw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677027; c=relaxed/simple;
	bh=47BRmEnvRR4IldG1NRbXSyO/UwJhKK2FEw8de5+dzU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PEjrVK8u3bcrdpSIbXtnCdhJ5HBOdHbxs9e5UL3cDyYoujfZJrSV5+ZNg4Z7aKFCbTgbgmrGSGyxiRzw9pjqwVZV5WOf7QoxPYz1xOdkGQfRKbMFGkhDLaofiZit2YUVwR41IphxCOV+ww2It+wuTVFnn/bufnB+E6imlArwJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZGNmoLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZGNmoLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C1C1F000FF;
	Tue, 29 Sep 2026 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790677014;
	bh=47BRmEnvRR4IldG1NRbXSyO/UwJhKK2FEw8de5+dzU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jZGNmoLNc7Hk9RYwcuM8bF1E565Wdlq4Nh9UlfaOTUB5iCemG7115BV5GZ2sLt/gw
	 VP3W7QBbZHR47cfbL+JmWBak36HFOBg6kUlSs2PfKFJ/ZTRb5DeRDh4lqAFG1OIg1P
	 f1m1ycbUjgNQ/JuXC/hlq/VAmXMNkEHW1DtX7NxnBoJ7rgXzt0BbJU12oq8GFEeYN3
	 I4mtVD8/YLHenPiB72BwwqumBtxzv86r7T2Oo8SVgF/Hok/d4NSlxEHEKtAyDENgK6
	 Yw14U5ZbkcbIehPYuSXw+YHc2/SkQLeSioFTpxVi5mJ0ErEG6vnGuREeqXngK3sbMy
	 vN9LF/hbRPwtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] regulator: of: fill in supply names in
 of_regulator_bulk_get_all()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@flipper.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929-regulator-get-all-v1-1-e887c66a47f1@flipper.net>
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
 <20260929-regulator-get-all-v1-1-e887c66a47f1@flipper.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:16:53 +0000
Message-Id: <20260929101654.10C1C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> of_regulator_bulk_get_all() returns an array it allocated itself, and
> fills in only the consumer of each entry. Every other way of getting a
> bulk array has the supply name set, because the caller provides it, and
> the core expects it to be there: regulator_bulk_enable() prints it when
> a supply fails to enable, so a caller that hands such an array to it
> dereferences uninitialised memory on that path.
>=20
> Copy each name into the array's own allocation, right behind the
> entries, so that it shares the array's lifetime and callers still have
> nothing extra to free. That also retires the fixed 64 byte stack buffer
> the names were assembled in, which is_supply_name() never bounded the
> copy against.
>=20
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260928-b4-rk3576-reboot-mode-v1-=
0-65486b03bd41@flipper.net?part=3D3
> Fixes: 27b9ecc7a9ba ("regulator: Add of_regulator_bulk_get_all")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-regulator-=
get-all-v1-0-e887c66a47f1@flipper.net?part=3D1

