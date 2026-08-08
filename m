Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FD34DCD2
	for <linux-pci@vger.kernel.org>; Sat,  8 Aug 2026 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786210051; cv=none; b=K+RIcLm9gOl6Rbt8yiZlbnbQ5MTu4IoQJDkNQb5Ni0kcgSihe87OfaU34JYdXO4zGvk7Ke6cj+BEnUEKNfPuJw7qIdFNn7vdpGI3yLY+Kdy+Q6oEl/RPTzwmtRwV18S0vPRXHdMvbF3E9NlFUflelDA2EP/Iom3Oit8cZSi9emk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786210051; c=relaxed/simple;
	bh=JTQ2YYBrdyoOSJiinbYOJrfJoxhhYnWRWwcPRYbc6PE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WjIbBfK2OtdfH8xxWKo8iVFKoiRudYfXDkX6STZ13ClElBv/lki9XJO4meIKDOg7u0fi8gutdDjT1/dKijh4yHbbR1pEeo19b2C37PZtJ9pifywkvqkA8AOJ6UpDi7EH0fx6+Lic5M1cKx82bjCbD8rZxRCc6DE2ZSjH31oYqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBZoxvq1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBZoxvq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373CA1F000E9;
	Sat,  8 Aug 2026 17:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786210049;
	bh=3FcFOl1jDH09TbX5ZW7H1dN/nS1PC42FspLTqrg9F8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kBZoxvq1dRM6hpZ03d3dfTBpW8OdzyIC+wvdkZZ7YGoNNQ2EN58IL6fMVZ4snhV92
	 tfdB81IUOc5BmB2Yz10K+BvZD40cOr9Ngnpyd8Fa24GD0CAh0M3p4iyh9RGp3hGdE3
	 +kAVtOTE+qMM86OJnlyRfIfYX9DDYsLf+17QHVnA5otp2pz/S/SMxVp6+LKqxTVwcO
	 uBFguApur+L/bWq2WwHLtZ4yuROH3MrnT/pauyWtiBBMOCxKH13CjZ5oY+RVu8hvZ0
	 AEW5y8cbEf8pvnvBR714ZEj/vbPn9x64bZ7OioU3J8TW9+CBQJsHA1Bp/0iJm6DJRX
	 127233tRh6aiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] PCI: Include human-readable sizes in resource
 assignment messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260808172308.282591-3-bhelgaas@google.com>
References: <20260808172308.282591-1-bhelgaas@google.com>
 <20260808172308.282591-3-bhelgaas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 17:27:28 +0000
Message-Id: <20260808172729.373CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Include human-readable sizes, e.g., "16.0 MiB", in addition to the hex
> "0x1000000" size, in resource-related messages.  Also consistently include
> the "0x" prefix.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808172308.2825=
91-1-bhelgaas@google.com?part=3D2

