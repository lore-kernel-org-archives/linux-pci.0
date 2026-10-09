Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CE819D074;
	Fri,  9 Oct 2026 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522082; cv=none; b=ndY3bpObwt7O0OKmhmPkXMsdu1cljdeRJeizgHp5H9k8HilUEZaLr1LkK1IuBbnglKh7UxdxY7B0pXRTMgOts/ZRXA+9VQLLvhuHRmdzs3Bl/a9iFd/IaziD/uo+IR01UKk6Y6lUkIrIHhStmUpB3K6r7DOMBHM0cPcS2rqO57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522082; c=relaxed/simple;
	bh=JFeeLK+dzX3pC08ZunTEHkRH2kL+Sukhr2kN5HawWCk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EUOk/HjnoyWeMwgQII29P25rHQrQcxzHyauTOzvIZPHBSaHKb2rJTLWE/E2GID0Cbb0+2ldKaaiNXjHstPZuh0yrqu8gACWiqg7teOZXbVdWHw99eiRPqCQRYLnSj9nBDUDjUvk+wloRzzkYkst4meJfho9grMIg63rY1Y/P1+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuNwEk7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuNwEk7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7971F000FF;
	Fri,  9 Oct 2026 05:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522081;
	bh=JFeeLK+dzX3pC08ZunTEHkRH2kL+Sukhr2kN5HawWCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NuNwEk7+L+qrUxpyDPCKx+cIc+yKb3Umq2XSKBo7w5RvgaxcaYAUtNeP89KNUcXbu
	 N/4ouwPto1m4w1xUD2gS6v5fUuuUMC3hn09Qmb5n04uIelUtlanX66RykrgPKxpZrW
	 5BM+fMV3fjaJLIn9XaKeEO1+YJK6tVhtuCO162e/23XJlUewA5QbvbRPNEtJs7x/J+
	 acPZcL7KJiLfHK5dYBYM/XbwSYPEhzW1xF4LtGSPpXN6z9la50aTV9RViaQVb2MKbO
	 Gra5VjdnRTQAecf+tYDQ4ZpMzJwOSX85U/2KscsbFuB51weMnLihFQrvP2EcHYwCEk
	 MOT/TSHjCnngw==
Message-ID: <sashiko-outbox-164861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] cxl: Account for link width in latency calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261009045452.1107921-3-den@valinux.co.jp>
References: <20261009045452.1107921-1-den@valinux.co.jp>
 <20261009045452.1107921-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:01:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> cxl_pci_get_latency() derives bandwidth from the per-lane speed returned
> by pcie_link_speed_mbps(), ignoring the negotiated link width. This
> overestimates the FlitLatency contribution for multi-lane links.
> Sections 2.11.3 and 2.11.4 of the Intel CXL Memory Device Software Guide
> describe the link bandwidth as the product of the negotiated speed and
> width.
>=20
> Replace pcie_link_speed_mbps() with pcie_link_bandwidth_mbps() and
> migrate both CXL callers (the only users of the API). The new helper
> obtains speed and width from a single Link Status read. The CXL
> bandwidth calculation no longer needs a separate width read and
> multiplication.
>=20
> While at it, make error handling more robust by converting PCI config
> read errors to negative errno values and checking for zero bandwidth
> before calculating latency.
>=20
> Fixes: 4d07a05397c8 ("cxl: Calculate and store PCI link latency for the d=
ownstream ports")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009045452.1107=
921-1-den@valinux.co.jp?part=3D2

